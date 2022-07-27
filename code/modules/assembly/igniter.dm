/obj/item/device/assembly/igniter
	name = "igniter"
	desc = "A small electronic device able to ignite combustable substances."
	icon_state = "igniter"
	m_amt = 500
	g_amt = 50
	w_amt = 10
	origin_tech = "magnets=1"

	activate()
		if(!..())	return 0//Cooldown check
		var/turf/location = get_turf(loc)
		if(location)
			location.hotspot_expose(1000,1000)
			for(var/obj/structure/reagent_dispensers/fueltank/Z in location)
				explosion(location, -1, 0, 2)
				del(Z.rig)
				del(src)


	attack_self(mob/user as mob)
		activate()
		add_fingerprint(user)
		return