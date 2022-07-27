/datum/round_event_control/alienspawn
	name = "Alien Invasion"
	typepath = /datum/round_event/alienspawn
	weight = 15
	max_occurrences = 3

/datum/round_event/alienspawn/announce()
	command_alert("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert")
	world << sound('sound/AI/aliens.ogg')

/datum/round_event/alienspawn/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	for(var/area/maintenance/A in world)
		for(var/turf/simulated/floor/plating/F in A)
			if(!F.contents.len)
				turfs += F

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/simulated/floor/plating/T = pick(turfs)
		spawn(0)	new/mob/living/simple_animal/hostile/alien/random(T) //spawn a controller at turf






