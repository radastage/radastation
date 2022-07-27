/mob/living/simple_animal/hostile/cyborg
	name = "Standard Cyborg"
	desc = "The creation of a sick roboticist."
	icon = 'icons/mob/robots.dmi'
	icon_state = "robot"
	icon_living = "robot"
	health = 200
	maxHealth = 300
	melee_damage_lower = 2
	melee_damage_upper = 6
	attacktext = "claws"
	faction = "neutral"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	a_intent = "harm"
	wall_smash = 1
	isrobot = 1
	luminosity = 7

/mob/living/simple_animal/hostile/cyborg/Die()
	createborg()

/mob/living/simple_animal/hostile/cyborg/proc/createborg()
	..()
//	visible_message("<b>[src]</b> shudders violently for a moment, then becomes motionless, its eyes slowly darkening.")
	var/mob/living/silicon/robot/M = new /mob/living/silicon/robot (src.loc)
	..()
	M.icon = icon
	M.icon_state = icon_state
	M.name = name
	M.adjustBruteLoss(301)
	del src
	return

/mob/living/simple_animal/hostile/cyborg/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/weldingtool) && W:welding)
		if (W:remove_fuel(0))
			src.adjustBruteLoss(-30)
			src.updatehealth()
			src.add_fingerprint(user)
			for(var/mob/O in viewers(user, null))
				O.show_message(text("\red [user] has fixed some of the dents on [src]!"), 1)
		else
			user << "Need more welding fuel!"
			return


/mob/living/simple_animal/hostile/cyborg/old
	icon_state = "robot_old"
	icon_living = "robot_old"
	attacktext = "punches"

/mob/living/simple_animal/hostile/cyborg/security
	name = "Security Cyborg"
	icon_state = "bloodhound"
	icon_living = "bloodhound"
	melee_damage_lower = 10
	melee_damage_upper = 30

/mob/living/simple_animal/hostile/cyborg/security/old
	icon_state = "Security"
	icon_living = "Security"
	attacktext = "punches"

/mob/living/simple_animal/hostile/cyborg/security/veryold
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "SecBot"
	icon_living = "SecBot"
	health = 150
	maxHealth = 200
	melee_damage_lower = 5
	melee_damage_upper = 15

/mob/living/simple_animal/hostile/cyborg/security/veryold/old
	icon = 'icons/mob/robots.dmi'
	attacktext = "punches"
	icon_state = "secborg"
	icon_living = "secborg"

/mob/living/simple_animal/hostile/cyborg/random
	name = "Random Cyborg"

/mob/living/simple_animal/hostile/cyborg/random/New()
	spawnrandomborg()

/mob/living/simple_animal/hostile/cyborg/random/proc/spawnrandomborg()
	var/list/mbspwn = list(	/mob/living/simple_animal/hostile/cyborg/security/veryold/old	= 1,
							/mob/living/simple_animal/hostile/cyborg/security/old			= 1,
							/mob/living/simple_animal/hostile/cyborg/security				= 1,
							/mob/living/simple_animal/hostile/cyborg/old					= 2,
							/mob/living/simple_animal/hostile/cyborg						= 2
							)
	var/borgtype = pickweight(mbspwn)
	. = ..()
	new borgtype(src.loc)
	del src
	return

/mob/living/simple_animal/hostile/spawner/cyborg
	name = "cyborg factory"
	icon = 'icons/obj/objects.dmi'
	icon_state = "borgcharger1"
	mob_type = /mob/living/simple_animal/hostile/cyborg/random

/mob/living/simple_animal/hostile/spawner/cyborg/Die()
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new /obj/machinery/recharge_station(src.loc)
	del(src)

/mob/living/simple_animal/hostile/cyborg/FindTarget()

	var/atom/T = null
	stop_automated_movement = 0
	for(var/atom/A in ListTargets())

		var/atom/F = Found(A)
		if(F)
			T = F
			break

		if(isliving(A))
			var/mob/living/L = A
			if(L.faction == src.faction && !attack_same)
				continue
			else if(L in friends)
				continue
			else if(L.faction == "nanotrasen")
				continue
			else
				if(!L.stat)
					stance = HOSTILE_STANCE_ATTACK
					T = L
					break

		else if(istype(A, /obj/mecha)) // Our line of sight stuff was already done in ListTargets().
			var/obj/mecha/M = A
			if (M.occupant)
				stance = HOSTILE_STANCE_ATTACK
				T = M
				break

	return T