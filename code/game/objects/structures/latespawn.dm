/obj/structure/latespawn
	name = "gateway"
	icon = 'icons/obj/machines/gateway.dmi'
	icon_state = "offcenter"
	climbable = 1
	desc = "A microscopic telecommunication device based on a bluespace technology."
	var/prevloc

/obj/structure/latespawn/New()
	prevloc = loc
	latejoin += loc

/obj/structure/latespawn/process()
	if (!prevloc in latejoin)
		latejoin += prevloc

/obj/structure/latespawn/Move()
	latejoin -= prevloc