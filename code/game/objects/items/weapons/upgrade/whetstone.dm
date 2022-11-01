/obj/item/weapon/whetstone
	name = "whetstone"
	desc = "Small weighted stone, used to sharpen any kind of weapon."
	icon = 'icons/obj/device.dmi'
	icon_state = "laptop"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15

/obj/item/weapon/whetstone/afterattack(obj/item/weapon/O, mob/user as mob)
	..()
	if(istype(O) && O.force > 0)
		O.force = O.force*1.05
		playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1, -6)
		user.visible_message("[user] upgrades [O] using [src].", "You upgrade [O] using [src].")
		if (prob(15))
			user << "\red [src] is used up!"
			user.drop_from_inventory(src)
			user.regenerate_icons()
			del(src)