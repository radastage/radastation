/obj/item/recharger_frame
	name = "recharger frame"
	desc = "This piece of machinery requires a power source and some cables. It also needs to be secured."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger0"
	m_amt = 3750
	var/hascell = 0
	var/hascable = 0

/obj/item/recharger_frame/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		user << "\red You secured the [src]."
	if (istype(W, /obj/item/weapon/cable_coil) && hascable == 0)
		var/obj/item/weapon/cable_coil/C = W
		if(C.amount < 5)
			user << "\red You need more wires."
			return
		user << "You added cables to the [src]."
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		C.use(5)
		hascable = 1
	if (istype(W, /obj/item/weapon/cell) && hascell == 0)
		user.drop_item()
		W.loc = src
		src.contents += W
		hascell = 1
		user << "You place [W] in the [src]."
	if (istype(W, /obj/item/weapon/crowbar) && hascell == 1)
		for(var/obj/item/weapon/cell/X in src.contents)
			src.contents -= X
			X.loc = src.loc
			hascell = 0
			user << "You remove the [X]."
	if (istype(W, /obj/item/weapon/screwdriver) && hascell == 1 && hascable == 1 && anchored == 1)
		new /obj/machinery/recharger(src.loc)
		user << "\green You finished the [src]!"
		del(src)

/obj/item/cell_charger_frame
	name = "cell charger frame"
	desc = "This piece of machinery requires a power source and some cables. It also needs to be secured."
	icon = 'icons/obj/power.dmi'
	icon_state = "ccharger0"
	m_amt = 3750
	var/hascell = 0
	var/hascable = 0

/obj/item/cell_charger_frame/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		user << "\red You secured the [src]."
	if (istype(W, /obj/item/weapon/cable_coil) && hascable == 0)
		var/obj/item/weapon/cable_coil/C = W
		if(C.amount < 5)
			user << "\red You need more wires."
			return
		user << "You added cables to the [src]."
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		C.use(5)
		hascable = 1
	if (istype(W, /obj/item/weapon/cell) && hascell == 0)
		user.drop_item()
		W.loc = src
		src.contents += W
		hascell = 1
		user << "You place [W] in the [src]."
	if (istype(W, /obj/item/weapon/crowbar) && hascell == 1)
		for(var/obj/item/weapon/cell/X in src.contents)
			src.contents -= X
			X.loc = src.loc
			hascell = 0
			user << "You remove the [X]."
	if (istype(W, /obj/item/weapon/screwdriver) && hascell == 1 && hascable == 1 && anchored == 1)
		new /obj/machinery/cell_charger(src.loc)
		user << "\green You finished the [src]!"
		del(src)
