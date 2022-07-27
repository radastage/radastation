/obj/item/clothing/head/helmet/space/plasma
	name = "plasmaman helmet"
	icon_state = "engspace_helmet"
	desc = "Looks like it is filled with plasma."

/obj/item/clothing/suit/space/plasma
	name = "plasmaman suit"
	icon_state = "rad_old"
	desc = "A suit that emits a weak purple glow."
	allowed = list(/obj/item/weapon/tank/plasma, /obj/item/weapon/pickaxe/plasmacutter, /obj/item/device)

/mob/living/carbon/human/plasmaman
	name = "Plasmaman"
	real_name = "Plasmaman"
	icon_state = "plasmaman_s"

/mob/living/carbon/human/plasmaman/New()
	if (alreadyspawned)
		..()

	else
		alreadyspawned = 1
		gender = pick(MALE,FEMALE)
		create_reagents(1000)

		//initialise organs
		organs = newlist(/datum/limb/chest, /datum/limb/head, /datum/limb/l_arm,
						 /datum/limb/r_arm, /datum/limb/r_leg, /datum/limb/l_leg)
		for(var/datum/limb/O in organs)
			O.owner = src
		internal_organs += new /obj/item/organ/appendix
		internal_organs += new /obj/item/organ/heart
		internal_organs += new /obj/item/organ/brain
		create_dna(src)
		age = rand(AGE_MIN,AGE_MAX)
		real_name = capitalize(pick(plasmaman_name) + " " + pick("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX"))
		name = real_name
		dna.mutantrace = "plasmaman"
		equip_to_slot_or_del(new /obj/item/clothing/suit/space/plasma(src), slot_wear_suit)
		equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/plasma(src), slot_head)
		equip_to_slot_or_del(new /obj/item/weapon/tank/plasma(src), slot_s_store)
		//human_hud('icons/mob/screen_plasmafire.dmi')
		update_body()
		update_hair()

		for(var/i=0;i<7;i++) // 2 for medHUDs and 5 for secHUDs
			hud_list += image('icons/mob/hud.dmi', src, "hudunknown")

		..()

/mob/living/carbon/human/plasmaman/Life()
	set invisibility = 0
	set background = 1

	if (monkeyizing)	return
	if(!loc)			return	// Fixing a null error that occurs when the mob isn't found in the world -- TLE

	..()

	//Apparently, the person who wrote this code designed it so that
	//blinded get reset each cycle and then get activated later in the
	//code. Very ugly. I dont care. Moving this stuff here so its easy
	//to find it.
	blinded = null
	fire_alert = 0 //Reset this here, because both breathe() and handle_environment() have a chance to set it.

	//TODO: seperate this out
	var/datum/gas_mixture/environment = loc.return_air()

	//No need to update all of these procs if the guy is dead.
	if(stat != DEAD)
		if(air_master.current_cycle%4==2 || failed_last_breath) 	//First, resolve location and get a breath
			breathe() 				//Only try to take a breath every 4 ticks, unless suffocating

		else //Still give containing object the chance to interact
			if(istype(loc, /obj/))
				var/obj/location_as_object = loc
				location_as_object.handle_internal_lifeform(src, 0)

		//Updates the number of stored chemicals for powers
		handle_changeling()

		//Mutations and radiation
		handle_mutations_and_radiation()

		//Chemicals in the body
		handle_chemicals_in_body()

		//Disabilities
		handle_disabilities()

		//Random events (vomiting etc)
		handle_random_events()

	//Handle temperature/pressure differences between body and environment
	handle_environment(environment)

	//stuff in the stomach
	handle_stomach()

	//Status updates, death etc.
	handle_regular_status_updates()		//TODO: optimise ~Carn
	update_canmove()

	//Update our name based on whether our face is obscured/disfigured
	name = get_visible_name()

	handle_regular_hud_updates()
	//if(client.prefs)
	//	client.prefs.UI_style = "Plasmafire"
	if(reagents.total_volume < 50)
		reagents.add_reagent("plasma", 0.3)

	if(reagents.has_reagent("plasma"))
		oxygen_alert = 0
		adjustToxLoss(-10)
		adjustOxyLoss(-2)

	//if(!reagents.has_reagent("plasma"))
	if(reagents.get_reagent_amount("plasma") < 0.2)
		oxygen_alert = 1
		oxyloss++
		adjustToxLoss(10)
		adjustOxyLoss(2)

	if(nutrition < 50)
		reagents.remove_reagent("plasma", 0.2)

	// Grabbing
	for(var/obj/item/weapon/grab/G in src)
		G.process()