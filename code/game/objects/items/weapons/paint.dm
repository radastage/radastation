//NEVER USE THIS IT SUX	-PETETHEGOAT

var/global/list/cached_icons = list()

/obj/item/weapon/paint
	name = "Paint Can"
	desc = "Used to recolor floors and walls. Can not be removed by the janitor."
	icon = 'icons/obj/items.dmi'
	icon_state = "paint_neutral"
	color = "FFFFFF"
	item_state = "paintcan"
	w_class = 3.0
	var/paintleft = 10

/obj/item/weapon/paint/red
	name = "Red paint"
	color = "C73232" //"FF0000"
	icon_state = "paint_red"

/obj/item/weapon/paint/green
	name = "Green paint"
	color = "2A9C3B" //"00FF00"
	icon_state = "paint_green"

/obj/item/weapon/paint/blue
	name = "Blue paint"
	color = "5998FF" //"0000FF"
	icon_state = "paint_blue"

/obj/item/weapon/paint/yellow
	name = "Yellow paint"
	color = "CFB52B" //"FFFF00"
	icon_state = "paint_yellow"

/obj/item/weapon/paint/violet
	name = "Violet paint"
	color = "AE4CCD" //"FF00FF"
	icon_state = "paint_violet"

/obj/item/weapon/paint/black
	name = "Black paint"
	color = "333333"
	icon_state = "paint_black"

/obj/item/weapon/paint/white
	name = "White paint"
	color = "FFFFFF"
	icon_state = "paint_white"


/obj/item/weapon/paint/anycolor
	name = "Any color"
	icon_state = "paint_neutral"

	attack_self(mob/user as mob)
		var/t1 = input(user, "Please select a color:", "Locking Computer", null) in list( "red", "blue", "green", "yellow", "violet", "black", "white")
		if ((user.get_active_hand() != src || user.stat || user.restrained()))
			return
		switch(t1)
			if("red")
				color = "C73232"
			if("blue")
				color = "5998FF"
			if("green")
				color = "2A9C3B"
			if("yellow")
				color = "CFB52B"
			if("violet")
				color = "AE4CCD"
			if("white")
				color = "FFFFFF"
			if("black")
				color = "333333"
		icon_state = "paint_[t1]"
		add_fingerprint(user)
		return


/obj/item/weapon/paint/afterattack(atom/target, mob/user as mob) ///obj/item/weapon/paint/afterattack(turf/target, mob/user as mob)
	if(paintleft <= 0)
		icon_state = "paint_empty"
		return
	if(!istype(target) || istype(target, /turf/space))
		return
	var/ind = "[initial(target.icon)][color]"
	if(!cached_icons[ind])
		var/icon/overlay = new/icon(initial(target.icon))
		overlay.Blend("#[color]",ICON_MULTIPLY)
		overlay.SetIntensity(1.4)
		target.icon = overlay
		cached_icons[ind] = target.icon
		paintleft--
	else
		target.icon = cached_icons[ind]
		paintleft--
	return

/obj/item/weapon/paint/paint_remover
	name = "Paint remover"
	icon_state = "paint_neutral"

	afterattack(turf/target, mob/user as mob)
		if(istype(target) && target.icon != initial(target.icon))
			target.icon = initial(target.icon)
		return
