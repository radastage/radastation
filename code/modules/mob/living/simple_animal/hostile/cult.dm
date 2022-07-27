/mob/living/simple_animal/hostile/cult
	name = "Blood Cultist"
	desc = "NAR-SIE HAS RISEN."
	icon_state = "cult"
	icon_living = "cult"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 150
	health = 150
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/cult
	var/weapon1
	var/weapon2
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	faction = "cult"
	gender = "male"
	status_flags = CANPUSH
	wander = 0
	attack_sound = 'sound/weapons/punch1.ogg'



/mob/living/simple_animal/hostile/cult/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	if(weapon2)
		new weapon2 (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/cult/meleecult
	weapon1 = /obj/item/weapon/melee/cultblade
	icon_state = "meleecult"
	icon_living = "meleecult"
	melee_damage_lower = 30
	melee_damage_upper = 35
	attacktext = "stabbed"
	wall_smash = 1
	attack_sound = null

/mob/living/simple_animal/hostile/cult/space
	corpse = /obj/effect/landmark/mobcorpse/cultspace
	maxHealth = 180
	health = 180
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	icon_state = "cultspace"
	icon_living = "cultspace"
	speed = 0
	wander = 1
	turns_per_move = 1

/mob/living/simple_animal/hostile/cult/meleecult/space
	corpse = /obj/effect/landmark/mobcorpse/cultspace
	maxHealth = 180
	health = 180
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	icon_state = "cultspacemelee"
	icon_living = "cultspacemelee"
	speed = 0
	wander = 1
	turns_per_move = 1

/mob/living/simple_animal/hostile/construct/random/New()
	var/list/randommob
	var/list/mbspwn = list(		/mob/living/simple_animal/hostile/construct/builder				= 4,
								/mob/living/simple_animal/hostile/construct/wraith				= 3,
								/mob/living/simple_animal/hostile/construct/armoured			= 2
																								)

	randommob = pickweight(mbspwn)
	new randommob(get_turf(src))
	del(src)

/mob/living/simple_animal/hostile/spawner/cult
	name = "pylon"
	maxHealth = 200
	health = 200
	icon = 'icons/obj/cult.dmi'
	icon_state = "pylon"
	mob_type = /mob/living/simple_animal/hostile/construct/random
	faction = "cult"
	spawn_text = "summoned by"