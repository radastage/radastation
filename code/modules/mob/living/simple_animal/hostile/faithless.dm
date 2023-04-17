/mob/living/simple_animal/hostile/faithless
	name = "Faithless"
	desc = "The Wish Granter's faith in humanity, incarnate"
	icon_state = "faithless"
	icon_living = "faithless"
	icon_dead = "faithless_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "passes through the"
	response_disarm = "shoves"
	response_harm = "hits the"
	speed = -1
	maxHealth = 80
	health = 80

	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "grips"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	faction = "faithless"

/mob/living/simple_animal/hostile/faithless/deity
	name = "Deity"
	desc = "A strange entity, emitting bright aura around its body."
	icon = 'icons/mob/mob.dmi'
	icon_state = "god"
	health = 400
	maxHealth = 400
	attacktext = "curses"
	attack_sound = 'sound/hallucinations/growl3.ogg'
	harm_intent_damage = 10
	ranged = 1
	projectiletype = /obj/item/projectile/beam/mindflayer
	projectilesound = 'sound/hallucinations/growl3.ogg'
	luminosity = 7

/mob/living/simple_animal/hostile/faithless/horror
	name = "horror"
	desc = "Straight from your nightmares"
	icon = 'icons/mob/mob.dmi'
	icon_state = "horror"
	health = 200
	maxHealth = 200
	attack_sound = 'sound/hallucinations/growl2.ogg'

/mob/living/simple_animal/hostile/faithless/horror/Die()
	playsound(src.loc, 'sound/hallucinations/far_noise.ogg', 50, 1, -1)
	emote("explodes into pieces!")
	new /obj/effect/gibspawner/generic(src.loc)
	del(src)

/mob/living/simple_animal/hostile/faithless/deity/FindTarget()
	. = ..()
	if(.)
		emote("curses [.]")

/mob/living/simple_animal/hostile/faithless/deity/New()
	..()
	src.icon += rgb(rand(0,155), rand(0,155), rand(0,155))
	if(prob(15))
		src.desc = "How can you kill a god?"

/mob/living/simple_animal/hostile/faithless/deity/Die()
	playsound(src.loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
	emote("is devoured by tear in reality!")
	new /obj/effect/expl_particles(src.loc)
	del(src)

/mob/living/simple_animal/hostile/faithless/deity/MoveToTarget()
	stop_automated_movement = 1
	if(!target_mob || SA_attackable(target_mob))
		stance = HOSTILE_STANCE_IDLE
	if(target_mob in ListTargets())
		if(ranged && prob(50))
			if(get_dist(src, target_mob) <= 6)
				OpenFire(target_mob)
			else
				walk_to(src, target_mob, 1, move_to_delay)
		else
			stance = HOSTILE_STANCE_ATTACKING
			new /obj/effect/effect/sparks(src.loc)
			emote("blinks to [target_mob]!")
			src.loc = target_mob.loc
			walk_to(src, target_mob, 1, move_to_delay)

/mob/living/simple_animal/hostile/faithless/Process_Spacemove(var/check_drift = 0)
	return 1

/mob/living/simple_animal/hostile/faithless/FindTarget()
	. = ..()
	if(.)
		emote("wails at [.]")

/mob/living/simple_animal/hostile/faithless/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(12))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/zombie
	name = "zombie"
	desc = "They hunger!"
	icon = 'icons/mob/human.dmi'
	icon_state = "zombie_s"
	icon_living = "zombie_s"
	icon_dead = "zombie_l"
	speak_chance = 15
	turns_per_move = 15
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits the"
	speed = 5
	maxHealth = 50
	health = 50

	harm_intent_damage = 10
	melee_damage_lower = 1
	melee_damage_upper = 15
	attacktext = "gnaws"
	attack_sound = 'sound/weapons/bite.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	faction = "zombie"
	speak = list("Braaaains...","Urgh...","Fresh meat...","...")
	speak_emote = list("growls","grunts","yells", "says", "moans", "roars")
	emote_hear = list("cries","yells", "says something")
	emote_see = list("gasps", "sniffs", "twitches violently", "goes pale for a second", "drools", "frowns", "coughs")

	speak_chance = 1

/mob/living/simple_animal/hostile/zombie/AttackingTarget()
	..()
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		if(L.reagents)
			L.reagents.add_reagent("toxin", 3)
			if(prob(15))
				L << "\red You feel a tiny prick."
				L.reagents.add_reagent("mindbreaker", 5)
				if(prob(15))
					if(istype(L, /mob/living/carbon/human))
						var/mob/living/carbon/human/H = L
						if(H.dna && H:dna:mutantrace == null)
							H:dna:mutantrace = "zombie"
							H.faction = "zombie"
