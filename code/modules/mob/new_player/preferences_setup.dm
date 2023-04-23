datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H
	proc/random_character(gender_override)
//		if(gender_override)
//			gender = gender_override
//		else
		gender = pick(MALE,FEMALE)
		underwear = random_underwear(gender)
		skin_tone = random_skin_tone()
		h_style = random_hair_style(gender)
		f_style = random_facial_hair_style(gender)
		h_color = random_short_color()
		f_color = h_color
		eye_color = random_eye_color()
//		real_name = random_name(gender)
		backbag = 2
		age = rand(AGE_MIN,AGE_MAX)

	proc/update_preview_icon()		//seriously. This is horrendous.
		del(preview_icon_front)
		del(preview_icon_side)
		var/icon/preview_icon = null

		var/g = "m"
		if(gender == FEMALE)	g = "f"

		preview_icon = new /icon('icons/mob/human.dmi', "[skin_tone]_[g]_s")

		if(underwear)
			var/datum/sprite_accessory/underwear/U = underwear_all[underwear]
			if(U)
				preview_icon.Blend(new /icon(U.icon, "[U.icon_state]_s"), ICON_OVERLAY)

		var/icon/eyes_s = new/icon("icon" = 'icons/mob/human_face.dmi', "icon_state" = "eyes_s")
		eyes_s.Blend("#[eye_color]", ICON_ADD)

		var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]
		if(hair_style)
			var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
			hair_s.Blend("#[h_color]", ICON_ADD)
			eyes_s.Blend(hair_s, ICON_OVERLAY)

		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[f_style]
		if(facial_hair_style)
			var/icon/facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
			facial_s.Blend("#[f_color]", ICON_ADD)
			eyes_s.Blend(facial_s, ICON_OVERLAY)

		var/icon/clothes_s = null
		if(job_civilian_low & ASSISTANT)//This gives the preview icon clothes depending on which job(if any) is set to 'high'
			clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
			clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
			if(backbag == 2)
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
			else if(backbag == 3)
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)

		else if(job_civilian_high)//I hate how this looks, but there's no reason to go through this switch if it's empty
			switch(job_civilian_high)
				if(HOP)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hop_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "helmet"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(BARTENDER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "ba_suit_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(BOTANIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hydroponics_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "ggloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "apron"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-hyd"), ICON_OVERLAY)
				if(CHEF)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chef_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "chef"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(JANITOR)
					clothes_s = new /icon('icons/mob/uniform.dmi', "janitor_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(LIBRARIAN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "red_suit_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(QUARTERMASTER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "qm_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/eyes.dmi', "sun"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "clipboard"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(CARGOTECH)
					clothes_s = new /icon('icons/mob/uniform.dmi', "cargotech_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(MINER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "miner_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(LAWYER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "lawyer_blue_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "briefcase"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(CHAPLAIN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chapblack_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(CLOWN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "clown_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "clown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "clown"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/back.dmi', "clownpack"), ICON_OVERLAY)
				if(MIME)
					clothes_s = new /icon('icons/mob/uniform.dmi', "mime_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "lgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "mime"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "beret"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "suspenders"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)

		else if(job_medsci_high)
			switch(job_medsci_high)
				if(RD)
					clothes_s = new /icon('icons/mob/uniform.dmi', "director_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "clipboard"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-tox"), ICON_OVERLAY)
				if(SCIENTIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "toxinswhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_tox_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-tox"), ICON_OVERLAY)
				if(CHEMIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chemistrywhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_chem_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-chem"), ICON_OVERLAY)
				if(CMO)
					clothes_s = new /icon('icons/mob/uniform.dmi', "cmo_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_lefthand.dmi', "firstaid"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_cmo_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-med"), ICON_OVERLAY)
				if(DOCTOR)
					clothes_s = new /icon('icons/mob/uniform.dmi', "medical_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_lefthand.dmi', "firstaid"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-med"), ICON_OVERLAY)
				if(GENETICIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "geneticswhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_gen_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-gen"), ICON_OVERLAY)
				if(VIROLOGIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "virologywhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "sterile"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_vir_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-vir"), ICON_OVERLAY)

		else if(job_engsec_high)
			switch(job_engsec_high)
				if(CAPTAIN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "captain_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "captain"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "cigaron"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/eyes.dmi', "sun"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "caparmor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(HOS)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hosred_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "helmet"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "securitypack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-sec"), ICON_OVERLAY)
				if(WARDEN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "warden_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "helmet"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "securitypack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-sec"), ICON_OVERLAY)
				if(DETECTIVE)
					clothes_s = new /icon('icons/mob/uniform.dmi', "detective_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "cigaron"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "detective"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "detective"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(OFFICER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "secred_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "helmet"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "securitypack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-sec"), ICON_OVERLAY)
				if(CHIEF)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chief_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "cigaron"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "hardhat0_white"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(ENGINEER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "engine_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "orange"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "hardhat0_yellow"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(ATMOSTECH)
					clothes_s = new /icon('icons/mob/uniform.dmi', "atmos_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(ROBOTICIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "robotics_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "toolbox_blue"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(AI)//Gives AI and borgs assistant-wear, so they can still customize their character
					clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
				if(CYBORG)
					clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)

		preview_icon.Blend(eyes_s, ICON_OVERLAY)
		if(clothes_s)
			preview_icon.Blend(clothes_s, ICON_OVERLAY)
		preview_icon_front = new(preview_icon, dir = SOUTH)
		preview_icon_side = new(preview_icon, dir = WEST)

		del(preview_icon)
		del(eyes_s)
		del(clothes_s)

/mob/verb/save_character()
	set name = "Save Character"
	set category = "Preferences"
	var/savefile/F = new("data/player_saves/[copytext(ckey,1,2)]/[ckey]/[src.real_name].sav")
	var/list/O=list()

	if(!( usr ))
		return

	if(src.real_name == "preferences")
		usr << "Ha ha very funny name but NO."
		return
	if(src.real_name == "Unknown")
		usr << "Try getting yourself a name, dummy."
		return

	var/confirm = input("Are you sure you wish to save?", "Character save") in list("Yes", "No")
	if(confirm == "Yes")
		if(ishuman(src))
			src:saved_gender=src:gender
			src:saved_skintone=src:skin_tone
			src:saved_hairstyle=src:h_style
			src:saved_facehair=src:f_style
			src:saved_underwear=src:underwear
		O+=src
		F<<O


	world.log<<"[src.real_name] saved."
	usr << "\blue [src.real_name] saved!"

/mob/verb/load_character()
	set name = "Load Character"
	set category = "Preferences"

	if(src.real_name == "preferences")
		usr << "Ha ha very funny name but NO."
		return
	if(src.real_name == "Unknown")
		usr << "Try getting yourself a name, dummy."
		return

	if(!( usr ))
		return

	/*
	for(var/f in flist("data/player_saves/[copytext(ckey,1,2)]/[ckey]/"))
		if(copytext("[f]", 1,16) != "preferences.sav")
			O += f

	var/choose = input("Which character do you want to load?", "Character list") in list(O)
	O=list()
	choose>>O
	for(var/mob/m in O)
		m.loc=src.loc
		m.lastDblClick=0
		m.alreadyspawned=1
		m.regenerate_icons()
		m.update_icons()
	world.log<<"[choose] loaded."
	usr << "\blue [src.real_name] loaded!"

	del(src)

*/

	if(!fexists("data/player_saves/[copytext(ckey,1,2)]/[ckey]/[src.real_name].sav"))
		usr << "\red [src.real_name].sav does not exist! Try saving or renaming first!"
		world.log<<"[src.real_name] tried to save but failed."
		return

	var/savefile/F = new("data/player_saves/[copytext(ckey,1,2)]/[ckey]/[src.real_name].sav")
	var/confirm = input("Are you sure you wish to load?", "Character load") in list("Yes", "No")
	if(confirm == "Yes")
		var/list/O=list()
		F>>O
		for(var/mob/living/carbon/human/m in O)
			m.loc=src.loc
			m.lastDblClick=0
			m.alreadyspawned=1
			m.gender=m.saved_gender
			m.skin_tone=m.saved_skintone
			m.h_style=m.saved_hairstyle
			m.f_style=m.saved_facehair
			m.tag=md5("[m.real_name]+[rand(9999)]")
			m.regenerate_icons()
			m.update_icons()
		world.log<<"[src.real_name] loaded."
		usr << "\blue [src.real_name] loaded!"

		del(src)

/mob/verb/list_characters()
	set name = "List Saved Characters"
	set category = "Preferences"
//	var/list/O=list()
	for(var/f in flist("data/player_saves/[copytext(ckey,1,2)]/[ckey]/"))
		if(copytext("[f]", 1,16) != "preferences.sav")
//			O += file(""data/player_saves/[copytext(ckey,1,2)]/[ckey]/[f]")
			usr << "\blue Found character: [f]"

/mob/verb/delete_character()
	set name = "Delete Character"
	set category = "Preferences"

	if(!( usr ))
		return

	if(src.real_name == "preferences")
		usr << "Ha ha very funny name but NO."
		return
	if(src.real_name == "Unknown")
		usr << "Try getting yourself a name, dummy."
		return

	if(!fexists("data/player_saves/[copytext(ckey,1,2)]/[ckey]/[src.real_name].sav"))
		usr << "\red [src.real_name].sav does not exist! Try saving or renaming first!"
	else
		world.log<<"[src.real_name] tried to save but failed."
		var/confirm = input("Are you sure you wish to delete?", "Character delete") in list("Yes", "No")
		if(confirm == "Yes")
			fdel("data/player_saves/[copytext(ckey,1,2)]/[ckey]/[src.real_name].sav")
			world.log<<"[src.real_name] deleted."
			usr << "\blue [src.real_name] deleted!"