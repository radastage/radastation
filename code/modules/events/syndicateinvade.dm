/datum/round_event_control/syndies
	name = "Syndicate Invasion"
	typepath = /datum/round_event/syndies
	weight = 15
	max_occurrences = 3

/datum/round_event/syndies
	var/spawncount = 1

/datum/round_event/syndies/setup()
	spawncount = rand(1, 8)

/datum/round_event/syndies/announce()
	command_alert("Enemy communication intercept.")
	world << sound('sound/AI/intercept.ogg')

/datum/round_event/syndies/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	for(var/area/hallway/A in world)
		for(var/turf/simulated/floor/F in A)
			if(!F.contents.len)
				turfs += F

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/simulated/floor/T = pick(turfs)
		spawn(0)	new/mob/living/simple_animal/hostile/spawner/syndicate(T) //spawn a controller at turf
		spawncount--






