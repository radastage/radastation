/mob/living/simple_animal/hostile/ert_commander
	name = "ERT Commander"
	desc = "Elite officer of Nanotrasen Emergency Response Team."
	icon_state = "ert_commander"
	icon_living = "ert_commander"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "hugs the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/ertcommander
	var/weapon1 = /obj/item/weapon/gun/projectile/mateba
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15
	faction = "neutral"
	status_flags = CANPUSH
	ranged = 1
	gender = "male"
	projectiletype = /obj/item/projectile/bullet
	projectilesound = 'sound/weapons/Gunshot.ogg'
	casingtype = /obj/item/ammo_casing/a357
	wall_smash = 1
	wander = 0
	attack_sound = 'sound/weapons/punch1.ogg'


/mob/living/simple_animal/hostile/ert_medical
	name = "ERT Medic"
	desc = "Elite officer of Nanotrasen Emergency Response Team."
	icon_state = "ert_medical"
	icon_living = "ert_medical"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "hugs the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/femalemobcorpse/ertmedical
	var/weapon1
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	gender = "female"
	minbodytemp = 0
	unsuitable_atoms_damage = 15
	faction = "neutral"
	status_flags = CANPUSH
	wander = 0
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/ert_engineer
	name = "ERT Engineer"
	desc = "Elite officer of Nanotrasen Emergency Response Team."
	icon_state = "ert_engineer"
	icon_living = "ert_engineer"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "hugs the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/ertengineer
	var/weapon1
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15
	gender = "male"
	faction = "neutral"
	status_flags = CANPUSH
	wander = 0
	attack_sound = null

/mob/living/simple_animal/hostile/ert_security
	name = "ERT Security"
	icon_state = "ert_security"
	icon_living = "ert_security"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "hugs the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/ertsecurity
	var/weapon1 = /obj/item/weapon/gun/energy/lasercannon
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15
	faction = "neutral"
	gender = "male"
	status_flags = CANPUSH
	projectiletype = "/obj/item/projectile/beam/heavylaser"
	projectilesound = 'sound/weapons/lasercannonfire.ogg'
	ranged = 1
	wall_smash = 1
	turns_per_move = 1
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/ert_security/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/ert_medical/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/ert_commander/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/ert_engineer/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	del src
	return