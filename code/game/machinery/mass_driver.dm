/obj/machinery/mass_driver
	name = "mass driver"
	desc = "The finest in spring-loaded piston toy technology, now on a space station near you."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "mass_driver"
	anchored = 1
	use_power = 0 //temp0201
	idle_power_usage = 2
	active_power_usage = 50
	var/power = 1
	var/code = 1
	var/id = 1
	var/drive_range = 50	//this is mostly irrelevant since current mass drivers throw into space, but you could make a lower-range mass driver for interstation transport or something I guess.

/obj/machinery/mass_driver/verb/set_id()
	set category = "Object"
	set name = "Set ID"
	set desc = "Set ID of door control button."
	set src in oview(1)

	if(usr.stat)
		return

	src.id = copytext(sanitize(input(usr, "Enter new id", "ID", 0) as null|text),1,5)

/obj/machinery/mass_driver/proc/drive(amount)
	if(stat & (BROKEN|NOPOWER))
		return
	use_power(500)
	var/O_limit
	var/atom/target = get_edge_target_turf(src, dir)
	for(var/atom/movable/O in loc)
		if(!O.anchored || istype(O, /obj/mecha))	//Mechs need their launch platforms.
			O_limit++
			if(O_limit >= 20)
				for(var/mob/M in hearers(src, null))
					M << "<span class='notice'>[src] lets out a screech, it doesn't seem to be able to handle the load.</span>"
				break
			use_power(500)
			spawn(0)
				O.throw_at(target, drive_range * power, power)
	flick("mass_driver1", src)


/obj/machinery/mass_driver/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return
	drive()
	..(severity)