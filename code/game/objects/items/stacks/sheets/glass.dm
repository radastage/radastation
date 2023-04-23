/* Glass stack types
 * Contains:
 *		Glass sheets
 *		Reinforced glass sheets
 *		Glass shards - TODO: Move this into code/game/object/item/weapons
 */

/*
 * Glass sheets
 */

var/global/list/datum/stack_recipe/glass_recipes = list ( \
	new/datum/stack_recipe("light bulb", /obj/item/weapon/light/bulb), \
	new/datum/stack_recipe("light tube", /obj/item/weapon/light/tube, 2), \
	new/datum/stack_recipe("syringe", /obj/item/weapon/reagent_containers/syringe), \
	new/datum/stack_recipe("beaker", /obj/item/weapon/reagent_containers/glass/beaker, 2), \
	new/datum/stack_recipe("large beaker", /obj/item/weapon/reagent_containers/glass/beaker/large, 4), \
	new/datum/stack_recipe("drinking glass", /obj/item/weapon/reagent_containers/food/drinks/drinkingglass), \
	new/datum/stack_recipe("mop bucket", /obj/structure/mopbucket, 3, time = 15, one_per_turf = 1), \
	new/datum/stack_recipe("mirror", /obj/structure/mirror, 3, time = 15, one_per_turf = 1), \
	new/datum/stack_recipe("prescription glasses", /obj/item/clothing/glasses/regular), \
)

/obj/item/stack/sheet/glass
	name = "glass"
	desc = "HOLY SHEET! That is a lot of glass."
	singular_name = "glass sheet"
	icon_state = "sheet-glass"
	g_amt = 3750
	origin_tech = "materials=1"

/obj/item/stack/sheet/glass/random/New()
	new /obj/item/stack/sheet/glass(src.loc, rand(1,50))
	del(src)

/obj/item/stack/sheet/glass/New()
	recipes = glass_recipes
	return ..()


/obj/item/stack/sheet/glass/attack_self(mob/user as mob)
	construct_window(user)

