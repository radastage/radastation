/mob/living/carbon/monkey/emote(var/act,var/m_type=1,var/message = null)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	//if(findtext(act,"s",-1) && !findtext(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
	//	act = copytext(act,1,length(act))

	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)

	switch(act)
		if("sign")
			if (!src.restrained())
				message = text("<B>[src.name]</B> signs[].", (text2num(param) ? text(" the number []", text2num(param)) : null))
				m_type = 1
		if("scratch")
			if (!src.restrained())
				message = "<B>[src.name]</B> scratches."
				m_type = 1
		if("whimper")
			if (!muzzled)
				message = "<B>[src.name]</B> whimpers."
				m_type = 2
		if("roar")
			if (!muzzled)
				message = "<B>[src.name]</B> roars."
				m_type = 2
		if("tail")
			message = "<B>[src.name]</B> waves its tail."
			m_type = 1
		if("gasp")
			message = "<B>[src.name]</B> gasps."
			m_type = 2
		if("shiver")
			message = "<B>[src.name]</B> shivers."
			m_type = 2
		if("drool")
			message = "<B>[src.name]</B> drools."
			m_type = 1
		if("paw")
			if (!src.restrained())
				message = "<B>[src.name]</B> flails its paw."
				m_type = 1
		if("scretch")
			if (!muzzled)
				message = "<B>[src.name]</B> scretches."
				m_type = 2
		if("choke")
			message = "<B>[src.name]</B> chokes."
			m_type = 2
		if("moan")
			message = "<B>[src.name]</B> moans!"
			m_type = 2
		if("nod")
			message = "<B>[src.name]</B> nods its head."
			m_type = 1
		if("sit")
			message = "<B>[src.name]</B> sits down."
			m_type = 1
		if("sway")
			message = "<B>[src.name]</B> sways around dizzily."
			m_type = 1
		if("sulk")
			message = "<B>[src.name]</B> sulks down sadly."
			m_type = 1
		if("twitch")
			message = "<B>[src.name]</B> twitches violently."
			m_type = 1
		if("dance")
			if (!src.restrained())
				message = "<B>[src.name]</B> dances around happily."
				m_type = 1
		if("roll")
			if (!src.restrained())
				message = "<B>[src.name]</B> rolls."
				m_type = 1
		if("shake")
			message = "<B>[src.name]</B> shakes its head."
			m_type = 1
		if("gnarl")
			if (!muzzled)
				message = "<B>[src.name]</B> gnarls and shows its teeth.."
				m_type = 2
		if("jump")
			message = "<B>[src.name]</B> jumps!"
			m_type = 1
		if("collapse")
			Paralyse(2)
			message = text("<B>[]</B> collapses!", src)
			m_type = 2
		if("deathgasp")
			message = "<b>[src.name]</b> lets out a faint chirp as it collapses and stops moving..."
			m_type = 1
		if("help")
			src << "choke, collapse, dance, deathgasp, drool, gasp, shiver, gnarl, jump, paw, moan, nod, roar, roll, scratch,\nscretch, shake, sign-#, sit, sulk, sway, tail, twitch, whimper"
		if(1)
			message = "<B>[src]</B> [message]"
		if("me")
			if(message)
				message = "<B>[src]</B> [message]"
		else
			message = "<B>[src]</B> [act]"
			//src << text("Invalid Emote: []", act)
	if ((message && src.stat == 0))
		if(src.client)
			log_emote("[name]/[key] : [message]")
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(703)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(746)
	return