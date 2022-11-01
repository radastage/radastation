/obj/effect/vaultspawner
	var/maxX = 6
	var/maxY = 6
	var/minX = 2
	var/minY = 2

/obj/effect/vaultspawner/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	if(!type)
		type = pick("sandstone","rock","alien")

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/wall/vault(locate(i,j,z),type)
			else
				new /turf/simulated/floor/vault(locate(i,j,z),type)

	del(src)


/obj/effect/stationspawner
	var/maxX = 15
	var/maxY = 15
	var/minX = 2
	var/minY = 2

/obj/effect/stationspawner/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	if(!type)
		type = pick("white","dark","bar","cafeteria","grimy","redfull","whiteredfull","bluefull","whitebluefull","greenfull","whitegreenfull","yellowfull","whiteyellowfull","engine","bcircuit","bcircuitoff", \
		"gcircuit","gcircuitoff","neutralfull","orangefull","purplefull","floorgrime","freezerfloor","hydrofloor","showroomfloor","elevatorshaft","asteroidfloor","asteroidplating","barber","cult","wood")

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				if(prob(15))
					new /turf/simulated/wall/r_wall(locate(i,j,z))
				else if (prob(45))
					new /turf/simulated/wall(locate(i,j,z))
					if (prob(8))
						new /obj/structure/sign/poster(locate(i,j,z))
					else if (prob(8))
						new /obj/structure/extinguisher_cabinet(locate(i,j,z))
					else if (prob(8))
						new /obj/item/device/radio/intercom(locate(i,j,z))
					else if (prob(8))
						new /obj/machinery/light_switch(locate(i,j,z))
					else if (prob(6))
						new /obj/machinery/power/apc(locate(i,(j+1),z))
					else if (prob(6))
						new /obj/machinery/firealarm(locate(i,j,z))
					else if (prob(6))
						new /obj/machinery/alarm(locate(i,j,z))
					else if (prob(6))
						new /obj/machinery/camera/all(locate(i,(j-1),z))
					else if (prob(6))
						new /obj/machinery/newscaster(locate(i,j,z))
					else if (prob(3))
						new /obj/structure/closet/fireaxecabinet(locate(i,j,z))
					else if (prob(3))
						new /obj/structure/reagent_dispensers/peppertank(locate(i,j,z))
						new /obj/item/weapon/reagent_containers/spray/pepper(locate(i,j,z))
					else if (prob(3))
						new /obj/machinery/vending/wallmed1(locate(i,j,z))
					else if (prob(6))
						new /obj/machinery/status_display(locate(i,j,z))
					else if (prob(3))
						new /obj/structure/reagent_dispensers/virusfood(locate(i,j,z))
						new /obj/item/weapon/reagent_containers/glass/bottle/retrovirus(locate(i,j,z))
				else if (prob(15))
					new /turf/simulated/floor/plating(locate(i,j,z))
					spawn_random_atom("/obj/machinery/door/airlock", locate(i,j,z))
				else if (prob(3))
					new /turf/simulated/floor/plating(locate(i,j,z))
					new /obj/machinery/shieldgen{anchored=1}(locate(i,j,z))
					new /obj/machinery/door/window/northright(locate(i,j,z))
					new /obj/machinery/door/window/southleft(locate(i,j,z))
					new /obj/machinery/door/window/eastright(locate(i,j,z))
					new /obj/machinery/door/window/westleft(locate(i,j,z))
				else
					new /obj/effect/windowspawn/reinforced(locate(i,j,z))
			else
				new /turf/simulated/floor/station(locate(i,j,z),type)
				if (prob(2))
					new /obj/machinery/light{on=1}(locate(i,(j+1),z))
					new /turf/simulated/wall/r_wall(locate(i,j,z))
				else if (prob(8))
					new /obj/machinery/light/small{on=1}(locate(i,(j+1),z))
					new /turf/simulated/wall(locate(i,j,z))
			//	if (prob(0.3))
			//		explosion_rec(locate(i,j,z), rand(0,30))
			//	else if (prob(15))
			//		new /obj/effect/stationloot(locate(i,j,z))
				else if (prob(2))
					new /obj/machinery/atmospherics/unary/vent_pump(locate(i,j,z))
				else if (prob(2))
					new /obj/machinery/atmospherics/unary/vent_scrubber(locate(i,j,z))

	del(src)


