/mob/living/verb/interact()
	set category = "Object"
	set name = "Interact"
	set desc = "Interact with someone in a sexual way."
	set src in oview(1)

//	var/rape
	var/orientation
	var/position
	var/sexverb
	var/bodymisc
//	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)

//	if(src.restrained() || muzzled || src.grabbed_by || !src.canmove || src.stunned || src.paralysis || src.sleeping)
//		rape = 1

	if(src.gender == MALE && usr.gender == MALE)
		orientation = "gay"

	if(src.gender == FEMALE && usr.gender == FEMALE)
		orientation = "lesbian"

	if(src.gender == FEMALE && usr.gender == MALE)
		orientation = "maledom"

	if(src.gender == MALE && usr.gender == FEMALE)
		orientation = "femdom"

	if(orientation == "gay")
		position = input("What would you like to do with them?") in list("Fuck Ass", "Fuck Mouth", "Footjob", "Give Footjob", "Thighjob", "Kiss", "Jerk Off", "Lick Feet", "Finger Ass", "Suck Them", "Lick Ass", "Mount Ass", "Slap Ass", "Insert Object (Anal)")

	if(orientation == "lesbian")
		position = input("What would you like to do with them?") in list("Fuck Mouth", "Kiss", "Jerk Off", "Lick Feet", "Give Footjob", "Finger Ass", "Suck Them", "Lick Ass", "Slap Ass", "Insert Object (Anal)", "Insert Object (Vaginal)")

	if(orientation == "maledom")
		position = input("What would you like to do with them?") in list("Fuck Ass", "Fuck Mouth", "Footjob", "Give Footjob", "Thighjob", "Kiss", "Jerk Off", "Lick Feet", "Finger Ass", "Suck Them", "Lick Ass", "Fuck Vagina", "Titjob", "Slap Ass", "Insert Object (Anal)", "Insert Object (Vaginal)")

	if(orientation == "femdom")
		position = input("What would you like to do with them?") in list("Fuck Mouth", "Kiss", "Jerk Off", "Lick Feet", "Give Footjob", "Finger Ass", "Suck Them", "Lick Ass", "Mount Vagina", "Mount Ass", "Slap Ass", "Insert Object (Anal)")

	switch(position)
		if("Fuck Ass")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("dick", "cock", "penis")
			usr.emote("me",1,sexverb + " his " + bodymisc + " in the " + src.name + "'s " + pick("pooper", "shitter", "pucker", "asshole", "ass", "butthole", "bumhole", "anus", "rectum", "wrong hole") + "!")
			playsound(src.loc, 'sound/effects/pop.ogg', 50, 1)
			if(prob(25))
				usr.emote("moan")
			if(prob(45))
				src.emote("groan")
			if(prob(10))
				src.emote("cry")
				src << "\red That hurts!"
			if(prob(10))
				src.emote("drool")
				src << "\blue That feels good..."
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums right in the " + src.name + "'s asshole!")
				usr.cum()
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
		if("Fuck Mouth")
			bodymisc = (usr.gender == FEMALE) ? pick("vagina", "pussy") : pick("dick", "cock", "penis")
			sexverb = (usr.gender == FEMALE) ? "rubs" : pick("stuffs", "puts", "sticks")
			if(usr.gender == FEMALE)
				usr.emote("me",1,sexverb + " her " + bodymisc + " against " + src.name + "'s " + pick("lips", "tongue", "mouth", "teeth", "nose", "chin") + "!")
			if(usr.gender == MALE)
				usr.emote("me",1,sexverb + " his " + bodymisc + " into " + src.name + "'s " + pick("mouth", "throat") + "!")
			if(prob(25))
				usr.emote("moan")
			if(prob(30))
				src.emote("gasp")
			if(prob(10))
				src.emote("choke")
				src << "\red That one was deep!"
			if(prob(20))
				src.emote("cough")
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.cum()
				usr.emote("me",1,"cums right in the " + src.name + "'s mouth!")
		if("Footjob")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("dick", "cock", "penis")
			var/feet = pick("toes", "feet")
			if(ishuman(src))
				if(src:wear_suit)
					feet = "shoes"
			if(ishuman(src))
				if(src:shoes)
					feet = src:shoes.name
			usr.emote("me",1,sexverb + " his " + bodymisc + " between " + src.name + "'s " + feet + "!")
			if(prob(25))
				usr.emote("moan")
			if(prob(5))
				usr.emote("drool")
				usr.emote("me",1,"cums right on the " + src.name + "'s feet!")
				usr.cum()

		if("Give Footjob")
			sexverb = pick("embraces", "rubs", "pokes")
			bodymisc = (src.gender == FEMALE) ? pick("vagina", "pussy") : pick("dick", "cock", "penis")
			var/feet = pick("toes", "feet")
			if(ishuman(usr))
				if(usr:wear_suit)
					feet = "shoes"
			if(ishuman(usr))
				if(usr:shoes)
					feet = usr:shoes.name
			usr.emote("me",1,sexverb + " " + src.name + "'s " + bodymisc + " using their " + feet + "!")
			if(prob(25))
				src.emote("moan")
			if(prob(5))
				src.emote("drool")
				src.emote("me",1,"cums right on the " + usr.name + "'s feet!")
				src.cum()

		if("Thighjob")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("dick", "cock", "penis")
			usr.emote("me",1,sexverb + " his " + bodymisc + " between " + src.name + "'s thighs!")
			if(prob(25))
				usr.emote("moan")
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums right on the " + src.name + "'s thighs!")
				usr.cum()
		if("Kiss")
			usr.emote("me",1,"kisses " + src.name + " in the " + pick("lips", "cheek", "mouth") + "!")
			if(prob(15))
				usr.emote("moan")
			if(prob(15))
				src.emote("moan")
		if("Slap Ass")
			usr.emote("me",1,"slaps " + src.name + " right on the " + pick("ass", "buttocks", "butt", "asscheeks", "booty") + "!")
			playsound(src.loc, 'sound/effects/snap.ogg', 50, 1)
			src.take_overall_damage(0.1,0)
			if(prob(35))
				src.emote("groan")
		if("Jerk Off")
			bodymisc = (src.gender == FEMALE) ? pick("vagina", "pussy") : pick("dick", "cock", "penis")
			sexverb = (src.gender == FEMALE) ? pick("rubs", "fingers", "pokes") : pick("jerks", "pulls", "embraces")
			usr.emote("me",1,sexverb + " " + src.name + "'s " + bodymisc + "!")
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums right in the " + usr.name + "'s hands!")
				src.cum()
		if("Lick Feet")
			sexverb = "licks"
			var/feet = pick("toes", "feet")
			if(ishuman(src))
				if(src:wear_suit)
					feet = "shoes"
			if(ishuman(src))
				if(src:shoes)
					feet = src:shoes.name
			usr.emote("me",1,sexverb + " " + src.name + "'s " + feet + "!")
		if("Finger Ass")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("pooper", "shitter", "pucker", "asshole", "ass", "butthole", "bumhole", "anus", "rectum", "wrong hole")
			usr.emote("me",1,sexverb + " their " + pick("finger", "fingers", "thumb", "index finger", "middle finger", "ring finger", "pinky") + " in " + src.name + "'s " + bodymisc + "!")
			playsound(src.loc, 'sound/effects/pop.ogg', 50, 1)
			if(prob(25))
				src.emote("moan")
			if(prob(45))
				src.emote("groan")
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
		if("Suck Them")
			sexverb = (src.gender == FEMALE) ? pick("licks", "sucks") : pick("chokes on", "licks", "sucks", "swallows")
			bodymisc = (src.gender == FEMALE) ? pick("vagina", "pussy") : pick("dick", "cock", "penis")
			usr.emote("me",1,sexverb + " " + src.name + "'s " + bodymisc + "!")
			if(prob(25))
				src.emote("moan")
			if(prob(30))
				usr.emote("gasp")
			if(prob(10))
				usr.emote("choke")
				usr << "\red That one was deep!"
			if(prob(20))
				usr.emote("cough")
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums right in the " + usr.name + "'s mouth!")
				src.cum()
		if("Lick Ass")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("pooper", "shitter", "pucker", "asshole", "ass", "butthole", "bumhole", "anus", "rectum", "wrong hole")
			usr.emote("me",1,sexverb + " their tongue in " + src.name + "'s " + bodymisc + "!")
			if(prob(25))
				src.emote("moan")
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
		if("Fuck Vagina")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("dick", "cock", "penis")
			usr.emote("me",1,sexverb + " his " + bodymisc + " in the " + src.name + "'s " + pick("pussy", "vagina") + "!")
			playsound(src.loc, 'sound/effects/pop.ogg', 50, 1)
			if(prob(25))
				src.emote("moan")
			if(prob(25))
				usr.emote("moan")
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums right in the " + src.name + "'s vagina!")
				usr.cum()
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
		if("Titjob")
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("dick", "cock", "penis")
			usr.emote("me",1,sexverb + " his " + bodymisc + " between " + src.name + "'s " + pick("boobs", "breasts", "tits", "milkers") + "!")
			if(prob(25))
				usr.emote("moan")
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums right on the " + src.name + "'s breasts!")
				usr.cum()
		if("Mount Vagina")
			sexverb = pick("sits on", "rides", "mounts")
			bodymisc = pick("vagina", "pussy")
			usr.emote("me",1,sexverb + " " + src.name + "'s " + pick("dick", "cock", "penis") + " with her " + bodymisc + "!")
			playsound(src.loc, 'sound/effects/pop.ogg', 50, 1)
			if(prob(25))
				src.emote("moan")
			if(prob(25))
				usr.emote("moan")
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums right in the " + usr.name + "'s vagina!")
				src.cum()
			if(prob(3))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums!")
				usr.cum()
		if("Mount Ass")
			sexverb = pick("sits on", "rides", "mounts")
			bodymisc = pick("pooper", "shitter", "pucker", "asshole", "ass", "butthole", "bumhole", "anus", "rectum", "wrong hole")
			usr.emote("me",1,sexverb + " " + src.name + "'s " + pick("dick", "cock", "penis") + " with their " + bodymisc + "!")
			playsound(src.loc, 'sound/effects/pop.ogg', 50, 1)
			if(prob(25))
				src.emote("moan")
			if(prob(45))
				usr.emote("groan")
			if(prob(10))
				usr.emote("cry")
				usr << "\red That hurts!"
			if(prob(10))
				usr.emote("drool")
				usr << "\blue That feels good..."
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums right in the " + usr.name + "'s asshole!")
				src.cum()
			if(prob(5))
				usr.emote("drool")
				usr << "\blue That feels good..."
				usr.emote("me",1,"cums!")
				usr.cum()
		if("Insert Object (Anal)")
			var/userforce
			var/itemname
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("pooper", "shitter", "pucker", "asshole", "ass", "butthole", "bumhole", "anus", "rectum", "wrong hole")
			if(!usr.r_hand && !usr.l_hand)
				return 0
			if(usr.r_hand && !usr.l_hand)
				userforce = usr.r_hand.force
				itemname = usr.r_hand.name
			if(!usr.r_hand && usr.l_hand)
				userforce = usr.l_hand.force
				itemname = usr.l_hand.name
			usr.emote("me",1,sexverb + " " + itemname + " in " + src.name + "'s " + bodymisc + "!")
			src.take_overall_damage(userforce,0)
			if(prob(50) && userforce > 0)
				src.emote("cry")
				src << "\red That hurts!"
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
			return 1
		if("Insert Object (Vaginal)")
			var/userforce
			var/itemname
			sexverb = pick("thrusts", "slides", "puts", "stuffs", "sticks")
			bodymisc = pick("pussy", "vagina")
			if(!usr.r_hand && !usr.l_hand)
				return 0
			if(usr.r_hand && !usr.l_hand)
				userforce = usr.r_hand.force
				itemname = usr.r_hand.name
			if(!usr.r_hand && usr.l_hand)
				userforce = usr.l_hand.force
				itemname = usr.l_hand.name
			usr.emote("me",1,sexverb + " " + itemname + " in " + src.name + "'s " + bodymisc + "!")
			src.take_overall_damage(userforce,0)
			if(prob(20) && userforce > 0)
				src.emote("cry")
				src << "\red That hurts!"
			if(prob(5))
				src.emote("drool")
				src << "\blue That feels good..."
				src.emote("me",1,"cums!")
				src.cum()
			return 1

/mob/proc/cum()
	if(stat == 2)
		return
	if(gender == MALE)
		playsound(src.loc, 'sound/interact/cum_m.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/pie_smudge(src.loc)
	if(gender == FEMALE)
		playsound(src.loc, 'sound/interact/cum_f.ogg', 50, 1, -1)

/mob/verb/dice()
	set name = "Roll D100"
	set category = "IC"
	var/result = rand(1, 100)
	if(!usr.stat)
		usr.visible_message("<span class='notice'>[usr] has rolled [result].</span>")

