/mob/living/carbon/human/gas
	name = "Serpent"
	real_name = "Serpent"
	voice_name = "Serpent"
	icon = 'icons/mob/gas.dmi'
	icon_state = "gas_s"

/mob/living/carbon/human/gas/New()
	if (alreadyspawned)
		..()

	else
		alreadyspawned = 1
		icon += rgb(rand(0,155), rand(0,155), rand(0,155))
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
		real_name = capitalize(pick(last_names) + " [rand(0, 300)]")
		name = real_name
		dna.mutantrace = "gas"
		equip_to_slot_or_del(new /obj/item/clothing/under/golem/gas(src), slot_w_uniform)
		equip_to_slot_or_del(new /obj/item/clothing/suit/golem/gas(src), slot_wear_suit)
		equip_to_slot_or_del(new /obj/item/clothing/shoes/golem/gas(src), slot_shoes)
		equip_to_slot_or_del(new /obj/item/clothing/mask/gas/golem/gas(src), slot_wear_mask)
		equip_to_slot_or_del(new /obj/item/clothing/gloves/golem/gas(src), slot_gloves)
		equip_to_slot_or_del(new /obj/item/clothing/head/space/golem/gas(src), slot_head)
		equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/gas(src), slot_back)

		update_body()
		update_hair()

		for(var/i=0;i<7;i++) // 2 for medHUDs and 5 for secHUDs
			hud_list += image('icons/mob/hud.dmi', src, "hudunknown")

		..()


/obj/item/clothing/under/golem/gas
	name = "serpent skin"
	desc = "an armored skin"

/obj/item/clothing/suit/golem/gas
	name = "serpent shell"
	desc = "an outter shell"

/obj/item/clothing/shoes/golem/gas
	name = "serpent tail"
	desc = "sturdy armored tail"


/obj/item/clothing/mask/gas/golem/gas
	name = "serpent mandible"
	desc = "pair of threatening mandibles"


/obj/item/clothing/gloves/golem/gas
	name = "serpent arms"
	desc = "powerful arms"


/obj/item/clothing/head/space/golem/gas
	name = "serpent head"
	desc = "a serpent's head"

/obj/item/weapon/storage/backpack/gas
	name = "serpent back"
	desc = "strong armored back"
	icon_state = null
	canremove = 0