/obj/effect/stationloot
	var/spawnthis = null
	var/list/spawnthing = list(	/obj/machinery/vending/robotics								= 6,
							/obj/machinery/vending/engineering								= 6,
							/obj/machinery/vending/cart										= 6,
							/obj/machinery/vending/engineering								= 6,
							/obj/machinery/vending/plasmaresearch							= 6,
							/obj/machinery/vending/cigarette								= 6,
							/obj/machinery/vending/medical									= 6,
							/obj/machinery/vending/security									= 6,
							/obj/machinery/vending/wallmed1									= 6,
							/obj/machinery/vending/wallmed2									= 6,
							/obj/machinery/vending/hydronutrients							= 6,
							/obj/machinery/vending/hydroseeds								= 6,
							/obj/machinery/vending/dinnerware								= 6,
							/obj/machinery/vending/tool										= 6,
							/obj/machinery/vending/engivend									= 6,
							/obj/machinery/vending/snack									= 6,
							/obj/machinery/vending/coffee									= 6,
							/obj/machinery/vending/boozeomat								= 6,
							/obj/machinery/vending/cola										= 6,
							/obj/machinery/vending/assist									= 6,
							/obj/item/weapon/storage/box									= 5,
							/obj/item/weapon/storage/box/syndie_kit/space					= 5,
							/obj/item/weapon/storage/box/syndicate							= 5,
							/obj/item/weapon/storage/box/lights/mixed						= 5,
							/obj/item/weapon/storage/box/ids								= 5,
							/obj/item/weapon/storage/box/monkeycubes						= 5,
							/obj/item/weapon/storage/box/donkpockets						= 5,
							/obj/item/weapon/storage/box/rxglasses							= 5,
							/obj/item/weapon/storage/box/PDAs								= 5,
							/obj/item/weapon/storage/box/beakers							= 5,
							/obj/item/weapon/storage/box/emps								= 5,
							/obj/item/weapon/storage/box/teargas							= 5,
							/obj/item/weapon/storage/box/components							= 9,
							/obj/item/clothing/mask/gas/alt									= 5,
							/obj/item/clothing/mask/gas										= 5,
							/obj/item/weapon/storage/box/flashbangs							= 5,
							/obj/item/weapon/storage/box/beakers							= 5,
							/obj/item/weapon/storage/box/syringes							= 5,
							/obj/item/weapon/storage/box/masks								= 5,
							/obj/item/weapon/storage/box/gloves								= 5,
							/obj/item/weapon/storage/box/engineer							= 5,
							/obj/item/weapon/storage/box/survival							= 5,
							/obj/item/weapon/storage/box/cups								= 5,
							/obj/item/weapon/storage/box/drinkingglasses					= 5,
							/obj/item/weapon/storage/box/condimentbottles					= 5,
							/obj/item/weapon/storage/box/prisoner							= 5,
							/obj/item/weapon/storage/box/handcuffs							= 5,
							/obj/item/weapon/storage/box/mousetraps							= 5,
							/obj/item/weapon/storage/box/pillbottles						= 5,
							/obj/item/weapon/storage/box/matches							= 5,
							/obj/item/weapon/storage/box/disks								= 5,
							/obj/item/weapon/storage/pill_bottle/dice						= 5,
							/obj/item/weapon/storage/pill_bottle/inaprovaline				= 5,
							/obj/item/weapon/storage/pill_bottle/antitox					= 5,
							/obj/item/weapon/storage/pill_bottle/kelotane					= 7,
							/obj/item/weapon/storage/belt/utility/full						= 7,
							/obj/item/weapon/storage/firstaid								= 3,
							/obj/item/weapon/storage/firstaid/o2							= 8,
							/obj/item/weapon/storage/firstaid/toxin							= 8,
							/obj/item/weapon/storage/firstaid/regular						= 8,
							/obj/item/weapon/storage/firstaid/fire							= 8,
							/obj/item/weapon/storage/photo_album							= 6,
							/obj/item/device/camera_film									= 4,
							/obj/item/device/camera											= 6,
							/obj/item/device/radio											= 7,
							/obj/item/weapon/reagent_containers/pill/bicaridine				= 8,
							/obj/item/weapon/reagent_containers/pill/dexalin				= 8,
							/obj/item/weapon/reagent_containers/pill/inaprovaline			= 8,
							/obj/item/weapon/reagent_containers/pill/kelotane				= 8,
							/obj/item/weapon/reagent_containers/pill/stox					= 8,
							/obj/item/weapon/reagent_containers/pill/cyanide				= 8,
							/obj/item/weapon/reagent_containers/pill/tox					= 8,
							/obj/item/weapon/reagent_containers/pill/antitox				= 8,
							/obj/item/weapon/reagent_containers/pill/adminordrazine			= 8,
							/obj/item/weapon/reagent_containers/syringe/lethal/choral		= 8,
							/obj/item/weapon/storage/briefcase								= 8,
							/obj/item/weapon/storage/wallet/random							= 9,
							/obj/item/weapon/storage/secure/briefcase						= 3,
							/obj/item/weapon/storage/fancy/candle_box						= 3,
							/obj/item/weapon/storage/fancy/egg_box							= 7,
							/obj/item/weapon/storage/fancy/donut_box						= 7,
							/obj/item/weapon/storage/backpack/holding						= 3,
							/obj/item/weapon/storage/backpack								= 8,
							/obj/item/weapon/storage/backpack/satchel_norm					= 7,
							/obj/machinery/computer/pandemic								= 5,
							/obj/machinery/computer/med_data								= 5,
							/obj/machinery/computer/crew									= 5,
							/obj/machinery/computer/communications							= 5,
							/obj/machinery/computer/card									= 5,
							/obj/machinery/computer/arcade									= 5,
							/obj/machinery/hydroponics										= 8,
							/obj/machinery/hydroponics/soil									= 8,
							/obj/structure/sink												= 9,
							/obj/structure/reagent_dispensers/fueltank						= 10,
							/obj/structure/reagent_dispensers/watertank						= 10,
							/obj/structure/barricade/wooden									= 13,
							/obj/structure/table/woodentable								= 6,
							/obj/structure/table/reinforced									= 7,
							/obj/structure/table											= 7,
							/obj/structure/mirror											= 7,
							/obj/structure/rack												= 6,
							/obj/structure/dispenser/oxygen									= 3,
							/obj/structure/dispenser/plasma									= 3,
							/obj/structure/filingcabinet									= 2,
							/obj/structure/closet											= 4,
							/obj/structure/closet/secure_closet	    						= 1,
							/obj/structure/closet/secure_closet/miner						= 1,
							/obj/structure/closet/secure_closet/exile						= 1,
							/obj/structure/closet/secure_closet/courtroom					= 1,
							/obj/structure/closet/secure_closet/injection					= 1,
							/obj/structure/closet/secure_closet/detective					= 1,
							/obj/structure/closet/secure_closet/security					= 1,
							/obj/structure/closet/secure_closet/warden						= 1,
							/obj/structure/closet/secure_closet/hos							= 1,
							/obj/structure/closet/secure_closet/hop							= 1,
							/obj/structure/closet/secure_closet/captains					= 1,
							/obj/structure/closet/secure_closet/RD							= 1,
							/obj/structure/closet/secure_closet/scientist					= 1,
							/obj/structure/closet/secure_closet/chemical					= 1,
							/obj/structure/closet/secure_closet/CMO							= 1,
							/obj/structure/closet/secure_closet/medical3					= 1,
							/obj/structure/closet/secure_closet/medical2					= 1,
							/obj/structure/closet/secure_closet/medical1					= 1,
							/obj/structure/closet/secure_closet/hydroponics					= 1,
							/obj/structure/closet/secure_closet/freezer/money				= 1,
							/obj/structure/closet/secure_closet/freezer/kitchen				= 1,
							/obj/structure/closet/secure_closet/freezer/fridge				= 1,
							/obj/structure/closet/secure_closet/freezer/meat				= 1,
							/obj/structure/closet/secure_closet/engineering_personal		= 1,
							/obj/structure/closet/secure_closet/engineering_welding			= 1,
							/obj/structure/closet/secure_closet/engineering_electrical		= 1,
							/obj/structure/closet/secure_closet/engineering_chief			= 1,
							/obj/structure/closet/secure_closet/quartermaster				= 1,
							/obj/structure/closet/secure_closet/cargotech					= 1,
							/obj/structure/closet/secure_closet/bar							= 1,
							/obj/structure/closet/wardrobe									= 1,
							/obj/structure/closet/wardrobe/mixed							= 6,
							/obj/structure/closet/wardrobe/grey								= 2,
							/obj/structure/closet/wardrobe/virology_white					= 2,
							/obj/structure/closet/wardrobe/genetics_white					= 2,
							/obj/structure/closet/wardrobe/chemistry_white					= 2,
							/obj/structure/closet/wardrobe/robotics_black					= 2,
							/obj/structure/closet/wardrobe/toxins_white						= 2,
							/obj/structure/closet/wardrobe/pjs								= 2,
							/obj/structure/closet/wardrobe/white							= 2,
							/obj/structure/closet/wardrobe/engineering_yellow				= 2,
							/obj/structure/closet/wardrobe/atmospherics_yellow				= 2,
							/obj/structure/closet/wardrobe/yellow							= 2,
							/obj/structure/closet/wardrobe/orange							= 2,
							/obj/structure/closet/wardrobe/green							= 2,
							/obj/structure/closet/wardrobe/chaplain_black					= 2,
							/obj/structure/closet/wardrobe/black							= 2,
							/obj/structure/closet/wardrobe/pink								= 2,
							/obj/structure/closet/wardrobe/red								= 2,
							/obj/structure/closet/athletic_mixed							= 5,
							/obj/structure/closet/masks										= 1,
							/obj/structure/closet/syndicate/personal						= 2,
							/obj/structure/closet/syndicate/nuclear							= 2,
							/obj/structure/closet/syndicate/resources/everything			= 2,
							/obj/structure/closet/syndicate/resources						= 2,
							/obj/structure/closet/malf/suits								= 2,
							/obj/structure/closet/chefcloset								= 2,
							/obj/structure/closet/gmcloset									= 3,
							/obj/structure/closet/toolcloset								= 3,
							/obj/structure/closet/jcloset									= 2,
							/obj/structure/closet/lawcloset									= 3,
							/obj/structure/closet/gimmick/tacticool							= 2,
							/obj/structure/closet/gimmick/russian							= 2,
							/obj/structure/closet/crate										= 3,
							/obj/structure/closet/crate/miningcar							= 3,
							/obj/structure/closet/crate/hydroponics/prespawned				= 3,
							/obj/structure/closet/crate/radiation							= 2,
							/obj/structure/closet/crate/rcd									= 2,
							/obj/structure/closet/crate/trashcart							= 3,
							/obj/structure/closet/crate/juice								= 2,
							/obj/structure/bedsheetbin										= 3,
							/obj/structure/stool											= 2,
							/obj/structure/stool/bed										= 6,
							/obj/structure/stool/bed/roller									= 6,
							/obj/structure/stool/bed/chair									= 2,
							/obj/structure/stool/bed/chair/office/dark						= 2,
							/obj/structure/stool/bed/chair/office/light						= 2,
							/obj/structure/stool/bed/chair/comfy/lime						= 2,
							/obj/structure/stool/bed/chair/comfy/black						= 2,
							/obj/structure/stool/bed/chair/comfy/teal						= 2,
							/obj/structure/stool/bed/chair/comfy/beige						= 2,
							/obj/structure/stool/bed/chair/comfy/brown						= 2,
							/obj/item/weapon/gun/syringe									= 5,
							/obj/item/weapon/gun/syringe/rapidsyringe						= 4,
							/obj/item/weapon/gun/projectile/shotgun/pump/combat				= 2,
							/obj/item/weapon/gun/projectile/automatic/l6_saw				= 2,
							/obj/item/weapon/gun/energy/temperature							= 2,
							/obj/item/weapon/gun/projectile/shotgun/doublebarrel			= 5,
							/obj/item/weapon/gun/projectile/shotgun/pump					= 4,
							/obj/item/weapon/gun/projectile/mateba							= 3,
							/obj/item/weapon/gun/projectile/detective						= 5,
							/obj/item/weapon/gun/projectile/pistol							= 5,
							/obj/item/weapon/gun/projectile/gyropistol						= 2,
							/obj/item/weapon/gun/projectile/deagle							= 2,
							/obj/item/weapon/gun/projectile/silenced						= 2,
							/obj/item/weapon/gun/projectile/automatic/c20r					= 2,
							/obj/item/weapon/gun/projectile/automatic/mini_uzi				= 2,
							/obj/item/weapon/gun/projectile/p08								= 3,
							/obj/item/weapon/gun/projectile/automatic/c05r					= 3,
							/obj/item/weapon/gun/energy/taser								= 5,
							/obj/item/weapon/gun/energy/stunrevolver						= 3,
							/obj/item/weapon/gun/energy/laser								= 3,
							/obj/item/weapon/gun/energy/laser/retro							= 5,
							/obj/item/weapon/gun/energy/gun									= 4,
							/obj/item/weapon/gun/energy/ionrifle							= 3,
							/obj/item/weapon/gun/energy/pulse_rifle							= 2,
							/obj/item/weapon/melee/classic_baton							= 2,
							/obj/item/weapon/melee/chainofcommand							= 2,
							/obj/item/weapon/melee/baton									= 2,
							/obj/item/weapon/melee/baton/loaded								= 5,
							/obj/item/weapon/melee/energy/axe								= 2,
							/obj/item/weapon/melee/energy/sword/color						= 5,
							/obj/item/weapon/melee/energy/sword/pirate						= 5,
							/obj/item/weapon/twohanded/dualsaber							= 3,
							/obj/item/weapon/storage/toolbox/syndicate						= 6,
							/obj/item/weapon/storage/toolbox/electrical						= 8,
							/obj/item/weapon/storage/toolbox/emergency						= 9,
							/obj/item/weapon/storage/toolbox/mechanical						= 9,
							/obj/machinery/suit_storage_unit/standard_unit					= 5,
							/obj/structure/grille											= 7,
							/obj/machinery/microwave										= 7,
							/obj/item/weapon/butch											= 7,
							/obj/item/stack/rods											= 7,
							/obj/item/stack/sheet/metal										= 10,
							/obj/item/stack/sheet/metal/random								= 40,
							/obj/item/stack/sheet/cloth										= 30,
							/obj/item/weapon/shard											= 30,
							/obj/item/stack/sheet/glass										= 10,
							/obj/item/stack/sheet/glass/random								= 30,
							/obj/item/stack/sheet/cardboard									= 20,
							/obj/item/stack/sheet/rglass									= 8,
							/obj/machinery/cell_charger										= 8,
							/obj/item/stack/sheet/plasteel									= 20,
							/obj/machinery/recharger										= 8,
							/obj/item/weapon/card/id/captains_spare							= 5,
							/obj/machinery/autolathe										= 10,
							/obj/machinery/porta_turret										= 5,
							/obj/item/device/multitool										= 6,
							/obj/structure/girder											= 10,
							/obj/structure/girder/reinforced								= 8,
							/obj/structure/girder/displaced									= 9,
							/obj/machinery/chem_dispenser									= 6,
							/obj/machinery/chem_master										= 6,
							/obj/item/weapon/pickaxe										= 8,
							/obj/item/weapon/twohanded/fireaxe								= 6,
							/obj/structure/closet/emcloset									= 14,
							/obj/structure/closet/emcloset/legacy							= 14,
							/obj/structure/closet/firecloset/full							= 14,
							/obj/item/device/radio/intercom									= 12,
							/obj/item/weapon/paper_bin										= 12,
							/obj/item/weapon/folder											= 7,
							/obj/item/weapon/folder/white									= 7,
							/obj/item/weapon/folder/yellow									= 7,
							/obj/item/weapon/folder/red										= 7,
							/obj/item/weapon/folder/blue									= 7,
							/obj/item/weapon/pen											= 7,
							/obj/item/weapon/pen/paralysis									= 7,
							/obj/item/weapon/pen/sleepypen									= 7,
							/obj/item/weapon/gun/energy/meteorgun/pen						= 4,
							/obj/item/weapon/coin											= 1,
							/obj/item/weapon/coin/twoheaded									= 5,
							/obj/item/weapon/coin/mythril									= 5,
							/obj/item/weapon/coin/adamantine								= 5,
							/obj/item/weapon/coin/clown										= 5,
							/obj/item/weapon/coin/uranium									= 5,
							/obj/item/weapon/coin/plasma									= 5,
							/obj/item/weapon/coin/iron										= 5,
							/obj/item/weapon/coin/diamond									= 5,
							/obj/item/weapon/coin/silver									= 5,
							/obj/item/weapon/coin/gold										= 5,
							/obj/machinery/reagentgrinder									= 8,
							/obj/item/stack/sheet/mineral/plasma							= 3,
							/obj/item/stack/sheet/mineral/clown								= 3,
							/obj/item/stack/sheet/mineral/silver							= 3,
							/obj/item/stack/sheet/mineral/gold								= 3,
							/obj/item/stack/sheet/mineral/diamond							= 3,
							/obj/item/weapon/claymore										= 3,
							/obj/item/weapon/surgical_drapes								= 3,
							/obj/structure/optable											= 3,
							/obj/structure/closet/l3closet									= 3,
							/obj/structure/closet/l3closet/general							= 3,
							/obj/structure/closet/l3closet/janitor							= 3,
							/obj/structure/closet/l3closet/security							= 3,
							/obj/structure/closet/l3closet/virology							= 3,
							/obj/structure/closet/bombcloset								= 3,
							/obj/structure/closet/bombclosetsecurity						= 3,
							/obj/item/weapon/kitchenknife									= 5,
							/obj/item/weapon/circular_saw									= 5,
							/obj/item/weapon/scalpel										= 3,
							/obj/item/weapon/surgicaldrill									= 3,
							/obj/item/weapon/cautery										= 3,
							/obj/item/weapon/hemostat										= 3,
							/obj/item/weapon/retractor										= 3,
							/obj/item/weapon/legcuffs/beartrap								= 4,
							/obj/structure/crematorium										= 1,
							/obj/structure/extinguisher_cabinet								= 7,
							/obj/structure/kitchenspike										= 5,
							/obj/structure/piano											= 2,
							/obj/machinery/biogenerator										= 4,
							/obj/machinery/bookbinder										= 1,
							/obj/machinery/constructable_frame/machine_frame				= 4,
							/obj/machinery/deployable/barrier								= 4,
							/obj/machinery/gibber											= 4,
							/obj/machinery/librarycomp										= 1,
							/obj/machinery/libraryscanner									= 1,
							/obj/machinery/mech_bay_recharge_port							= 4,
							/obj/machinery/monkey_recycler									= 4,
							/obj/machinery/photocopier										= 2,
							/obj/machinery/pipedispenser									= 2,
							/obj/machinery/portable_atmospherics/canister/air				= 20,
							/obj/machinery/portable_atmospherics/canister/nitrogen			= 20,
							/obj/machinery/portable_atmospherics/canister/oxygen			= 20,
							/obj/machinery/atmospherics/pipe/tank/air						= 20,
							/obj/machinery/atmospherics/pipe/tank/oxygen					= 10,
							/obj/machinery/seed_extractor									= 6,
							/obj/machinery/sleeper											= 8,
							/obj/machinery/washing_machine									= 5,
							/obj/structure/dresser											= 5,
							/obj/machinery/shower											= 8,
							/obj/item/weapon/circuitboard/curefab							= 3,
							/obj/item/weapon/circuitboard/operating							= 3,
							/obj/item/weapon/circuitboard/crew								= 3,
							/obj/item/weapon/circuitboard/rdconsole							= 3,
							/obj/item/weapon/circuitboard/arcade							= 3,
							/obj/item/weapon/circuitboard/cloning							= 3,
							/obj/item/weapon/circuitboard/robotics							= 3,
							/obj/item/weapon/circuitboard/teleporter						= 3,
							/obj/item/weapon/circuitboard/card								= 3,
							/obj/item/weapon/circuitboard/communications					= 3,
							/obj/item/weapon/circuitboard/scan_consolenew					= 3,
							/obj/item/weapon/circuitboard/pandemic							= 3,
							/obj/item/weapon/circuitboard/med_data							= 3,
							/obj/item/weapon/circuitboard/security							= 3,
							/obj/item/weapon/circuitboard/clonescanner						= 3,
							/obj/item/weapon/circuitboard/clonepod							= 3,
							/obj/item/weapon/circuitboard/mechfab							= 3,
							/obj/item/weapon/circuitboard/circuit_imprinter					= 3,
							/obj/item/weapon/circuitboard/protolathe						= 3,
							/obj/item/weapon/circuitboard/autolathe							= 3,
							/obj/item/weapon/circuitboard/destructive_analyzer				= 3,
							/obj/item/device/radio/electropack								= 2,
							/obj/item/weapon/cable_coil/random								= 4,
							/obj/item/weapon/screwdriver									= 4,
							/obj/item/weapon/wrench											= 4,
							/obj/item/weapon/weldingtool									= 4,
							/obj/item/weapon/crowbar										= 4,
							/obj/item/weapon/wirecutters									= 4,
							/mob/living/carbon/monkey										= 3,
							/mob/living/simple_animal/mouse									= 5,
							/mob/living/carbon/human										= 5,
							/obj/item/weapon/hatchet										= 4,
							/obj/item/weapon/reagent_containers/glass/bucket				= 8,
							/obj/item/weapon/shovel/spade									= 4,
							/obj/item/weapon/shovel											= 4,
							/obj/item/weapon/reagent_containers/glass/beaker				= 6,
							/obj/item/weapon/reagent_containers/glass/beaker/sulphuric		= 4,
							/obj/item/device/flashlight										= 7,
							/obj/item/device/flashlight/lantern/on							= 7,
							/obj/item/device/flashlight/lantern								= 7,
							/obj/item/device/flashlight/flare								= 7,
							/obj/item/device/flashlight/lamp								= 7,
							/obj/item/device/flashlight/lamp/green							= 7,
							/obj/item/device/flashlight/pen									= 7,
							/obj/effect/decal/cleanable/robot_debris						= 12,
							/obj/effect/decal/cleanable/blood/gibs							= 10,
							/obj/effect/gibspawner/robot									= 9,
							/obj/effect/gibspawner/xeno										= 9,
							/obj/effect/gibspawner/human									= 10,
							/obj/effect/gibspawner/generic									= 9,
							/obj/effect/decal/remains/human									= 9,
							/obj/effect/decal/remains/robot									= 8,
							/obj/effect/decal/remains/xeno									= 7,
							/obj/item/weapon/reagent_containers/spray/cleaner				= 7,
							/obj/effect/mobspawn											= 1,
							/obj/effect/mobspawn/skrell										= 1,
							/obj/effect/mobspawn/shadowperson								= 1,
//							/obj/effect/mobspawn/flyperson									= 1,
							/obj/effect/mobspawn/abductor									= 1,
							/obj/effect/mobspawn/lifebringer								= 1,
							/obj/effect/mobspawn/freegolem									= 1,
							/obj/effect/mobspawn/lizard										= 1,
							/obj/effect/mobspawn/slime										= 1,
							/obj/effect/mobspawn/alien										= 1,
							/obj/effect/mobspawn/cyborg										= 1,
							/obj/effect/mobspawn/monkey										= 1,
							/obj/effect/mobspawn/resomi										= 1,
							/obj/effect/mobspawn/assistant									= 1,
							/obj/effect/mobspawn/atmostech									= 1,
							/obj/effect/mobspawn/cargotech									= 1,
							/obj/effect/mobspawn/chaplain									= 1,
							/obj/effect/mobspawn/lawyer										= 1,
							/obj/effect/mobspawn/librarian									= 1,
							/obj/effect/mobspawn/captain									= 1,
							/obj/effect/mobspawn/hop										= 1,
							/obj/effect/mobspawn/hos										= 1,
							/obj/effect/mobspawn/ce											= 1,
							/obj/effect/mobspawn/rd											= 1,
							/obj/effect/mobspawn/cmo										= 1,
							/obj/effect/mobspawn/engineer									= 1,
							/obj/effect/mobspawn/doctor										= 1,
							/obj/effect/mobspawn/geneticist									= 1,
							/obj/effect/mobspawn/virologist									= 1,
							/obj/effect/mobspawn/chemist									= 1,
							/obj/effect/mobspawn/scientist									= 1,
							/obj/effect/mobspawn/roboticist									= 1,
							/obj/effect/mobspawn/bartender									= 1,
							/obj/effect/mobspawn/botanist									= 1,
							/obj/effect/mobspawn/chef										= 1,
							/obj/effect/mobspawn/janitor									= 1,
							/obj/effect/mobspawn/quartermaster								= 1,
							/obj/effect/mobspawn/miner										= 1,
							/obj/effect/mobspawn/clown										= 1,
							/obj/effect/mobspawn/mime										= 1,
							/obj/effect/mobspawn/warden										= 1,
							/obj/effect/mobspawn/detective									= 1,
							/obj/effect/mobspawn/changeling									= 1,
							/obj/effect/mobspawn/ninja										= 1,
							/obj/effect/mobspawn/serpent									= 1,
							/obj/effect/mobspawn/deathcommando								= 1,
							/obj/effect/mobspawn/security									= 1,
							/obj/machinery/wish_granter										= 1,
							/mob/living/simple_animal/hostile/faithless						= 3,
							/obj/effect/landmark/mobcorpse									= 7,
							/obj/effect/landmark/malemobcorpse/spaceninja					= 1,
							/obj/effect/landmark/femalemobcorpse/femalespaceninja			= 1,
							/obj/effect/landmark/femalemobcorpse/syndicatescoutspace		= 1,
							/obj/effect/landmark/femalemobcorpse/russianscout				= 1,
							/obj/effect/landmark/femalemobcorpse/nanotrasenscout			= 1,
							/obj/effect/landmark/femalemobcorpse/syndicatescout				= 1,
							/obj/effect/landmark/femalemobcorpse/ertmedical					= 1,
							/obj/effect/landmark/mobcorpse/cultspace						= 1,
							/obj/effect/landmark/mobcorpse/russiantrooper					= 1,
							/obj/effect/landmark/mobcorpse/syndicateelite					= 1,
							/obj/effect/landmark/mobcorpse/centcomcommander					= 1,
							/obj/effect/landmark/mobcorpse/centcomranged					= 1,
							/obj/effect/landmark/mobcorpse/centcom							= 1,
							/obj/effect/landmark/mobcorpse/thunderdomerheavy				= 1,
							/obj/effect/landmark/mobcorpse/syndicateagent					= 1,
							/obj/effect/landmark/mobcorpse/nanotrasenspace					= 1,
							/obj/effect/landmark/mobcorpse/nanotrasenwarden					= 1,
							/obj/effect/landmark/mobcorpse/nanotrasenhos					= 1,
							/obj/effect/landmark/mobcorpse/spacerussian						= 1,
							/obj/effect/landmark/mobcorpse/ertsecurity						= 1,
							/obj/effect/landmark/mobcorpse/ertengineer						= 1,
							/obj/effect/landmark/mobcorpse/ertcommander						= 1,
							/obj/effect/landmark/mobcorpse/deathsquad						= 1,
							/obj/effect/landmark/mobcorpse/cult								= 1,
							/obj/effect/landmark/mobcorpse/thunderdomer						= 1,
							/obj/effect/landmark/mobcorpse/nanotrasen						= 1,
							/obj/effect/landmark/mobcorpse/russian							= 1,
							/obj/effect/landmark/mobcorpse/russian/ranged					= 1,
							/obj/effect/landmark/mobcorpse/pirate							= 1,
							/obj/effect/landmark/mobcorpse/pirate/ranged					= 1,
							/obj/effect/landmark/mobcorpse/clown							= 2,
							/obj/effect/landmark/mobcorpse/syndicatecommando				= 1,
							/obj/effect/landmark/mobcorpse/syndicatesoldier					= 1,
							/obj/item/device/radio/beacon									= 5,
							/obj/item/weapon/soap											= 5,
							/obj/item/weapon/soap/syndie									= 2,
							/obj/item/weapon/soap/deluxe									= 2,
							/obj/item/weapon/soap/nanotrasen								= 2,
							/obj/item/weapon/bananapeel										= 4,
							/obj/machinery/recharge_station									= 3,
							/obj/item/device/assembly/timer									= 4,
							/obj/item/device/assembly/signaler								= 4,
							/obj/item/device/assembly/prox_sensor							= 4,
							/obj/item/device/assembly/igniter								= 4,
							/obj/item/device/assembly/infra									= 2,
							/obj/machinery/bot/secbot										= 3,
							/obj/machinery/bot/secbot/beepsky								= 3,
							/obj/machinery/bot/medbot										= 4,
							/obj/machinery/bot/medbot/mysterious							= 2,
							/obj/machinery/bot/floorbot										= 4,
							/obj/machinery/bot/ed209										= 2,
							/obj/machinery/bot/cleanbot										= 4,
							/turf/simulated/wall											= 12,
							/obj/structure/falsewall										= 8,
							/obj/structure/falserwall										= 9,
							/turf/simulated/wall/r_wall										= 9,
							/obj/effect/windowspawn											= 12,
							/mob/living/simple_animal/hostile/cyborg						= 4,
							/mob/living/simple_animal/hostile/cyborg/random					= 6,
							/mob/living/simple_animal/hostile/giant_spider					= 2,
							/mob/living/simple_animal/hostile/giant_spider/nurse			= 2,
							/mob/living/simple_animal/hostile/giant_spider/hunter			= 2,
							/mob/living/simple_animal/hostile/alien/random					= 5,
							/mob/living/simple_animal/hostile/spawner/nanotrasen			= 5,
							/mob/living/simple_animal/hostile/spawner/syndicate				= 5,
							/obj/mecha/working/ripley										= 4,
							/obj/mecha/working/ripley/mining								= 2,
							/obj/mecha/working/ripley/deathripley							= 1,
							/obj/mecha/working/ripley/firefighter							= 2,
							/obj/mecha/medical/odysseus										= 2,
							/obj/mecha/combat/phazon										= 2,
							/obj/mecha/combat/marauder										= 2,
							/obj/mecha/combat/marauder/mauler								= 1,
							/obj/mecha/combat/marauder/seraph								= 1,
							/obj/mecha/combat/honker										= 3,
							/obj/mecha/combat/gygax											= 3,
							/obj/mecha/combat/gygax/dark									= 1,
							/obj/mecha/combat/durand										= 3,
							/obj/machinery/r_n_d/protolathe									= 5,
							/obj/machinery/r_n_d/destructive_analyzer						= 5,
							/obj/machinery/r_n_d/circuit_imprinter							= 5,
							/obj/machinery/computer/rdconsole/core							= 5,
							/obj/machinery/computer/rdconsole/robotics						= 5,
							/obj/item/stack/medical/bruise_pack								= 8,
							/obj/item/stack/medical/ointment								= 8,
							/obj/effect/workplace_kitchen									= 6,
							/obj/effect/workplace_recycler									= 6,
							/obj/effect/workplace_botanist									= 6,
							/obj/effect/workplace_teleporter								= 6,
							/obj/effect/workplace_research_and_development					= 6,
							/obj/effect/workplace_chemical									= 6,
							/obj/effect/workplace_dnascanner								= 6,
							/obj/effect/workplace_furnacespawn								= 6,
							/obj/effect/workplace_library									= 6,
							/obj/effect/workplace_bar										= 6,
							/obj/structure/turret/gun_turret								= 5,
							/obj/effect/workplace_shield									= 5,
							/obj/structure/sink/puddle										= 4
							)

