
//energy guns//
/obj/item/weapon/gun/energy/laser/pistol
	name = "laser pistol"
	desc = "A laser pistol issued to high ranking members of a certain shadow corporation."
	icon_state = "laserpistol"
	projectile_type = /obj/item/projectile/beam
	w_class = 2.0
	cell_removing = 1
	fire_delay = 3
	charge_cost = 200 // holds less "ammo" then the rifle variant.


/obj/item/weapon/gun/energy/laser/rifle
	name = "laser rifle"
	desc = "improper laser rifle, standart shots and ejectable cell"
	icon_state = "lrifle"
	projectile_type = /obj/item/projectile/beam
	cell_removing = 1
	fire_delay = 0.5
	charge_cost = 100

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

	attack_self(mob/living/user as mob)
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
/obj/item/weapon/gun/projectile/automatic/k4m
	name = "Carbine Mk4"
	desc = "Hmm.. That reminds me, but what? Uses 5.56 rounds."
	icon_state = "k4m"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 30
	burst_count = 3
	m_amt = 7500
	caliber = list("5.56" = 1)
	origin_tech = "combat=4;materials=4"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2
	auto_mag_drop = 1
	flags =  USEDELAY
	fire_delay = 0.5

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "k4m-full"
		else
			icon_state = "k4m"
		return

/obj/item/weapon/gun/projectile/automatic/mp5
	name = "Mp5-A2"
	desc = "A lightweight, fast firing gun, used by Corp. special ops. Uses 9mm rounds."
	icon_state = "mp5a"
	w_class = 3.0
	max_shells = 30
	burst_count = 3
	m_amt = 4000
	caliber = "9x18"
	fire_sound = 'sound/weapons/mp5.ogg'
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/c9mmp"
	mag_type = "/obj/item/ammo_storage/magazine/c9mmp"
	load_method = 2
	auto_mag_drop = 1
	flags =  USEDELAY
	fire_delay = 0.5

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "mp5a-full"
		else
			icon_state = "mp5a"
		return



/obj/item/weapon/gun/projectile/automatic/G36K
	name = "G36K"
	desc = "For a PKS/EXALT fire support"
	icon_state = "g36k"
	item_state = "c20r"
	w_class = 4.0
	max_shells = 30
	m_amt = 5600
	burst_count = 3
	caliber = list("5.56" = 1)
	origin_tech = "combat=5;materials=3;syndicate=4"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	auto_mag_drop = 1

/obj/item/weapon/gun/projectile/automatic/G36K/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/assault
	name = "\improper Assault Rifle"
	desc = "Very fast firing gun, issued to shadow organization members."
	icon_state = "assaultrifle"
	origin_tech = "combat=5;materials=2"
	m_amt = 1800
	item_state = "c20r"
	w_class = 4.0
	max_shells = 30
	burst_count = 6
	caliber = list("5.56" = 1)
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/Gunshot_c20.ogg'
	load_method = 2
	auto_mag_drop = 1
	flags =  USEDELAY
	fire_delay = 1

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "assaultrifle-full"
		else
			icon_state = "assaultrifle"
		return

/obj/item/weapon/gun/projectile/automatic/advanced
	name = "High tech assault rifle"
	desc = "A lightweight gun, made with plastic. Strange, but this rifle have mark with that text: Made from PKS. Uses 12.7 rounds"
	icon_state = "pkst1m"
	origin_tech = "combat=5;materials=2"
	item_state = "c20r"
	w_class = 4.0
	max_shells = 15
	m_amt = 400
	burst_count = 3
	caliber = list("12.7" = 1)
	ammo_type = "/obj/item/ammo_casing/a127s"
	mag_type = "/obj/item/ammo_storage/magazine/a127s"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	auto_mag_drop = 1
	flags =  USEDELAY
	fire_delay = 0.2

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "pkst1m-full"
		else
			icon_state = "pkst1m"
		return


/////test////

/*
/obj/item/weapon/gun/projectile/automatic/hkg36c
	name = "HK-G36c"
	desc = "tactical assault rifle. Can kill... if you have skill Uses 5.56 rounds."
	icon_state = "hkg36c"
	item_state = "c20r"
	w_class = 4.0
	max_shells = 30
	burst_count = 4
	caliber = list("5.56" = 1)
	origin_tech = "combat=4;materials=3"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	auto_mag_drop = 1

/obj/item/weapon/gun/projectile/automatic/hkg36c/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/b80b
	name = "b80b"
	desc = "If you want to be a really great sniper. Uses 0.50S rounds."
	icon_state = "b80b"
	w_class = 3.0
	max_shells = 9
	burst_count = 3
	caliber = list("5.56" = 1)
	origin_tech = "combat=4;materials=4"
	ammo_type = "/obj/item/ammo_casing/a50s"
	mag_type = "/obj/item/ammo_storage/magazine/a50s"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	auto_mag_drop = 1

/obj/item/weapon/gun/projectile/automatic/hkg36c/isHandgun()
	return 1
*/

//scripts//
/obj/item/weapon/gun/energy/verb/eject_battery(mob/living/user as mob)
	if (cell_removing)
		set name = "Eject Battery"
		set category = "Object"

		if(power_supply)
			//power_supply.loc = get_turf(src.loc)
			power_supply.loc = src
			power_supply.update_icon()
			user.put_in_hands(power_supply)
			power_supply = null
			update_icon()
			user << "<span class='notice'>You pull the [power_supply] out of \the [src]!</span>"
			return
		else
			user << "<span class='notice'>It has no cell!</span>"
	else
		user << "<span class='notice'>You cant remove cell from that gun</span>"
	return

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

/obj/item/weapon/gun/projectile/automatic/u40ag
	name = "Carbine Mk2"
	desc = "Machine gun for civil violence. Used by mercenaries, personal guards. Weapon of last chance. .45 rounds."
	icon_state = "u40ag"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 8
	caliber = list(".45" = 1)
	burst_count = 2
	m_amt = 3750
	origin_tech = "combat=5;materials=1"
	ammo_type = "/obj/item/ammo_casing/c45"
	mag_type = "/obj/item/ammo_storage/magazine/c45"
	load_method = 2
	auto_mag_drop = 1

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "u40ag-full"
		else
			icon_state = "u40ag"
		return