/obj/item/weapon/gun/energy
	icon_state = "energy"
	name = "energy gun"
	desc = "A basic energy-based gun."
	fire_sound = 'sound/weapons/Taser.ogg'
	fire_delay = 1

	var/obj/item/weapon/cell/power_supply //What type of power cell this uses
	var/charge_cost = 100 //How much energy is needed to fire.
	var/cell_type = "/obj/item/weapon/cell"
	var/projectile_type = "/obj/item/projectile/beam/practice"
	var/cell_removing = 0
	var/modifystate

	emp_act(severity)
		power_supply.use(round(power_supply.maxcharge / severity))
		update_icon()
		..()


	process_chambered()
		if(in_chamber)	return 1
		if(!power_supply)	return 0
		if(!power_supply.use(charge_cost))	return 0
		if(!projectile_type)	return 0
		in_chamber = new projectile_type(src)
		return 1


	update_icon()
		if(power_supply)
			var/ratio = power_supply.charge / power_supply.maxcharge
			ratio = round(ratio, 0.25) * 100
			if(modifystate)
				icon_state = "[modifystate][ratio]"
			else
				icon_state = "[initial(icon_state)][ratio]"
		else
			icon_state = "[initial(icon_state)]-empty"
		return

/obj/item/weapon/gun/energy/New()
	. = ..()

	if(cell_type)
		power_supply = new cell_type(src)
	else
		power_supply = new(src)

	power_supply.give(power_supply.maxcharge)

/obj/item/weapon/gun/energy/Destroy()
	if(power_supply)
		power_supply.loc = get_turf(src)
		power_supply = null

	..()

/obj/item/weapon/gun/energy/attack_self(mob/living/user as mob)
	if(istype(user,/mob/living/carbon/monkey))
		user << "<span class='warning'>It's too heavy for you to wield fully.</span>"
		return

	if(user.a_intent == "grab")
		if(two_handed)
			..()
			if(wielded) //Trying to unwield it
				unwield()
				user << "<span class='notice'>You are now carrying the [name] with one hand.</span>"
				if (src.unwieldsound)
					playsound(src.loc, unwieldsound, 50, 1)

				var/obj/item/weapon/twohanded/gun/O = user.get_inactive_hand()
				if(O && istype(O))
					del(O)
				return

			else //Trying to wield it
				if(user.get_inactive_hand())
					user << "<span class='warning'>You need your other hand to be empty</span>"
					return
				wield()
				user << "<span class='notice'>You grab the [initial(name)] with both hands.</span>"
				if (src.wieldsound)
					playsound(src.loc, wieldsound, 50, 1)

				var/obj/item/weapon/twohanded/gun/O = new(user) ////Let's reserve his other hand~
				O.name = "[initial(name)] - offhand"
				O.desc = "Your second grip on the [initial(name)]"
				user.put_in_inactive_hand(O)
				return