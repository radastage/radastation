

/obj/structure/reagent_dispensers
	name = "Dispenser"
	desc = "..."
	icon = 'icons/obj/objects.dmi'
	icon_state = "watertank"
	density = 1
	anchored = 0
	flags = FPRINT
	pressure_resistance = 2*ONE_ATMOSPHERE

	var/amount_per_transfer_from_this = 10
	var/possible_transfer_amounts = list(10,25,50,100)

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		return

	New()
		create_reagents(1000)
		if (!possible_transfer_amounts)
			src.verbs -= /obj/structure/reagent_dispensers/verb/set_APTFT
		..()

	examine()
		set src in view()
		..()
		if (!(usr in view(2)) && usr!=src.loc) return
		usr << "\blue It contains:"
		if(reagents && reagents.reagent_list.len)
			for(var/datum/reagent/R in reagents.reagent_list)
				usr << "\blue [R.volume] units of [R.name]"
		else
			usr << "\blue Nothing."

	verb/set_APTFT() //set amount_per_transfer_from_this
		set name = "Set transfer amount"
		set category = "Object"
		set src in view(1)
		var/N = input("Amount per transfer from this:","[src]") as null|anything in possible_transfer_amounts
		if (N)
			amount_per_transfer_from_this = N

	ex_act(severity)
		switch(severity)
			if(1.0)
				del(src)
				return
			if(2.0)
				if (prob(50))
					new /obj/effect/effect/water(src.loc)
					del(src)
					return
			if(3.0)
				if (prob(5))
					new /obj/effect/effect/water(src.loc)
					del(src)
					return
			else
		return

	blob_act()
		if(prob(50))
			new /obj/effect/effect/water(src.loc)
			del(src)







//Dispensers
/obj/structure/reagent_dispensers/watertank
	name = "watertank"
	desc = "A watertank"
	icon = 'icons/obj/objects.dmi'
	icon_state = "watertank"
	amount_per_transfer_from_this = 10
	New()
		..()
		reagents.add_reagent("water",1000)

/obj/structure/reagent_dispensers/watertank/attackby(obj/item/I, mob/user)
	if (istype(I, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		user << "\red You deconstruct the [src]."
		new /obj/structure/cart_custom(src.loc)
		new /obj/item/weapon/reagent_containers/glass/bucket(src.loc)
		del(src)

/obj/structure/reagent_dispensers/fueltank
	name = "fueltank"
	desc = "A fueltank"
	icon = 'icons/obj/objects.dmi'
	icon_state = "weldtank"
	amount_per_transfer_from_this = 10
	var/obj/item/device/assembly_holder/rig = null
	var/accepts_rig = 1
	New()
		..()
		reagents.add_reagent("fuel",1000)


	bullet_act(var/obj/item/projectile/Proj)
		if(istype(Proj ,/obj/item/projectile/beam)||istype(Proj,/obj/item/projectile/bullet))
			message_admins("[key_name_admin(Proj.firer)] triggered a fueltank explosion.")
			log_game("[key_name(Proj.firer)] triggered a fueltank explosion.")
			explosion(src.loc,-1,0,2)
			if(src)
				del(src)



	blob_act()
		explosion(src.loc,0,1,5,7,10)
		if(src)
			del(src)

	ex_act()
		explosion(src.loc,-1,0,2)
		if(src)
			del(src)

	attack_hand()
		if(rig)
			usr.visible_message("<span class='notice'>[usr] begins to detach [rig] from [src].</span>", "<span class='notice'>You begin to detach [rig] from [src].</span>")
			if(!src) return
			usr.visible_message("<span class='notice'>[usr] detaches [rig] from [src].</span>", "<span class='notice'>You detach [rig] from [src].</span>")
			rig.loc = get_turf(usr)
			rig.anchored = 0
			rig.pickable = 1
			accepts_rig = 1
			rig = null

	attackby(obj/item/W, mob/user)
		if(istype(W, /obj/item/device/assembly_holder))
			var/obj/item/device/assembly_holder/H = W
			if(accepts_rig)
				if(istype(H.a_left,/obj/item/device/assembly/igniter) || istype(H.a_right,/obj/item/device/assembly/igniter))
					user.drop_item()
					rig = W
					rig.loc = src.loc
					rig.anchored = 1
					rig.pickable = 0
					accepts_rig = 0
		if(istype(W, /obj/item/weapon/wrench))
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "\red You deconstruct the [src]."
			new /obj/structure/cart_custom(src.loc)
			new /obj/item/device/assembly/igniter(src.loc)
			del(src)

	Move()
		var/atom/A = src.loc
		. = ..()
		src.move_speed = world.timeofday - src.l_move_time
		src.l_move_time = world.timeofday
		src.m_flag = 1
		if ((A != src.loc && A && A.z == src.z))
			src.last_move = get_dir(A, src.loc)
		if (rig)
			rig.loc = src.loc
			rig.last_move = get_dir(A, src.loc)
		return

/obj/structure/reagent_dispensers/peppertank
	name = "Pepper Spray Refiller"
	desc = "Refill pepper spray canisters."
	icon = 'icons/obj/objects.dmi'
	icon_state = "peppertank"
	anchored = 1
	density = 0
	amount_per_transfer_from_this = 45
	New()
		..()
		reagents.add_reagent("condensedcapsaicin",1000)


/obj/structure/reagent_dispensers/water_cooler
	name = "Water-Cooler"
	desc = "A machine that dispenses water to drink"
	amount_per_transfer_from_this = 5
	icon = 'icons/obj/vending.dmi'
	icon_state = "water_cooler"
	possible_transfer_amounts = null
	anchored = 1
	New()
		..()
		reagents.add_reagent("water",500)


/obj/structure/reagent_dispensers/beerkeg
	name = "beer keg"
	desc = "A beer keg"
	icon = 'icons/obj/objects.dmi'
	icon_state = "beertankTEMP"
	amount_per_transfer_from_this = 10
	New()
		..()
		reagents.add_reagent("beer",1000)

/obj/structure/reagent_dispensers/beerkeg/blob_act()
	explosion(src.loc,0,3,5,7,10)
	del(src)

/obj/structure/reagent_dispensers/virusfood
	name = "Virus Food Dispenser"
	desc = "A dispenser of virus food."
	icon = 'icons/obj/objects.dmi'
	icon_state = "virusfoodtank"
	amount_per_transfer_from_this = 10
	anchored = 1

	New()
		..()
		reagents.add_reagent("virusfood", 1000)