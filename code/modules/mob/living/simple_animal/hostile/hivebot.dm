/obj/item/projectile/hivebotbullet
	damage = 15
	damage_type = BRUTE

/obj/item/weapon/gun/energy/hivegun
	cell_type = null
	charge_cost = 0
	projectile_type = "/obj/item/projectile/hivebotbullet"
	icon_state = "hivegun"
	name = "hivegun"
	desc = "Part of a hivebot."
	fire_sound = 'sound/weapons/Gunshot.ogg'


/mob/living/simple_animal/hostile/hivebot
	name = "hivebot"
	desc = "A small robot"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "basic"
	icon_living = "basic"
	icon_dead = "basic"
	health = 10
	maxHealth = 10
	melee_damage_lower = 1
	melee_damage_upper = 2
	attacktext = "claws"
	projectilesound = 'sound/weapons/Gunshot.ogg'
	projectiletype = /obj/item/projectile/hivebotbullet
	faction = "hivebot"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	isrobot = 1

/mob/living/simple_animal/hostile/hivebot/range
	name = "hivebot"
	desc = "A smallish robot, this one is armed!"
	ranged = 1

/mob/living/simple_animal/hostile/hivebot/rapid
	ranged = 1
	rapid = 1

/mob/living/simple_animal/hostile/hivebot/strong
	name = "strong hivebot"
	desc = "A robot, this one is armed and looks tough!"
	icon_state = "EngBot"
	health = 50
	ranged = 1
	rapid = 1


/mob/living/simple_animal/hostile/hivebot/Die()
	..()
	visible_message("<b>[src]</b> blows apart!")
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	if(prob(10))
		new /obj/item/weapon/pickaxe/hivebot(src.loc)
	else if(prob(5))
		new /obj/item/clothing/suit/armor/vest/hivebot(src.loc)
	else if(prob(5))
		new /obj/item/clothing/head/helmet/hivebot(src.loc)
	else if(prob(1))
		new /obj/item/weapon/gun/energy/hivegun(src.loc)
	del src
	return

/*
/mob/living/simple_animal/hostile/hivebot/tele//this still needs work
	name = "Beacon"
	desc = "Some odd beacon thing"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "def_radar-off"
	icon_living = "def_radar-off"
	health = 200
	maxHealth = 200
	status_flags = 0
	anchored = 1
	stop_automated_movement = 1
	var/bot_type = "norm"
	var/bot_amt = 10
	var/spawn_delay = 600
	var/turn_on = 0
	var/auto_spawn = 1
	proc
		warpbots()


	New()
		..()
		var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
		smoke.set_up(5, 0, src.loc)
		smoke.start()
		visible_message("\red <B>The [src] warps in!</B>")
		playsound(src.loc, 'sound/effects/EMPulse.ogg', 25, 1)

	warpbots()
		icon_state = "def_radar"
		visible_message("\red The [src] turns on!")
		while(bot_amt > 0)
			bot_amt--
			switch(bot_type)
				if("norm")
					new /mob/living/simple_animal/hostile/hivebot(get_turf(src))
				if("range")
					new /mob/living/simple_animal/hostile/hivebot/range(get_turf(src))
				if("rapid")
					new /mob/living/simple_animal/hostile/hivebot/rapid(get_turf(src))
		spawn(100)
			del(src)
		return


	Life()
		..()
		if(stat == 0)
			if(prob(2))//Might be a bit low, will mess with it likely
				warpbots()



*/
/mob/living/simple_animal/hostile/spawner/hivebot
	name = "hivebot beacon"
	maxHealth = 200
	health = 200
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "def_radar-off"
	icon_living = "def_radar-off"
	mob_type = /mob/living/simple_animal/hostile/hivebot/random
	faction = "hivebot"
	spawn_text = "warps in by"



/mob/living/simple_animal/hostile/hivebot/random/New()
	var/list/randommob
	var/list/mbspwn = list(	/mob/living/simple_animal/hostile/hivebot/strong				= 2,
							/mob/living/simple_animal/hostile/hivebot/rapid					= 3,
							/mob/living/simple_animal/hostile/hivebot/range					= 4,
							/mob/living/simple_animal/hostile/hivebot						= 5
							)
	randommob = pickweight(mbspwn)
	new randommob(get_turf(src))
	del(src)

