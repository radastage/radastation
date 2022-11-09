/obj/effect/overlay
	name = "overlay"
	unacidable = 1
	var/i_attached//Added for possible image attachments to objects. For hallucinations and the like.

/obj/effect/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='icons/effects/beam.dmi'
	icon_state="b_beam"
	var/tmp/atom/BeamSource
	New()
		..()
		spawn(10) del src

/obj/effect/overlay/palmtree_r
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm1"
	density = 1
	layer = 5
	anchored = 1

/obj/effect/overlay/palmtree_l
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm2"
	density = 1
	layer = 5
	anchored = 1

/obj/effect/overlay/coconut
	name = "Coconuts"
	icon = 'icons/misc/beach.dmi'
	icon_state = "coconuts"

/obj/effect/overlay/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(src, /obj/effect/overlay/palmtree_l) || istype(src, /obj/effect/overlay/palmtree_r))
		if (istype(W, /obj/item/weapon/hatchet) || istype(W, /obj/item/weapon/twohanded/fireaxe) || istype(W, /obj/item/weapon/circular_saw))
			new /obj/item/weapon/grown/log( user.loc )
			new /obj/item/weapon/grown/log( user.loc )
			new /obj/item/weapon/grown/log( user.loc )
			new /obj/item/weapon/grown/log( user.loc )
			new /obj/item/weapon/grown/log( user.loc )
			if(prob(50))
				new /obj/item/weapon/grown/log( user.loc )
			if(prob(50))
				new /obj/item/weapon/grown/log( user.loc )
			if(prob(50))
				new /obj/item/weapon/grown/log( user.loc )
			if(prob(50))
				new /obj/item/weapon/grown/log( user.loc )
			if(prob(50))
				new /obj/item/weapon/grown/log( user.loc )
			del(src)