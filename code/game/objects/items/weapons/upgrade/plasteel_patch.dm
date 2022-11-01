/obj/item/weapon/plasteel_patch
	name = "plasteel patch"
	desc = "Small plate, used to upgrade, reinforce and harden any kind of armor."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "dermal"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15

/obj/item/weapon/plasteel_patch/afterattack(obj/item/clothing/W as obj, mob/user as mob)
	..()
	if (in_range(src, user) && istype(W))
		for(var/A in W.armor)
			var/amount = W.armor[A]
			if(amount > 0)
				W.armor[A] = W.armor[A]*1.05

		playsound(src.loc, 'sound/items/Welder2.ogg', 50, 1, -6)
		user.visible_message("\blue [user] upgrades [W] using [src].", "\green You upgrade [W] using [src].")

		if (prob(15))
			user << "\red [src] is used up!"
			user.drop_from_inventory(src)
			user.regenerate_icons()
			del(src)
