/datum/job/assistant
	title = "Assistant"
	flag = ASSISTANT
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()

/datum/job/assistant/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
//	var/clothingcolorlist = list("Black", "Blue", "Orange", "Red", "Purple", "Green", "Grey", "Brown)
	var/clothingcolor = pick("Black", "Blue", "Orange", "Red", "Purple", "Green", "Grey", "Brown")
	switch(clothingcolor)
		if("Black")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/black(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
		if("Blue")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/blue(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/blue(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/blue(H), slot_gloves)
		if("Orange")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/orange(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/orange(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/orange(H), slot_gloves)
		if("Red")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/red(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/red(H), slot_gloves)
		if("Purple")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/purple(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/purple(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/purple(H), slot_gloves)
		if("Green")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/green(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/green(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/green(H), slot_gloves)
		if("Grey")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/grey(H), slot_gloves)
		if("Brown")
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/brown(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(H), slot_gloves)
	return 1

/datum/job/assistant/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()