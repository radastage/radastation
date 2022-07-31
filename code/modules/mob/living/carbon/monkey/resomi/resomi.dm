/mob/living/carbon/monkey/resomi
	name = "resomi"
	voice_name = "resomi"
	voice_message = "chirps"
	say_message = "chirps"
	icon = 'icons/mob/resomi.dmi'
	icon_state = "resomi1"
	gender = NEUTER
	pass_flags = PASSTABLE
	update_icon = 0		///no need to call regenerate_icon
	var/variation
	var/age
	stop_walking = 1

/mob/living/carbon/monkey/resomi/New()
	if (alreadyspawned)
		..()

	else
		alreadyspawned = 1
		variation = rand(1,7)
		icon_state = "resomi[variation]"
		create_reagents(1000)

		internal_organs += new /obj/item/organ/appendix
		internal_organs += new /obj/item/organ/heart
		internal_organs += new /obj/item/organ/brain
		name = random_name_resomi()
		real_name = name
		age = rand(15,45)
		gender = pick(MALE, FEMALE)
		icon += rgb(rand(0,200), rand(0,200), rand(0,200))
		update_icon = 1

		..()

/mob/living/carbon/monkey/resomi/update_icons()
	update_hud()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	overlays.Cut()
	if(lying)
		icon_state = "resomi[variation]_l"
		for(var/image/I in overlays_lying)
			overlays += I
	else
		icon_state = "resomi[variation]"
		for(var/image/I in overlays_standing)
			overlays += I

proc/random_name_resomi()
	var/sounds = rand(1,4)
	var/syllables = list("ca", "ra", "ma", "sa", "na", "ta", "la", "sha", "scha", "a", "a", \
	"ce", "re", "me", "se", "ne", "te", "le", "she", "sche", "e", "e", "ci", "ri", "mi", \
	"si", "ni", "ti", "li", "shi", "schi", "i", "i")
	var/i = 0
	var/newname = ""

	while(i<=sounds)
		i++
		newname += pick(syllables)

	. = capitalize(newname)

/mob/living/carbon/monkey/resomi/examine()
	set src in oview()

	if(!usr || !src)	return
	if( (usr.sdisabilities & BLIND || usr.blinded || usr.stat) && !istype(usr,/mob/dead/observer) )
		usr << "<span class='notice'>Something is there but you can't see it.</span>"
		return

	var/msg = "<span class='info'>*---------*\nThis is \icon[src] \a <EM>[src], [age2agedescription(age)] resomi</EM>!\n"

	if (src.handcuffed)
		msg += "It is \icon[src.handcuffed] handcuffed!\n"
	if (src.wear_mask)
		msg += "It has \icon[src.wear_mask] \a [src.wear_mask] on its head.\n"
	if (src.l_hand)
		msg += "It has \icon[src.l_hand] \a [src.l_hand] in its left hand.\n"
	if (src.r_hand)
		msg += "It has \icon[src.r_hand] \a [src.r_hand] in its right hand.\n"
	if (src.back)
		msg += "It has \icon[src.back] \a [src.back] on its back.\n"
	if (src.stat == DEAD)
		msg += "<span class='deadsay'>It is limp and unresponsive, with no signs of life.</span>\n"
	else
		msg += "<span class='warning'>"
		if (src.getBruteLoss())
			if (src.getBruteLoss() < 30)
				msg += "It has minor bruising.\n"
			else
				msg += "<B>It has severe bruising!</B>\n"
		if (src.getFireLoss())
			if (src.getFireLoss() < 30)
				msg += "It has minor burns.\n"
			else
				msg += "<B>It has severe burns!</B>\n"
		if (src.stat == UNCONSCIOUS)
			msg += "It isn't responding to anything around it; it seems to be asleep.\n"
		msg += "</span>"

	if (src.digitalcamo)
		msg += "It is repulsively uncanny!\n"

	msg += "[desc]\n"
	msg += "*---------*</span>"

	usr << msg
	return