proc/spawn_random_atom(var/object as text, turf/location as turf)
	var/list/matches = get_fancy_list_of_types()
	var/chosen

	if (!isnull(object) && object!="")
		matches = filter_fancy_list(matches, object)

	if(matches.len==0)
		return

	chosen = pick(matches)

	var/atom/newatom = new chosen(location)

	if(!newatom.icon || newatom.icon == null || newatom.icon_state == null)
		del(newatom)


/obj/effect/stationloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)


/obj/effect/windowspawn
	var/spawnthis = null
	var/list/spawnthing = list(	/obj/structure/window/basic									= 5,
								/obj/structure/window/reinforced							= 4,
								/obj/structure/window/reinforced/tinted						= 3,
								/obj/structure/window/reinforced/tinted/frosted				= 2
								)

/obj/effect/windowspawn/New()
	new /turf/simulated/floor/plating (src.loc)
	var/windowtype = pickweight(spawnthing)
	var/obj/structure/window/WIN1 = new windowtype(get_turf(src))
	WIN1.dir = NORTH
	var/obj/structure/window/WIN2 = new windowtype(get_turf(src))
	WIN2.dir = SOUTH
	var/obj/structure/window/WIN3 = new windowtype(get_turf(src))
	WIN3.dir = EAST
	var/obj/structure/window/WIN4 = new windowtype(get_turf(src))
	WIN4.dir = WEST
	new /obj/structure/grille (src.loc)
	del(src)

