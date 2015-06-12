/obj/item/weapon/gun/projectile/automatic/arifles
	name = "\improper UNKNOWN IMPORSIBLE SHIT"
	desc = "THAT IS SHIT, WHY YOU SPAWN SHIT?"
	item_state = "c20r"
	icon_state = "k4m"
	m_amt = 7500
	burst_count = 3
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	origin_tech = "combat=4;materials=2"
	two_handed = 1
	force = 5
	recoil = 0.2
	var/melee_cooldown = 0

/obj/item/weapon/gun/projectile/automatic/arifles/update_icon()
 ..()
	if(stored_magazine)
		icon_state = "[initial(icon_state)].full"

		if(scope_installed && !silenced)
			icon_state = "[initial(icon_state)].full.scope"
			return

		if(!scope_installed && silenced)
			icon_state = "[initial(icon_state)].full.silencer"
			return

		if(scope_installed && silenced)
			icon_state = "[initial(icon_state)].full.scope.silencer"
			return

	if(!stored_magazine)
		icon_state = "[initial(icon_state)]"

		if(scope_installed && !silenced)
			icon_state = "[initial(icon_state)].scope"
			return

		if(!scope_installed && silenced)
			icon_state = "[initial(icon_state)].silencer"
			return

		if(scope_installed && silenced)
			icon_state = "[initial(icon_state)].scope.silencer"
			return
	return

/obj/item/weapon/gun/projectile/automatic/arifles/k4m //twohanded version of automatic guns
	name = "\improper Carbine Mk4"
	desc = "Hmm.. That reminds me, but what? Uses 5.56 rounds."
	icon_state = "k4m"
	item_state = "c20r"
	w_class = 4.0
	max_shells = 30
	caliber = list("5.56" = 1)
	origin_tech = "combat=3;materials=3;engineering=2"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	load_method = 2
	force = 15
	slot_flags = SLOT_BACK
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	silencer_allowed = 1//modules
	scope_allowed = 1//modules

/obj/item/weapon/gun/projectile/automatic/arifles/k4m/rnd
	desc = "Carbine Mk4, made from plastic and plasteel composite alloys. Uses 5.56 rounds."
	icon_state = "k4mr"
	origin_tech = "combat=3;materials=4;engineering=2"

/obj/item/weapon/gun/projectile/automatic/arifles/k4m/isHandgun()
	return 1


/obj/item/weapon/gun/projectile/automatic/arifles/c20r
	name = "\improper C-20r SMG"
	desc = "A lightweight, fast firing gun, for when you REALLY need someone dead. Uses 12mm rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp"
	icon_state = "c20r"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 20
	burst_count = 4
	m_amt = 7500
	caliber = list("12mm" = 1)
	origin_tech = "combat=4;materials=2;engineering=2;syndicate=4"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	mag_type = "/obj/item/ammo_storage/magazine/a12mm"
	fire_sound = 'sound/weapons/Gunshot_c20.ogg'
	load_method = 2
	force = 6
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/arifles/c20r/update_icon()
	..()
	if(stored_magazine)
		icon_state = "c20r-[round(getAmmo(),4)]"
	else
		icon_state = "c20r"
	return

/obj/item/weapon/gun/projectile/automatic/arifles/c20r/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/arifles/g36k
	name = "G36K"
	desc = "For a PKS/EXALT fire support"
	icon_state = "g36k"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 30
	m_amt = 5600
	burst_count = 3
	caliber = list("5.56" = 1)
	origin_tech = "combat=5;materials=3;syndicate=4"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	force = 10
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	silencer_allowed = 1//modules
	scope_allowed = 1//modules

