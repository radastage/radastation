/obj/item/weapon/gun/energy/laser/immolator
	name = "CH-PS \"Immolator\" Laser"
	desc = "A heavy laser rifle, powered with a rechargable battery. It scorches people through."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_laser"
	item_state = "mecha_laser"
	projectile_type = "/obj/item/projectile/beam"
	fire_sound = 'sound/weapons/Laser.ogg'
	charge_cost = 0
	recoil = 2
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/laser/immolator/heavy
	name = "CH-LC \"Solaris\" Laser Cannon"
	desc = "A heavy laser rifle, powered with a rechargable battery. It scorches people to ashes."
	projectile_type = "/obj/item/projectile/beam/heavylaser"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	charge_cost = 0
	recoil = 4
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/ionrifle/heavy
	name = "mkIV Ion Heavy Cannon"
	icon = 'icons/mecha/mecha_equipment.dmi'
	desc = "Heavy ion rifle, designed to destroy armies of rogue cyborgs."
	icon_state = "mecha_ion"
	item_state = "mecha_ion"
	projectile_type = "/obj/item/projectile/ion"
	fire_sound = 'sound/weapons/Laser.ogg'
	charge_cost = 0
	recoil = 5
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/pulse_rifle/heavy
	name = "eZ-13 mk2 Heavy pulse rifle"
	icon = 'icons/mecha/mecha_equipment.dmi'
	desc = "A true destroyer's choice. Wield this weapon to take on the world."
	icon_state = "mecha_pulse"
	item_state = "mecha_pulse"
	projectile_type = "/obj/item/projectile/beam/pulse/heavy"
	fire_sound = 'sound/weapons/marauder.ogg'
	charge_cost = 0
	recoil = 8
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/taser/heavy
	name = "PBT \"Pacifier\" Mounted Taser"
	icon = 'icons/mecha/mecha_equipment.dmi'
	desc = "Powerful taser that can neutralize a crowd."
	icon_state = "mecha_taser"
	item_state = "mecha_taser"
	projectile_type = "/obj/item/projectile/energy/electrode"
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 0
	recoil = 5
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/honker
	projectile_type = null
	name = "HoNkER BlAsT 5000"
	desc = "H.O.N.K. TO THE FRONTLINE!"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_honker"
	item_state = "mecha_honker"
	fire_sound = 'sound/items/AirHorn.ogg'
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/honker/attack_self(mob/user)
	playsound(user, fire_sound, 100, 1)
	for(var/mob/living/carbon/M in ohearers(6, user))
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(istype(H.ears, /obj/item/clothing/ears/earmuffs))
				continue
		M << "<font color='red' size='7'>HONK</font>"
		M.sleeping = 0
		M.stuttering += 20
		M.ear_deaf += 30
		M.Weaken(3)
		if(prob(30))
			M.Stun(10)
			M.Paralyse(4)
		else
			M.make_jittery(500)

/obj/item/weapon/gun/energy/scattershot
	name = "LBX AC 10 \"Scattershot\""
	desc = "Firstly manufactured by space pirates, this weapon has proven itself to be quite potent in a battlefield."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_scatter"
	item_state = "mecha_scatter"
	projectile_type = "/obj/item/projectile/bullet/midbullet"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	w_class = 20
	charge_cost = 0
	recoil = 3

	update_icon()
		..()
		icon_state = item_state

/obj/item/weapon/gun/energy/lmg
	name = "Ultra AC 2"
	desc = "Trusty machinegun, usually mounted on combat mechs."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_uac2"
	item_state = "mecha_uac2"
	projectile_type = "/obj/item/projectile/bullet/weakbullet"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	charge_cost = 0
	recoil = 1
	w_class = 20

	update_icon()
		..()
		icon_state = item_state

/*
/obj/item/weapon/gun/energy/missile_rack
	name = "SRM-8 Missile Rack"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_missilerack"
	item_state = "mecha_missilerack"
	projectile_type = "/obj/item/projectile/bullet/gyro"
	fire_sound = 'sound/effects/Explosion1.ogg'

	update_icon()
		..()
		icon_state = item_state

*/

/obj/item/weapon/gun/energy/grenadelauncher
	name = "SGL-6 Grenade Launcher"
	desc = "This weapon shoots small, yet dangerous explosives."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"
	item_state = "mecha_grenadelnchr"
	projectile_type = "/obj/item/projectile/bullet/gyro"
	fire_sound = 'sound/effects/bang.ogg'
	recoil = 1
	charge_cost = 0
	w_class = 20
/*
/obj/item/missile/primed/New()
	primed = 1

/obj/item/weapon/grenade/flashbang/primed/New()
	prime()

/obj/item/weapon/gun/energy/grenadelauncher/cluster
	name = "SOP-6 Grenade Launcher"
	projectile_type = "/obj/item/weapon/grenade/flashbang/clusterbang/primed"

/obj/item/weapon/grenade/flashbang/clusterbang/primed/New()
	prime()

/obj/item/weapon/gun/energy/banana_mortar
	name = "Banana Mortar"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_bananamrtr"
	item_state = "mecha_bananamrtr"
	projectile_type = "/obj/item/weapon/bananapeel"

*/