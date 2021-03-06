
/obj/item/weapon/gun/energy/taser
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon_state = "taser"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 1250
	fire_delay = 6 //������� �������� �������!!
	projectile_type = "/obj/item/projectile/energy/electrode"
	cell_type = "/obj/item/weapon/cell/ammo"

/obj/item/weapon/gun/energy/taser/cyborg
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon_state = "taser"
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 500
	projectile_type = "/obj/item/projectile/energy/electrode"
	cell_type = "/obj/item/weapon/cell/ammo"
	var/charge_tick = 0
	var/recharge_time = 10 //Time it takes for shots to recharge (in ticks)

	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()

	process() //Every [recharge_time] ticks, recharge a shot for the cyborg
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0

		if(!power_supply) return 0 //sanity
		if(isrobot(src.loc))
			var/mob/living/silicon/robot/R = src.loc
			if(R && R.cell)
				R.cell.use(charge_cost) 		//Take power from the borg...
				power_supply.give(charge_cost)	//... to recharge the shot

		update_icon()
		return 1


/obj/item/weapon/gun/energy/crossbow
	name = "mini energy-crossbow"
	desc = "A weapon favored by many of the syndicates stealth specialists."
	icon_state = "crossbow"
	w_class = 2.0
	charge_cost = 1550
	item_state = "crossbow"
	m_amt = 2000
	w_type = RECYK_ELECTRONIC
	origin_tech = "combat=2;magnets=2;syndicate=5"
	silenced = 1
	fire_sound = 'sound/weapons/ebow.ogg'
	projectile_type = "/obj/item/projectile/energy/bolt"
	cell_type = "/obj/item/weapon/cell/ammo/syndi"
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
		power_supply.give(350)
		return 1


	update_icon()
		return



/obj/item/weapon/gun/energy/crossbow/largecrossbow
	name = "Energy Crossbow"
	desc = "A weapon favored by syndicate infiltration teams."
	icon_state = "largecrossbow"
	w_class = 4.0
	force = 10
	m_amt = 8000
	two_handed = 1
	w_type = RECYK_ELECTRONIC
	charge_cost = 500
	projectile_type = "/obj/item/projectile/energy/bolt/large"

	update_icon()
		if(power_supply)
			var/ratio = power_supply.charge / power_supply.maxcharge
			ratio = round(ratio, 0.25) * 100
			icon_state = "[initial(icon_state)][ratio]"
		else
			icon_state = "[initial(icon_state)]-empty"
		return