/obj/effect/windowspawn/basic
	spawnthing = list( /obj/structure/window/basic )

/obj/effect/windowspawn/reinforced
	spawnthing = list( /obj/structure/window/reinforced )

/obj/effect/windowspawn/tinted
	spawnthing = list( /obj/structure/window/reinforced/tinted )

/obj/effect/windowspawn/frosted
	spawnthing = list( /obj/structure/window/reinforced/tinted/frosted )


/obj/effect/cultstation
	var/maxX = 12
	var/maxY = 12
	var/minX = 3
	var/minY = 3

/obj/effect/cultstation/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/wall/cult(locate(i,j,z))
			else
				new /turf/simulated/floor/engine/cult(locate(i,j,z))
				if (prob(15))
					new /obj/effect/cultloot(locate(i,j,z))

	del(src)

/obj/effect/cultloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)

/obj/effect/cultloot
	var/spawnthis = null
	var/list/spawnthing = list(	/mob/living/simple_animal/hostile/cult						= 3,
							/mob/living/simple_animal/hostile/cult/space					= 2,
							/mob/living/simple_animal/hostile/cult/meleecult				= 1,
							/mob/living/simple_animal/hostile/cult/meleecult/space			= 1,
							/mob/living/simple_animal/hostile/construct/builder				= 4,
							/mob/living/simple_animal/hostile/construct/wraith				= 3,
							/mob/living/simple_animal/hostile/construct/armoured			= 2,
							/mob/living/simple_animal/hostile/spawner/cult					= 1,
							/obj/item/weapon/storage/backpack/cultpack						= 2,
							/obj/item/weapon/melee/cultblade								= 2,
							/obj/structure/cult/tome										= 3,
							/obj/structure/cult/pylon										= 2,
							/obj/structure/cult/forge										= 2,
							/obj/item/weapon/paper/talisman/supply							= 3,
							/obj/item/device/flashlight/lantern/on							= 3,
							/obj/item/weapon/tome											= 4
							)


