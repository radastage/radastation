//Meant for simple animals to drop lootable human bodies.

//If someone can do this in a neater way, be my guest-Kor

//This has to be seperate from the Away Mission corpses, because New() doesn't work for those, and initialize() doesn't work for these.

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).


/obj/effect/landmark/mobcorpse
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


/obj/effect/landmark/mobcorpse/New()
	createCorpse()

/obj/effect/landmark/mobcorpse/proc/createCorpse() //Creates a mob and checks for gear in each slot before attempting to equip it.
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



//List of different corpse types

/obj/effect/landmark/mobcorpse/syndicatesoldier
	name = "Syndicate Operative"
	corpseuniform = /obj/item/clothing/under/syndicate
	corpsesuit = /obj/item/clothing/suit/armor/vest
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpseradio = /obj/item/device/radio/headset
	corpsemask = /obj/item/clothing/mask/gas
	corpsehelmet = /obj/item/clothing/head/helmet/swat
	corpseback = /obj/item/weapon/storage/backpack
	corpseid = 1
	corpseidjob = "Operative"
	corpseidaccess = "Syndicate"
	corpsewhiteskin = 1



/obj/effect/landmark/mobcorpse/syndicatecommando
	name = "Syndicate Commando"
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
	corpseidjob = "Operative"
	corpseidaccess = "Syndicate"

/obj/effect/landmark/mobcorpse/clown
	name = "Clown"
	corpseuniform = /obj/item/clothing/under/rank/clown
	corpseshoes = /obj/item/clothing/shoes/clown_shoes
	corpseradio = /obj/item/device/radio/headset
	corpsemask = /obj/item/clothing/mask/gas/clown_hat
	corpsepocket1 = /obj/item/weapon/bikehorn
	corpseback = /obj/item/weapon/storage/backpack/clown
	corpseid = 1
	corpseidjob = "Clown"
	corpseidaccess = "Clown"
	corpsewhiteskin = 1



/obj/effect/landmark/mobcorpse/pirate
	name = "Pirate"
	corpseuniform = /obj/item/clothing/under/pirate
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpseglasses = /obj/item/clothing/glasses/eyepatch
	corpsehelmet = /obj/item/clothing/head/bandana
	corpsewhiteskin = 1



/obj/effect/landmark/mobcorpse/pirate/ranged
	name = "Pirate Gunner"
	corpsesuit = /obj/item/clothing/suit/pirate
	corpsehelmet = /obj/item/clothing/head/pirate
	corpsewhiteskin = 1



/obj/effect/landmark/mobcorpse/russian
	name = "Russian"
	corpseuniform = /obj/item/clothing/under/soviet
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpsehelmet = /obj/item/clothing/head/bearpelt
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/russian/ranged
	corpsehelmet = /obj/item/clothing/head/ushanka

/obj/effect/landmark/mobcorpse/nanotrasen
	name = "Nanotrasen Security"
	corpseuniform = /obj/item/clothing/under/darkred
	corpsesuit = /obj/item/clothing/suit/armor/bulletproof
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpseradio = /obj/item/device/radio/headset/headset_sec
	corpsemask = /obj/item/clothing/mask/gas/swat
	corpsehelmet = /obj/item/clothing/head/helmet/swat/nanotrasen
	corpseback = /obj/item/weapon/storage/backpack/security
	corpseid = 1
	corpseidjob = "Security"
	corpseidaccess = "Nanotrasen"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/thunderdomer
	name = "Thunderdomer"
	corpseuniform = /obj/item/clothing/under/color/red
	corpsesuit = /obj/item/clothing/suit/armor/vest
	corpseshoes = /obj/item/clothing/shoes/black
	corpsehelmet = /obj/item/clothing/head/helmet/thunderdome
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/cult
	name = "Blood Cultist"
	corpsesuit = /obj/item/clothing/suit/cultrobes/alt
	corpseshoes = /obj/item/clothing/shoes/cult
	corpsehelmet = /obj/item/clothing/head/culthood/alt
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/deathsquad
	name = "Death Commando"
	corpseuniform = /obj/item/clothing/under/color/green
	corpsesuit = /obj/item/clothing/suit/armor/swat
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpsemask = /obj/item/clothing/mask/gas/swat
	corpsehelmet = /obj/item/clothing/head/helmet/space/deathsquad
	corpseback = /obj/item/weapon/storage/backpack/security
	corpseglasses = /obj/item/clothing/glasses/thermal
	corpsepocket1 = /obj/item/weapon/grenade/flashbang
	corpsepocket2 = /obj/item/weapon/melee/energy/sword
	corpseid = 1
	corpseidjob = "Death Commando"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"

/obj/effect/landmark/mobcorpse/ertcommander
	name = "ERT Commander"
	corpseuniform = /obj/item/clothing/under/color/blue
	corpsesuit = /obj/item/clothing/suit/space/ert/commander
	corpsehelmet = /obj/item/clothing/head/helmet/space/ert/commander
	corpsemask = /obj/item/clothing/mask/breath
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "ERT Commander"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"

/obj/effect/landmark/mobcorpse/ertengineer
	name = "ERT Engineer"
	corpseuniform = /obj/item/clothing/under/color/yellow
	corpsesuit = /obj/item/clothing/suit/space/ert/engineer
	corpsehelmet = /obj/item/clothing/head/helmet/space/ert/engineer
	corpsemask = /obj/item/clothing/mask/breath
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseshoes = /obj/item/clothing/shoes/magboots
	corpseid = 1
	corpseidjob = "ERT Engineer"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"

