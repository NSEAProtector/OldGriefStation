/obj/item/weapon/gun/projectile/shotgun/pump
	name = "shotgun"
	desc = "Useful for sweeping alleys."
	fire_sound = 'sound/weapons/shotgun.ogg'
	icon_state = "shotgun"
	item_state = "shotgun"
	max_shells = 4
	w_class = 4.0
	force = 10
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	slot_flags = SLOT_BACK
	caliber = list("shotgun" = 1, "flare" = 1) //flare shells are still shells
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/beanbag"
	gun_flags = 0
	two_handed = 1
	var/recentpump = 0 // to prevent spammage
	var/pumped = 0
	var/obj/item/ammo_casing/current_shell = null

	isHandgun()
		return 0

	attack_self(mob/living/user as mob)
		if (user.a_intent == "disarm")
			if(recentpump)	return
			pump(user)
			recentpump = 1
			spawn(10)
				recentpump = 0
			return
		if(user.a_intent == "grab") //twohanded shotguuunss!!..
			if(two_handed)
				..()
				if(wielded) //Trying to unwield it
					unwield()
					user << "<span class='notice'>You are now carrying the [name] with one hand.</span>"
					if (src.unwieldsound)
						playsound(src.loc, unwieldsound, 50, 1)

					var/obj/item/weapon/twohanded/offhand/O = user.get_inactive_hand()
					if(O && istype(O))
						O.unwield()
					return

				else //Trying to wield it
					if(user.get_inactive_hand())
						user << "<span class='warning'>You need your other hand to be empty</span>"
						return
					wield()
					user << "<span class='notice'>You grab the [initial(name)] with both hands.</span>"
					if (src.wieldsound)
						playsound(src.loc, wieldsound, 50, 1)

					var/obj/item/weapon/twohanded/offhand/O = new(user) ////Let's reserve his other hand~
					O.name = "[initial(name)] - offhand"
					O.desc = "Your second grip on the [initial(name)]"
					user.put_in_inactive_hand(O)
					return

	process_chambered()
		if(in_chamber)
			return 1
		else if(current_shell && current_shell.BB)
			in_chamber = current_shell.BB //Load projectile into chamber.
			current_shell.BB.loc = src //Set projectile loc to gun.
			current_shell.BB = null
			current_shell.update_icon()
			return 1
		return 0

	proc/pump(mob/M as mob)
		playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
		pumped = 0
		if(current_shell)//We have a shell in the chamber
			current_shell.loc = get_turf(src)//Eject casing
			current_shell = null
			if(in_chamber)
				in_chamber = null
		if(!getAmmo())
			return 0
		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.
		current_shell = AC
		update_icon()	//I.E. fix the desc
		return 1

/obj/item/weapon/gun/projectile/shotgun/pump/combat
	name = "combat shotgun"
	icon_state = "cshotgun"
	max_shells = 8
	origin_tech = "combat=5;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun"
	two_handed = 1

/obj/item/weapon/gun/projectile/shotgun/pump/riot
	name = "riot shotgun"
	icon_state = "riotshotgun"
	max_shells = 5
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/beanbag"
	two_handed = 1

	attackby(var/obj/item/A as obj, mob/user as mob) ///Viton - Fast Copy past!
		..()
		A.update_icon()
		update_icon()
		if(istype(A, /obj/item/weapon/circular_saw) || istype(A, /obj/item/weapon/melee/energy) || istype(A, /obj/item/weapon/pickaxe/plasmacutter))
			user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
			if(getAmmo())
				afterattack(user, user)	//it will. we call it twice, for twice the FUN
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>The shotgun goes off!</span>", "<span class='danger'>The shotgun goes off in your face!</span>")
				return
			if(do_after(user, 30))	//SHIT IS STEALTHY EYYYYY
				icon_state = "cuttedriotshotgun"
				w_class = 3.0
				two_handed = 0
				item_state = "gun"
				slot_flags &= ~SLOT_BACK	//you can't sling it on your back
				slot_flags |= SLOT_BELT		//but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
				name = "sawn-off riot shotgun"
				desc = "Omar's coming!"
				user << "<span class='warning'>You shorten the barrel of \the [src]!</span>"

//this is largely hacky and bad :(	-Pete
/obj/item/weapon/gun/projectile/shotgun/doublebarrel
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon_state = "dshotgun"
	item_state = "shotgun"
	max_shells = 2
	w_class = 4.0
	force = 10
	flags =  FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BACK
	caliber = list("shotgun" = 1, "flare" = 1)
	origin_tech = "combat=3;materials=1"
	ammo_type = "/obj/item/ammo_casing/shotgun/beanbag"

	process_chambered()
		if(in_chamber)
			return 1
		if(!getAmmo())
			return 0
		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.
		if(AC.BB)
			in_chamber = AC.BB //Load projectile into chamber.
			AC.BB.loc = src //Set projectile loc to gun.
			AC.BB = null
			AC.update_icon()
			return 1
		return 0

	attack_self(mob/living/user as mob)
		..()

		if(!(locate(/obj/item/ammo_casing/shotgun) in src) && !getAmmo())
			user << "<span class='notice'>\The [src] is empty.</span>"
			return

		for(var/obj/item/ammo_casing/shotgun/shell in src)	//This feels like a hack.	//don't code at 3:30am kids!!
			if(shell in loaded)
				loaded -= shell
			shell.loc = get_turf(src.loc)

		user << "<span class='notice'>You break \the [src].</span>"
		update_icon()

	attackby(var/obj/item/A as obj, mob/user as mob)
		..()
		A.update_icon()
		update_icon()
		if(istype(A, /obj/item/weapon/circular_saw) || istype(A, /obj/item/weapon/melee/energy) || istype(A, /obj/item/weapon/pickaxe/plasmacutter))
			user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
			if(getAmmo())
				afterattack(user, user)	//will this work?
				afterattack(user, user)	//it will. we call it twice, for twice the FUN
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>The shotgun goes off!</span>", "<span class='danger'>The shotgun goes off in your face!</span>")
				return
			if(do_after(user, 30))	//SHIT IS STEALTHY EYYYYY
				icon_state = "sawnshotgun"
				w_class = 3.0
				two_handed = 0
				item_state = "gun"
				slot_flags &= ~SLOT_BACK	//you can't sling it on your back
				slot_flags |= SLOT_BELT		//but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
				name = "sawn-off shotgun"
				desc = "Omar's coming!"
				user << "<span class='warning'>You shorten the barrel of \the [src]!</span>"