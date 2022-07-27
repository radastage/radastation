/mob/living/simple_animal/hostile/retaliate/centcom
	name = "CentCom Officer"
	desc = "Glory to CentCom."
	icon_state = "centcom"
	icon_living = "centcom"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 80
	health = 80
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/centcom
	var/weapon1
	var/weapon2
	var/conf_access = 50
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	wall_smash = 0
	faction = "neutral"
	gender = "male"
	status_flags = CANPUSH
	wander = 0
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/centcom/Die()
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

/mob/living/simple_animal/hostile/retaliate/centcom/centcomranged
	weapon1 = /obj/item/weapon/gun/projectile/shotgun/pump/combat
	icon_state = "centcomranged"
	icon_living = "centcomranged"
	maxHealth = 110
	health = 110
	ranged = 1
	projectilesound = 'sound/weapons/Gunshot.ogg'
	projectiletype = /obj/item/projectile/bullet
	casingtype = /obj/item/ammo_casing/shotgun
	corpse = /obj/effect/landmark/mobcorpse/centcomranged


/mob/living/simple_animal/hostile/retaliate/centcom/centcomcommander
	name = "CentCom Commander"
	maxHealth = 125
	health = 125
	weapon1 = /obj/item/weapon/gun/projectile/mateba
	melee_damage_lower = 10
	melee_damage_upper = 15
	icon_state = "centcomcommander"
	icon_living = "centcomcommander"
	corpse = /obj/effect/landmark/mobcorpse/centcomcommander
	ranged = 1
	gender = "male"
	projectiletype = /obj/item/projectile/bullet
	projectilesound = 'sound/weapons/Gunshot.ogg'
	casingtype = /obj/item/ammo_casing/a357

