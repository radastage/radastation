/mob/living/simple_animal/hostile/lizardman
	desc = "A sentient lizardperson."
	name = "lizardperson"
	icon = 'icons/mob/human.dmi'
	icon_state = "lizard_m_s"
	icon_dead = "lizard_m_l"
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
	melee_damage_lower = 7
	melee_damage_upper = 7
	attacktext = "scratched"
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
	faction = "lizard"
	gender = "male"
	wander = 1
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/retaliate/lizardman/female
	icon_state = "lizard_f_s"
	icon_dead = "lizard_f_l"
	gender = "female"

/mob/living/simple_animal/hostile/retaliate/lizardman/New()
	..()
	src.name = random_name_lizard(gender)
	src.icon += rgb(rand(0,155), rand(0,155), rand(0,155))

/mob/living/simple_animal/hostile/retaliate/lizardman/Die()
	..()
	visible_message("<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless...")
	return