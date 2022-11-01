var/global/list/datum/stack_recipe/rods_recipes = list ( \
	new/datum/stack_recipe("grille", /obj/structure/grille, 2, time = 50, one_per_turf = 1), \
	new/datum/stack_recipe("tank transfer valve", /obj/item/device/transfer_valve), \
	new/datum/stack_recipe("timer", /obj/item/device/assembly/timer), \
	new/datum/stack_recipe("proximity sensor", /obj/item/device/assembly/prox_sensor), \
	new/datum/stack_recipe("igniter", /obj/item/device/assembly/igniter), \
	new/datum/stack_recipe("pen", /obj/item/weapon/pen), \
	new/datum/stack_recipe("fork", /obj/item/weapon/kitchen/utensil/fork), \
	new/datum/stack_recipe("wirecutters", /obj/item/weapon/wirecutters), \
	new/datum/stack_recipe("crowbar", /obj/item/weapon/crowbar), \
	new/datum/stack_recipe("wrench", /obj/item/weapon/wrench), \
	new/datum/stack_recipe("screwdriver", /obj/item/weapon/screwdriver), \
	new/datum/stack_recipe("cable coil", /obj/item/weapon/cable_coil/random), \
	new/datum/stack_recipe("makeshift lighter", /obj/item/weapon/lighter/random{name="makeshift lighter"}), \
	new/datum/stack_recipe("pipe", /obj/item/pipe), \
	)

/obj/item/stack/rods
	name = "metal rods"
	desc = "Some rods. Can be used for building, or something."
	singular_name = "metal rod"
	icon_state = "rods"
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 3.0
	force = 9.0
	throwforce = 15.0
	throw_speed = 5
	throw_range = 20
	m_amt = 1875
	max_amount = 60
	attack_verb = list("hit", "bludgeoned", "whacked")

/obj/item/stack/rods/New(var/loc, var/amount=null)
	recipes = rods_recipes
	return ..()

/obj/item/stack/rods/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W

		if(amount < 2)
			user << "\red You need at least two rods to do this."
			return

		if(WT.remove_fuel(0,user))
			var/obj/item/stack/sheet/metal/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			for (var/mob/M in viewers(src))
				M.show_message("\red [src] is shaped into metal by [user.name] with the weldingtool.", 3, "\red You hear welding.", 2)
			var/obj/item/stack/rods/R = src
			src = null
			var/replace = (user.get_inactive_hand()==R)
			R.use(2)
			if (!R && replace)
				user.put_in_hands(new_item)
		return

	if (istype(W, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/IG = W

		if(IG.secured == 1)
			usr << "\red [IG] is secured!"
		else
			user.drop_from_inventory(W)
			new /obj/item/weapon/weldingtool/improvised(usr.loc)
			playsound(user.loc, 'sound/items/Screwdriver.ogg', 50, 1, -3)
			user << "\blue You assemble an improvised welder."
			del(W)
			use(1)
	..()

/*
/obj/item/stack/rods/attack_self(mob/user as mob)
	src.add_fingerprint(user)

	if(!istype(user.loc,/turf)) return 0

	if (locate(/obj/structure/grille, usr.loc))
		for(var/obj/structure/grille/G in usr.loc)
			if (G.destroyed)
				G.health = 10
				G.density = 1
				G.destroyed = 0
				G.icon_state = "grille"
				use(1)
			else
				return 1
	else
		if(amount < 2)
			user << "\blue You need at least two rods to do this."
			return
		usr << "\blue Assembling grille..."
		if (!do_after(usr, 10))
			return
		var/obj/structure/grille/F = new /obj/structure/grille/ ( usr.loc )
		usr << "\blue You assemble a grille"
		F.add_fingerprint(usr)
		use(2)
	return
	*/
