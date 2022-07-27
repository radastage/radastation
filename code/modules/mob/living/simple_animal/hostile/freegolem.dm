/mob/living/simple_animal/hostile/retaliate/freegolem
	name = "Adamantine Golem"
	desc = "Free golem."
	icon_state = "golemmale"
	icon_living = "golemmale"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = 2
	stop_automated_movement_when_pulled = 0
	maxHealth = 140
	health = 140
	harm_intent_damage = 5
	melee_damage_lower = 1
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/golemcorpse/golem
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
	wall_smash = 1
	faction = "golem"
	gender = "male"
	wander = 1
	status_flags = CANPUSH
	luminosity = 6
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/freegolem/Die()
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

/mob/living/simple_animal/hostile/retaliate/freegolem/pickaxe
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "pierced"
	desc = "Free golem. This one is holding a pickaxe in his hand."
	weapon1 = /obj/item/weapon/pickaxe
	icon_state = "golemmalepick"
	icon_living = "golemmalepick"

/mob/living/simple_animal/hostile/retaliate/freegolem/female
	gender = "female"
	corpse = /obj/effect/landmark/golemcorpsefemale/golem
	icon_state = "golemfemale"
	icon_living = "golemfemale"

/mob/living/simple_animal/hostile/retaliate/freegolem/pickaxe/female
	gender = "female"
	desc = "Free golem. This one is holding a pickaxe in her hand."
	corpse = /obj/effect/landmark/golemcorpsefemale/golem
	icon_state = "golemfemalepick"
	icon_living = "golemfemalepick"


/mob/living/simple_animal/hostile/retaliate/freegolem/random/proc/spawnrandom()
	var/list/mbspwn = list(	/mob/living/simple_animal/hostile/retaliate/freegolem/pickaxe/female	= 1,
							/mob/living/simple_animal/hostile/retaliate/freegolem/female			= 1,
							/mob/living/simple_animal/hostile/retaliate/freegolem/pickaxe			= 1,
							/mob/living/simple_animal/hostile/retaliate/freegolem					= 1
							)
	var/golemtype = pickweight(mbspwn)
	. = ..()
	new golemtype(src.loc)
	del src
	return
