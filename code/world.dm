/world
	mob = /mob/new_player
	turf = /turf/space
	area = /area
	view = "15x15"
	cache_lifespan = 1

#define RECOMMENDED_VERSION 495

/world/New()
	//logs
	var/date_string = time2text(world.realtime, "YYYY/MM-Month/DD-Day")
//	if(revdata && istext(revdata.revision) && length(revdata.revision)>7)
//		log = file("data/logs/runtime/[copytext(revdata.revision,1,8)].log")
//	else
//		log = file("data/logs/runtime/[time2text(world.realtime,"YYYY-MM")].log")		//funtimelog
	href_logfile = file("data/logs/[date_string] hrefs.htm")
	diary = file("data/logs/[date_string].log")
	diaryofmeanpeople = file("data/logs/[date_string] Attack.log")
	diary << "\n\nStarting up. [time2text(world.timeofday, "hh:mm.ss")]\n---------------------"
	diaryofmeanpeople << "\n\nStarting up. [time2text(world.timeofday, "hh:mm.ss")]\n---------------------"
	changelog_hash = md5('html/changelog.html')					//used for telling if the changelog has changed recently

	if(byond_version < RECOMMENDED_VERSION)
		world.log << "Your server's BYOND version does not meet the recommended requirements for /tg/station code. Please update BYOND."

	make_datum_references_lists()	//initialises global lists for referencing frequently used datums (so that we only ever do it once)

	load_configuration()
	load_mode()
	load_motd()
	load_admins()
	LoadBansjob()
	if(config.usewhitelist)
		load_whitelist()
	jobban_loadbanfile()
	appearance_loadbanfile()
	jobban_updatelegacybans()
	LoadBans()
	investigate_reset()

	if(config && config.server_name != null && config.server_suffix && world.port > 0)
		// dumb and hardcoded but I don't care~
		config.server_name += " #[(world.port % 1000) / 100]"

	makepowernets()

	sun = new /datum/sun()
	radio_controller = new /datum/controller/radio()
	data_core = new /obj/effect/datacore()
	paiController = new /datum/paiController()

	if(config.sql_enabled)
		if(!setup_database_connection())
			world.log << "Your server failed to establish a connection with the database."
		else
			world.log << "Database connection established."

	plmaster = new /obj/effect/overlay()
	plmaster.icon = 'icons/effects/tile_effects.dmi'
	plmaster.icon_state = "plasma"
	plmaster.layer = FLY_LAYER
	plmaster.mouse_opacity = 0

	slmaster = new /obj/effect/overlay()
	slmaster.icon = 'icons/effects/tile_effects.dmi'
	slmaster.icon_state = "sleeping_agent"
	slmaster.layer = FLY_LAYER
	slmaster.mouse_opacity = 0

	master_controller = new /datum/controller/game_controller()
	spawn(-1)
		master_controller.setup()
		lighting_controller.Initialize()

	src.update_status()

	process_teleport_locs()			//Sets up the wizard teleport locations
	process_ghost_teleport_locs()	//Sets up ghost teleport locations.
	sleep_offline = 1
	kill_air = 1
//	createworld()

	spawn(3000)		//so we aren't adding to the round-start lag
		if(config.ToRban)
			ToRban_autoupdate()
		if(config.kick_inactive)
			KickInactiveClients()
	return

#undef RECOMMENDED_VERSION

//world/Topic(href, href_list[])
//		world << "Received a Topic() call!"
//		world << "[href]"
//		for(var/a in href_list)
//			world << "[a]"
//		if(href_list["hello"])
//			world << "Hello world!"
//			return "Hello world!"
//		world << "End of Topic() call."
//		..()

/world/Topic(T, addr, master, key)
	diary << "TOPIC: \"[T]\", from:[addr], master:[master], key:[key]"

	if (T == "ping")
		var/x = 1
		for (var/client/C)
			x++
		return x

	else if(T == "players")
		var/n = 0
		for(var/mob/M in player_list)
			if(M.client)
				n++
		return n

	else if (T == "status")
		var/list/s = list()
		s["version"] = game_version
		s["mode"] = master_mode
		s["respawn"] = config ? abandon_allowed : 0
		s["enter"] = enter_allowed
		s["vote"] = config.allow_vote_mode
		s["ai"] = config.allow_ai
		s["host"] = host ? host : null
		s["players"] = list()
		var/n = 0
		var/admins = 0

		for(var/client/C in clients)
			if(C.holder)
				if(C.holder.fakekey)
					continue	//so stealthmins aren't revealed by the hub
				admins++
			s["player[n]"] = C.key
			n++
		s["players"] = n

		s["revision"] = revdata.revision
		s["admins"] = admins

		return list2params(s)


