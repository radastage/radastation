/obj/item/weapon/gun/projectile/shotgun/pump
	name = "shotgun"
	desc = "Useful for sweeping alleys."
	icon_state = "shotgun"
	item_state = "shotgun"
	max_shells = 4
	w_class = 4.0
	force = 10
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	slot_flags = SLOT_BACK
	caliber = "shotgun"
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/beanbag"
	var/recentpump = 0 // to prevent spammage
	var/pumped = 0
	var/obj/item/ammo_casing/current_shell = null


	load_into_chamber()
		if(in_chamber)
			var/obj/item/ammo_casing/AC = current_shell
			AC.desc += " This one is spent."
			AC.BB = null //remove the ammunition from the shell
			return 1
		return 0


	attack_self(mob/living/user as mob)
		if(recentpump)	return
		pump()
		recentpump = 1
		spawn(10)
			recentpump = 0
		return


	proc/pump(mob/M as mob)
		playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
		pumped = 0
		if(current_shell)//We have a shell in the chamber
			current_shell.loc = get_turf(src)//Eject casing
			current_shell = null
			if(in_chamber)
				in_chamber = null
		if(!loaded.len)	return 0
		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.
		current_shell = AC
		if(AC.BB)
			in_chamber = AC.BB //Load projectile into chamber.
		update_icon()	//I.E. fix the desc
		return 1

/obj/item/weapon/gun/projectile/shotgun/pump/combat
	name = "combat shotgun"
	icon_state = "cshotgun"
	max_shells = 8
	origin_tech = "combat=5;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun"
	w_class = 5

//this is largely hacky and bad :(	-Pete
/obj/item/weapon/gun/projectile/shotgun/doublebarrel
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon_state = "dshotgun"
	item_state = "shotgun"
	max_shells = 2
	w_class = 4.0
	force = 10
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	slot_flags = SLOT_BACK
	caliber = "shotgun"
	origin_tech = "combat=3;materials=1"
	ammo_type = "/obj/item/ammo_casing/shotgun/beanbag"

	New()
		for(var/i = 1, i <= max_shells, i++)
			loaded += new ammo_type(src)

		update_icon()
		return

	load_into_chamber()
//		if(in_chamber)
//			return 1 {R}
		if(!loaded.len)
			return 0

		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.

		if(AC.BB)
			in_chamber = AC.BB //Load projectile into chamber.
			AC.BB.loc = src //Set projectile loc to gun.
			AC.BB = null //Remove the ammunition from the shell
			AC.desc += " This one is spent."
			return 1
		return 0

	attack_self(mob/living/user as mob)
		if(!(locate(/obj/item/ammo_casing/shotgun) in src) && !loaded.len)
			user << "<span class='notice'>\The [src] is empty.</span>"
			return

		for(var/obj/item/ammo_casing/shotgun/shell in src)	//This feels like a hack.	//don't code at 3:30am kids!!
			if(shell in loaded)
				loaded -= shell
			shell.loc = get_turf(src.loc)

		user << "<span class='notice'>You open \the [src].</span>"
		update_icon()

	attackby(var/obj/item/A as obj, mob/user as mob)
		if(istype(A, /obj/item/ammo_casing) && !load_method)
			var/obj/item/ammo_casing/AC = A
			if(AC.caliber == caliber && (loaded.len < max_shells) && (contents.len < max_shells))	//forgive me father, for i have sinned
				user.drop_item()
				AC.loc = src
				loaded += AC
				user << "<span class='notice'>You load a shell into \the [src]!</span>"
		A.update_icon()
		update_icon()
		if(istype(A, /obj/item/weapon/circular_saw) || istype(A, /obj/item/weapon/melee/energy) || istype(A, /obj/item/weapon/pickaxe/plasmacutter))
			user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
			if(loaded.len)
				afterattack(user, user)	//will this work?
				afterattack(user, user)	//it will. we call it twice, for twice the FUN
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>The shotgun goes off!</span>", "<span class='danger'>The shotgun goes off in your face!</span>")
				return
			if(do_after(user, 30))	//SHIT IS STEALTHY EYYYYY
				icon_state = "sawnshotgun"
				w_class = 3.0
				item_state = "gun"
				slot_flags &= ~SLOT_BACK	//you can't sling it on your back
				slot_flags |= SLOT_BELT		//but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
				name = "sawn-off shotgun"
				desc = "Omar's coming!"
				user << "<span class='warning'>You shorten the barrel of \the [src]!</span>"

/obj/item/weapon/gun/projectile/shotgun/pump/pipegun
	name = "pipe gun"
	desc = "An assembly made from pipe and an igniter attached to it. It is unfinished and requires to be cut."
	icon_state = "pipegun0"
	max_shells = 0
	origin_tech = "combat=2;materials=2"
	fire_sound = 'sound/weapons/pipegun.ogg'

/obj/item/weapon/gun/projectile/shotgun/pump/pipegun/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/ammo_casing) && !load_method)
		var/obj/item/ammo_casing/AC = A
		if(AC.caliber == caliber && (loaded.len < max_shells) && (contents.len < max_shells))	//forgive me father, for i have sinned
			user.drop_item()
			AC.loc = src
			loaded += AC
			user << "<span class='notice'>You load a shell into \the [src]!</span>"
	A.update_icon()
	update_icon()
	if(istype(A, /obj/item/weapon/wirecutters) || istype(A, /obj/item/weapon/pickaxe/plasmacutter))
		user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
		playsound(user.loc, 'sound/items/Wirecutter.ogg', 100, 1)
		if(do_after(user, 30))
			max_shells = 1
			user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
			desc = "An assembly made from cut pipe and an igniter attached to it. It is a single-shot firearm that uses the igniter as a firing mechanism. It is also potentially dangerous to use."
			icon_state = "pipegun1"
			update_icon()

/obj/item/weapon/gun/projectile/shotgun/pump/pipegun/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	..()
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	if(prob(20))
		user.Stun(5)
		user.Weaken(5)
		user.apply_effect(STUTTER, 5)
		user.visible_message("<span class='danger'>[user]'s [src.name] has misfired!</span>")
		playsound(user.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
	else if(prob(10))
		user.Stun(10)
		user.Weaken(10)
		user.apply_effect(STUTTER, 10)
		playsound(user.loc, 'sound/effects/clang.ogg', 100, 1, -1)
		user.apply_damage(10, BRUTE, "l_arm")
		user.apply_damage(10, BRUTE, "r_arm")
		user.visible_message("<span class='danger'>[user]'s [src.name] has exploded violently!</span>")
		user.ear_damage += 30
		user.ear_deaf += 120
		if(prob(30))
			user.visible_message("<span class='danger'>[src] is destroyed!</span>")
			user.drop_item()
			del(src)
