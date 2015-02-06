
//energy guns//
/obj/item/weapon/gun/energy/laser/pistol
	name = "laser pistol"
	desc = "A laser pistol issued to high ranking members of a certain shadow corporation."
	icon_state = "lpistol"
	projectile_type = /obj/item/projectile/beam
	cell_type = "/obj/item/weapon/cell/high"
	w_class = 2.0
	cell_removing = 1
	fire_delay = 3
	charge_cost = 1000 // holds less "ammo" then the rifle variant.

/obj/item/weapon/gun/energy/laser/rifle
	name = "laser rifle"
	desc = "improper laser rifle, standart shots and ejectable cell"
	icon_state = "lrifle"
	projectile_type = /obj/item/projectile/beam
	cell_type = "/obj/item/weapon/cell/high"
	cell_removing = 1
	fire_delay = 0.5
	charge_cost = 500
	two_handed = 1

/obj/item/weapon/gun/energy/sniper //Самое мощное летальное энерго оружие, что должно быть на станции. от него баланс.
	name = "P.E.S.R. Mk80"
	desc = "pulse-based energy sniper rifle, stable model - Mark 80"
	icon_state = "sniper"
	item_state = null	//so the human update icon uses the icon_state instead.
	projectile_type = "/obj/item/projectile/beam"
	cell_type = "/obj/item/weapon/cell/high"
	fire_sound = 'sound/weapons/pulse.ogg'
	cell_removing = 1
	w_class = 4
	force = 10
	charge_cost = 250
	slot_flags = SLOT_BACK
	var/mode = 1
	var/zoomdevicename = null //for name of scopes
	var/zoom = 0 //for items with scopes
	fire_delay = 5
	two_handed = 1

	attack_self(mob/living/user as mob)
		if(user.a_intent == "help")
			switch(mode)
				if(2)
					mode = 0
					charge_cost = 500
					fire_delay = 10 //учитесь стрелять наконец!!
					fire_sound = 'sound/weapons/Taser.ogg'
					user << "\red [src.name] is now set to shock beam mode."
					projectile_type = "/obj/item/projectile/beam/xsniper"
				if(0)
					mode = 1
					charge_cost = 250
					fire_delay = 5
					fire_sound = 'sound/weapons/Laser.ogg'
					user << "\red [src.name] is now set to laser mode."
					projectile_type = "/obj/item/projectile/beam"
				if(1)
					mode = 2
					charge_cost = 500
					fire_delay = 20 //Снайперка не автоматическая, не забывайте об этом.
					fire_sound = 'sound/weapons/pulse.ogg'
					user << "\red [src.name] is now set to high power sniper mode."
					projectile_type = "/obj/item/projectile/beam/deathlaser"
			return

/obj/item/weapon/gun/energy/sniper/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1
	zoom()

//projectile//

/obj/item/weapon/gun/projectile/automatic/assault_rifles/mp5/isHandgun()
	return 0

/obj/item/weapon/gun/energy/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/weapon/cell) && !power_supply)
		user.drop_item()
		power_supply = A
		power_supply.loc = src
		user << "<span class='notice'>You load a new [power_supply] into \the [src]!</span>"
		update_icon()
	else
		..()
	return

/obj/item/weapon/gun/energy/sniper/proc/zoom(var/tileoffset = 11,var/viewsize = 12) //tileoffset is client view offset in the direction the user is facing. viewsize is how far out this thing zooms. 7 is normal view

	var/devicename

	if(zoomdevicename)
		devicename = zoomdevicename
	else
		devicename = src.name

	var/cannotzoom

	if(usr.stat || !(istype(usr,/mob/living/carbon/human)))
		usr << "You are unable to focus through the [devicename]"
		cannotzoom = 1
	else if(!zoom && global_hud.darkMask[1] in usr.client.screen)
		usr << "Your welding equipment gets in the way of you looking through the [devicename]"
		cannotzoom = 1
	else if(!zoom && usr.get_active_hand() != src)
		usr << "You are too distracted to look through the [devicename], perhaps if it was in your active hand this might work better"
		cannotzoom = 1

	if(!zoom && !cannotzoom)
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)	// If the user has already limited their HUD this avoids them having a HUD when they zoom in
		usr.button_pressed_F12(1)
		usr.client.view = viewsize
		zoom = 1

		var/tilesize = 32
		var/viewoffset = tilesize * tileoffset

		switch(usr.dir)
			if (NORTH)
				usr.client.pixel_x = 0
				usr.client.pixel_y = viewoffset
			if (SOUTH)
				usr.client.pixel_x = 0
				usr.client.pixel_y = -viewoffset
			if (EAST)
				usr.client.pixel_x = viewoffset
				usr.client.pixel_y = 0
			if (WEST)
				usr.client.pixel_x = -viewoffset
				usr.client.pixel_y = 0

		usr.visible_message("[usr] peers through the [zoomdevicename ? "[zoomdevicename] of the [src.name]" : "[src.name]"].")

		/*
		if(istype(usr,/mob/living/carbon/human/))
			var/mob/living/carbon/human/H = usr
			usr.visible_message("[usr] holds [devicename] up to [H.get_visible_gender() == MALE ? "his" : H.get_visible_gender() == FEMALE ? "her" : "their"] eyes.")
		else
			usr.visible_message("[usr] holds [devicename] up to its eyes.")
		*/

	else
		usr.client.view = world.view
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)
		zoom = 0

		usr.client.pixel_x = 0
		usr.client.pixel_y = 0

		if(!cannotzoom)
			usr.visible_message("[zoomdevicename ? "[usr] looks up from the [zoomdevicename] of the [src.name]" : "[usr] lowers the [src.name]"].")

	return

//melee//
/obj/item/weapon/kitchenknife/tento
	force = 20.0
	throwforce = 15
	icon_state = "tento"
	item_state = "knife"


//Custom items for players//
/obj/item/clothing/head/soft/black
	name = "black cap"
	desc = "It's a baseball hat in a tasteless black colour."
	icon_state = "blacksoft"
	_color = "black"

/obj/item/weapon/storage/secure/briefcase/locked
	locked = 1
	code = "17935"

	New()
		..()
		new /obj/item/weapon/kitchenknife/tento(src)
		new /obj/item/clothing/head/soft/black(src)
		new /obj/item/clothing/head/soft/black(src)
		new	/obj/item/clothing/under/lawyer/female
		new	/obj/item/clothing/under/lawyer/red

