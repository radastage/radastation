/obj/machinery/driver_button
	name = "mass driver button"
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	desc = "A remote control switch for a mass driver."
	var/id = null
	var/active = 0
	anchored = 1.0
	use_power = 0 //temp0201
	idle_power_usage = 2
	active_power_usage = 4

/obj/machinery/driver_button/verb/set_id()
	set category = "Object"
	set name = "Set ID"
	set desc = "Set ID of door control button."
	set src in oview(1)

	if(usr.stat)
		return

	src.id = copytext(sanitize(input(usr, "Enter new id", "ID", 0) as null|text),1,5)

/obj/machinery/ignition_switch
	name = "ignition switch"
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	desc = "A remote control switch for a mounted igniter."
	var/id = null
	var/active = 0
	anchored = 1.0
	use_power = 0 //temp0201
	idle_power_usage = 2
	active_power_usage = 4

/obj/machinery/flasher_button
	name = "flasher button"
	desc = "A remote control switch for a mounted flasher."
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	var/id = null
	var/active = 0
	anchored = 1.0
	use_power = 0 //temp0201
	idle_power_usage = 2
	active_power_usage = 4

/obj/machinery/flasher_button/verb/set_id()
	set category = "Object"
	set name = "Set ID"
	set desc = "Set ID of door control button."
	set src in oview(1)

	if(usr.stat)
		return

	src.id = copytext(sanitize(input(usr, "Enter new id", "ID", 0) as null|text),1,5)

/obj/machinery/crema_switch
	desc = "Burn baby burn!"
	name = "crematorium igniter"
	icon = 'icons/obj/power.dmi'
	icon_state = "crema_switch"
	anchored = 1.0
//	req_access = list(access_crematorium)
	var/on = 0
	var/area/area = null
	var/otherarea = null
	var/id = 1

/obj/machinery/crema_switch/verb/set_id()
	set category = "Object"
	set name = "Set ID"
	set desc = "Set ID of door control button."
	set src in oview(1)

	if(usr.stat)
		return

	src.id = copytext(sanitize(input(usr, "Enter new id", "ID", 0) as null|text),1,5)