/obj/item/stack/sheet/glass/attackby(obj/item/W, mob/user)
	..()
	if(istype(W,/obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/CC = W
		if(CC.amount < 5)
			user << "\b There is not enough wire in this coil. You need 5 lengths."
			return
		CC.use(5)
		user << "\blue You attach wire to the [name]."
		new /obj/item/stack/light_w(user.loc)
		src.use(1)
	else if( istype(W, /obj/item/stack/rods) )
		var/obj/item/stack/rods/V  = W
		var/obj/item/stack/sheet/rglass/RG = new (user.loc)
		RG.add_fingerprint(user)
		RG.add_to_stacks(user)
		V.use(1)
		var/obj/item/stack/sheet/glass/G = src
		src = null
		var/replace = (user.get_inactive_hand()==G)
		G.use(1)
		if (!G && !RG && replace)
			user.put_in_hands(RG)
	else
		return ..()

/obj/item/stack/sheet/glass/proc/construct_window(mob/user as mob)
	if(!user || !src)	return 0
	if(!istype(user.loc,/turf)) return 0
	if(!user.IsAdvancedToolUser())
		user << "\red You don't have the dexterity to do this!"
		return 0
	var/title = "Sheet-Glass"
	title += " ([src.amount] sheet\s left)"
	switch(alert(title, "Would you like full tile glass or one direction?", "One Direction", "Full Window", "Recipes", "Cancel"))
		if("One Direction")
			if(!src)	return 1
			if(src.loc != user)	return 1

			var/list/directions = new/list(cardinal)
			var/i = 0
			for (var/obj/structure/window/win in user.loc)
				i++
				if(i >= 4)
					user << "\red There are too many windows in this location."
					return 1
				directions-=win.dir
				if(!(win.ini_dir in cardinal))
					user << "\red Can't let you do that."
					return 1

			//Determine the direction. It will first check in the direction the person making the window is facing, if it finds an already made window it will try looking at the next cardinal direction, etc.
			var/dir_to_set = 2
			for(var/direction in list( user.dir, turn(user.dir,90), turn(user.dir,180), turn(user.dir,270) ))
				var/found = 0
				for(var/obj/structure/window/WT in user.loc)
					if(WT.dir == direction)
						found = 1
				if(!found)
					dir_to_set = direction
					break

			var/obj/structure/window/W
			W = new /obj/structure/window/basic( user.loc, 0 )
			W.dir = dir_to_set
			W.ini_dir = W.dir
			W.anchored = 0
			src.use(1)
		if("Full Window")
			if(!src)	return 1
			if(src.loc != user)	return 1
			if(src.amount < 2)
				user << "\red You need more glass to do that."
				return 1
			if(locate(/obj/structure/window) in user.loc)
				user << "\red There is a window in the way."
				return 1
			var/obj/structure/window/W
			W = new /obj/structure/window/basic( user.loc, 0 )
			W.dir = SOUTHWEST
			W.ini_dir = SOUTHWEST
			W.anchored = 0
			src.use(2)

		if("Recipes")
			if(!src || src.loc != user) return 1
			src.interact(user)
			return 1

	return 0


/*
 * Reinforced glass sheets
 */
/obj/item/stack/sheet/rglass
	name = "reinforced glass"
	desc = "Glass which seems to have rods or something stuck in them."
	singular_name = "reinforced glass sheet"
	icon_state = "sheet-rglass"
	g_amt = 3750
	m_amt = 1875
	origin_tech = "materials=2"

var/global/list/datum/stack_recipe/rglass_recipes = list ( \
	new/datum/stack_recipe("welding goggles", /obj/item/clothing/glasses/welding, 2), \
	new/datum/stack_recipe("welding helmet", /obj/item/clothing/head/welding, 3), \
	new/datum/stack_recipe("riot shield", /obj/item/weapon/shield/riot, 3), \
	new/datum/stack_recipe("sunglasses", /obj/item/clothing/glasses/sunglasses), \
	new/datum/stack_recipe("big sunglasses", /obj/item/clothing/glasses/sunglasses/big, 2), \
	new/datum/stack_recipe("syringe gun", /obj/item/weapon/gun/syringe, 3), \
	new/datum/stack_recipe("station bounced radio", /obj/item/device/radio/off, 2), \
	new/datum/stack_recipe("station intercom", /obj/item/device/radio/intercom, 4, time = 75, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("desk lamp", /obj/item/device/flashlight/lamp, 2), \
	new/datum/stack_recipe("lantern", /obj/item/device/flashlight/lantern, 2), \
	new/datum/stack_recipe("hydroponics tray", /obj/machinery/hydroponics, 4, time = 25, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("retractor", /obj/item/weapon/retractor, 2), \
	new/datum/stack_recipe("hemostat", /obj/item/weapon/hemostat), \
	new/datum/stack_recipe("cautery", /obj/item/weapon/cautery), \
	new/datum/stack_recipe("surgical drill", /obj/item/weapon/surgicaldrill, 2), \
	new/datum/stack_recipe("scalpel", /obj/item/weapon/scalpel, 2), \
	new/datum/stack_recipe("circular saw", /obj/item/weapon/circular_saw, 4), \
	null, \
	new/datum/stack_recipe("ablative armor vest", /obj/item/clothing/suit/armor/laserproof, 8, time = 125), \
	null, \
	new/datum/stack_recipe("light tile", /obj/item/stack/tile/light, 1,4,20), \
	new/datum/stack_recipe("camera", /obj/item/device/camera, 1, time = 10), \
	new/datum/stack_recipe("multitool", /obj/item/device/multitool, 1, time = 10), \
	new/datum/stack_recipe("All-In-One Grinder", /obj/machinery/reagentgrinder, 4, time = 25, one_per_turf = 1, on_floor = 1), \

)

/obj/item/stack/sheet/rglass/New()
	recipes = rglass_recipes
	return ..()

/obj/item/stack/sheet/rglass/cyborg
	name = "reinforced glass"
	desc = "Glass which seems to have rods or something stuck in them."
	singular_name = "reinforced glass sheet"
	icon_state = "sheet-rglass"
	g_amt = 0
	m_amt = 0

/obj/item/stack/sheet/rglass/attack_self(mob/user as mob)
	construct_window(user)

/obj/item/stack/sheet/rglass/proc/construct_window(mob/user as mob)
	if(!user || !src)	return 0
	if(!istype(user.loc,/turf)) return 0
	if(!user.IsAdvancedToolUser())
		user << "\red You don't have the dexterity to do this!"
		return 0
	var/title = "Sheet Reinf. Glass"
	title += " ([src.amount] sheet\s left)"
	switch(input(title, "Would you like full tile glass a one direction glass pane or a windoor?") in list("One Direction", "Full Window", "Windoor", "Recipes", "Cancel"))
		if("One Direction")
			if(!src)	return 1
			if(src.loc != user)	return 1
			var/list/directions = new/list(cardinal)
			var/i = 0
			for (var/obj/structure/window/win in user.loc)
				i++
				if(i >= 4)
					user << "\red There are too many windows in this location."
					return 1
				directions-=win.dir
				if(!(win.ini_dir in cardinal))
					user << "\red Can't let you do that."
					return 1

			//Determine the direction. It will first check in the direction the person making the window is facing, if it finds an already made window it will try looking at the next cardinal direction, etc.
			var/dir_to_set = 2
			for(var/direction in list( user.dir, turn(user.dir,90), turn(user.dir,180), turn(user.dir,270) ))
				var/found = 0
				for(var/obj/structure/window/WT in user.loc)
					if(WT.dir == direction)
						found = 1
				if(!found)
					dir_to_set = direction
					break

			var/obj/structure/window/W
			W = new /obj/structure/window/reinforced( user.loc, 1 )
			W.state = 0
			W.dir = dir_to_set
			W.ini_dir = W.dir
			W.anchored = 0
			src.use(1)

		if("Full Window")
			if(!src)	return 1
			if(src.loc != user)	return 1
			if(src.amount < 2)
				user << "\red You need more glass to do that."
				return 1
			if(locate(/obj/structure/window) in user.loc)
				user << "\red There is a window in the way."
				return 1
			var/obj/structure/window/W
			W = new /obj/structure/window/reinforced( user.loc, 1 )
			W.state = 0
			W.dir = SOUTHWEST
			W.ini_dir = SOUTHWEST
			W.anchored = 0
			src.use(2)

		if("Recipes")
			if(!src || src.loc != user) return 1
			src.interact(user)
			return 1


		if("Windoor")
			if(!src || src.loc != user) return 1

			if(isturf(user.loc) && locate(/obj/structure/windoor_assembly/, user.loc))
				user << "\red There is already a windoor assembly in that location."
				return 1

			if(isturf(user.loc) && locate(/obj/machinery/door/window/, user.loc))
				user << "\red There is already a windoor in that location."
				return 1

			if(src.amount < 5)
				user << "\red You need more glass to do that."
				return 1

			var/obj/structure/windoor_assembly/WD
			WD = new /obj/structure/windoor_assembly(user.loc)
			WD.state = "01"
			WD.anchored = 0
			src.use(5)
			switch(user.dir)
				if(SOUTH)
					WD.dir = SOUTH
					WD.ini_dir = SOUTH
				if(EAST)
					WD.dir = EAST
					WD.ini_dir = EAST
				if(WEST)
					WD.dir = WEST
					WD.ini_dir = WEST
				else//If the user is facing northeast. northwest, southeast, southwest or north, default to north
					WD.dir = NORTH
					WD.ini_dir = NORTH
		else
			return 1


	return 0

/*
 * Glass shards - TODO: Move this into code/game/object/item/weapons
 */
/obj/item/weapon/shard/Bump()

	spawn( 0 )
		if (prob(20))
			src.force = 15
		else
			src.force = 4
		..()
		return
	return

/obj/item/weapon/shard/New()

	src.icon_state = pick("large", "medium", "small")
	switch(src.icon_state)
		if("small")
			src.pixel_x = rand(-12, 12)
			src.pixel_y = rand(-12, 12)
		if("medium")
			src.pixel_x = rand(-8, 8)
			src.pixel_y = rand(-8, 8)
		if("large")
			src.pixel_x = rand(-5, 5)
			src.pixel_y = rand(-5, 5)
		else
	return

/obj/item/weapon/shard/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if ( istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0, user))
			var/obj/item/stack/sheet/glass/NG = new (user.loc)
			for (var/obj/item/stack/sheet/glass/G in user.loc)
				if(G==NG)
					continue
				if(G.amount>=G.max_amount)
					continue
				G.attackby(NG, user)
				usr << "You add the newly-formed glass to the stack. It now contains [NG.amount] sheets."
			//SN src = null
			del(src)
			return
	return ..()

/obj/item/weapon/shard/HasEntered(AM as mob|obj)
	if(ismob(AM))
		var/mob/M = AM
		M << "\red <B>You step in the broken glass!</B>"
		playsound(src.loc, 'sound/effects/glass_step.ogg', 50, 1)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/feetCover = (H:wear_suit && (H:wear_suit.body_parts_covered&FEET))
			var/golemfeet = (H:dna && (H:dna.mutantrace == "golem")) || (H:dna && (H:dna.mutantrace == "adamantine"))
			if(H.shoes || feetCover || golemfeet) //suka rabotay pidor uebu feetcover
				return

			var/datum/limb/affecting = H.get_organ(pick("l_leg", "r_leg"))
			H.Weaken(3)
			if(affecting.take_damage(5, 0))
				H.update_damage_overlays(0)
			H.updatehealth()
	..()