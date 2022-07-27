/mob/living/simple_animal/hostile/retaliate/deathsquad
	name = "Death Commando"
	desc = "Rip and tear."
	icon_state = "deathsquad"
	icon_living = "deathsquad"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 200
	health = 200
	harm_intent_damage = 5
	melee_damage_lower = 30
	melee_damage_upper = 30
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/deathsquad
	var/weapon1 = /obj/item/weapon/gun/energy/pulse_rifle
	var/weapon2
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
	wall_smash = 1
	faction = "neutral"
	status_flags = CANPUSH
	ranged = 1
	gender = "male"
	projectilesound = 'sound/weapons/pulse.ogg'
	projectiletype = /obj/item/projectile/beam/pulse
	turns_per_move = 1
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/deathsquad/Die()
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