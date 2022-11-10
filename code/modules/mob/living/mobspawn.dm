/obj/effect/mobspawn
	anchored = 1
	desc = "a strange rune used to create humans. It glows when spirits are nearby."
	name = "human rune"
	icon = 'icons/obj/rune.dmi'
	icon_state = "main1"
	unacidable = 1
	layer = TURF_LAYER
	invisibility = INVISIBILITY_OBSERVER
	var/delchance = 15
	var/spawninfo = null
	var/spawnuniform = null
	var/spawnsuit = null
	var/spawnshoes = null
	var/spawngloves = null
	var/spawnradio = null
	var/spawnglasses = null
	var/spawnmask = null
	var/spawnhelmet = null
	var/spawnbelt = null
	var/spawnpocket1 = null
	var/spawnpocket2 = null
	var/spawnback = null
	var/rank
	var/customjob
	var/spawnidicon
	var/spawnidaccess = list()
	var/spawntext
//	var/spawnmob = /mob/living/carbon/human

/obj/effect/mobspawn/DblClick()
	return modify_spawn()

/obj/effect/mobspawn/verb/modify_spawn()
	set name = "Modify Rune"
	set category = "Object"
	set desc = "Modify that rune spawn"
	set src in oview(1)

//	if(!usr.stat) return //make it for ghosts

	var/def_value
	var/mod_slot = input("Select slot:", "Slot", def_value) as null|anything in list("under", "suit", "shoes", "gloves", "radio", "glasses", "mask", "head", "belt", "pocket1", "pocket2", "back", "custom job", "spawn id icon", "spawn id access", "rune name", "delete chance", "race")
	if (!mod_slot) return

	if(mod_slot == "custom job")
		customjob = copytext(sanitize(input(usr, "Enter custom job", "Assignment", mod_slot) as null|text),1,30)
		return

	if(mod_slot == "spawn id icon")
		spawnidicon = copytext(sanitize(input(usr, "Enter custom id icon", "icon", "data|id|orange|gold|silver|centcom|emag|fingerprint0|fingerprint1") as null|text),1,999)
		return

	if(mod_slot == "spawn id access")
		spawnidaccess += copytext(sanitize(input(usr, "Enter custom access", "Airlock Access", "5") as null|text),1,999)
		return

	if (mod_slot == "rune name")
		src.name = copytext(sanitize(input(usr, "Enter new rune name", "Rune name", "spawn rune[rand(1, 999)]") as null|text),1,30)
		return

	if(mod_slot == "delete chance")
		src.delchance = copytext(sanitize(input(usr, "Enter new delete chance", "Delete chance", 0) as null|text),1,5)
		return

	if(mod_slot == "race")
		src.spawntext = copytext(sanitize(input(usr, "Enter new mutant race", "Race", "human") as null|text),1,20)
		return

	var/slot_type = copytext(sanitize(input(usr, "What is that slot type?", "Slot item", "/obj/item/clothing/[mod_slot]") as null|text),1,999)
	if (!slot_type)
		return

	var/list/matches = get_fancy_list_of_types()
	if (!isnull(slot_type) && slot_type!="")
		matches = filter_fancy_list(matches, slot_type)

	if(matches.len==0)
		return

	var/chosen
	if(matches.len==1)
		chosen = matches[1]
	else
		chosen = input("Select a type", "Item type", matches[1]) as null|anything in matches
		if(!chosen)
			return
	chosen = matches[chosen]
	slot_type = chosen

	switch(mod_slot)
		if("under")
			spawnuniform = slot_type
		if("suit")
			spawnsuit = slot_type
		if("shoes")
			spawnshoes = slot_type
		if("gloves")
			spawngloves = slot_type
		if("radio")
			spawnradio = slot_type
		if("glasses")
			spawnglasses = slot_type
		if("mask")
			spawnmask = slot_type
		if("head")
			spawnhelmet = slot_type
		if("belt")
			spawnbelt = slot_type
		if("pocket1")
			spawnpocket1 = slot_type
		if("pocket2")
			spawnpocket2 = slot_type
		if("back")
			spawnback = slot_type

