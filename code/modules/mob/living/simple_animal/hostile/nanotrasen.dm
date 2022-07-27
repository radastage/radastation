/mob/living/simple_animal/hostile/retaliate/nanotrasen
	name = "Nanotrasen Security"
	desc = "Glory to Nanotrasen."
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 1
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
	var/corpse = /obj/effect/landmark/mobcorpse/nanotrasen
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
	faction = "nanotrasen"
	gender = "male"
	status_flags = CANPUSH
	wander = 1
	attack_sound = 'sound/weapons/punch1.ogg'

/mob/living/simple_animal/hostile/retaliate/nanotrasen/Die()
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


/mob/living/simple_animal/hostile/retaliate/nanotrasen/ranged
	icon_state = "nanotrasenranged"
	icon_living = "nanotrasenranged"
	weapon1 = /obj/item/weapon/gun/projectile/mateba
	ranged = 1
	projectiletype = /obj/item/projectile/bullet
	projectilesound = 'sound/weapons/Gunshot.ogg'
	casingtype = /obj/item/ammo_casing/a357

/mob/living/simple_animal/hostile/retaliate/nanotrasen/ranged/smg
	weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
	ranged = 1
	rapid = 1
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	casingtype = /obj/item/ammo_casing/a12mm
	projectilesound = 'sound/weapons/Gunshot_smg.ogg'
	projectiletype = /obj/item/projectile/bullet/midbullet2

/mob/living/simple_animal/hostile/retaliate/nanotrasen/hos
	name = "Nanotrasen Head of Security"
	maxHealth = 200
	health = 200
	icon_state = "nanotrasenhos"
	icon_living = "nanotrasenhos"
	corpse = /obj/effect/landmark/mobcorpse/nanotrasenhos
	weapon1 = /obj/item/weapon/gun/energy/laser
	ranged = 1
	projectiletype = /obj/item/projectile/beam/heavylaser
	projectilesound = 'sound/weapons/Laser.ogg'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	corpse = /obj/effect/landmark/mobcorpse/nanotrasenhos

/mob/living/simple_animal/hostile/retaliate/nanotrasen/warden
	name = "Nanotrasen Warden"
	maxHealth = 125
	health = 125
	icon_state = "nanotrasenwarden"
	icon_living = "nanotrasenwarden"
	weapon1 = /obj/item/weapon/gun/energy/laser
	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/Laser.ogg'
	corpse = /obj/effect/landmark/mobcorpse/nanotrasenwarden

/mob/living/simple_animal/hostile/retaliate/nanotrasen/space
	maxHealth = 125
	health = 125
	icon_state = "nanotrasenspace"
	icon_living = "nanotrasenspace"
	weapon1 = /obj/item/weapon/gun/energy/laser
	ranged = 1
	projectiletype = /obj/item/projectile/beam/heavylaser
	projectilesound = 'sound/weapons/Laser.ogg'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	corpse = /obj/effect/landmark/mobcorpse/nanotrasenspace

/mob/living/simple_animal/hostile/retaliate/nanotrasen/scout
	name = "Nanotrasen Scout"
	corpse = /obj/effect/landmark/femalemobcorpse/nanotrasenscout
	icon_state = "nanotrasenscout"
	icon_living = "nanotrasenscout"
	gender = "female"
	melee_damage_lower = 10
	melee_damage_upper = 10
	wall_smash = 0

/mob/living/simple_animal/hostile/spawner/nanotrasen
	name = "nanotrasen security beacon"
	maxHealth = 200
	health = 200
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"
	mob_type = /mob/living/simple_animal/hostile/retaliate/nanotrasen/random
	faction = "nanotrasen"
	spawn_text = "teleported by"

/mob/living/simple_animal/hostile/retaliate/nanotrasen/random/New()
	var/list/randommob
	var/list/mbspwn = list(	/mob/living/simple_animal/hostile/retaliate/nanotrasen/hos		= 1,
							/mob/living/simple_animal/hostile/retaliate/nanotrasen/space	= 1,
							/mob/living/simple_animal/hostile/retaliate/nanotrasen/ranged	= 2,
							/mob/living/simple_animal/hostile/retaliate/nanotrasen			= 2,
							/mob/living/simple_animal/hostile/retaliate/nanotrasen/ranged/smg	= 2,
							/mob/living/simple_animal/hostile/retaliate/nanotrasen/scout	= 2
							)

	randommob = pickweight(mbspwn)
	new randommob(get_turf(src))
	del(src)