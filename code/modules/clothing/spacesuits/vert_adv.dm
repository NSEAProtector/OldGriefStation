
//Code by vert1881/Lilorien Vert



//Space ninja autif. for e.g

/obj/item/clothing/head/helmet/space/space_adv
	name = "Space working hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has radiation shielding."
	icon_state = "rig.0.rd"
	item_state = "rdhelm"
	armor = list(melee = 60, bullet = 20, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 80)
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECITON_TEMPERATURE
	canremove = 1
	_color = "rd"
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	var/no_light=0
	action_button_name = "Toggle Helmet Light"

	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		if(no_light)
			return
		on = !on
		icon_state = "rig.[on].[_color]"
//		item_state = "rig[on].[_color]"
		update_icon()

		if(on)	user.SetLuminosity(user.luminosity + brightness_on)
		else	user.SetLuminosity(user.luminosity - brightness_on)

	pickup(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity + brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity - brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)

	emp_act(severity)
		if(istype(src.loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/M = src.loc
			M << "\red Your helmet overloads and blinds you!"
			if(M.glasses == src)
				M.eye_blind = 3
				M.eye_blurry = 5
				M.disabilities |= NEARSIGHTED
				spawn(100)
					M.disabilities &= ~NEARSIGHTED

/obj/item/clothing/suit/space/space_adv
	name = "Space working hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has radiation shielding."
	icon_state = "rdrig"
	item_state = "rdrig"
	slowdown = 1
	species_fit = list("Vox")
	armor = list(melee = 50, bullet = 40, laser = 30,energy = 5, bomb = 35, bio = 100, rad = 80)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECITON_TEMPERATURE
	canremove = 1
	var/depl = 0
	var/mob/living/carbon/affecting = null //The wearer


//Space ninja autif. for e.g

                     //____DEPLOY_____//
/obj/item/clothing/suit/space/space_adv/proc/depl() //Body cheking
	set name = "Deploy Helmet"
	set category = "Suit"
	set src in usr

	if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv))
		if(!istype(usr:head, /obj/item/clothing/head))               //Head gear cheking
			var/obj/item/clothing/head/helmet/space/space_adv/n_hood //����
			usr.update_icons()


			affecting = usr
			depl = 1
			canremove = 0
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/rig))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/rig, slot_head)//military
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv/military))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv/military, slot_head)//military
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv/swat))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv/swat, slot_head)//swat
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv/faction))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv/faction, slot_head)//frac
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv/roaper))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv/roaper, slot_head)//roaper//ported from Bay12//
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv/black))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv/black, slot_head) //CE Black
			if(istype(usr:wear_suit, /obj/item/clothing/suit/space/space_adv))
				usr.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/space_adv, slot_head)

/*
			var/obj/item/clothing/head/helmet/space/space_adv
			usr.contents += /obj/item/clothing/head/helmet/space/space_adv                        Version with reconnect
			usr:head = /obj/item/clothing/head/helmet/space/space_adv  //Head create
*/
			n_hood = usr:head
			n_hood.canremove = 0
			usr.update_icons()
			usr.update_hud()
			usr << "\red <B>DEPLOYED</B>\n"
			depl_a() //verbs
			return

		else


			usr << "\red <B>ERROR</B>: 100113 \black HEAD GEAR LOCATED \nABORTING..."
			return 0

	return

                      //____RETRACT_____//
/obj/item/clothing/suit/space/space_adv/proc/retr()

	set name = "Retract Helmet"
	set category = "Suit"
	set src in usr
	var/obj/item/clothing/head/helmet/space/space_adv/n_hood //����
	n_hood = usr:head
	usr.update_icons()

	if(n_hood)//HEAD should be attached
		n_hood.canremove = 1
		usr:client.screen -= n_hood
		usr.u_equip(n_hood)
		del(n_hood)
//		usr.contents -= n_hood
//		usr:head = null //Delete head
		usr.update_icons()
		usr.update_hud()
		usr.client.screen -= /obj/item/clothing/head/helmet/space/space_adv

//		canremove = 1
//		n_hood = usr:head
//		n_hood.canremove = 1
		depl = 0
		canremove = 1
		affecting = null
		usr << "\red <B>RETRACTED</B>\n"
		depl_a()
	else
		usr << "\red <B>ERROR</B>: 100113 \black HEAD GEAR NOT LOCATED \nABORTING..."
	depl_a()
	usr.update_icons()
	usr.update_hud()
	return

                     //____CHECKING_____//
/obj/item/clothing/suit/space/space_adv/proc/depl_a()
	if(depl)
		verbs -= /obj/item/clothing/suit/space/space_adv/proc/depl
		verbs += /obj/item/clothing/suit/space/space_adv/proc/retr
	else
		verbs += /obj/item/clothing/suit/space/space_adv/proc/depl
		verbs -= /obj/item/clothing/suit/space/space_adv/proc/retr
	return

/obj/item/clothing/suit/space/space_adv/New()
	..()
	verbs += /obj/item/clothing/suit/space/space_adv/proc/depl//suit initialize verb





	                  //___Unwrench___//To remove suit

