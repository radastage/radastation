/mob/living/simple_animal/hostile/russian
	name = "Russian"
	desc = "For the Motherland!"
	icon_state = "russianmelee"
	icon_living = "russianmelee"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "slashes"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/russian
	var/weapon1 = /obj/item/weapon/kitchenknife
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	faction = "russian"
	gender = "male"
	status_flags = CANPUSH
	wall_smash = 1
	wander = 0



/mob/living/simple_animal/hostile/russian/ranged
	icon_state = "russianranged"
	icon_living = "russianranged"
	corpse = /obj/effect/landmark/mobcorpse/russian/ranged
	attacktext = "punches"
	weapon1 = /obj/item/weapon/gun/projectile/mateba
	ranged = 1
	projectiletype = /obj/item/projectile/bullet
	projectilesound = 'sound/weapons/Gunshot.ogg'
	casingtype = /obj/item/ammo_casing/a357
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/russian/spacerussian
	icon_state = "russianspace"
	icon_living = "russianspace"
	weapon1 = null
	melee_damage_lower = 10
	melee_damage_upper = 10
	maxHealth = 120
	health = 120
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	corpse = /obj/effect/landmark/mobcorpse/spacerussian
	attacktext = "punches"

/mob/living/simple_animal/hostile/russian/scout
	name = "Russian Scout"
	icon_state = "russianscout"
	icon_living = "russianscout"
	corpse = /obj/effect/landmark/femalemobcorpse/russianscout
	wall_smash = 0
	weapon1 = null
	melee_damage_lower = 10
	melee_damage_upper = 10
	gender = "female"
	attacktext = "punches"
	wander = 1
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/russian/ranged/trooper
	name = "Russian Trooper"
	weapon1 = /obj/item/weapon/gun/projectile/shotgun/pump/combat
	icon_state = "russiantrooper"
	icon_state = "russiantrooper"
	maxHealth = 110
	health = 110
	ranged = 1
	projectilesound = 'sound/weapons/Gunshot.ogg'
	projectiletype = /obj/item/projectile/bullet
	casingtype = /obj/item/ammo_casing/shotgun
	corpse = /obj/effect/landmark/mobcorpse/russiantrooper


/mob/living/simple_animal/hostile/russian/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	del src
	return
