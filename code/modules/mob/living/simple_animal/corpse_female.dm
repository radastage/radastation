//Meant for simple animals to drop lootable human bodies.

//If someone can do this in a neater way, be my guest-Kor

//This has to be seperate from the Away Mission corpses, because New() doesn't work for those, and initialize() doesn't work for these.

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).


/obj/effect/landmark/femalemobcorpse
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
	var/corpsewhiteskin = null //Need for mobs with exposed flesh (as russians and pirates)
	var/corpseid = 0     //Just set to 1 if you want them to have an ID
	var/corpseidjob = null // Needs to be in quotes, such as "Clown" or "Chef." This just determines what the ID reads as, not their access
	var/corpseidaccess = null //This is for access. See access.dm for which jobs give what access. Again, put in quotes. Use "Captain" if you want it to be all access.
	var/corpseidicon = null //For setting it to be a gold, silver, centcomm etc ID

/obj/effect/landmark/femalemobcorpse/New()
	createCorpse()

/obj/effect/landmark/femalemobcorpse/proc/createCorpse() //Creates a mob and checks for gear in each slot before attempting to equip it.
	var/mob/living/carbon/human/M = new /mob/living/carbon/human (src.loc)
//	M.real_name = src.name
	M.stat = 2 //Kills the new mob
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
	M.gender = FEMALE
	M.skin_tone = random_skin_tone()
	M.h_style = pick(hair_styles_female_list)
	M.f_style = pick(facial_hair_styles_female_list)
	M.h_color = random_short_color()
	M.f_color = M.h_color
	M.eye_color = random_eye_color()
	M.underwear = pick(underwear_f)
	M.update_body()
	M.update_hair()
	M.age = rand(AGE_MIN,AGE_MAX)
	M.real_name = capitalize(pick(first_names_female)) + " " + capitalize(pick(last_names))

	del(src)

/obj/effect/landmark/femalemobcorpse/femalespaceninja
	name = "Space Ninja"
	corpsesuit = /obj/item/clothing/suit/space/space_ninja/female
	corpseradio = /obj/item/device/radio/headset
	corpseshoes = /obj/item/clothing/shoes/space_ninja
	corpsehelmet = /obj/item/clothing/head/helmet/space/space_ninja
	corpsegloves = /obj/item/clothing/gloves/space_ninja
	corpseuniform = /obj/item/clothing/under/color/black
	corpsemask = /obj/item/clothing/mask/gas/voice/space_ninja

/obj/effect/landmark/femalemobcorpse/ertmedical
	name = "ERT Medic"
	corpseuniform = /obj/item/clothing/under/aqua
	corpsesuit = /obj/item/clothing/suit/space/ert/medical
	corpsehelmet = /obj/item/clothing/head/helmet/space/ert/medical
	corpsemask = /obj/item/clothing/mask/breath
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "ERT Medic"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"

/obj/effect/landmark/femalemobcorpse/syndicatescout
	name = "Syndicate Scout"
	corpseuniform = /obj/item/clothing/under/syndicate
	corpseshoes = /obj/item/clothing/shoes/red
	corpsemask = /obj/item/clothing/mask/gas
	corpsegloves = /obj/item/clothing/gloves/black
	corpseid = 1
	corpseidjob = "Scout"
	corpseidaccess = "Syndicate"

/obj/effect/landmark/femalemobcorpse/nanotrasenscout
	name = "Nanotrasen Scout"
	corpseuniform = /obj/item/clothing/under/rank/security
	corpsesuit = /obj/item/clothing/suit/armor/vest
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpsegloves = /obj/item/clothing/gloves/black
	corpseradio = /obj/item/device/radio/headset/headset_sec
	corpsemask = /obj/item/clothing/mask/gas
	corpsehelmet = /obj/item/clothing/head/helmet
	corpseback = /obj/item/weapon/storage/backpack/security
	corpseid = 1
	corpseidjob = "Scout"
	corpseidaccess = "Nanotrasen"

/obj/effect/landmark/femalemobcorpse/russianscout
	name = "Russian Scout"
	corpseuniform = /obj/item/clothing/under/soviet
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpsewhiteskin = 1

/obj/effect/landmark/femalemobcorpse/syndicatescoutspace
	name = "Syndicate Scout"
	corpseuniform = /obj/item/clothing/under/syndicate
	corpsesuit = /obj/item/clothing/suit/space/rig/syndi
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpseradio = /obj/item/device/radio/headset
	corpsemask = /obj/item/clothing/mask/gas/syndicate
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig/syndi
	corpseback = /obj/item/weapon/tank/jetpack/oxygen
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "Scout"
	corpseidaccess = "Syndicate"