/obj/effect/mobspawn/New()
	..()
	announce_to_ghosts()

/obj/effect/mobspawn/proc/spawnthatassholealreadyplease()
	var/mob/dead/observer/ghost
	for(var/mob/dead/observer/O in src.loc)
		ghost = O
		break
	if(ghost)
		var/mob/living/carbon/human/G = new /mob/living/carbon/human
		G.key = ghost.key
		G.loc = src.loc
		icon_state = "golem2"
		if (rank)
			job_master.AssignRole(G, rank, 1)
			job_master.EquipRank(G, rank, 1)
		if (spawnsuit)
			G.equip_to_slot_or_del(new spawnsuit(G), slot_wear_suit)
		if (spawnuniform)
			G.equip_to_slot_or_del(new spawnuniform(G), slot_w_uniform)
		if (spawnshoes)
			G.equip_to_slot_or_del(new spawnshoes(G), slot_shoes)
		if (spawngloves)
			G.equip_to_slot_or_del(new spawngloves(G), slot_gloves)
		if(spawnradio)
			G.equip_to_slot_or_del(new spawnradio(G), slot_ears)
		if(spawnglasses)
			G.equip_to_slot_or_del(new spawnglasses(G), slot_glasses)
		if(spawnmask)
			G.equip_to_slot_or_del(new spawnmask(G), slot_wear_mask)
		if(spawnhelmet)
			G.equip_to_slot_or_del(new spawnhelmet(G), slot_head)
		if(spawnbelt)
			G.equip_to_slot_or_del(new spawnbelt(G), slot_belt)
		if(spawnpocket1)
			G.equip_to_slot_or_del(new spawnpocket1(G), slot_r_store)
		if(spawnpocket2)
			G.equip_to_slot_or_del(new spawnpocket2(G), slot_l_store)
		if(spawnback)
			G.equip_to_slot_or_del(new spawnback(G), slot_back)
		if (customjob)
			var/obj/item/weapon/card/id/C = new /obj/item/weapon/card/id(G)
			if(C)
				C.registered_name = G.real_name
				C.assignment = customjob
				C.name = "[C.registered_name]'s ID Card ([C.assignment])"
				if(G.w_uniform)
					G.equip_to_slot_or_del(C, slot_wear_id)
					G.equip_to_slot_or_del(new /obj/item/device/pda(G), slot_belt)
				else
					C.loc = G.loc
					new /obj/item/device/pda(G.loc)
				if(spawnidicon)
					C.icon_state = spawnidicon
				if(spawnidaccess)
					C.access = spawnidaccess
		if (spawntext)
			G.dna.mutantrace = spawntext

		switch (spawninfo)
			if ("golem")
				G.dna.mutantrace = "adamantine"
				G.real_name = "Adamantine" + " " + (pick(golem_name))
				G.underwear = null
				G.faction = "golem"
			//	G.maxHealth = rand(100,300)
			//	G.health = G.maxHealth
				G.equip_to_slot_or_del(new /obj/item/clothing/under/golem(G), slot_w_uniform)
				G.equip_to_slot_or_del(new /obj/item/clothing/suit/golem(G), slot_wear_suit)
				G.equip_to_slot_or_del(new /obj/item/clothing/shoes/golem(G), slot_shoes)
				G.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/golem(G), slot_wear_mask)
				G.equip_to_slot_or_del(new /obj/item/clothing/gloves/golem(G), slot_gloves)
			if ("lizard")
				G.dna.mutantrace = "lizard"
				G.real_name = random_name_lizard(gender)
				G.underwear = null
				G.equip_to_slot_or_del(new /obj/item/clothing/under/gladiator(G), slot_w_uniform)
				G.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/gladiator(G), slot_head)
				G.icon += rgb(rand(150,255), rand(0,30), rand(150,255))
				G.faction = "sandwalker"
			if ("lifebringer")
				G.dna.mutantrace = "plant"
				G.underwear = null
				G.faction = "lifebringer"
				var/realname = pick("Tomato", "Potato", "Broccoli", "Carrot", "Ambrosia", "Pumpkin", "Ivy", "Kudzu", "Banana", "Moss", "Flower", "Bloom", "Root", "Bark", "Glowshroom", "Petal", "Leaf", \
	"Venus", "Sprout","Cocoa", "Strawberry", "Citrus", "Oak", "Cactus", "Pepper", "Juniper")
				var/number = pick("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX")
				G.real_name = capitalize(realname) + " " + number
				G.equip_to_slot_or_del(new /obj/item/clothing/under/rank/hydroponics(G), slot_w_uniform)
				G.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/floragun(G), slot_belt)
				G.icon += rgb(rand(30,255), rand(30,255), rand(30,255))
			if ("abductor")
				var/abductorname = pick("Alpha Mothership", "Beta Mothership", "Gamma Mothership", "Delta Mothership", "Epsilon Mothership", "Zeta Mothership", "Eta Mothership", "Theta Mothership", "Iota Mothership", "Kappa Mothership", "Lambda Mothership", \
				"Mu Mothership", "Nu Mothership", "Xi Mothership", "Omicron Mothership", "Pi Mothership", "Rho Mothership", \
	"Sigma Mothership", "Tau Mothership","Upsilon Mothership", "Phi Mothership", "Chi Mothership", "Psi Mothership", "Omega Mothership", "Neptune Mothership", "Saturn Mothership", "Jupiter Mothership")
				G.dna.mutantrace = "abductor"
				G.underwear = null
				G.faction = "abductor"
				G.real_name = abductorname + " Agent"
				G.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(G), slot_w_uniform)
				G.equip_to_slot_or_del(new /obj/item/device/radio/headset/syndicate(G), slot_ears)
				G.equip_to_slot_or_del(new /obj/item/clothing/shoes/combat(G), slot_shoes)
				G.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/reactive(G), slot_wear_suit)
				G.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(G), slot_back)
				G.mind.special_role = "abductor"
				G.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/decloner(G), slot_belt)
				G.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/abductor(G), slot_head)
				G.equip_to_slot_or_del(new /obj/item/weapon/hand_tele(G), slot_r_store)
				for(var/datum/mind/M in ticker.minds)
				var/datum/objective/debrain/O = new /datum/objective/debrain()

				for(var/datum/mind/M in ticker.minds)
					if((M.current && M.current.stat != DEAD) && M.special_role != "abductor" &&(istype(M.current,/mob/living/carbon/human)))
						O.owner = G.mind
						O.target = M
						O.explanation_text = "Steal the brain of [M.current.real_name]."
						G.mind.objectives += O
						break

			if ("flyperson")
				G.dna.mutantrace = "fly"
				G.underwear = null
				G.faction = "fly"
				var/flynameprefix = pick("Voyage", "Flight", "Avia", "Fly", "Elapse", "Pass", "Omission", "Lowering", "Conduct", "Direct")
				var/flynamesuffix = pick("Pilot", "Person", "Navigator", "Driver", "Leader", "Guide", "Passenger")
				G.real_name = flynameprefix+" "+flynamesuffix
				G.maxHealth = 75
				G.health = 75
			if ("shadowperson")
				G.dna.mutantrace = "shadow"
				G.underwear = null
				G.faction = "faithless"
				var/shadownameprefix = pick("Death", "Dark", "Blackness", "Shadow", "Lightless", "Grim", "Gloom", "Obscurity", "Night", "Murk")
				var/shadownamesuffix = pick("Dweller", "Stranger", "Habitant", "Occupant", "Denizen", "Tenant", "Inmate")
				G.real_name = shadownameprefix+" "+shadownamesuffix
				G.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/shadow(G), slot_glasses)
			if ("skrell")
				G.faction = "skrell"
				G.dna.mutantrace = "skrell"
				G.underwear = null
				G.real_name = random_name_skrell()
				G.icon += rgb(rand(0,155), rand(0,155), rand(0,155))
			if ("lizard2")
				G.faction = "lizard"
				G.dna.mutantrace = "lizard"
				G.real_name = random_name_lizard(gender)
				G.underwear = null
				G.icon += rgb(rand(0,155), rand(0,155), rand(0,155))
			if ("cyborg")
				G.Robotize()
			if ("monkey")
				G.monkeyize()
			if ("syndie")
				G.faction = "syndicate"
				ticker.mode.equip_syndicate(G)
			if ("cult")
				G.faction = "cult"
				G.equip_to_slot_or_del(new /obj/item/clothing/suit/cultrobes/alt(G), slot_wear_suit)
				G.equip_to_slot_or_del(new /obj/item/clothing/head/culthood/alt(G), slot_head)
				G.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult(G), slot_shoes)
			if ("slime")
				G.slimeize()
			if ("alien")
				G.Alienize()
			if ("ai")
				var/mob/living/silicon/ai/D = new /mob/living/silicon/ai
				D.loc = G.loc
				D.key = G.key
				del(G)
			if ("resomi")
				var/mob/living/carbon/monkey/resomi/V = new /mob/living/carbon/monkey/resomi
				V.loc = G.loc
				V.key = G.key
				if(spawnmask)
					V.equip_to_slot_or_del(new spawnmask(V), slot_wear_mask)
				if(spawnback)
					V.equip_to_slot_or_del(new spawnback(V), slot_back)
				del(G)
			if ("larva")
				var/mob/living/carbon/alien/larva/L = new /mob/living/carbon/alien/larva
				L.loc = G.loc
				L.key = G.key
				del(G)
			if ("ninja")
				G.real_name = "[pick(ninja_titles)] [pick(ninja_names)]"
				G.equip_space_ninja()
			if ("changeling")
				G.make_changeling()
			if ("deathsquad")
				var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(G)
				L.imp_in = G
				L.implanted = 1
				G.equip_to_slot_or_del(new /obj/item/clothing/under/color/green(G), slot_w_uniform)
				G.equip_to_slot_or_del(new /obj/item/clothing/shoes/swat(G), slot_shoes)
				G.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/swat(G), slot_wear_suit)
				G.equip_to_slot_or_del(new /obj/item/clothing/gloves/swat(G), slot_gloves)
				G.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/deathsquad(G), slot_head)
				G.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat(G), slot_wear_mask)
				G.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal(G), slot_glasses)
				G.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/security(G), slot_back)
				G.equip_to_slot_or_del(new /obj/item/weapon/storage/box(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/ammo_magazine/a357(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/regular(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/weapon/storage/box/flashbangs(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/device/flashlight(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/weapon/plastique(G), slot_in_backpack)
				G.equip_to_slot_or_del(new /obj/item/weapon/melee/energy/sword(G), slot_l_store)
				G.equip_to_slot_or_del(new /obj/item/weapon/grenade/flashbang(G), slot_r_store)
				G.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen(G), slot_s_store)
				G.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/mateba(G), slot_belt)
				G.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle(G), slot_r_hand)
			if ("serpent")
				var/mob/living/carbon/human/gas/Y = new /mob/living/carbon/human/gas
				Y.loc = G.loc
				Y.key = G.key
				del(G)
			if ("plasmaman")
				var/mob/living/carbon/human/plasmaman/PL = new /mob/living/carbon/human/plasmaman
				PL.loc = G.loc
				PL.key = G.key
				del(G)
			if ("ogre")
				G.dna.mutantrace = "space ogre"
				G.gender = MALE
				G.regenerate_icons()
				G.real_name = "[capitalize(pick(adjectives))] [pick(ogre_names)]"
			if ("wizard")
				G.mind.make_Wizard()


	if(prob(delchance))
		del(src)


proc/announce_to_ghosts()
	for(var/mob/dead/observer/G in player_list)
		if(G.client)
			var/area/A = get_area(src)
			if(A)
				G << "Spawner created in [A.name]."






/////////////////////////OH SNAP////////////////////////////////////////
/obj/effect/mobspawn/freegolem
	desc = "a strange rune used to create golems. It glows when spirits are nearby."
	name = "golem rune"
	spawninfo = "golem"
	delchance = 33

/obj/effect/mobspawn/sandwalker
	desc = "a strange rune used to create sandwalkers. It glows when spirits are nearby."
	name = "lizard rune"
	spawninfo = "lizard"
	delchance = 20

/obj/effect/mobspawn/lifebringer
	desc = "a strange rune used to create lifebringers. It glows when spirits are nearby."
	name = "plant rune"
	spawninfo = "lifebringer"
	delchance = 20


/obj/effect/mobspawn/abductor
	desc = "a strange rune used to create abductors. It glows when spirits are nearby."
	name = "abductor rune"
	spawninfo = "abductor"
	delchance = 85

/obj/effect/mobspawn/flyperson
	desc = "a strange rune used to create flies. It glows when spirits are nearby."
	name = "fly rune"
	spawninfo = "flyperson"
	delchance = 45

/obj/effect/mobspawn/shadowperson
	desc = "a strange rune used to create shadows. It glows when spirits are nearby."
	name = "shadow rune"
	spawninfo = "shadowperson"
	delchance = 45

/obj/effect/mobspawn/skrell
	desc = "a strange rune used to create aquatic humanoids. It glows when spirits are nearby."
	name = "skrell rune"
	spawninfo = "skrell"
	delchance = 15

/obj/effect/mobspawn/lizard
	desc = "a strange rune used to create lizards. It glows when spirits are nearby."
	name = "lizard rune"
	spawninfo = "lizard2"
	delchance = 15

/obj/effect/mobspawn/cyborg
	desc = "a strange rune used to create cyborgs. It glows when spirits are nearby."
	name = "cyborg rune"
	spawninfo = "cyborg"
	delchance = 50

/obj/effect/mobspawn/monkey
	desc = "a strange rune used to create monkeys. It glows when spirits are nearby."
	name = "monkey rune"
	spawninfo = "monkey"
	delchance = 10

/obj/effect/mobspawn/syndicate
	desc = "a strange rune used to create syndies. It glows when spirits are nearby."
	name = "syndicate rune"
	spawninfo = "syndie"
	delchance = 45

/obj/effect/mobspawn/cult
	desc = "a strange rune used to create cultists. It glows when spirits are nearby."
	name = "cultist rune"
	spawninfo = "cult"
	delchance = 30

/obj/effect/mobspawn/slime
	desc = "a strange rune used to create slimes. It glows when spirits are nearby."
	name = "slime rune"
	spawninfo = "slime"
	delchance = 20

/obj/effect/mobspawn/alien
	desc = "a strange rune used to create aliens. It glows when spirits are nearby."
	name = "alien rune"
	spawninfo = "alien"
	delchance = 33

/obj/effect/mobspawn/larva
	desc = "a strange rune used to create larvas. It glows when spirits are nearby."
	name = "larva rune"
	spawninfo = "larva"
	delchance = 5

/obj/effect/mobspawn/resomi
	desc = "a strange rune used to create bipedal saurians. It glows when spirits are nearby."
	name = "resomi rune"
	spawninfo = "resomi"
	delchance = 10

/obj/effect/mobspawn/assistant
	name = "assistant rune"
	rank = "Assistant"
	delchance = 5

/obj/effect/mobspawn/atmostech
	name = "atmospheric rune"
	rank = "Atmospheric Technician"
	delchance = 10

/obj/effect/mobspawn/cargotech
	name = "cargo rune"
	rank = "Cargo Technician"
	delchance = 10

/obj/effect/mobspawn/chaplain
	name = "chaplain rune"
	rank = "Chaplain"
	delchance = 75

/obj/effect/mobspawn/lawyer
	name = "lawyer rune"
	rank = "Lawyer"
	delchance = 75

/obj/effect/mobspawn/librarian
	name = "librarian rune"
	rank = "Librarian"
	delchance = 75

/obj/effect/mobspawn/captain
	name = "captain rune"
	rank = "Captain"
	delchance = 100

/obj/effect/mobspawn/hop
	name = "HoP rune"
	rank = "Head of Personnel"
	delchance = 100

/obj/effect/mobspawn/hos
	name = "HoS rune"
	rank = "Head of Security"
	delchance = 100

/obj/effect/mobspawn/ce
	name = "CE rune"
	rank = "Chief Engineer"
	delchance = 100

/obj/effect/mobspawn/rd
	name = "RD rune"
	rank = "Research Director"
	delchance = 100

/obj/effect/mobspawn/cmo
	name = "CMO rune"
	rank = "Chief Medical Officer"
	delchance = 100

/obj/effect/mobspawn/engineer
	name = "engineer rune"
	rank = "Station Engineer"
	delchance = 15

/obj/effect/mobspawn/doctor
	name = "doctor rune"
	rank = "Medical Doctor"
	delchance = 15

/obj/effect/mobspawn/geneticist
	name = "geneticist rune"
	rank = "Geneticist"
	delchance = 25

/obj/effect/mobspawn/virologist
	name = "virologist rune"
	rank = "Virologist"
	delchance = 25

/obj/effect/mobspawn/chemist
	name = "chemist rune"
	rank = "Chemist"
	delchance = 25

/obj/effect/mobspawn/scientist
	name = "scientist rune"
	rank = "Scientist"
	delchance = 15

/obj/effect/mobspawn/roboticist
	name = "roboticist rune"
	rank = "Roboticist"
	delchance = 25

/obj/effect/mobspawn/bartender
	name = "bartender rune"
	rank = "Bartender"
	delchance = 45

/obj/effect/mobspawn/botanist
	name = "botanist rune"
	rank = "Botanist"
	delchance = 20

/obj/effect/mobspawn/chef
	name = "chef rune"
	rank = "Chef"
	delchance = 45

/obj/effect/mobspawn/janitor
	name = "janitor rune"
	rank = "Janitor"
	delchance = 25

/obj/effect/mobspawn/quartermaster
	name = "quartermaster rune"
	rank = "Quartermaster"
	delchance = 100

/obj/effect/mobspawn/miner
	name = "miner rune"
	rank = "Shaft Miner"
	delchance = 30

/obj/effect/mobspawn/clown
	name = "clown rune"
	rank = "Clown"
	delchance = 45

/obj/effect/mobspawn/mime
	name = "mime rune"
	rank = "Mime"
	delchance = 45

/obj/effect/mobspawn/warden
	name = "warden rune"
	rank = "Warden"
	delchance = 45

/obj/effect/mobspawn/detective
	name = "detective rune"
	rank = "Detective"
	delchance = 45

/obj/effect/mobspawn/security
	name = "security rune"
	rank = "Security Officer"
	delchance = 30

/obj/effect/mobspawn/ninja
	name = "ninja rune"
	spawninfo = "ninja"
	delchance = 80

/obj/effect/mobspawn/changeling
	name = "changeling rune"
	spawninfo = "changeling"
	delchance = 55

/obj/effect/mobspawn/deathcommando
	name = "deathsquad rune"
	spawninfo = "deathsquad"
	delchance = 80

/obj/effect/mobspawn/serpent
	name = "serpent rune"
	desc = "a strange rune used to create giant armored serpentids. It glows when spirits are nearby."
	delchance = 33
	spawninfo = "serpent"

/obj/effect/mobspawn/ai
	name = "ai rune"
	delchance = 100
	desc = "a strange rune used to create artificial intelligence. It glows when spirits are nearby."
	spawninfo = "ai"

/obj/effect/mobspawn/plasmaman
	name = "plasmaman rune"
	delchance = 24
	desc = "a strange rune used to create plasmamen. It glows when spirits are nearby."
	spawninfo = "plasmaman"

/obj/effect/mobspawn/ogre
	name = "ogre rune"
	delchance = 24
	desc = "a strange rune used to create space ogres. It glows when spirits are nearby."
	spawninfo = "ogre"

/obj/effect/mobspawn/test_subject
	name = "test subject rune"
	delchance = 5
	desc = "a strange rune used to create test subjects. It glows when spirits are nearby."
	spawnuniform = /obj/item/clothing/under/rank/medical/purple
	customjob = "Test Subject"
	spawnmask = /obj/item/clothing/mask/surgical
	spawnhelmet = /obj/item/clothing/head/helmet/space/rig/medical{name = "face cover"}
	spawnsuit = /obj/item/clothing/suit/straight_jacket
	spawnshoes = /obj/item/clothing/shoes/white
	spawnback = /obj/item/weapon/storage/backpack/satchel_med
	spawnradio = /obj/item/device/radio/headset/headset_med
	spawnglasses = /obj/item/clothing/glasses/sunglasses/blindfold

/obj/effect/mobspawn/prisoner
	name = "prisoner rune"
	delchance = 5
	desc = "a strange rune used to create convicts. It glows when spirits are nearby."
	spawnshoes = /obj/item/clothing/shoes/orange
	spawnuniform = /obj/item/clothing/under/color/orange

/obj/effect/mobspawn/wizard
	name = "wizard rune"
	delchance = 78
	desc = "We've gone full circle."
	spawninfo = "wizard"
	spawnshoes = /obj/item/clothing/shoes/sandal
	spawnsuit = /obj/item/clothing/suit/wizrobe
	spawnhelmet = /obj/item/clothing/head/wizard
	spawnuniform = /obj/item/clothing/under/purple

/obj/effect/mobspawn/nurse
	name = "nurse rune"
	delchance = 33
	customjob = "Nurse"
	spawnradio = /obj/item/device/radio/headset/headset_med
	spawnback = /obj/item/weapon/storage/backpack/satchel_med
	spawnbelt = /obj/item/weapon/storage/belt/medical
	spawngloves = /obj/item/clothing/gloves/latex
	spawnmask = /obj/item/clothing/mask/surgical
	spawnpocket1 = /obj/item/device/flashlight/pen
	spawnshoes = /obj/item/clothing/shoes/white
	spawnsuit = /obj/item/clothing/suit/apron/surgical
	spawnuniform = /obj/item/clothing/under/rank/nursesuit
	spawnhelmet = /obj/item/clothing/head/nursehat

/obj/effect/mobspawn/tourist
	name = "tourist rune"
	delchance = 20
	customjob = "Tourist"
	spawnback = /obj/item/weapon/storage/backpack/satchel
	spawnbelt = /obj/item/device/camera
	spawnglasses = /obj/item/clothing/glasses/sunglasses
	spawnpocket1 = /obj/item/weapon/storage/wallet/random
	spawnradio = /obj/item/device/radio/headset
	spawnshoes = /obj/item/clothing/shoes/tourist
	spawnuniform = /obj/item/clothing/under/tourist

/obj/effect/mobspawn/mailman
	name = "mailman rune"
	delchance = 40
	customjob = "Postman"
	spawnback = /obj/item/weapon/storage/backpack/santabag{name = "cargo bag"}
	spawnradio = /obj/item/device/radio/headset/headset_srv
	spawnshoes = /obj/item/clothing/shoes/brown
	spawnhelmet = /obj/item/clothing/head/mailman
	spawnuniform = /obj/item/clothing/under/rank/mailman

/obj/effect/mobspawn/waiter
	name = "waiter rune"
	delchance = 20
	customjob = "Waiter"
	spawnshoes = /obj/item/clothing/shoes/laceup
	spawnuniform = /obj/item/clothing/under/waiter
	spawnradio = /obj/item/device/radio/headset/headset_srv
	spawnpocket1 = /obj/item/weapon/barcodescanner