/world/Reboot(var/reason)
#ifdef dellogging
	var/log = file("data/logs/del.log")
	log << time2text(world.realtime)
	//mergeSort(del_counter, /proc/cmp_descending_associative)	//still testing the sorting procs. Use notepad++ to sort the resultant logfile for now.
	for(var/index in del_counter)
		var/count = del_counter[index]
		if(count > 10)
			log << "#[count]\t[index]"
#endif
	spawn(0)
		world << sound(pick('sound/AI/newroundsexy.ogg','sound/misc/apcdestroyed.ogg','sound/misc/bangindonk.ogg')) // random end sounds!! - LastyBatsy

	for(var/client/C in clients)
		if(config.server)	//if you set a server location in config.txt, it sends you there instead of trying to reconnect to the same world address. -- NeoFite
			C << link("byond://[config.server]")
		else
			C << link("byond://[world.address]:[world.port]")

	..(reason)


#define INACTIVITY_KICK	6000	//10 minutes in ticks (approx.)
/world/proc/KickInactiveClients()
	spawn(-1)
		set background = 1
		while(1)
			sleep(INACTIVITY_KICK)
			for(var/client/C in clients)
				if(C.is_afk(INACTIVITY_KICK))
					if(!istype(C.mob, /mob/dead))
						log_access("AFK: [key_name(C)]")
						C << "\red You have been inactive for more than 10 minutes and have been disconnected."
						del(C)
#undef INACTIVITY_KICK


/world/proc/load_mode()
	var/list/Lines = file2list("data/mode.txt")
	if(Lines.len)
		if(Lines[1])
			master_mode = Lines[1]
			diary << "Saved mode is '[master_mode]'"

/world/proc/save_mode(var/the_mode)
	var/F = file("data/mode.txt")
	fdel(F)
	F << the_mode

/world/proc/load_motd()
	join_motd = file2text("config/motd.txt")

/world/proc/load_configuration()
	config = new /datum/configuration()
	config.load("config/config.txt")
	config.load("config/game_options.txt","game_options")
	config.loadsql("config/dbconfig.txt")
	// apply some settings from config..
	abandon_allowed = config.respawn


/world/proc/update_status()
	var/s = ""

	if (config && config.server_name)
		s += "<b>[config.server_name]</b> &#8212; "

	s += "<b>[station_name()]</b>";
	s += " ("
	s += "<a href=\"http://\">" //Change this to wherever you want the hub to link to.
//	s += "[game_version]"
	s += "Default"  //Replace this with something else. Or ever better, delete it and uncomment the game version.
	s += "</a>"
	s += ")"

	var/list/features = list()

	if(ticker)
		if(master_mode)
			features += master_mode
	else
		features += "<b>STARTING</b>"

	if (!enter_allowed)
		features += "closed"

	features += abandon_allowed ? "respawn" : "no respawn"

	if (config && config.allow_vote_mode)
		features += "vote"

	if (config && config.allow_ai)
		features += "AI allowed"

	var/n = 0
	for (var/mob/M in player_list)
		if (M.client)
			n++

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"

	/*
	is there a reason for this? the byond site shows 'hosted by X' when there is a proper host already.
	if (host)
		features += "hosted by <b>[host]</b>"
	*/

	if (!host && config && config.hostedby)
		features += "hosted by <b>[config.hostedby]</b>"

	if (features)
		s += ": [dd_list2text(features, ", ")]"

	/* does this help? I do not know */
	if (src.status != s)
		src.status = s

#define FAILED_DB_CONNECTION_CUTOFF 5
var/failed_db_connections = 0

