/mob/living/simple_animal/hostile/retaliate/thunderdomer
	name = "Thunderdomer"
	desc = "A brave arena warrior."
	icon_state = "thunderdomer"
	icon_living = "thunderdomer"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 110
	health = 110
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/thunderdomer
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
	wall_smash = 0
	faction = "neutral"
	gender = "male"
	wander = 0
	status_flags = CANPUSH
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/thunderdomer/Die()
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

/mob/living/simple_animal/hostile/retaliate/thunderdomer/rangedthunderdomer
	weapon1 = /obj/item/weapon/gun/energy/pulse_rifle/destroyer
	icon_state = "rangedthunderdomer"
	icon_living = "rangedthunderdomer"
	desc = "A brave arena warrior, equipped with a pulse destroyer."
	ranged = 1
	projectilesound = 'sound/weapons/pulse.ogg'
	projectiletype = /obj/item/projectile/beam/pulse

/mob/living/simple_animal/hostile/retaliate/thunderdomer/meleethunderdomer
	weapon1 = /obj/item/weapon/kitchenknife
	icon_state = "meleethunderdomer"
	icon_living = "meleethunderdomer"
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "slashes"
	attack_sound = null

/mob/living/simple_animal/hostile/retaliate/thunderdomer/heavythunderdomer
	maxHealth = 150
	health = 150
	weapon1 = /obj/item/weapon/melee/energy/sword/red
	melee_damage_lower = 20
	melee_damage_upper = 25
	attacktext = "slashes"
	icon_state = "thunderdomerheavy"
	icon_living = "thunderdomerheavy"
	corpse = /obj/effect/landmark/mobcorpse/thunderdomerheavy
	wall_smash = 1
	wander = 1
	turns_per_move = 1
	attack_sound = null

