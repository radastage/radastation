/mob/living/carbon/human/attack_hand(mob/living/carbon/human/M as mob)
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return


	if((M != src) && check_shields(0, M.name))
		visible_message("\red <B>[M] attempted to touch [src]!</B>")
		return 0

	if(M.gloves && istype(M.gloves,/obj/item/clothing/gloves))
		var/obj/item/clothing/gloves/G = M.gloves
		if(G.cell)
			if(M.a_intent == "harm")//Stungloves. Any contact will stun the alien.
				if(G.cell.charge >= 2500)
					G.cell.charge -= 2500
					playsound(src.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
					visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
					M.attack_log += text("\[[time_stamp()]\] <font color='red'>Stungloved [src.name] ([src.ckey])</font>")
					src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stungloved by [M.name] ([M.ckey])</font>")

					log_attack("<font color='red'>[M.name] ([M.ckey]) stungloved [src.name] ([src.ckey])</font>")

					var/armorblock = run_armor_check(M.zone_sel.selecting, "energy")
					apply_effects(5,5,0,0,5,0,0,armorblock)
					return 1
				else
					M << "\red Not enough charge! "
					visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
				return


	switch(M.a_intent)
		if("help")
			if(health >= 0)
				help_shake_act(M)
				return 1

			//CPR
			if((M.head && (M.head.flags & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags & MASKCOVERSMOUTH)))
				M << "<span class='notice'>Remove your mask!</span>"
				return 0
			if((head && (head.flags & HEADCOVERSMOUTH)) || (wear_mask && (wear_mask.flags & MASKCOVERSMOUTH)))
				M << "<span class='notice'>Remove their mask!</span>"
				return 0

			if(cpr_time < world.time + 30)
				visible_message("<span class='notice'>[M] is trying to perform CPR on [src]!</span>")
				if(!do_mob(M, src))
					return 0
				if((health >= -99 && health <= 0))
					cpr_time = world.time
					var/suff = min(getOxyLoss(), 7)
					adjustOxyLoss(-suff)
					updatehealth()
					M.visible_message("[M] performs CPR on [src]!")
					src << "<span class='unconscious'>You feel a breath of fresh air enter your lungs. It feels good.</span>"
					if (prob(50))
						spawn(0)
							heal_overall_damage(0.5,0.5)
							adjustToxLoss(-0.5)
							adjustOxyLoss(-0.5)
							updatehealth()

		if("grab")
			if(M == src)
				return 0
			if(w_uniform)
				w_uniform.add_fingerprint(M)

			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M, src)
			if(buckled)
				M << "<span class='notice'>You cannot grab [src], \he is buckled in!</span>"
			if(!G)	//the grab will delete itself in New if affecting is anchored
				return
			M.put_in_active_hand(G)
			grabbed_by += G
			G.synch()
			LAssailant = M

			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			visible_message("<span class='warning'>[M] has grabbed [src] passively!</span>")
			return 1

		if("harm")
			M.attack_log += text("\[[time_stamp()]\] <font color='red'>Punched [src.name] ([src.ckey])</font>")
			src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been punched by [M.name] ([M.ckey])</font>")

			log_attack("<font color='red'>[M.name] ([M.ckey]) punched [src.name] ([src.ckey])</font>")

			var/attack_verb = "punch"
			if(lying)
				attack_verb = "kick"
			else if(M.dna)
				switch(M.dna.mutantrace)
					if("lizard")
						attack_verb = "scratch"
					if("plant", "gas")
						attack_verb = "slash"
					if("zombie")
						attack_verb = "gnaw"

			var/damage = rand(0, 9)
			if(!damage)
				switch(attack_verb)
					if("slash")
						playsound(loc, 'sound/weapons/slashmiss.ogg', 25, 1, -1)
					if("scratch")
						playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1, -1)
					if("gnaw")
						playsound(loc, 'sound/weapons/bite.ogg', 25, 1, -1)
					else
						playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)

				visible_message("<span class='warning'>[M] has attempted to [attack_verb] [src]!</span>")
				return 0


			var/datum/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")



			if(HULK in M.mutations)
				damage += 5


			switch(attack_verb)
				if("slash")
					playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
				if("gnaw")
					playsound(loc, 'sound/weapons/bite.ogg', 25, 1, -1)
				else
					playsound(loc, "punch", 25, 1, -1)

			visible_message("<span class='danger'>[M] has [attack_verb]ed [src]!</span>", \
							"<span class='userdanger'>[M] has [attack_verb]ed [src]!</span>")

			apply_damage(damage, BRUTE, affecting, armor_block)

			if(M.dna && src.dna)
				if(M.dna.mutantrace == "zombie" && src.dna.mutantrace == null && prob(7))
					visible_message("<span class='danger'>[M] has infected [src]!</span>", \
					"<span class='userdanger'>[M] has infected [src]!</span>")
					src.dna.mutantrace = "zombie"
					src.faction = "zombie"


			if(damage >= 9)
				visible_message("<span class='danger'>[M] has weakened [src]!</span>", \
								"<span class='userdanger'>[M] has weakened [src]!</span>")
				apply_effect(4, WEAKEN, armor_block)
				forcesay(hit_appends)
			else if(lying)
				forcesay(hit_appends)



		if("disarm")
			M.attack_log += text("\[[time_stamp()]\] <font color='red'>Disarmed [src.name] ([src.ckey])</font>")
			src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been disarmed by [M.name] ([M.ckey])</font>")
			log_attack("<font color='red'>[M.name] ([M.ckey]) disarmed [src.name] ([src.ckey])</font>")

			if(w_uniform)
				w_uniform.add_fingerprint(M)
			var/datum/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/randn = rand(1, 100)
			if(randn <= 25)
				apply_effect(2, WEAKEN, run_armor_check(affecting, "melee"))
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				visible_message("<span class='danger'>[M] has pushed [src]!</span>",
								"<span class='userdanger'>[M] has pushed [src]!</span>")
				forcesay(hit_appends)
				return

			var/talked = 0	// BubbleWrap

			if(randn <= 60)
				//BubbleWrap: Disarming breaks a pull
				if(pulling)
					visible_message("<span class='warning'>[M] has broken [src]'s grip on [pulling]!</span>")
					talked = 1
					stop_pulling()

				//BubbleWrap: Disarming also breaks a grab - this will also stop someone being choked, won't it?
				if(istype(l_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/lgrab = l_hand
					if(lgrab.affecting)
						visible_message("<span class='warning'>[M] has broken [src]'s grip on [lgrab.affecting]!</span>")
						talked = 1
					spawn(1)
						del(lgrab)
				if(istype(r_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/rgrab = r_hand
					if(rgrab.affecting)
						visible_message("<span class='warning'>[M] has broken [src]'s grip on [rgrab.affecting]!</span>")
						talked = 1
					spawn(1)
						del(rgrab)
				//End BubbleWrap

				if(!talked)	//BubbleWrap
					drop_item()
					visible_message("<span class='danger'>[M] has disarmed [src]!</span>", \
									"<span class='userdanger'>[M] has disarmed [src]!</span>")
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return


			playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] attempted to disarm [src]!</span>", \
							"<span class='userdanger'>[M] attemped to disarm [src]!</span>")
	return

/mob/living/carbon/human/proc/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, inrange, params)
	return