/obj/effect/landmark/mobcorpse/ertsecurity
	name = "ERT Security"
	corpseuniform = /obj/item/clothing/under/color/red
	corpsesuit = /obj/item/clothing/suit/space/ert/security
	corpsehelmet = /obj/item/clothing/head/helmet/space/ert/security
	corpsemask = /obj/item/clothing/mask/breath
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "ERT Engineer"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"

/obj/effect/landmark/mobcorpse/spacerussian
	name = "Russian"
	corpseuniform = /obj/item/clothing/under/soviet
	corpseshoes = /obj/item/clothing/shoes/black
	corpsesuit = /obj/item/clothing/suit/space
	corpsemask = /obj/item/clothing/mask/breath
	corpsehelmet = /obj/item/clothing/head/helmet/space
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/nanotrasenhos
	name = "Nanotrasen Head of Security"
	corpseuniform = /obj/item/clothing/under/rank/head_of_security
	corpsesuit = /obj/item/clothing/suit/space/rig/security/hos
	corpsemask = /obj/item/clothing/mask/breath
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig/security/hos
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpsegloves = /obj/item/clothing/gloves/black
	corpseradio = /obj/item/device/radio/headset/heads/hos
	corpseback = /obj/item/weapon/storage/backpack/satchel_sec
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "Head of Security"
	corpseidaccess = "access_hos"

/obj/effect/landmark/mobcorpse/nanotrasenwarden
	name = "Nanotrasen Warden"
	corpseuniform = /obj/item/clothing/under/rank/warden
	corpsesuit = /obj/item/clothing/suit/armor/vest/warden
	corpseshoes = /obj/item/clothing/shoes/jackboots
	corpsegloves = /obj/item/clothing/gloves/black
	corpseradio = /obj/item/device/radio/headset/headset_sec
	corpsehelmet = /obj/item/clothing/head/helmet/warden
	corpseback = /obj/item/weapon/storage/backpack/satchel_sec
	corpseid = 1
	corpseidjob = "Warden"
	corpseidaccess = "access_security"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/nanotrasenspace
	name = "Nanotrasen Security"
	corpseuniform = /obj/item/clothing/under/darkred
	corpsesuit = /obj/item/clothing/suit/space/rig/security
	corpsemask = /obj/item/clothing/mask/breath
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig/security
	corpseback = /obj/item/weapon/storage/backpack/satchel_sec
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "Security"
	corpseidaccess = "Nanotrasen"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/syndicateagent
	name = "Syndicate Agent"
	corpseuniform = /obj/item/clothing/under/syndicate
	corpseshoes = /obj/item/clothing/shoes/red
	corpsesuit = /obj/item/clothing/suit/space/syndicate
	corpsemask = /obj/item/clothing/mask/gas
	corpsehelmet = /obj/item/clothing/head/helmet/space/syndicate
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen

/obj/effect/landmark/mobcorpse/thunderdomerheavy
	name = "Thunderdomer"
	corpseuniform = /obj/item/clothing/under/color/red
	corpsesuit = /obj/item/clothing/suit/armor/tdome/red
	corpseshoes = /obj/item/clothing/shoes/brown
	corpsehelmet = /obj/item/clothing/head/helmet/thunderdome
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/centcom
	name = "CentCom Officer"
	corpseuniform = /obj/item/clothing/under/rank/centcom_officer
	corpseshoes = /obj/item/clothing/shoes/black
	corpseid = 1
	corpseidjob = "CentCom Officer"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/centcomranged
	name = "CentCom Officer"
	corpseuniform = /obj/item/clothing/under/rank/centcom_officer
	corpseshoes = /obj/item/clothing/shoes/black
	corpsesuit = /obj/item/clothing/suit/armor/bulletproof
	corpseglasses = /obj/item/clothing/glasses/sunglasses
	corpseid = 1
	corpseidjob = "CentCom Officer"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/centcomcommander
	name = "CentCom Commander"
	corpseuniform = /obj/item/clothing/under/rank/centcom_commander
	corpsesuit = /obj/item/clothing/suit/armor/bulletproof
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpsehelmet = /obj/item/clothing/head/centhat
	corpseglasses = /obj/item/clothing/glasses/eyepatch
	corpsemask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	corpseid = 1
	corpseidjob = "CentCom Commander"
	corpseidaccess = "access_cent_specops"
	corpseidicon = "centcom"
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/syndicateelite
	name = "Syndicate Stormtrooper"
	corpseuniform = /obj/item/clothing/under/syndicate
	corpsesuit = /obj/item/clothing/suit/space/rig/syndi/elite
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpseradio = /obj/item/device/radio/headset
	corpsemask = /obj/item/clothing/mask/gas/syndicate
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig/syndi/elite
	corpseback = /obj/item/weapon/tank/jetpack/oxygen
	corpsepocket1 = /obj/item/weapon/tank/emergency_oxygen
	corpseid = 1
	corpseidjob = "Stormtrooper"
	corpseidaccess = "Syndicate"

/obj/effect/landmark/mobcorpse/russiantrooper
	name = "Russian Trooper"
	corpseuniform = /obj/item/clothing/under/soviet
	corpsesuit = /obj/item/clothing/suit/armor/bulletproof
	corpseshoes = /obj/item/clothing/shoes/combat
	corpsegloves = /obj/item/clothing/gloves/swat
	corpsemask = /obj/item/clothing/mask/balaclava
	corpsehelmet = /obj/item/clothing/head/helmet/swat
	corpsewhiteskin = 1

/obj/effect/landmark/mobcorpse/cultspace
	name = "Blood Cultist"
	corpsesuit = /obj/item/clothing/suit/space/cult
	corpseshoes = /obj/item/clothing/shoes/cult
	corpsehelmet = /obj/item/clothing/head/helmet/space/cult
	corpseback = /obj/item/weapon/storage/backpack/cultpack


