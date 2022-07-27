/mob/living/simple_animal/hostile/spawner
	name = "monster nest"
	icon = 'icons/mob/animal.dmi'
	health = 100
	maxHealth = 100
	gender = NEUTER
	var/list/spawned_mobs = list()
	var/max_mobs = 5
	var/spawn_delay = 0
	var/spawn_time = 300 //30 seconds default
	var/mob_type = /mob/living/simple_animal/hostile/carp
	var/spawn_text = "emerges from"
	status_flags = 0
	anchored = TRUE
	stop_automated_movement = 1
	wander = 0
	minbodytemp = 0
	maxbodytemp = 350
	stat = 1


/mob/living/simple_animal/hostile/spawner/Life()
	. = ..()
	spawn_mob()

/mob/living/simple_animal/hostile/spawner/Die()
	del src

/mob/living/simple_animal/hostile/spawner/proc/spawn_mob()
	var/list/nearby = viewers(7,src)
	if(nearby.len >= max_mobs)
		return 0
	if(spawn_delay > world.time)
		return 0
//	if(spawned_mobs.len >= max_mobs)
//		return 0
//	if(spawn_delay > world.time)
//		return 0
	spawn_delay = world.time + spawn_time
	var/mob/living/simple_animal/L = new mob_type(src.loc)
	spawned_mobs += L
	L.faction = src.faction
	visible_message("<span class='danger'>[L] [spawn_text] [src].</span>")

/mob/living/simple_animal/hostile/spawner/verb/edit_spawner()
	set name = "Edit Spawner"
	set category = "Object"
	set desc = "Modify that spawner"
	set src in oview(1)

	var/mobtype = copytext(sanitize(input(usr, "What mob type?", "Slot item", "/mob/living/") as null|text),1,999)
	if (!mobtype)
		return

	var/list/matches = get_fancy_list_of_types()
	if (!isnull(mobtype) && mobtype!="")
		matches = filter_fancy_list(matches, mobtype)

	if(matches.len==0)
		return

	var/chosen
	if(matches.len==1)
		chosen = matches[1]
	else
		chosen = input("Select a type", "Mob type", matches[1]) as null|anything in matches
		if(!chosen)
			return
	chosen = matches[chosen]
	mobtype = chosen

	if(src.mob_type)
		src.mob_type = mobtype
