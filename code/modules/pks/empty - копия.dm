/obj/item/weapon/gun/projectile/automatic/px90
	name = "PiX9.0"
	desc = "Advanced SMG designated PiX9.0. Has an attached underbarrel grenade launcher which can be toggled on and off, semi and single shoots mode."
	icon = 'icons/obj/pks/projectile.dmi'
	icon_state = "m90"
	item_state = "m90"
	lefthand_file = 'icons/mob/in-hand/TG/guns_lefthand.dmi'
	righthand_file = 'icons/mob/in-hand/TG/guns_righthand.dmi'
	origin_tech = "combat=7;materials=4"
	mag_type = "/obj/item/ammo_storage/magazine/a556"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2
	auto_mag_drop = 1
	w_class = 3.0
	max_shells = 30
	burst_count = 3
	fire_delay = 1
	two_handed = 1
	fire_mode = 0
	burstfire_switch = 0
	var/obj/item/weapon/gun/projectile/revolver/grenadelauncher/underbarrel

	attack_self(mob/living/user as mob)
		if(user.a_intent == "help")
			switch(burstfire_switch)
				if(0)
					fire_mode = 1
					user << "<span class='notice'>You switch to burst fire mode.</span>"
				if(1)
					fire_mode = 0
					fire_delay = 0
					user << "<span class='notice'>You switch to semi-auto.</span>"
			playsound(user, 'sound/weapons/empty.ogg', 100, 1)
			update_icon()


/obj/item/weapon/gun/projectile/automatic/px90/New()
	..()
	underbarrel = new /obj/item/weapon/gun/projectile/revolver/grenadelauncher(src)
	update_icon()
	return

/obj/item/weapon/gun/projectile/automatic/px90/afterattack(var/atom/target, var/mob/living/user, flag, params)
	if(user.a_intent == "harm")
		underbarrel.afterattack(target, user, flag, params)
	else
		..()
		return

/obj/item/weapon/gun/projectile/automatic/px90/attackby(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user)
	else
		..()

/obj/item/weapon/gun/projectile/automatic/px90/update_icon()
	..()
	overlays.Cut()
	switch(fire_mode)
		if(0)
			overlays += "[initial(icon_state)]semi"
		if(1)
			overlays += "[initial(icon_state)]burst"
	icon_state = "[initial(icon_state)][stored_magazine ? "-full" : ""]"
	return

/obj/item/weapon/gun/projectile/revolver/grenadelauncher//this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	desc = "A break-operated grenade launcher."
	name = "grenade launcher"
	icon_state = "dshotgun-sawn"
	item_state = "gun"
	max_shells = 1
	ammo_type = /obj/item/ammo_casing/a40mm
	//fire_sound = 'sound/weapons/grenadelaunch.ogg'
	w_class = 3


/obj/item/weapon/gun/projectile/revolver/grenadelauncher/attackby(var/obj/item/A, mob/user)
	..()
	if(istype(A, /obj/item/ammo_storage/box) || istype(A, /obj/item/ammo_casing))
		chamber_round()
/*
/obj/item/ammo_storage/magazine/grenadelauncher
	name = "grenade launcher magazine"
	ammo_type = "/obj/item/ammo_casing/a40mm"
	caliber = "a40mm"
	max_ammo = 5
*/
/obj/item/ammo_casing/a40mm
	name = "40mm"
	desc = "Explosive supplement to the grenade launchers."
	icon_state = "rpground"
	caliber = "rpg"
	projectile_type = "/obj/item/projectile/bullet/a40mm"
	m_amt = 5000
	w_type = RECYK_METAL
	w_class = 2.0

/obj/item/projectile/a40mm
	name = "40mm round"
	icon_state = "rpground"
	flag = "bullet"
	damage_type = BRUTE
	damage = 30
	stun = 5
	weaken = 5
	var/embed = 1

/obj/item/projectile/bullet/a40mm/Bump(var/atom/rocket)
	explosion(rocket, -1, 0, 2, 4)
	qdel(src)