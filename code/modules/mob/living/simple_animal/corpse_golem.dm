/obj/effect/landmark/golemcorpse
	name = "Unknown"
	var/mobname = "Unknown"  //Unused now but it'd fuck up maps to remove it now
	var/corpseuniform = null //Set this to an object path to have the slot filled with said object on the corpse.
	var/corpsesuit = null
	var/corpseshoes = null
	var/corpsegloves = null
	var/corpseradio = null
	var/corpseglasses = null
	var/corpsemask = null
	var/corpsehelmet = null
	var/corpsebelt = null
	var/corpsepocket1 = null
	var/corpsepocket2 = null
	var/corpseback = null
	var/corpseicon = null
	var/corpsewhiteskin = null //Need for mobs with exposed flesh (as russians and pirates)
	var/corpseid = 0     //Just set to 1 if you want them to have an ID
	var/corpseidjob = null // Needs to be in quotes, such as "Clown" or "Chef." This just determines what the ID reads as, not their access
	var/corpseidaccess = null //This is for access. See access.dm for which jobs give what access. Again, put in quotes. Use "Captain" if you want it to be all access.
	var/corpseidicon = null //For setting it to be a gold, silver, centcomm etc ID
	var/datum/dna/dna = null


/obj/effect/landmark/golemcorpse/New()
	createCorpse()

/obj/effect/landmark/golemcorpse/proc/createCorpse() //Creates a mob and checks for gear in each slot before attempting to equip it.
	var/mob/living/carbon/human/M = new /mob/living/carbon/human (src.loc)
//	M.real_name = src.name
	M.stat = 2 //Kills the new mob
	dna = new /datum/dna(M)
	M.dna.mutantrace = "adamantine"
	M.gender = MALE
	M.real_name = "Adamantine" + " " + (pick(golem_name))
	M.underwear = null
	if(src.corpsewhiteskin)
		M.skin_tone = "caucasian1"
	if(src.corpseuniform)
		M.equip_to_slot_or_del(new src.corpseuniform(M), slot_w_uniform)
	if(src.corpsesuit)
		M.equip_to_slot_or_del(new src.corpsesuit(M), slot_wear_suit)
	if(src.corpseshoes)
		M.equip_to_slot_or_del(new src.corpseshoes(M), slot_shoes)
	if(src.corpsegloves)
		M.equip_to_slot_or_del(new src.corpsegloves(M), slot_gloves)
	if(src.corpseradio)
		M.equip_to_slot_or_del(new src.corpseradio(M), slot_ears)
	if(src.corpseglasses)
		M.equip_to_slot_or_del(new src.corpseglasses(M), slot_glasses)
	if(src.corpsemask)
		M.equip_to_slot_or_del(new src.corpsemask(M), slot_wear_mask)
	if(src.corpsehelmet)
		M.equip_to_slot_or_del(new src.corpsehelmet(M), slot_head)
	if(src.corpsebelt)
		M.equip_to_slot_or_del(new src.corpsebelt(M), slot_belt)
	if(src.corpsepocket1)
		M.equip_to_slot_or_del(new src.corpsepocket1(M), slot_r_store)
	if(src.corpsepocket2)
		M.equip_to_slot_or_del(new src.corpsepocket2(M), slot_l_store)
	if(src.corpseback)
		M.equip_to_slot_or_del(new src.corpseback(M), slot_back)
	if(src.corpseicon)
		M.icon += src.icon
	if(src.corpseid == 1)
		var/obj/item/weapon/card/id/W = new(M)
		W.name = "[src.name]'s ID Card"
		var/datum/job/jobdatum
		for(var/jobtype in typesof(/datum/job))
			var/datum/job/J = new jobtype
			if(J.title == corpseidaccess)
				jobdatum = J
				break
		if(src.corpseidicon)
			W.icon_state = corpseidicon
		if(src.corpseidaccess)
			if(jobdatum)
				W.access = jobdatum.get_access()
			else
				W.access = list()
		if(corpseidjob)
			W.assignment = corpseidjob
		W.registered_name = src.name
		M.equip_to_slot_or_del(W, slot_wear_id)
	del(src)

/obj/effect/landmark/golemcorpse/golem
	name = "Adamantine Golem"
	corpseuniform = /obj/item/clothing/under/golem
	corpsehelmet = /obj/item/clothing/head/space/golem
	corpsesuit = /obj/item/clothing/suit/golem
	corpseshoes = /obj/item/clothing/shoes/golem
	corpsemask = /obj/item/clothing/mask/gas/golem
	corpsegloves = /obj/item/clothing/gloves/golem
	corpsepocket1 = /obj/item/device/flashlight/lantern/on