/obj/effect/alienstation
	var/maxX = 12
	var/maxY = 12
	var/minX = 3
	var/minY = 3

/obj/effect/alienstation/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/floor/plating(locate(i,j,z))
				new /obj/structure/alien/resin/wall(locate(i,j,z))
			else
				new /turf/simulated/floor/plating(locate(i,j,z))
				new /obj/structure/alien/weeds(locate(i,j,z))
				if (prob(15))
					new /obj/effect/alienloot(locate(i,j,z))

	del(src)

/obj/effect/alienloot
	var/spawnthis = null
	var/list/spawnthing = list( /mob/living/simple_animal/hostile/alien/random	= 3,
								/obj/effect/mobspawn/larva						= 1,
								/obj/effect/mobspawn/alien						= 1,
								/obj/structure/stool/bed/alien					= 1,
								/obj/effect/decal/remains/human					= 2,
								/obj/item/device/flashlight/lantern/on			= 2,
								/obj/structure/alien/resin/membrane				= 2, /obj/item/weed_extract = 2,
								/obj/structure/alien/egg						= 3	)

/obj/effect/alienloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)

/obj/effect/snowforest
	var/maxX = 30
	var/maxY = 30
	var/minX = 5
	var/minY = 5

/obj/effect/snowforest/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/floor/plating/snow(locate(i,j,z))
				if(prob(15))
					new /obj/structure/mineral_door/wood(locate(i,j,z))
				else new /turf/simulated/wall/wooden(locate(i,j,z))
			else
				new /turf/simulated/floor/plating/snow(locate(i,j,z))
				if(prob(15))
					new /obj/structure/barricade/wooden(locate(i,j,z))
				else if(prob(15))
					new /obj/structure/flora/tree/pine(locate(i,j,z))
				else if(prob(10))
					new /obj/effect/snowloot(locate(i,j,z))

	del(src)


