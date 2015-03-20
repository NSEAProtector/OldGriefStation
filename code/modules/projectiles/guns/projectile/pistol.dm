/obj/item/weapon/gun/projectile/syndi
	name = "\improper syndicate pistol"
	desc = "A small, quiet,  easily concealable gun. Uses .45 rounds."
	icon_state = "syndi"
	w_class = 3.0
	max_shells = 8
	caliber = list(".45"  = 1, ".45r" = 1)
	origin_tech = "combat=2;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45r"
	mag_type = "/obj/item/ammo_storage/magazine/c45"
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	load_method = 2
	silencer_allowed = 1//modules

/obj/item/weapon/gun/projectile/syndi/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? ".full" : ""][silenced ? ".silencer" : ""]"
	return

/obj/item/weapon/gun/projectile/colt
	name = "improper Colt M1911"
	desc = "A cheap Martian knock-off of a Colt M1911. Uses less-than-lethal .45 rounds."
	icon_state = "m1911"
	w_class = 3.0
	max_shells = 8
	caliber = list(".45"  = 1, ".45r" = 1)
	origin_tech = "combat=2;materials=2"
	ammo_type = "/obj/item/ammo_casing/c45r"
	mag_type = "/obj/item/ammo_storage/magazine/c45/rubber"
	load_method = 2

/obj/item/weapon/gun/projectile/colt/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? ".full" : ""]"
	return


/obj/item/weapon/gun/projectile/deagle
	name = "\improper desert eagle"
	desc = "A robust handgun that uses .50 AE ammo"
	icon_state = "deagle"
	force = 14.0
	max_shells = 7
	caliber = list(".50" = 1)
	ammo_type ="/obj/item/ammo_casing/a50"
	mag_type = "/obj/item/ammo_storage/magazine/a50"
	load_method = 2
	gun_flags = AUTOMAGDROP

/obj/item/weapon/gun/projectile/deagle/gold
	desc = "A gold plated gun folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/deagle/camo
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"



/obj/item/weapon/gun/projectile/gyropistol
	name = "\improper gyrojet pistol"
	desc = "A bulky pistol designed to fire self propelled rounds"
	icon_state = "gyropistol"
	max_shells = 8
	caliber = list("75" = 1)
	fire_sound = 'sound/weapons/elecfire.ogg'
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/a75"
	mag_type = "/obj/item/ammo_storage/magazine/a75"
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/gyropistol/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? ".full" : ""]"
	return

/obj/item/weapon/gun/projectile/pistol
	name = "\improper Stechtkin pistol"
	desc = "A small, easily concealable gun. Uses 9mm rounds."
	icon_state = "pistol"
	w_class = 2
	max_shells = 8
	caliber = list("9mm" = 1)
	silenced = 0
	origin_tech = "combat=2;materials=2;syndicate=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	mag_type = "/obj/item/ammo_storage/magazine/mc9mm"
	load_method = 2
	gun_flags = AUTOMAGDROP
	//modules
	silencer_allowed = 1

/obj/item/weapon/gun/projectile/pistol/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? ".full" : ""][silenced ? ".silencer" : ""]"
	return
