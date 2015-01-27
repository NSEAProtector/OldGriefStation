/obj/item/weapon/gun/energy
	icon_state = "energy"
	name = "energy gun"
	desc = "A basic energy-based gun."
	fire_sound = 'sound/weapons/Taser.ogg'

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

/obj/item/weapon/gun/energy/verb/eject_battery(mob/living/user as mob)
	if (cell_removing)
		set name = "Eject Battery"
		set category = "Object"

		if(power_supply)
			power_supply.loc = get_turf(src.loc)
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