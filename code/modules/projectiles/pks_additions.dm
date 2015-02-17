
//energy guns//
/obj/item/weapon/gun/energy/laser/pistol
	name = "Laser pistol"
	desc = "A laser pistol issued to high ranking members of a certain shadow corporation."
	icon_state = "lpistol"
	projectile_type = /obj/item/projectile/beam
	cell_type = "/obj/item/weapon/cell/ammo"
	w_class = 2.0
	cell_removing = 1
	fire_delay = 3
	charge_cost = 1250 // holds less "ammo" then the rifle variant.

/obj/item/weapon/gun/energy/laser/rifle
	name = "Laser rifle"
	desc = "improper laser rifle, standart shots and ejectable cell"
	icon_state = "lrifle"
	projectile_type = /obj/item/projectile/beam/captain
	cell_type = "/obj/item/weapon/cell/ammo"
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
	cell_type = "/obj/item/weapon/cell/ammo"
	fire_sound = 'sound/weapons/pulse.ogg'
	cell_removing = 1
	w_class = 4
	force = 10
	charge_cost = 250
	slot_flags = SLOT_BACK
	var/mode = 1
	fire_delay = 5
	two_handed = 1
	scope_allowed = 1

	attack_self(mob/living/user as mob)
		..()

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

	update_icon()
		if(power_supply)
			var/ratio = power_supply.charge / power_supply.maxcharge
			ratio = round(ratio, 0.25) * 100
			if(scope_installed)
				if(modifystate)
					icon_state = "[modifystate][ratio].scope"
				else
					icon_state = "[initial(icon_state)][ratio].scope"
			else
				if(modifystate)
					icon_state = "[modifystate][ratio]"
				else
					icon_state = "[initial(icon_state)][ratio]"
		else
			icon_state = "[initial(icon_state)]-empty"
			if(scope_installed)
				icon_state = "[initial(icon_state)]-empty.scope"
		return

//melee//
/obj/item/weapon/kitchenknife/tento
	name = "Tento"
	desc = "Not just a knife...."
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


/obj/structure/closet/syndicate/pks
	desc = "It's a storage unit for operative gear. - FUCK YOU, That is for PKS, Hhahahaha."

/obj/structure/closet/syndicate/pks/New()
	..()
	sleep(2)
	new /obj/item/weapon/tank/jetpack/oxygen(src)
	new /obj/item/clothing/mask/gas/syndicate(src)
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/head/helmet/space/rig/syndi(src)
	new /obj/item/clothing/suit/space/space_adv/faction(src)
	new /obj/item/weapon/crowbar/red(src)
	new /obj/item/weapon/cell/ammo/syndi(src)
	new	/obj/item/weapon/cell/ammo/syndi(src)
	new	/obj/item/weapon/cell/ammo/syndi(src)
	new /obj/item/weapon/card/id/syndicate(src)
	new /obj/item/device/multitool(src)
	new /obj/item/weapon/shield/energy(src)
	new /obj/item/clothing/shoes/magboots(src)

//Combat Power Cells
/obj/item/weapon/cell/ammo
	name = "Basic gun energy cell"
	desc = "Mini gun cell with good capacity, used for most energy weapons. Warning: DONT ATTEMPT FUCKING INSTALL THAT CELL BACKWARDS, YOU BASTARDS!!!"
	icon = 'icons/obj/guns/gun.dmi'
	icon_state = "basic_ammocell"
	item_state = "basic_ammocell"
	origin_tech = "powerstorage=3"
	maxcharge = 5000
	w_class = 1
	m_amt = 30
	g_amt = 30

/obj/item/weapon/cell/ammo/crap
	name = "Crap gun energy cell"
	desc = "First model of Gun energy cells.. Stupid and very unstable, but easy to find.."
	maxcharge = 2500

/obj/item/weapon/cell/ammo/syndi
	name = "Suspicious looking gun energy cell"
	desc = "Strange gun cell, hm, that cell have super capacity.. and.. syndicate bandge. Wow."
	icon_state = "syndi_ammocell"
	item_state = "syndi_ammocell"
	origin_tech = "powerstorage=5"
	maxcharge = 10000
	m_amt = 30
	g_amt = 30

/obj/item/weapon/cell/ammo/hyper
	name = "Hyper capacity gun energy cell"
	desc = "Mini gun cell with hyper capacity, rare."
	icon_state = "hyper_ammocell"
	item_state = "hyper_ammocell"
	origin_tech = "powerstorage=4"
	maxcharge = 15000
	m_amt = 30
	g_amt = 30

/obj/item/weapon/cell/ammo/rechargable
	name = "Rechargable capacity gun energy cell"
	desc = "Rechargable cell, thats is great step for all energy technologies"
	icon_state = "rechargable_ammocell"
	item_state = "rechargable_ammocell"
	origin_tech = "powerstorage=6"
	maxcharge = 2500
	m_amt = 30
	g_amt = 30
	var/charge_tick = 0

	process()
		charge_tick++
		if(charge_tick < 4) return 0
		charge_tick = 0
		src.give(250)
		update_icon()
		return 1