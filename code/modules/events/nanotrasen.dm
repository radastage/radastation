/datum/round_event_control/nanotrasen
	name = "Nanotrasen Security Spawn"
	typepath = /datum/round_event/nanotrasen
	weight = 600
	max_occurrences = 1
	earliest_start = 12

/datum/round_event/nanotrasen/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	for(var/area/security/A in world)
		for(var/turf/simulated/floor/F in A)
			if(!F.contents.len)
				turfs += F

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/simulated/floor/T = pick(turfs)
		spawn(0)	new/mob/living/simple_animal/hostile/spawner/nanotrasen(T) //spawn a controller at turf