/obj/effect/snowloot
	var/spawnthis = null
	var/list/spawnthing = list( /obj/structure/flora/tree/pine					= 20,
								/mob/living/simple_animal/hostile/bear			= 1,
								/mob/living/simple_animal/hostile/russian		= 1,
								/mob/living/simple_animal/hostile/russian/scout	= 1,
								/mob/living/simple_animal/hostile/russian/spacerussian		= 1,
								/mob/living/simple_animal/hostile/russian/ranged	= 1,
								/obj/item/device/flashlight/lamp/green				= 1,
								/mob/living/simple_animal/hostile/russian/ranged/trooper = 1,
								/obj/structure/closet/gimmick/russian			= 1,
								/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka						= 1	)

/obj/effect/snowloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)

/obj/effect/randomstation/New()
	var/stationlist = list( /obj/effect/stationspawner = 4, /obj/effect/alienstation = 2, /obj/effect/cultstation = 2, \
							/obj/effect/asteroidspawn = 3, /obj/effect/snowforest = 2, /obj/effect/pirateshuttle = 2, \
							/obj/effect/syndicateshuttle = 2, /obj/effect/cyborgsatellite = 2, /obj/effect/plasmaruins = 2	)

	var/stationtype = pickweight(stationlist)

	new stationtype(src.loc)
	del(src)

