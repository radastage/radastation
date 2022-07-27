/obj/structure
	icon = 'icons/obj/structures.dmi'
	var/climbable

/obj/structure/verb/climb()
	set name = "Climb structure"
	set category = "Object"
	set src in oview(1)

	if(!src.climbable)
		return

	if(usr.stat || (!ishuman(usr) && !ismonkey(usr)))
		return

	if(!usr.stat && usr.canmove && !usr.restrained() && in_range(src, usr))
		usr << "<span class='notice'>You begin to climb \the [src].</span>"
		if(do_after(usr,50))
			usr.loc=src.loc

/obj/structure/blob_act()
	if(prob(50))
		del(src)

/obj/structure/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			if(prob(50))
				del(src)
				return
		if(3.0)
			return

/obj/structure/meteorhit(obj/O as obj)
	del(src)