/obj/item/weapon/gun/projectile/automatic/arifles/g36k/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/arifles/assault
	name = "\improper Assault Rifle"
	desc = "Very fast firing gun, issued to shadow organization members."
	icon_state = "assaultrifle"
	origin_tech = "combat=4;materials=4"
	m_amt = 1800
	w_class = 4.0
	max_shells = 30
	burst_count = 6
	caliber = list("5.56" = 1)
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/Gunshot_c20.ogg'
	load_method = 2
	force = 7
	slot_flags = SLOT_BACK
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/arifles/assault/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/arifles/advanced
	name = "\improper High tech assault rifle"
	desc = "A lightweight gun, made with plastic. Strange, but this rifle have mark with that text: Made from PKS. Uses 12.7 rounds"
	icon_state = "pkst1m"
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	origin_tech = "combat=5;materials=5"
	item_state = "pkst1m"
	w_class = 4.0
	max_shells = 15
	m_amt = 400
	burst_count = 3
	force = 12
	caliber = list("12.7" = 1)
	ammo_type = "/obj/item/ammo_casing/a127s"
	mag_type = "/obj/item/ammo_storage/magazine/a127s"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/arifles/advanced/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/arifles/bolter
	name = "Bolter"
	desc = "To a Space Marine, the boltgun is far more than a weapon; it is an instrument of Mankind's divinity, the bringer of death to his foes. Its howling blast is a prayer to the gods of battle."
	icon_state = "boltrilfe"
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	origin_tech = "combat=8;materials=4"
	item_state = "c20r"
	w_class = 4.0
	max_shells = 30
	m_amt = 10000
	burst_count = 4
	force = 10
	caliber = list("75" = 1)
	ammo_type = "/obj/item/ammo_casing/a75"
	mag_type = "/obj/item/ammo_storage/magazine/a72e"
	fire_sound = 'sound/weapons/G36.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/arifles/bolter/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/b80b
	name = "b80b"
	desc = "If you want to be a really great sniper. Uses 0.50S rounds."
	icon_state = "b80b"
	w_class = 4.0
	max_shells = 9
	burst_count = 3
	force = 10
	caliber = list("5.56" = 1)
	origin_tech = "combat=4;materials=4"
	ammo_type = "/obj/item/ammo_casing/a50s"
	mag_type = "/obj/item/ammo_storage/magazine/a50s"
	fire_sound = 'sound/weapons/G36.ogg'
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/assault_rifles/b80b/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/arifles/u40ag
	name = "\improper Carbine Mk1"
	desc = "Machine gun for civil violence. Used by mercenaries, personal guards. .45 rounds. That gun have module slots for - Tactical flashlight. Can be crafted on tables from any stuff or metal!!"
	icon_state = "u40ag"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 8
	caliber = list("9mm" = 1)
	automatic = 0
	m_amt = 3750
	force = 6
	origin_tech = "combat=3;materials=1;engineering=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	mag_type = "/obj/item/ammo_storage/magazine/mc9mm"
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	silencer_allowed = 1//modules
	scope_allowed = 1//modules

/obj/item/weapon/gun/projectile/automatic/u40ag/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/arifles/u40ag/crafted/New()//for crafted version of that carbine.
	for(var/ammo in loaded)
		loaded -= ammo

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw
	name = "\improper L6 SAW"
	desc = "A rather traditionally made light machine gun with a pleasantly lacquered wooden pistol grip. Has 'Aussec Armoury- 2531' engraved on the reciever"
	icon_state = "l6closed100"
	item_state = "l6closedmag"
	w_class = 4
	slot_flags = 0
	max_shells = 50
	burst_count = 10
	force = 9
	m_amt = 15000
	caliber = list("a762" = 1)
	origin_tech = "combat=5;materials=1;syndicate=2"
	lent_ammo = 1
	ammo_type = "/obj/item/ammo_casing/a762"
	mag_type = "/obj/item/ammo_storage/magazine/a762"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2
	var/cover_open = 0

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/attack_self(mob/user as mob)
	if(user.a_intent == "harm")
		cover_open = !cover_open
		user << "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>"
		update_icon()

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/update_icon()
	icon_state = "l6[cover_open ? "open" : "closed"][stored_magazine ? round(getAmmo(), 25) : "-empty"]"


/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		user << "<span class='notice'>[src]'s cover is open! Close it before firing!</span>"
	else
		..()
		update_icon()

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/attack_hand(mob/user as mob)
	if(loc != user)
		..()
		return	//let them pick it up
	if(!cover_open)
		..()
	else if(cover_open && stored_magazine) //since attack_self toggles the cover and not the magazine, we use this instead
		if(user.a_intent == "disarm")
			RemoveMag(user)//drop the mag
			user << "<span class='notice'>You remove the magazine from [src].</span>"

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/attackby(obj/item/ammo_storage/magazine/a762/A as obj, mob/user as mob)
	if(!cover_open)
		user << "<span class='notice'>[src]'s cover is closed! You can't insert a new mag!</span>"
		return
	else if(cover_open)
		..()

/obj/item/weapon/gun/projectile/automatic/arifles/l6_saw/force_removeMag() //special because of its cover
	if(user.a_intent == "disarm")
		if(cover_open && stored_magazine)
			RemoveMag(usr)
			usr << "<span class='notice'>You remove the magazine from [src].</span>"
		else if(stored_magazine)
			usr << "<span class='rose'>The [src]'s cover has to be open to do that!</span>"
		else
			usr << "<span class='rose'>There is no magazine to remove!</span>"

/*
/////unused////

/obj/item/weapon/gun/projectile/automatic/assault_rifles/hkg36c
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

/obj/item/weapon/gun/projectile/automatic/assault_rifles/hkg36c/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/assault_rifles/b80b
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

/obj/item/weapon/gun/projectile/automatic/assault_rifles/b80b/isHandgun()
	return 1
*/
//scripts//
/*
/obj/item/weapon/gun/projectile/automatic/assault_rifles/update_icon()
	..()
	icon_state = "[initial(icon_state)][stored_magazine ? ".Full" : ""][silenced ? ".silencer" : ""][zoom ? ".scope" : ""]"
	return
*/
