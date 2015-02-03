/obj/item/weapon/gun/projectile/automatic/assault_rifles //Hopefully someone will find a way to make these fire in bursts or something. --Superxpdude
	name = "\improper Carbine Mk4"
	desc = "Hmm.. That reminds me, but what? Uses 5.56 rounds."
	icon_state = "k4m"
	item_state = "c20r"
	max_shells = 30
	burst_count = 3
	m_amt = 7500
	caliber = list("5.56" = 1)
	origin_tech = "combat=4;materials=4"
	ammo_type = "/obj/item/ammo_casing/a556"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	two_handed = 1
	var/cooldown = 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/update_icon()
	..()
	if(stored_magazine)
		icon_state = "k4m-full"
	else
		icon_state = "k4m"
	return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/attack(mob/living/M as mob, mob/living/user as mob, def_zone)

	..()
	if(wielded)
		if(user.a_intent == "disarm")
			if ((M_CLUMSY in user.mutations) && prob(50))
				user << "\red You club yourself over the head."
				user.Weaken(3 * force)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					H.apply_damage(2*force, BRUTE, "head")
				else
					user.take_organ_damage(2*force)
				return
			if(user.zone_sel.selecting == "head")
				if(cooldown <= 0)
					playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
					target.Weaken(8)
					target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been knocked with [src.name] by [user.name] ([user.ckey])</font>")
					user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to knock [target.name] ([target.ckey])</font>")
					log_attack("<font color='red'>[user.name] ([user.ckey]) knocked down [target.name] ([target.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)])</font>")
					src.add_fingerprint(user)
					target.visible_message("\red <B>[target] has been knocked down with \the [src] by [user]!</B>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
					cooldown = 1
					spawn(40)
						cooldown = 0
				return
			else
				playsound(get_turf(src), 'sound/weapons/Genhit.ogg', 50, 1, -1)
				target.Weaken(2)
				target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
				user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [target.name] ([target.ckey])</font>")
				log_attack("<font color='red'>[user.name] ([user.ckey]) attacked [target.name] ([target.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)])</font>")
				src.add_fingerprint(user)
				target.visible_message("\red <B>[target] has been stunned with \the [src] by [user]!</B>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
			return
		else
			return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/c20r/isHandgun()
	return 1


/obj/item/weapon/gun/projectile/automatic/assault_rifles/c20r
	name = "\improper C-20r SMG"
	desc = "A lightweight, fast firing gun, for when you REALLY need someone dead. Uses 12mm rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp"
	icon_state = "c20r"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 20
	burst_count = 4
	m_amt = 7500
	caliber = list("12mm" = 1)
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	mag_type = "/obj/item/ammo_storage/magazine/a12mm"
	fire_sound = 'sound/weapons/Gunshot_c20.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/assault_rifles/c20r/update_icon()
	..()
	if(stored_magazine)
		icon_state = "c20r-[round(getAmmo(),4)]"
	else
		icon_state = "c20r"
	return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/c20r/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/G36K
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
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	two_handed = 1

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "g36k-full"
		else
			icon_state = "g36k"
		return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/G36K/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/assault
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
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	update_icon()
		..()
		if(stored_magazine)
			icon_state = "assaultrifle-full"
		else
			icon_state = "assaultrifle"
		return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/assault/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/advanced
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
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

	update_icon()
		..()
		if(stored_magazine)
			icon_state = "pkst1m-full"
		else
			icon_state = "pkst1m"
		return

/obj/item/weapon/gun/projectile/automatic/assault_rifles/advanced/isHandgun()
	return 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw
	name = "\improper L6 SAW"
	desc = "A rather traditionally made light machine gun with a pleasantly lacquered wooden pistol grip. Has 'Aussec Armoury- 2531' engraved on the reciever"
	icon_state = "l6closed100"
	item_state = "l6closedmag"
	w_class = 4
	slot_flags = 0
	max_shells = 50
	burst_count = 10
	m_amt = 15000
	caliber = list("a762" = 1)
	origin_tech = "combat=5;materials=1;syndicate=2"
	ammo_type = "/obj/item/ammo_casing/a762"
	mag_type = "/obj/item/ammo_storage/magazine/a762"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2
	var/cover_open = 0

/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/attack_self(mob/user as mob)
	if (user.a_intent == "disarm")
		cover_open = !cover_open
		user << "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>"
		update_icon()


/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/update_icon()
	icon_state = "l6[cover_open ? "open" : "closed"][stored_magazine ? round(getAmmo(), 25) : "-empty"]"


/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		user << "<span class='notice'>[src]'s cover is open! Close it before firing!</span>"
	else
		..()
		update_icon()

/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/attack_hand(mob/user as mob)
	if(loc != user)
		..()
		return	//let them pick it up
	if(!cover_open)
		..()
	else if(cover_open && stored_magazine) //since attack_self toggles the cover and not the magazine, we use this instead
		//drop the mag
		RemoveMag(user)
		user << "<span class='notice'>You remove the magazine from [src].</span>"

/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/attackby(obj/item/ammo_storage/magazine/a762/A as obj, mob/user as mob)
	if(!cover_open)
		user << "<span class='notice'>[src]'s cover is closed! You can't insert a new mag!</span>"
		return
	else if(cover_open)
		..()

/obj/item/weapon/gun/projectile/automatic/assault_rifles/l6_saw/force_removeMag() //special because of its cover
	if(cover_open && stored_magazine)
		RemoveMag(usr)
		usr << "<span class='notice'>You remove the magazine from [src].</span>"
	else if(stored_magazine)
		usr << "<span class='rose'>The [src]'s cover has to be open to do that!</span>"
	else
		usr << "<span class='rose'>There is no magazine to remove!</span>"

/////test////
/*
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

/obj/item/weapon/gun/projectile/automatic/assault_rifles/hkg36c/isHandgun()
	return 1
*/
//scripts//
