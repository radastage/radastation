/mob/living/simple_animal/hostile/retaliate/spaceninja
	name = "Space Ninja"
	desc = "Elite mercenary assassin of the mighty Spider Clan."
	icon = 'icons/mob/mob.dmi'
	icon_state = "s-ninja"
	icon_living = "s-ninja"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement_when_pulled = 0
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 20
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/malemobcorpse/spaceninja
	var/weapon1
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
	gender = "male"
	status_flags = CANPUSH
	turns_per_move = 1
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/spaceninja/Die()
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

/mob/living/simple_animal/hostile/retaliate/spaceninja/femalespaceninja
	icon_state = "s-ninjaf"
	icon_living = "s-ninjaf"
	corpse = /obj/effect/landmark/femalemobcorpse/femalespaceninja
	gender = "female"