/obj/effect/syndicateshuttle
	var/maxX = 17
	var/maxY = 17
	var/minX = 9
	var/minY = 9

/turf/simulated/shuttle/wall/syndicate
	icon_state = "wall3"

/obj/effect/syndicateshuttle/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/shuttle/floor4(locate(i,j,z))
				if(prob(15))
					new /obj/machinery/door/airlock/security(locate(i,j,z))
				else new /turf/simulated/shuttle/wall/syndicate(locate(i,j,z))
			else
				new /turf/simulated/shuttle/floor4(locate(i,j,z))
				if(prob(15))
					new /obj/effect/windowspawn(locate(i,j,z))
				else if(prob(15))
					new /turf/simulated/shuttle/wall/syndicate(locate(i,j,z))
				else if(prob(20))
					new /obj/effect/syndicateloot(locate(i,j,z))

	del(src)

/obj/effect/syndicateloot
	var/spawnthis = null
	var/list/spawnthing = list( /mob/living/simple_animal/hostile/syndicate/random		= 1,
								/mob/living/simple_animal/hostile/spawner/syndicate		= 1,
								/obj/item/weapon/reagent_containers/food/snacks/syndicake	= 1,
								/obj/machinery/computer/syndicate_station					= 1,
								/obj/effect/spawner/newbomb/timer/syndicate					= 1,
								/obj/item/weapon/storage/toolbox/syndicate				 = 1,
								/obj/item/device/radio/uplink							= 1,
								/obj/effect/mobspawn/syndicate							= 1,
								/obj/item/device/flashlight/lamp						= 1,
								/obj/effect/wreckage_random								= 1,
								/obj/structure/closet/syndicate/nuclear						= 1	)


/obj/effect/syndicateloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)

/obj/effect/wreckage_random/New()
	spawn_random_atom("/obj/structure/mecha_wreckage/", src.loc)
	del(src)

/obj/effect/cyborgsatellite
	var/maxX = 17
	var/maxY = 17
	var/minX = 9
	var/minY = 9

/obj/effect/cyborgsatellite/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/floor/plating(locate(i,j,z))
				if(prob(15))
					new /obj/machinery/door/airlock/centcom(locate(i,j,z))
				else new /obj/structure/grille(locate(i,j,z))
			else
				new /turf/simulated/floor/plating(locate(i,j,z))
				if(prob(15))
					new /obj/structure/grille(locate(i,j,z))
				else if(prob(33))
					new /obj/effect/cyborgloot(locate(i,j,z))

	del(src)

/obj/effect/cyborgloot
	var/spawnthis = null
	var/list/spawnthing = list( /mob/living/simple_animal/hostile/cyborg/random			= 1,
								/mob/living/simple_animal/hostile/spawner/cyborg		= 1,
								/obj/item/device/radio/beacon							= 1,
								/obj/machinery/vending/robotics								= 1,
								/obj/machinery/vending/assist							= 1,
								/obj/effect/mobspawn/cyborg								 = 1,
								/obj/effect/mobspawn/ai									= 1,
								/obj/structure/closet/malf/suits							= 1,
								/obj/item/assembly/shock_kit							= 1,
								/obj/machinery/camera/all								= 1,
								/obj/item/device/flashlight/lamp						= 1,
								/obj/structure/grille									= 1	)


/obj/effect/cyborgloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)


/obj/effect/pirateshuttle
	var/maxX = 17
	var/maxY = 17
	var/minX = 9
	var/minY = 9

/obj/effect/pirateshuttle/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)
	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/shuttle/floor(locate(i,j,z))
				if(prob(15))
					new /obj/machinery/door/airlock/external(locate(i,j,z))
				else new /turf/simulated/shuttle/wall(locate(i,j,z))
			else
				new /turf/simulated/shuttle/floor(locate(i,j,z))
				if(prob(15))
					new /obj/structure/grille(locate(i,j,z))
				else if(prob(15))
					new /turf/simulated/shuttle/wall(locate(i,j,z))
				else if(prob(20))
					new /obj/effect/pirateloot(locate(i,j,z))

	del(src)

/obj/effect/pirateloot
	var/spawnthis = null
	var/list/spawnthing = list( /mob/living/simple_animal/hostile/pirate			= 1,
								/mob/living/simple_animal/hostile/pirate/ranged		= 1,
								/obj/item/stack/sheet/metal							= 1,
								/obj/item/stack/sheet/metal/random					= 1,
								/obj/item/stack/sheet/glass							= 1,
								/obj/item/stack/sheet/glass/random					 = 1,
								/obj/item/weapon/spacecash/c1000					= 1,
								/obj/item/weapon/spacecash/c500						= 1,
								/obj/item/weapon/spacecash/c200						= 1,
								/obj/item/weapon/spacecash/c100						= 1,
								/obj/item/weapon/spacecash/c50						= 1,
								/obj/item/weapon/spacecash/c20						= 1,
								/obj/item/weapon/spacecash/c10						= 1,
								/obj/item/device/flashlight/lamp/green				= 1,
								/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka						= 1	)

/obj/effect/pirateloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis (src.loc)
	del(src)

/obj/effect/asteroidspawn
	var/maxX = 30
	var/maxY = 30
	var/minX = 3
	var/minY = 3

/obj/effect/asteroidspawn/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/mineral/random(locate(i,j,z))
			else
				new /turf/simulated/mineral/random(locate(i,j,z))

	del(src)

/obj/effect/plasmaruins
	var/maxX = 24
	var/maxY = 24
	var/minX = 4
	var/minY = 4

/obj/effect/plasmaruins/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY,var/type = null)

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/wall/mineral/plasma(locate(i,j,z))
				if(prob(20))
					new /turf/simulated/floor/engine/n20/plasma(locate(i,j,z))
					new /obj/structure/mineral_door/transparent/plasma(locate(i,j,z))
			else
				new /turf/simulated/floor/engine/n20/plasma(locate(i,j,z))
				if(prob(10))
					new /obj/effect/plasmaloot(locate(i,j,z))

	del(src)

/obj/effect/plasmaloot/New()
	var/list/spawnthing = list( /turf/simulated/wall/mineral/plasma					= 1,
								/obj/item/stack/sheet/mineral/plasma				= 1,
								/obj/item/weapon/pickaxe/plasmacutter				= 1,
								/obj/item/weapon/tank/plasma						= 1,
								/obj/effect/spawner/newbomb/timer/syndicate			= 1,
								/obj/effect/mobspawn/plasmaman						= 1,
								/obj/structure/ore_box								= 1,
								/obj/structure/dispenser/plasma						= 1,
								/obj/item/weapon/ore/plasma							= 1,
								/obj/item/device/flashlight/lantern/on				= 1,
								/obj/machinery/vending/plasmaresearch				 = 1
								)
	var/spawnthis = pickweight(spawnthing)
	new spawnthis(src.loc)
	del(src)


/turf/simulated/floor/engine/n20/plasma/New()
	..()
	var/datum/gas_mixture/adding = new
	var/datum/gas/sleeping_agent/trace_gas = new

	trace_gas.moles = 2000
	adding.trace_gases += trace_gas
	adding.temperature = T20C

	assume_air(adding)
	icon += rgb(100,30,100)



