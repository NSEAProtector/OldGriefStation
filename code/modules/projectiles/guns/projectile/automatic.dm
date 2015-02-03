/obj/item/weapon/gun/projectile/automatic //Hopefully someone will find a way to make these fire in bursts or something. --Superxpdude
	name = "submachine gun"
	desc = "A lightweight, fast firing gun. Uses 9mm rounds."
	icon_state = "saber"	//ugly
	w_class = 3.0
	max_shells = 18
	caliber = list("9mm" = 1)
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	automatic = 1
	flags =  USEDELAY
	var/burstfire = 0 //Whether or not the gun fires multiple bullets at once
	var/burst_count = 3
	load_method = 2
	mag_type = "/obj/item/ammo_storage/magazine/smg9mm"
	m_amt = 3500

/obj/item/weapon/gun/projectile/automatic/attack_self(mob/living/user as mob)

	..()
	if(user.a_intent == "help")
		switch(burstfire)
			if(0)
				burstfire = 1
				user << "<span class='notice'>You switch to burst fire mode.</span>"
			if(1)
				burstfire = 0
				fire_delay = 0
				user << "<span class='notice'>You switch to semi-auto.</span>"
		playsound(user, 'sound/weapons/empty.ogg', 100, 1)
		update_icon()
		return

/obj/item/weapon/gun/projectile/automatic/update_icon()
	..()
	if(stored_magazine)
		icon_state = "saber-full"
	else
		icon_state = "saber"
	return

/obj/item/weapon/gun/projectile/automatic/isHandgun()
	return 0


/obj/item/weapon/gun/projectile/automatic/verb/ToggleFire()
	set name = "Toggle Burstfire"
	set category = "Object"
	burstfire = !burstfire
	usr << "You toggle \the [src]'s firing setting to [burstfire ? "burst fire" : "single fire"]."

/*
/obj/item/weapon/gun/projectile/automatic/assault_rifles/update_icon()
	..()
	icon_state = "[initial(icon_state)][stored_magazine ? "-[stored_magazine.max_ammo]" : ""][chambered ? "" : "-e"]"
	return
*/ //Говно код который глючит. У тебя он так и не заработал как нужно, фикс блин.

/obj/item/weapon/gun/projectile/automatic/Fire()
	if(burstfire == 1)
		if(ready_to_fire())
			fire_delay = 0
		else
			usr << "<span class='warning'>\The [src] is still cooling down!</span>"
			return
		var/shots_fired = 0 //haha, I'm so clever
		var/to_shoot = min(burst_count, getAmmo())
		for(var/i = 1; i <= to_shoot; i++)
			..()
			shots_fired++
		message_admins("[usr] just shot [shots_fired] burst fire bullets out of [getAmmo() + shots_fired] from their [src].")
		fire_delay = shots_fired * 7
	else
		..()


/obj/item/weapon/gun/projectile/automatic/mini_uzi
	name = "Uzi"
	desc = "A lightweight, fast firing gun, for when you want someone dead. Uses .45 rounds."
	icon_state = "mini-uzi"
	w_class = 3.0
	max_shells = 10
	burst_count = 3
	caliber = list(".45" = 1)
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45m"
	mag_type = "/obj/item/ammo_storage/magazine/uzi45"
	m_amt = 4000
	update_icon()
		..()
		if(stored_magazine)
			icon_state = "mini-uzi-loaded"
		else
			icon_state = "mini-uzi"
		return


/obj/item/weapon/gun/projectile/automatic/mini_uzi/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/u40ag
	name = "Carbine Mk2"
	desc = "Machine gun for civil violence. Used by mercenaries, personal guards. Weapon of last chance. .45 rounds."
	icon_state = "u40ag"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 8
	caliber = list(".45" = 1,".45r" = 1)
	burst_count = 2
	m_amt = 3750
	origin_tech = "combat=5;materials=1"
	ammo_type = "/obj/item/ammo_casing/c45"
	mag_type = "/obj/item/ammo_storage/magazine/c45"
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "u40ag-full"
		else
			icon_state = "u40ag"
		return

/obj/item/weapon/gun/projectile/automatic/u40ag/isHandgun()
	return 0

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
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "mp5a-full"
		else
			icon_state = "mp5a"
		return

/obj/item/weapon/gun/projectile/automatic/mp5/isHandgun()
	return 0