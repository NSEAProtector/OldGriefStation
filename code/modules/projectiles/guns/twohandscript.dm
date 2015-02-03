/*--------------------Ak72ti------------------projectile/
/projectile-----------Ak72ti---------------------------*/

/*--------------------Ak72ti------------------dropped in projectile.dm/
/obj/item/weapon/gun/projectile/attack_self(mob/living/user as mob)
	if(istype(user,/mob/living/carbon/monkey))
		user << "<span class='warning'>It's too heavy for you to wield fully.</span>"
		return

	if(two_handed)
		if(user.a_intent == "grab")
			..()
			if(wielded) //Trying to unwield it
				unwield()
				user << "<span class='notice'>You are now carrying the [name] with one hand.</span>"
				if (src.unwieldsound)
					playsound(src.loc, unwieldsound, 50, 1)

				var/obj/item/weapon/twohanded/gun/O = user.get_inactive_hand()
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

				var/obj/item/weapon/twohanded/gun/O = new(user) ////Let's reserve his other hand~
				O.name = "[initial(name)] - offhand"
				O.desc = "Your second grip on the [initial(name)]"
				user.put_in_inactive_hand(O)
				return
/--------------------Ak72ti------------------dropped in projectile.dm*/


/obj/item/weapon/gun/projectile/dropped(mob/living/user as mob)
	if(user)
		var/obj/item/weapon/gun/O = user.get_inactive_hand()
		if(istype(O))
			O.unwield()
			del(O)
	return

/obj/item/weapon/gun/projectile/pickup(mob/living/user)
	unwield()
/*--------------------Ak72ti------------------projectile/
/projectile-----------Ak72ti---------------------------*/

/*--------------------Ak72ti------------------energy/
/energy---------------Ak72ti-----------------------*/
/obj/item/weapon/gun/energy/attack_self(mob/living/user as mob)
	if(istype(user,/mob/living/carbon/monkey))
		user << "<span class='warning'>It's too heavy for you to wield fully.</span>"
		return

	if(two_handed)
		if(user.a_intent == "grab")
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

/obj/item/weapon/gun/energy/dropped(mob/living/user as mob)
	//handles unwielding a twohanded weapon when dropped as well as clearing up the offhand
	if(user)
		var/obj/item/weapon/gun/O = user.get_inactive_hand()
		if(istype(O))
			O.unwield()
	return	unwield()

/obj/item/weapon/gun/energy/pickup(mob/living/user)
	unwield()
/*--------------------Ak72ti------------------energy/
/energy---------------Ak72ti-----------------------*/