proc/setup_database_connection()

	if(failed_db_connections >= FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to connect anymore.
		return 0

	if(!dbcon)
		dbcon = new()

	var/user = sqlfdbklogin
	var/pass = sqlfdbkpass
	var/db = sqlfdbkdb
	var/address = sqladdress
	var/port = sqlport

	dbcon.Connect("dbi:mysql:[db]:[address]:[port]","[user]","[pass]")
	. = dbcon.IsConnected()
	if ( . )
		failed_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		failed_db_connections++		//If it failed, increase the failed connections counter.
		if(config.sql_enabled)
			world.log << "SQL error: " + dbcon.ErrorMsg()

	return .

//This proc ensures that the connection to the feedback database (global variable dbcon) is established
proc/establish_db_connection()
	if(failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return 0

	if(!dbcon || !dbcon.IsConnected())
		return setup_database_connection()
	else
		return 1

#undef FAILED_DB_CONNECTION_CUTOFF

/*proc/createworld()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas
	var/random = rand(1,5)
	for(var/i = 0, i < random, i++)
		for(var/area/security/A in world)
			for(var/turf/simulated/floor/F in A)
				if(!F.contents.len)
					turfs += F

		if(turfs.len) //Pick a turf to spawn at if we can
			var/turf/simulated/floor/T = pick(turfs)

			spawn(0)	new/mob/living/simple_animal/hostile/spawner/nanotrasen(T) //spawn a controller at turf


	random = rand(5, 15)
	for(var/i = 0, i < random, i++)
		for(var/area/mine/unexplored/A in world)
			for(var/turf/simulated/floor/plating/airless/asteroid/F in A)
				if(!F.contents.len)
					turfs += F

		if(turfs.len) //Pick a turf to spawn at if we can
			var/turf/simulated/floor/T = pick(turfs)

			spawn(0)	new /mob/living/simple_animal/hostile/retaliate/sandwalker/random(T)

	random = rand(5, 15)
	for(var/i = 0, i < random, i++)
		for(var/area/mine/unexplored/A in world)
			for(var/turf/simulated/floor/plating/airless/asteroid/F in A)
				if(!F.contents.len)
					turfs += F

		if(turfs.len) //Pick a turf to spawn at if we can
			var/turf/simulated/floor/T = pick(turfs)

			spawn(0)	new /mob/living/simple_animal/hostile/retaliate/freegolem/random(T)
*/

/proc/Good_Save(var/file_name)
	world<<"Saving map."
	world.log<<"Saving map."

	if(!file_name)
		file_name = "1"

	for(var/n=1,n<=2,n++)
		if(n==2)continue
		world<<file_name
		var/list/O=list()
		for(var/atom/movable/o)if(o.z==n)
			o.saved_x=o.x
			o.saved_y=o.y
			O+=o
		for(var/mob/living/carbon/human/H)if(H.z==n)
			H.saved_gender=H.gender
			H.saved_skintone=H.skin_tone
			H.saved_hairstyle=H.h_style
			H.saved_facehair=H.f_style
			H.saved_underwear=H.underwear
		for(var/turf/simulated/t)if(t.z==n)
			t.saved_x=t.x
			t.saved_y=t.y
			O+=t
		for(var/datum/light_source/LS)if(!LS.owner)
			del(LS)
		var/savefile/F=new("MapSaves/[file_name].sav")
		F<<O
		world<<"[file_name] saved"
	world<<"Map saved."
	world.log<<"Map saved."

/proc/Good_Load(Save,load_loc_info)
	world<<"Loading map."
	world.log<<"Loading map."
	var/n=1
	if(!fexists("MapSaves/[n].sav"))
		world<<"No map to load."
		world.log<<"No map to load."
		return
	for(var/atom/movable/o)del(o)
	for(var/turf/simulated/t)del(t)
	for(var/datum/light_source/LS)del(LS)
	var/savefile/F=new("MapSaves/[n].sav")
	var/list/O=list()
	F>>O
	for(var/atom/movable/o in O)
		o.loc=locate(o.saved_x,o.saved_y,n)
	for(var/mob/living/carbon/human/H)
		H.gender=H.saved_gender
		H.skin_tone=H.saved_skintone
		H.h_style=H.saved_hairstyle
		H.f_style=H.saved_facehair
		H.underwear=H.saved_underwear
	for(var/mob/m)
		m.lastDblClick=0
		m.alreadyspawned=1
		m.regenerate_icons()
		m.update_icons()
	for(var/turf/simulated/t in O)
		var/fukkenturf = t
		new fukkenturf(locate(t.saved_x,t.saved_y,n))
		del t
		world<<"[n] loaded."
	world<<"Map loaded."
	world.log<<"Map loaded."

/datum/stack_recipe/Write()
	return

/datum/stack_recipe/Read()
	return