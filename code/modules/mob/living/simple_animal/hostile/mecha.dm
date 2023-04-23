/mob/living/simple_animal/hostile/retaliate/mecha
	name = "APLU \"Ripley\""
	wander = 0
	faction = "neutral"
	friendly = "pushes"
	health = 200
	melee_damage_lower = 30
	melee_damage_upper = 30
	attacktext = "rams into"
	attack_sound = 'sound/mecha/mechturn.ogg'
	desc = "Autonomous Power Loader Unit. The workhorse of the exosuit world."
	icon = 'icons/mecha/mecha.dmi'
	icon_state = "ripley"
	var/emerge_mob = /mob/living/simple_animal/hostile/retaliate/thunderdomer
	var/wreckage = /obj/structure/mecha_wreckage/ripley

/mob/living/simple_animal/hostile/retaliate/mecha/Die()
	visible_message("<b>[src]</b> blows apart!")
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new wreckage(src.loc)
	new emerge_mob(src.loc)
	del(s)
	del(src)

/mob/living/simple_animal/hostile/retaliate/mecha/gib()
	visible_message("<b>[src]</b> blows apart!")
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new wreckage(src.loc)
	del(s)
	del(src)

/mob/living/simple_animal/hostile/retaliate/mecha/nanotrasen
	name = "Gygax"
	wander = 1
	faction = "nanotrasen"
	health = 300
	melee_damage_lower = 30
	melee_damage_upper = 30
	attacktext = "slams into"
	desc = "A lightweight, security exosuit. Popular among private and corporate security."
	icon_state = "gygax"
	emerge_mob = /mob/living/simple_animal/hostile/retaliate/nanotrasen
	wreckage = /obj/structure/mecha_wreckage/gygax

/mob/living/simple_animal/hostile/retaliate/mecha/syndicate
	name = "Marauder"
	wander = 1
	faction = "syndicate"
	health = 500
	melee_damage_lower = 45
	melee_damage_upper = 45
	attacktext = "mauls"
	desc = "Heavy-duty, combat exosuit, developed after the Durand model. Rarely found among civilian populations."
	icon_state = "marauder"
	emerge_mob = /mob/living/simple_animal/hostile/syndicate
	wreckage = /obj/structure/mecha_wreckage/marauder

