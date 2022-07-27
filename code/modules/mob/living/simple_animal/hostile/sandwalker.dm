/mob/living/simple_animal/hostile/retaliate/sandwalker
	name = "Sandwalker"
	desc = "A sentient lizardperson. This one is armed with a spear."
	icon_state = "sandwalkermalespear"
	icon_living = "sandwalkermalespear"
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
	melee_damage_lower = 13
	melee_damage_upper = 13
	attacktext = "gored"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/sandwalkercorpse/sandwalker
	var/weapon1 = /obj/item/weapon/twohanded/spear
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
	faction = "sandwalker"
	gender = "male"
	wander = 1
	luminosity = 6
	status_flags = CANPUSH
	attack_sound = 'sound/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/retaliate/sandwalker/initialize()
	..()
	luminosity = 6

/mob/living/simple_animal/hostile/retaliate/sandwalker/Die()
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

/mob/living/simple_animal/hostile/retaliate/sandwalker/unarmedmale
	desc = "A sentient lizardperson."
	icon_state = "sandwalkermale"
	icon_living = "sandwalkermale"
	maxHealth = 100
	health = 100
	attack_sound = 'sound/weapons/punch1.ogg'
	weapon1 = null
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "scratched"

/mob/living/simple_animal/hostile/retaliate/sandwalker/unarmedfemale
	desc = "A sentient lizardperson."
	icon_state = "sandwalkerfemale"
	icon_living = "sandwalkerfemale"
	corpse = /obj/effect/landmark/sandwalkercorpsefemale/sandwalker
	maxHealth = 100
	health = 100
	attack_sound = 'sound/weapons/punch1.ogg'
	weapon1 = null
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "scratched"
	gender = "female"

/mob/living/simple_animal/hostile/retaliate/sandwalker/female
	icon_state = "sandwalkerfemalespear"
	icon_living = "sandwalkerfemalespear"
	corpse = /obj/effect/landmark/sandwalkercorpsefemale/sandwalker
	gender = "female"

/mob/living/simple_animal/hostile/retaliate/sandwalker/random
	name = "Random Sandwalker"

/mob/living/simple_animal/hostile/retaliate/sandwalker/random/New()
	spawnrandom()

/mob/living/simple_animal/hostile/retaliate/sandwalker/random/proc/spawnrandom()
	var/list/mbspwn = list(	/mob/living/simple_animal/hostile/retaliate/sandwalker/female			= 1,
							/mob/living/simple_animal/hostile/retaliate/sandwalker					= 1,
							/mob/living/simple_animal/hostile/retaliate/sandwalker/unarmedfemale	= 1,
							/mob/living/simple_animal/hostile/retaliate/sandwalker/unarmedmale		= 1
							)
	var/sandwalkertype = pickweight(mbspwn)
	. = ..()
	new sandwalkertype(src.loc)
	del src
	return