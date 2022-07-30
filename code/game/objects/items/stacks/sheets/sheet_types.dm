/* Diffrent misc types of sheets
 * Contains:
 *		Metal
 *		Plasteel
 *		Wood
 *		Cloth
 *		Cardboard
 */

/*
 * Metal
 */
var/global/list/datum/stack_recipe/metal_recipes = list ( \
	new/datum/stack_recipe("stool", /obj/structure/stool, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("chair", /obj/structure/stool/bed/chair, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("swivel chair", /obj/structure/stool/bed/chair/office/dark, 5, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("comfy chair", /obj/structure/stool/bed/chair/comfy/beige, 2, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("bed", /obj/structure/stool/bed, 2, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("table parts", /obj/item/weapon/table_parts, 2), \
	new/datum/stack_recipe("rack parts", /obj/item/weapon/rack_parts), \
	new/datum/stack_recipe("closet", /obj/structure/closet, 2, time = 15, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("canister", /obj/machinery/portable_atmospherics/canister, 10, time = 15, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 2, 60), \
	null, \
	new/datum/stack_recipe("computer frame", /obj/structure/computerframe, 5, time = 25, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("wall girders", /obj/structure/girder, 2, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("airlock assembly", /obj/structure/door_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("machine frame", /obj/machinery/constructable_frame/machine_frame, 5, time = 25, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("turret frame", /obj/machinery/porta_turret_construct, 5, time = 25, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("grenade casing", /obj/item/weapon/grenade/chem_grenade), \
	new/datum/stack_recipe("large grenade casing", /obj/item/weapon/grenade/chem_grenade/large, 2), \
	new/datum/stack_recipe("handcuffs", /obj/item/weapon/handcuffs, 2), \
	new/datum/stack_recipe("bear trap", /obj/item/weapon/legcuffs/beartrap, 2), \
	new/datum/stack_recipe("spade", /obj/item/weapon/shovel/spade), \
	new/datum/stack_recipe("kitchen knife", /obj/item/weapon/kitchenknife, 3), \
	new/datum/stack_recipe("kitchen spike", /obj/structure/kitchenspike, 5, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("light fixture frame", /obj/item/light_fixture_frame, 2), \
	new/datum/stack_recipe("small light fixture frame", /obj/item/light_fixture_frame/small, 1), \
	null, \
	new/datum/stack_recipe("apc frame", /obj/item/apc_frame, 2), \
	new/datum/stack_recipe("air alarm frame", /obj/item/alarm_frame, 2), \
	new/datum/stack_recipe("bucket", /obj/item/weapon/reagent_containers/glass/bucket, 2), \
	new/datum/stack_recipe("mop", /obj/item/weapon/mop, 2), \
	new/datum/stack_recipe("cart", /obj/structure/cart_custom, 3, time = 30, one_per_turf = 1), \
	new/datum/stack_recipe("sledgehammer", /obj/item/weapon/pickaxe/hammer, 4), \
	new/datum/stack_recipe("scythe", /obj/item/weapon/scythe, 4), \
	new/datum/stack_recipe("cane", /obj/item/weapon/cane), \
	new/datum/stack_recipe("hatchet", /obj/item/weapon/hatchet, 4), \
	new/datum/stack_recipe("fire alarm frame", /obj/item/firealarm_frame, 2), \
	new/datum/stack_recipe("recharger frame", /obj/item/recharger_frame), \
	new/datum/stack_recipe("cell charger frame", /obj/item/cell_charger_frame), \
	new/datum/stack_recipe("stethoscope", /obj/item/clothing/tie/stethoscope), \
	null, \
	new/datum/stack_recipe("yellow hardhat", /obj/item/clothing/head/hardhat), \
	new/datum/stack_recipe("blue hardhat", /obj/item/clothing/head/hardhat/dblue), \
	new/datum/stack_recipe("orange hardhat", /obj/item/clothing/head/hardhat/orange), \
	new/datum/stack_recipe("red hardhat", /obj/item/clothing/head/hardhat/red), \
	new/datum/stack_recipe("white hardhat", /obj/item/clothing/head/hardhat/white), \
	null, \
	new/datum/stack_recipe("iron coin", /obj/item/weapon/coin/iron), \
	new/datum/stack_recipe("iron door", /obj/structure/mineral_door/iron, 20, one_per_turf = 1, on_floor = 1), \
)

/obj/item/stack/sheet/metal
	name = "metal"
	desc = "Sheets made out off metal. It has been dubbed Metal Sheets."
	singular_name = "metal sheet"
	icon_state = "sheet-metal"
	m_amt = 3750
	throwforce = 14.0
	flags = FPRINT | TABLEPASS | CONDUCT
	origin_tech = "materials=1"

/obj/item/stack/sheet/metal/random/New()
	new /obj/item/stack/sheet/metal(src.loc, rand(1,50))
	del(src)

/obj/item/stack/sheet/metal/cyborg
	name = "metal"
	desc = "Sheets made out off metal. It has been dubbed Metal Sheets."
	singular_name = "metal sheet"
	icon_state = "sheet-metal"
	m_amt = 0
	throwforce = 14.0
	flags = FPRINT | TABLEPASS | CONDUCT

/obj/item/stack/sheet/metal/New(var/loc, var/amount=null)
	recipes = metal_recipes
	return ..()


/*
 * Plasteel
 */
var/global/list/datum/stack_recipe/plasteel_recipes = list ( \
	new/datum/stack_recipe("AI core", /obj/structure/AIcore, 4, time = 50, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("shutters", /obj/machinery/door/poddoor/shutters, 4, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("blast door", /obj/machinery/door/poddoor, 4, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("blast door control", /obj/machinery/door_control, 1, time = 10, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("conveyor belt", /obj/machinery/conveyor, 1, time = 15, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("conveyor switch", /obj/machinery/conveyor_switch, 1, time = 5, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe("morgue", /obj/structure/morgue, 4, time = 50, one_per_turf = 1), \
	new/datum/stack_recipe("crematorium", /obj/structure/crematorium, 4, time = 50, one_per_turf = 1), \
	new/datum/stack_recipe("crematorium switch", /obj/machinery/crema_switch, 1, time = 10, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("mass driver", /obj/machinery/mass_driver, 4, time = 50, one_per_turf = 1), \
	new/datum/stack_recipe("mass driver button", /obj/machinery/driver_button, 1, time = 10, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("armor", /obj/item/clothing/suit/armor/vest, 3, time = 15), \
	new/datum/stack_recipe("helmet", /obj/item/clothing/head/helmet, 1, time = 5), \
	new/datum/stack_recipe("riot armor", /obj/item/clothing/suit/armor/riot, 4, time = 35), \
	new/datum/stack_recipe("riot helmet", /obj/item/clothing/head/helmet/riot, 2, time = 10), \
	null, \
	new/datum/stack_recipe("emitter", /obj/machinery/power/emitter, 6, time = 70, one_per_turf = 1), \
	new/datum/stack_recipe("shield generator", /obj/machinery/shieldwallgen, 6, time = 70, one_per_turf = 1), \
	new/datum/stack_recipe("power cell", /obj/item/weapon/cell/crap/empty), \
	null, \
	new/datum/stack_recipe("biogenerator", /obj/machinery/biogenerator, 5, time = 100, one_per_turf = 1), \
	new/datum/stack_recipe("vendomat", /obj/machinery/vending, 5, time = 100, one_per_turf = 1), \
	new/datum/stack_recipe("gateway", /obj/structure/latespawn, 10, time = 100, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("cyborg recharging station", /obj/machinery/recharge_station, 5, time = 100, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("gas mask", /obj/item/clothing/mask/gas), \
	new/datum/stack_recipe("gas mask (alt)", /obj/item/clothing/mask/gas/alt), \
	new/datum/stack_recipe("space suit", /obj/item/clothing/suit/space, 5, time = 1000), \
	new/datum/stack_recipe("space helmet", /obj/item/clothing/head/helmet/space, 3, time = 1000), \
	new/datum/stack_recipe("cyborg visor", /obj/item/clothing/mask/gas/cyborg), \
	new/datum/stack_recipe("armored robe", /obj/item/clothing/suit/cultrobes/alt, 4, time = 35), \
	new/datum/stack_recipe("heavy armor", /obj/item/clothing/suit/armor/heavy, 5, time = 35), \
	null, \
	new/datum/stack_recipe("autolathe", /obj/machinery/autolathe, 5, time = 60, one_per_turf = 1), \
	new/datum/stack_recipe("microwave oven", /obj/machinery/microwave, 3, time = 35, one_per_turf = 1), \
	new/datum/stack_recipe("chem dispenser", /obj/machinery/chem_dispenser, 4, time = 60, one_per_turf = 1), \
	new/datum/stack_recipe("gibber", /obj/machinery/gibber, 6, time = 120, one_per_turf = 1), \
	new/datum/stack_recipe("chem master", /obj/machinery/chem_master, 4, time = 60, one_per_turf = 1), \
	new/datum/stack_recipe("operating table", /obj/structure/optable, 4, time = 60, one_per_turf = 1), \
	new/datum/stack_recipe("suit storage unit", /obj/machinery/suit_storage_unit, 5, time = 60, one_per_turf = 1), \
	new/datum/stack_recipe("arcade machine", /obj/machinery/computer/arcade, 4, time = 70, one_per_turf = 1), \
	new/datum/stack_recipe("washing machine", /obj/machinery/washing_machine, 4, time = 70, one_per_turf = 1), \
	new/datum/stack_recipe("space minimog", /obj/structure/piano, 4, time = 70, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("rapid-construction device", /obj/item/weapon/rcd, 7, time = 250), \
	new/datum/stack_recipe("compressed matter cartridge", /obj/item/weapon/rcd_ammo, 2, time = 150), \
	new/datum/stack_recipe("magboots", /obj/item/clothing/shoes/magboots, 5, time = 250), \
	new/datum/stack_recipe("airlock painter", /obj/item/weapon/airlock_painter), \
	new/datum/stack_recipe("secure safe", /obj/item/weapon/storage/secure/safe, time = 10, one_per_turf = 1), \
	new/datum/stack_recipe("floor safe", /obj/structure/safe/floor, 2, time = 20, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("safe", /obj/structure/safe, 2, time = 20, one_per_turf = 1), \
	null, \
	new/datum/stack_recipe("sink", /obj/structure/sink, 3, time = 40, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("toilet", /obj/structure/toilet, 3, time = 40, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("urinal", /obj/structure/urinal, 3, time = 40, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("shower", /obj/machinery/shower, 3, time = 40, one_per_turf = 1, on_floor = 1), \

	)

/obj/item/stack/sheet/plasteel
	name = "plasteel"
	singular_name = "plasteel sheet"
	desc = "This sheet is an alloy of iron and plasma."
	icon_state = "sheet-plasteel"
	item_state = "sheet-metal"
	m_amt = 7500
	throwforce = 15.0
	flags = FPRINT | TABLEPASS | CONDUCT
	origin_tech = "materials=2"

/obj/item/stack/sheet/plasteel/New(var/loc, var/amount=null)
		recipes = plasteel_recipes
		return ..()

/*
 * Wood
 */
var/global/list/datum/stack_recipe/wood_recipes = list ( \
	new/datum/stack_recipe("wooden sandals", /obj/item/clothing/shoes/sandal, 1), \
	new/datum/stack_recipe("wood floor tile", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("table parts", /obj/item/weapon/table_parts/wood, 2), \
	new/datum/stack_recipe("wooden chair", /obj/structure/stool/bed/chair/wood/normal, 1, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 3, time = 20, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("wooden door", /obj/structure/mineral_door/wood, 5, time = 20, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("coffin", /obj/structure/closet/coffin, 5, time = 15, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("wooden baton", /obj/item/weapon/melee/classic_baton, 3, time = 5), \
	new/datum/stack_recipe("fire axe", /obj/item/weapon/twohanded/fireaxe, 5, time = 10), \
	new/datum/stack_recipe("book case", /obj/structure/bookcase, 4, time = 15, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("dresser", /obj/structure/dresser, 4, time = 15, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("buckler", /obj/item/weapon/shield/buckler, 3, time = 14), \
	null, \
	new/datum/stack_recipe("wooden wall", /turf/simulated/wall/wooden, 5, time = 40, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("convert to cardboard", /obj/item/stack/sheet/cardboard, 1, 2, 4), \
	)

/obj/item/stack/sheet/wood
	name = "wooden planks"
	desc = "One can only guess that this is a bunch of wood."
	singular_name = "wood plank"
	icon_state = "sheet-wood"
	origin_tech = "materials=1;biotech=1"

/obj/item/stack/sheet/wood/New(var/loc, var/amount=null)
	recipes = wood_recipes
	return ..()

/*
 * Cloth
 */
/obj/item/stack/sheet/cloth
	name = "cloth"
	desc = "This roll of cloth is made from only the finest chemicals and bunny rabbits."
	singular_name = "cloth roll"
	icon_state = "sheet-cloth"
	origin_tech = "materials=2"

/obj/item/stack/sheet/cloth/New()
	recipes = cloth_recipes
	return ..()

var/global/list/datum/stack_recipe/cloth_recipes = list ( \
	new/datum/stack_recipe("white jumpsuit", /obj/item/clothing/under/color/white, 2), \
	new/datum/stack_recipe("white shoes", /obj/item/clothing/shoes/white), \
	new/datum/stack_recipe("white gloves", /obj/item/clothing/gloves/white), \
	new/datum/stack_recipe("sterile mask", /obj/item/clothing/mask/surgical), \
	new/datum/stack_recipe("damp rag", /obj/item/weapon/reagent_containers/glass/rag), \
	new/datum/stack_recipe("improvised bandage", /obj/item/stack/medical/bruise_pack/improvised, 2), \
	new/datum/stack_recipe("eyepatch", /obj/item/clothing/glasses/eyepatch), \
	new/datum/stack_recipe("blindfold", /obj/item/clothing/glasses/sunglasses/blindfold), \
	new/datum/stack_recipe("muzzle", /obj/item/clothing/mask/muzzle), \
	new/datum/stack_recipe("balaclava", /obj/item/clothing/mask/balaclava, 1), \
	new/datum/stack_recipe("suspenders", /obj/item/clothing/suit/suspenders, 1), \
	new/datum/stack_recipe("straight jacket", /obj/item/clothing/suit/straight_jacket, 4), \
	new/datum/stack_recipe("waistcoat", /obj/item/clothing/suit/wcoat, 1), \
	new/datum/stack_recipe("judge's robe", /obj/item/clothing/suit/judgerobe, 3), \
	new/datum/stack_recipe("chaplain hoodie", /obj/item/clothing/suit/chaplain_hoodie, 3), \
	new/datum/stack_recipe("webbing", /obj/item/clothing/suit/armor/webbing, 2), \
	new/datum/stack_recipe("labcoat", /obj/item/clothing/suit/labcoat, 2), \
	new/datum/stack_recipe("mad scientist's labcoat", /obj/item/clothing/suit/labcoat/mad, 2), \
	new/datum/stack_recipe("chef's apron", /obj/item/clothing/suit/chef, 2), \
	new/datum/stack_recipe("chef's hat", /obj/item/clothing/head/chefhat), \
	new/datum/stack_recipe("grey cap", /obj/item/clothing/head/soft/grey), \
	new/datum/stack_recipe("bedsheet", /obj/item/weapon/bedsheet), \
	new/datum/stack_recipe("surgical drapes", /obj/item/weapon/surgical_drapes, 3), \
	new/datum/stack_recipe("surgical apron", /obj/item/clothing/suit/apron/surgical, 2), \
	new/datum/stack_recipe("coveralls", /obj/item/clothing/suit/apron/overalls, 2), \
	new/datum/stack_recipe("body bag", /obj/item/bodybag, 3, time = 50, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("carpet", /obj/item/stack/tile/carpet, 1, 4, 20), \
	null, \
	new/datum/stack_recipe("luchador mask", /obj/item/clothing/mask/luchador), \
	new/datum/stack_recipe("rudos mask", /obj/item/clothing/mask/luchador/rudos), \
	new/datum/stack_recipe("tecnicos mask", /obj/item/clothing/mask/luchador/tecnicos), \
	new/datum/stack_recipe("horse head mask", /obj/item/clothing/mask/horsehead), \
	new/datum/stack_recipe("pig mask",/obj/item/clothing/mask/pig), \
	null, \
	new/datum/stack_recipe("Lawyer suit", /obj/item/clothing/under/lawyer/female, 3), \
	new/datum/stack_recipe("executive suit", /obj/item/clothing/under/suit_jacket/really_black, 3), \
	new/datum/stack_recipe("athletic shorts", /obj/item/clothing/under/shorts/black, 1), \
	new/datum/stack_recipe("roboticist's jumpsuit", /obj/item/clothing/under/rank/roboticist, 2), \
	new/datum/stack_recipe("turtleneck", /obj/item/clothing/under/syndicate/tacticool, 2), \
	new/datum/stack_recipe("sundress", /obj/item/clothing/under/sundress, 2), \
	null, \
	new/datum/stack_recipe("shirt", /obj/item/clothing/suit/shirt), \
	new/datum/stack_recipe("bra", /obj/item/clothing/suit/bra), \
	new/datum/stack_recipe("top", /obj/item/clothing/suit/top), \
	null, \
	new/datum/stack_recipe("pants", /obj/item/clothing/under/pants), \
	new/datum/stack_recipe("skirt", /obj/item/clothing/under/skirt), \
	new/datum/stack_recipe("underwear", /obj/item/clothing/under/underwear), \
	new/datum/stack_recipe("thong", /obj/item/clothing/under/thong), \
	new/datum/stack_recipe("panties", /obj/item/clothing/under/panties), \
	new/datum/stack_recipe("one-piece swimsuit", /obj/item/clothing/under/onepiece), \
	new/datum/stack_recipe("boxers", /obj/item/clothing/under/boxers), \
	null, \
	new/datum/stack_recipe("knee-high socks", /obj/item/clothing/shoes/kneehighs), \
	new/datum/stack_recipe("socks", /obj/item/clothing/shoes/socks), \
	new/datum/stack_recipe("stockings", /obj/item/clothing/shoes/stockings), \
	null, \
	new/datum/stack_recipe("rabbit ears", /obj/item/clothing/head/rabbitears), \
	new/datum/stack_recipe("sturdy top-hat", /obj/item/clothing/head/that), \
	new/datum/stack_recipe("pirate bandana", /obj/item/clothing/head/bandana), \
	new/datum/stack_recipe("bowler-hat", /obj/item/clothing/head/bowler), \
	new/datum/stack_recipe("detective hat", /obj/item/clothing/head/det_hat), \

	)

/obj/item/stack/sheet/cloth/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if (istype(W, src.type))
		var/obj/item/stack/S = W
		if (S.amount >= max_amount)
			return 1
		var/to_transfer as num
		if (user.get_inactive_hand()==src)
			to_transfer = 1
		else
			to_transfer = min(src.amount, S.max_amount-S.amount)
		S.amount+=to_transfer
		if (S && usr.machine==S)
			spawn(0) S.interact(usr)
		src.use(to_transfer)
		if (src && usr.machine==src)
			spawn(0) src.interact(usr)

	if(istype(W, /obj/item/weapon/retractor))
		if(src.amount < 2)
			return
		user << "\blue You sew some cloth together using [W]!"
		src.amount--
		spawn_random_atom("/obj/item/clothing/under/", user.loc)

	else return ..()




/*
 * Cardboard
 */
var/global/list/datum/stack_recipe/cardboard_recipes = list ( \
	new/datum/stack_recipe("box", /obj/item/weapon/storage/box), \
	new/datum/stack_recipe("light tubes", /obj/item/weapon/storage/box/lights/tubes), \
	new/datum/stack_recipe("light bulbs", /obj/item/weapon/storage/box/lights/bulbs), \
	new/datum/stack_recipe("mouse traps", /obj/item/weapon/storage/box/mousetraps), \
	new/datum/stack_recipe("cardborg suit", /obj/item/clothing/suit/cardborg, 3), \
	new/datum/stack_recipe("cardborg helmet", /obj/item/clothing/head/cardborg), \
	new/datum/stack_recipe("clipboard", /obj/item/weapon/clipboard), \
	new/datum/stack_recipe("pizza box", /obj/item/pizzabox), \
	new/datum/stack_recipe("folder", /obj/item/weapon/folder), \
	new/datum/stack_recipe("package wrapper", /obj/item/weapon/packageWrap, 2), \
	new/datum/stack_recipe("wrapping paper", /obj/item/weapon/wrapping_paper, 2), \
	new/datum/stack_recipe("paper bin", /obj/item/weapon/paper_bin), \
	new/datum/stack_recipe("film cartridge", /obj/item/device/camera_film), \
	new/datum/stack_recipe("photo album", /obj/item/weapon/storage/photo_album), \
	new/datum/stack_recipe("festive paper hat", /obj/item/clothing/head/festive), \
	new/datum/stack_recipe("notice board", /obj/structure/noticeboard, 2, time = 10, one_per_turf = 1), \
)

/obj/item/stack/sheet/cardboard	//BubbleWrap
	name = "cardboard"
	desc = "Large sheets of card, like boxes folded flat."
	singular_name = "cardboard sheet"
	icon_state = "sheet-card"
	flags = FPRINT | TABLEPASS
	origin_tech = "materials=1"

/obj/item/stack/sheet/cardboard/New(var/loc, var/amount=null)
		recipes = cardboard_recipes
		return ..()