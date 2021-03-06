//energy guns//
/obj/item/weapon/gun/energy/laser/pistol
	name = "Laser pistol"
	desc = "A laser pistol issued to high ranking members of a certain shadow corporation."
	icon_state = "lpistol"
	origin_tech = "combat=3;materials=6;magnets=3"
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
	origin_tech = "combat=4;materials=4;magnets=3"
	projectile_type = /obj/item/projectile/beam/captain
	cell_type = "/obj/item/weapon/cell/ammo"
	cell_removing = 1
	fire_delay = 0.5
	charge_cost = 500
	two_handed = 1

/obj/item/weapon/gun/energy/plasma/pistol
	name = "Plasma pistol"
	desc = "Plasma pistol that is given to members of an unknown shadow organization."
	icon_state = "ppistol"
	origin_tech = "combat=3;magnets=3;materials=4;plasmatech=3"
	item_state = null
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	projectile_type = /obj/item/projectile/energy/plasma/pistol
	charge_cost = 750
	w_class = 2.0
	cell_removing = 1

/obj/item/weapon/gun/energy/plasma/light
	name = "light plasma rifle"
	desc = "Light plasma rifle that is given to members of an unknown shadow organization."
	icon_state = "plightrifle"
	origin_tech = "combat=4;materials=4;magnets=3;plasmatech=4"
	item_state = null
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	projectile_type = /obj/item/projectile/energy/plasma/light
	two_handed = 1
	charge_cost = 500
	cell_removing = 1

/obj/item/weapon/gun/energy/plasma/rifle
	name = "plasma rifle"
	desc = "Plasma rifle that is given to members of an unknown shadow organization."
	icon_state = "prifle"
	item_state = null
	origin_tech = "combat=4;materials=4;magnets=3;plasmatech=4"
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	projectile_type = /obj/item/projectile/energy/plasma/rifle
	slot_flags = SLOT_BACK
	two_handed = 1
	w_class = 4
	charge_cost = 500
	cell_removing = 1

/obj/item/weapon/gun/energy/erttaser
	name = "Advanced taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns. Used by E.R.T. That taser have compact plasma reactor. Reactor fuel indicator shows that.. the fuel runs out in a year or two."
	icon_state = "erttaser"
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	origin_tech = "combat=3;magnets=6;materials=6;powerstorage=8"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 1250
	fire_delay = 6 //������� �������� �������!!
	projectile_type = "/obj/item/projectile/energy/electrode"
	cell_type = "/obj/item/weapon/cell/ammo/hyper"
	origin_tech = "combat=2;materials=5;plasma=5"
	var/charge_tick = 0

	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()

	process()
		charge_tick++
		if(charge_tick < 4) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(100)
		update_icon()
		return 1

/obj/item/weapon/gun/energy/stunrevolver
	name = "stun pistol"
	desc = "A high-tech revolver that fires stun cartridges. The stun cartridges can be recharged using a conventional energy gun cell, who can be removed."
	icon_state = "stunrevolver"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	origin_tech = "combat=3;materials=3;powerstorage=2;magnets=4"
	cell_type = "/obj/item/weapon/cell/ammo"
	charge_cost = 1000
	cell_removing = 1
	fire_delay = 2
	w_class = 2.0
	projectile_type = "/obj/item/projectile/energy/electrode"

/obj/item/weapon/gun/energy/shockrifle
	name = "Shock Rifle"
	desc = "The Pacificer energy shock rifle, two modes, beam and taser"
	icon_state = "shockrifle"
	lefthand_file = 'icons/mob/guns_lefthand.dmi'
	righthand_file = 'icons/mob/guns_righthand.dmi'
	item_state = "erttaser"
	cell_type = "/obj/item/weapon/cell/ammo"
	slot_flags = SLOT_BACK
	scope_allowed = 1
	two_handed = 1
	cell_removing = 1
	w_class = 4
	force = 10
// for normal firemode at start of the game
	charge_cost = 500
	fire_delay = 3
	fire_sound = 'sound/weapons/laser2.ogg'
	projectile_type = "/obj/item/projectile/beam/xsniper"

	var/mode = 1

	attack_self(mob/living/user as mob)
		..()

		if(user.a_intent == "help")
			switch(mode)
				if(0)
					mode = 1
					charge_cost = 1250
					fire_delay = 8
					fire_sound = 'sound/weapons/laser2.ogg'
					user << "\red [src.name] is now set to shock beam mode."
					projectile_type = "/obj/item/projectile/beam/shockrifle"
				if(1)
					mode = 0
					charge_cost = 500
					fire_delay = 4
					fire_sound = 'sound/weapons/Taser.ogg'
					user << "\red [src.name] is now set to taser mode."
					projectile_type = "/obj/item/projectile/energy/electrode"

/obj/item/weapon/gun/energy/pulsesniper //basic
	name = "Sniper Rifle"
	desc = "pulse-based energy sniper rifle, stable model - Mark 11"
	icon_state = "psniper"
	item_state = null
	cell_type = "/obj/item/weapon/cell/ammo"
	slot_flags = SLOT_BACK
	two_handed = 1
	cell_removing = 1
	w_class = 4
	force = 10
	scope_installed = 1
//mode settings
	charge_cost = 2500
	fire_delay = 40
	projectile_type = "/obj/item/projectile/beam/hpulse"
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/weapon/gun/energy/sniper //old and more multipurpose version
	name = "Sniper Rifle"
	desc = "pulse-based energy sniper rifle, stable model - Mark 8"
	icon_state = "sniper"
	item_state = null
	cell_type = "/obj/item/weapon/cell/ammo"
	slot_flags = SLOT_BACK
	scope_allowed = 1
	two_handed = 1
	cell_removing = 1
	w_class = 4
	force = 10
//mode settings
	charge_cost = 500
	fire_delay = 20
	projectile_type = "/obj/item/projectile/beam"
	fire_sound = 'sound/weapons/pulse.ogg'
	var/mode = 2

	attack_self(mob/living/user as mob)
		..()

		if(user.a_intent == "help")
			switch(mode)
				if(2)
					mode = 0
					charge_cost = 500
					fire_delay = 10 //������� �������� �������!!
					fire_sound = 'sound/weapons/pulse.ogg'
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
					fire_delay = 20 //��������� �� ��������������, �� ��������� �� ����.
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


/obj/item/weapon/storage/belt/faction //���� ��� ����������, ������ ��������, � ������ �������� ���������, ����� ������� ����� ����, ������ ��� ����� ������������� ��������� ��������� ��� ���.
	name = "Universal suspicious looking belt"
	desc = "Can hold any gear. Used by military enginers, pirates, or other NonNT formations and Factions, like a syndicate. For storage - use magnite and activate when you attach item to magnite."
	icon_state = "factionbelt"
	item_state = "faction"//Could likely use a better one.
	storage_slots = 8 //�������� ������������ ��� Max_combined_w_class
	max_w_class = 3 //��� ��� �� ���� ������ ���� �������� �������
	max_combined_w_class = 14 //�������� ������������ ��� ����, ��� �� ������ ���� �������� ���� ������ ����� ������� 3

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