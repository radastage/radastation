/obj/item/device/radio/beacon
	name = "Tracking Beacon"
	desc = "A beacon used by a teleporter."
	icon_state = "beacon"
	item_state = "signaler"
	var/code = "electronic"
	origin_tech = "bluespace=1"

/obj/item/device/radio/beacon/hear_talk()
	return


/obj/item/device/radio/beacon/send_hear()
	return null


/obj/item/device/radio/beacon/verb/alter_signal(t as text)
	set name = "Alter Beacon's Signal"
	set category = "Object"
	set src in usr

	if ((usr.canmove && !( usr.restrained() )))
		src.code = t
	if (!( src.code ))
		src.code = "beacon"
	src.add_fingerprint(usr)
	return

/obj/item/device/radio/beacon/verb/rename()
	set name = "Rename beacon"
	set category = "Object"
	set src in usr

	var/n_name = copytext(sanitize(input(usr, "What would you like to name the radio beacon?", "Beacon renaming", null)  as text), 1, MAX_NAME_LEN)
	if((loc == usr && usr.stat == 0))
		name = "Tracking Beacon[(n_name ? text("- '[n_name]'") : null)]"
	add_fingerprint(usr)

/*
/obj/item/device/radio/beacon/bacon //Probably a better way of doing this, I'm lazy.
	proc/digest_delay()
		spawn(600)
			del(src)*/ //Bacon beacons are no more rip in peace