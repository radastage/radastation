/obj/structure/cart_custom
	name = "cart"
	desc = "This is some kind of a cart. Might be useful to hold buckets or igniters or whatever..."
	icon = 'icons/obj/objects.dmi'
	icon_state = "cart"
	anchored = 0
	density = 1
	climbable = 1
	var/holding = list()

/obj/structure/cart_custom/proc/removeholdings()
	for(var/obj/item/X in src.holding)
		src.holding -= X
		X.loc = src.loc
		X.anchored = 0
		X.pickable = 1

/obj/structure/cart_custom/attackby(obj/item/I, mob/user)
	..()
	if (istype(I, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		user << "\red You deconstruct [src]."
		new /obj/item/stack/sheet/metal(src.loc)
		new /obj/item/stack/sheet/metal(src.loc)
		new /obj/item/stack/sheet/metal(src.loc)
		removeholdings()
		del(src)
	if (istype(I, /obj/item/device/assembly/igniter))
		user << "You added [I] to the [src]."
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		new /obj/structure/reagent_dispensers/fueltank(src.loc)
		del(I)
		removeholdings()
		del(src)
	if (istype(I, /obj/item/weapon/reagent_containers/glass/bucket))
		user << "You added [I] to the [src]."
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		new /obj/structure/reagent_dispensers/watertank(src.loc)
		del(I)
		removeholdings()
		del(src)
	else
		user.drop_item()
		holding += I
		I.loc = src.loc
		I.anchored = 1
		I.pickable = 0
		user << "\blue You place [I.name] in [src.name]"

/obj/structure/cart_custom/MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
	if(istype(O, /obj/structure/mopbucket))
		user << "You added [O] to the [src]."
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		new /obj/structure/janitorialcart(src.loc)
		del(O)
		del(src)

/obj/structure/cart_custom/Move()
	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.timeofday - src.l_move_time
	src.l_move_time = world.timeofday
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
	for(var/obj/item/X in src.holding)
		X.loc = src.loc
		X.last_move = get_dir(A, src.loc)
	return

/obj/structure/cart_custom/attack_hand(mob/user)
	..()
	for(var/obj/item/X in src.holding)
		src.holding -= X
		X.loc = usr.loc
		X.anchored = 0
		X.pickable = 1
		user << "\red You remove the [X.name] from [src.name]"