/obj/effect/workplace_furnacespawn/New(turf/location as turf)
	new /obj/machinery/mineral/input(locate(location.x,(location.y+1),location.z))
	new /obj/machinery/mineral/output(locate(location.x,(location.y-1),location.z))
	new /obj/machinery/mineral/processing_unit(locate(location.x,location.y,location.z))
	new /obj/machinery/mineral/processing_unit_console(locate((location.x-1),location.y,location.z))

	del(src)

/obj/effect/workplace_dnascanner/New(turf/location as turf)
	new /obj/machinery/dna_scannernew(locate(location.x,location.y,location.z))
	new /obj/machinery/computer/scan_consolenew(locate((location.x-1),location.y,location.z))
	new /obj/item/weapon/storage/box/monkeycubes(locate(location.x,location.y,location.z))

	del(src)

/obj/effect/workplace_chemical/New(turf/location as turf)
	new /obj/machinery/chem_dispenser(locate(location.x,location.y,location.z))
	new /obj/machinery/chem_master(locate((location.x-1),location.y,location.z))
	new /obj/item/weapon/storage/box/beakers(locate(location.x,location.y,location.z))

	del(src)

/obj/effect/workplace_research_and_development/New(turf/location as turf)
	new /obj/machinery/r_n_d/protolathe(locate(location.x,(location.y+1),location.z))
	new /obj/machinery/r_n_d/destructive_analyzer(locate(location.x,(location.y-1),location.z))
	new /obj/machinery/r_n_d/server/core(locate((location.x-1),location.y,location.z))
	new /obj/machinery/r_n_d/circuit_imprinter(locate((location.x-1),(location.y+1),location.z))
	new /obj/machinery/computer/rdconsole/core(locate(location.x,location.y,location.z))

	del(src)

/obj/effect/workplace_robotics/New(turf/location as turf)
	new /obj/machinery/computer/mecha(locate(location.x,location.y,location.z))
	new /obj/machinery/mech_bay_recharge_port(locate(location.x,(location.y+1),location.z))
	new /turf/simulated/floor/mech_bay_recharge_floor(locate((location.x+1),(location.y+1),location.z))
	new /obj/machinery/mecha_part_fabricator(locate((location.x+1),location.y,location.z))
	new /obj/machinery/robotic_fabricator(locate((location.x+2),location.y,location.z))
	new /obj/machinery/computer/mech_bay_power_console(locate((location.x+2),(location.y+1),location.z))
	del(src)

/obj/effect/workplace_teleporter/New(turf/location as turf)
	new /obj/machinery/teleport/hub(locate((location.x+1),location.y,location.z))
	new /obj/machinery/teleport/station(locate(location.x,location.y,location.z))
	new /obj/machinery/computer/teleporter(locate((location.x-1),location.y,location.z))
	new /obj/item/device/radio/beacon(locate((location.x-1),location.y,location.z))

	del(src)

/obj/effect/workplace_botanist/New(turf/location as turf)
	new /obj/machinery/biogenerator(locate((location.x+1),location.y,location.z))
	new /obj/machinery/seed_extractor(locate(location.x,location.y,location.z))
	new /obj/machinery/hydroponics(locate((location.x-1),location.y,location.z))
	new /obj/structure/reagent_dispensers/watertank(locate((location.x-2),location.y,location.z))
	new /obj/item/weapon/reagent_containers/glass/bucket(locate((location.x-2),location.y,location.z))
	new /obj/item/weapon/minihoe(locate((location.x-2),location.y,location.z))
	new /obj/item/weapon/hatchet(locate((location.x-2),location.y,location.z))
	new /obj/item/weapon/shovel/spade(locate((location.x-2),location.y,location.z))
	new /obj/item/weapon/storage/bag/plants(locate((location.x-2),location.y,location.z))

	del(src)

/obj/effect/workplace_recycler/New(turf/location as turf)
	new /obj/machinery/autolathe(locate(location.x,location.y,location.z))
	new /obj/structure/reagent_dispensers/fueltank(locate((location.x-1),location.y,location.z))
	new /obj/item/weapon/storage/toolbox/mechanical(locate((location.x-1),location.y,location.z))

	del(src)

/obj/effect/workplace_kitchen/New(turf/location as turf)
	new /obj/structure/table/reinforced(locate(location.x,location.y,location.z))
	new /obj/item/weapon/book/manual/chef_recipes(locate(location.x,location.y,location.z))
	new /obj/machinery/microwave(locate(location.x,location.y,location.z))
	new /obj/item/weapon/reagent_containers/spray/cleaner(locate(location.x,location.y,location.z))
	new /obj/item/weapon/reagent_containers/food/condiment/peppermill(locate((location.x+1),location.y,location.z))
	new /obj/item/weapon/reagent_containers/food/condiment/saltshaker(locate((location.x+1),location.y,location.z))
	new /obj/structure/closet/secure_closet/freezer/fridge(locate((location.x+1),location.y,location.z))
	new /obj/machinery/processor(locate((location.x-1),location.y,location.z))
	new /obj/item/weapon/kitchenknife(locate((location.x-1),location.y,location.z))

	del(src)

/obj/effect/workplace_library/New(turf/location as turf)
	new /obj/machinery/bookbinder(locate((location.x-1),location.y,location.z))
	new /obj/machinery/librarycomp(locate(location.x,location.y,location.z))
	new /obj/machinery/photocopier(locate((location.x+1),location.y,location.z))

	del(src)

/obj/effect/workplace_bar/New(turf/location as turf)
	new /obj/structure/reagent_dispensers/beerkeg(locate((location.x-1),location.y,location.z))
	new /obj/structure/table/woodentable(locate(location.x,location.y,location.z))
	new /obj/item/weapon/book/manual/barman_recipes(locate(location.x,location.y,location.z))
	new /obj/item/weapon/reagent_containers/food/drinks/shaker(locate(location.x,location.y,location.z))
	new /obj/machinery/vending/boozeomat(locate((location.x+1),location.y,location.z))

	del(src)

/obj/effect/workplace_shield/New(turf/location as turf)
	new /obj/machinery/shieldwallgen(locate((location.x-1),location.y,location.z))
	new /obj/machinery/shieldwallgen(locate((location.x+1),location.y,location.z))

	del(src)

/obj/effect/asteroidloot
	var/spawnthis = null
	var/list/spawnthing = list( //mob/living/simple_animal/hostile/spawner/hivebot 	= 1,
								/obj/item/device/flashlight/lantern/on				= 5,
								/obj/item/weapon/ore/glass							= 5,
								/mob/living/simple_animal/hostile/creature			= 2,
								/mob/living/simple_animal/hostile/giant_spider		= 1,
								/mob/living/simple_animal/hostile/giant_spider/nurse = 1,
								/mob/living/simple_animal/hostile/giant_spider/hunter = 1,
								/mob/living/simple_animal/hostile/hivebot/random	= 5,
								/mob/living/simple_animal/hostile/faithless/horror	= 1,
								/mob/living/simple_animal/hostile/alien/random		= 1,
								/mob/living/simple_animal/hostile/carp				= 1
								)

/obj/effect/asteroidloot/New()
	spawnthis = pickweight(spawnthing)
	new spawnthis(src.loc)
	del(src)