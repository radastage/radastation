/mob/living/simple_animal/hostile/retaliate/skrell
	desc = "A sentient aquatic humanoid."
	name = "skrell"
	icon = 'icons/mob/human.dmi'
	icon_state = "skrell_m_s"
	icon_dead = "skrell_m_l"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = 0
	stop_automated_movement_when_pulled = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 0
	melee_damage_upper = 9
	attacktext = "punches"
	a_intent = "harm"
	var/corpse
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
	faction = "skrell"
	gender = "male"
	wander = 1
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/retaliate/skrell/female
	icon_state = "skrell_f_s"
	icon_dead = "skrell_f_l"
	gender = "female"

/mob/living/simple_animal/hostile/retaliate/skrell/New()
	..()
	src.name = random_name_skrell()
	src.icon += rgb(rand(0,155), rand(0,155), rand(0,155))

/mob/living/simple_animal/hostile/retaliate/skrell/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	return