/obj/item/weapon/wrench/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(user.zone_sel.selecting == "head")
		src.add_fingerprint(user)
		if(istype(M:wear_suit, /obj/item/clothing/suit/space/space_adv))
			user.visible_message("\red [user] begins to unwrench [M]'s suit.", "\red You begin to unwrench the suit of [M].")
			sleep(20)
			var/obj/item/clothing/head/helmet/space/space_adv/n_hood //����
			var/obj/item/clothing/suit/space/space_adv/n_body
			n_hood = M:head
			n_body = M:wear_suit
			if(n_hood)
				n_hood.canremove = 1
				M.u_equip(n_hood)
				n_body.canremove = 1
			else
				return ..()
	else
		return ..()






	                 //____OTHER SUITS____//
/obj/item/clothing/head/helmet/space/space_adv/black
	name = "suspicius looking advanced hardsuit helmet"
	desc = "It's a reinforced engineering hardsuit helmet inspiring fear in the ordinary people."
	icon_state = "rig.0.ceblack"
	item_state = "ceblackhelm"
	_color = "ceblack"
	armor = list(melee = 30, bullet = 40, laser = 30, energy = 10, bomb = 50, bio = 100, rad = 100)
	species_restricted = list("exclude","Vox")
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE

/obj/item/clothing/suit/space/space_adv/black
	name = "suspicius looking advanced hardsuit"
	species_restricted = list("exclude","Vox")
	desc = "It's a reinforced engineering hardsuit inspiring fear in the ordinary people."
	item_state = "ceblack"
	icon_state = "ceblack"
	armor = list(melee = 40, bullet = 40, laser = 30, energy = 15, bomb = 50, bio = 100, rad = 100)
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE

///Military // Cargo color suits
/obj/item/clothing/head/helmet/space/space_adv/military
	name = "Military space hardsuit helmet"
	desc = "A special helmet designed for military forces"
	icon_state = "rig.0.military"
	item_state = "militaryhelm"
	armor = list(melee = 60, bullet = 50, laser = 50, energy = 60, bomb = 75, bio = 100, rad = 80)
	_color = "military"
	/obj/item/clothing/glasses/hud/security/process_hud

/obj/item/clothing/suit/space/space_adv/military
	name = "Military space hardsuit"
	desc = "A special suit designed for military forces, armored with portable plastel armor layer"
	icon_state = "militaryrig"
	item_state = "militaryrig"
	armor = list(melee = 40, bullet = 70, laser = 60, energy = 50, bomb = 75, bio = 100, rad = 80)
	allowed = list(/obj/item/weapon/gun,/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/melee/baton)

//SWAT //Red suits
/obj/item/clothing/head/helmet/space/space_adv/swat
	name = "Swat space hardsuit helmet"
	desc = "A special helmet designed for SWAT, armored with close combat kewlar layers"
	icon_state = "rig.0.swat"
	item_state = "secswatrig"
	_color = "swat"
	armor = list(melee = 75, bullet = 50, laser = 30, energy = 20, bomb = 45, bio = 100, rad = 80)
	/obj/item/clothing/glasses/hud/security/process_hud

/obj/item/clothing/suit/space/space_adv/swat
	name = "SWAT space hardsuit"
	desc = "A special suit designed for SWAT, armored with close combat kewlar layers"
	icon_state = "swatrig"
	item_state = "swatrig"
	armor = list(melee = 75, bullet = 50, laser = 30, energy = 10, bomb = 45, bio = 100, rad = 80)
	allowed = list(/obj/item/weapon/gun,/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/melee/baton)

// //Rare suits
/obj/item/clothing/head/helmet/space/space_adv/faction
	name = "Suspicious looking special space hardsuit helmet"
	desc = "Heavy modifed SWAT space suit helmet, armored with close combat kewlar layers, bullet armor layer, advanced anti radiation suit hat. "
	icon_state = "rig.0.frac"
	item_state = "fracrig"
	_color = "frac"
	brightness_on = 6
	armor = list(melee = 80, bullet = 50, laser = 60, energy = 20, bomb = 45, bio = 100, rad = 100)

/obj/item/clothing/suit/space/space_adv/faction
	name = "Suspicious looking SWAT space hardsuit"
	desc = "Heavy modifed SWAT space suit, armored with close combat kewlar layers, bullet armor layer, advanced anti radiation suit."
	icon_state = "fracrig"
	item_state = "fracrig"
	armor = list(melee = 70, bullet = 70, laser = 60, energy = 25, bomb = 45, bio = 100, rad = 100)
	allowed = list(/obj/item/weapon/gun,/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/melee)

/obj/item/clothing/head/helmet/space/space_adv/roaper
	name = "Roaper space space hardsuit"
	desc = "Unknown suit"
	icon_state = "rig.0.roaper"
	item_state = "roaper"
	_color = "roaper"
	brightness_on = 6
	armor = list(melee = 40, bullet = 60, laser = 40, energy = 15, bomb = 45, bio = 100, rad = 100)
	var/vision_mode = 0

/obj/item/clothing/suit/space/space_adv/roaper
	name = "Roaper space hardsuit"
	desc = "unknown suit"
	icon_state = "roaper"
	item_state = "roaper"
	armor = list(melee = 40, bullet = 60, laser = 40, energy = 15, bomb = 45, bio = 100, rad = 100)
	allowed = list(/obj/item/weapon/gun,/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/melee)

//Code by vert1881/Lilorien Vert && Viton/Ak72ti