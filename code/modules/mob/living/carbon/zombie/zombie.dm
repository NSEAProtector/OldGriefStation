////Zombie VG////

#define cycle_pause 4 //min 1
#define viewrange 7 //min 2

/mob/living/carbon/human/zombie/New()
 	..()
 	// Uh, what? - N3X
 	src.mind = new/datum/mind(src)


/mob/living/carbon/human/zombie						//Define
	name = "zombie"
	desc = "A Zombie."
	a_intent = "harm"

	var/state = 0

	var/list/path = new/list()

	var/frustration = 0
	var/mob/living/carbon/target
	var/list/path_target = new/list()

	var/turf/trg_idle
	var/list/path_idle = new/list()

	var/alive = 1 //1 alive, 0 dead

	var/zsay = new/list()

	New()
		..()
		zsay += "braaaaains"
		zsay += "Mrrrhrrrrrrmmmm"
		zsay += "BRAIIIIIIIIINSSSSS"
		zsay += "uuuuuuuuuuuhhhh"
		zsay += "grrrr-grrrii-gggrii-fffee-rrr"
		zsay += "UHhuHUhuhhhh"
		zsay += "thriii-thirriiill--errrr"
		zsay += "GRRRRRRRRR"
		zsay += "ahhhaaaarraaghh"
		zsay += "eeemmmmmmaaarrrrrrraggh"
		zsay += "AAARRAAAGGGGHHHHHH"
		zsay += "FFFFEEEEERRAAAAG"
		zsay += "bbbb-bbb-ainnnnnns"
		zsay += "aaaadd-mmm-iiiinn-aaaaabbb-uuuu-ssss"

		src.contract_disease(new/datum/disease/z_virus)

		src.process()

	emote(var/act)
		act = "<B>[src]</B> moans."
		for (var/mob/O in hearers(src, null))
			O.show_message(act, 2)

	Bumped(AM as mob|obj)
	//	..()
		if(istype(AM, /mob/living/carbon/human/zombie))
			return
		if(ismob(AM) && (ishuman(AM) || ismonkey(AM)) )
			src.target = AM
			set_attack()
		else if(ismob(AM))
			spawn(0)
				var/turf/T = get_turf(src)
				AM:loc = T

	Bump(atom/A)
		if(istype(A, /mob/living/carbon/human/zombie))
			return
		if(ismob(A) && (ishuman(A) || ismonkey(A)))
			src.target = A
			set_attack()
		else if(ismob(A))
			src.loc = A:loc


	proc/set_attack()
		state = 1
		if(path_idle.len) path_idle = new/list()
		trg_idle = null

	proc/set_idle()
		state = 2
		if (path_target.len) path_target = new/list()
		target = null
		frustration = 0

	proc/set_null()
		state = 0
		if (path_target.len) path_target = new/list()
		if (path_idle.len) path_idle = new/list()
		target = null
		trg_idle = null
		frustration = 0

	proc/process()
		//set background = 1
		var/quick_move = 1
		var/slow_move = 0

		if (src.stat == 2)
			return

		if (src.stat > 0 || lying)
			spawn(cycle_pause)
				src.process()
			return

		if(istype(src.shoes, /obj/item/clothing/shoes/orange))
			var/obj/item/clothing/shoes/orange/Os = src.shoes
			if(Os.chained)
				slow_move = 1
		else if(istype(src.wear_suit, /obj/item/clothing/suit/straight_jacket))
			slow_move = 1


		else if (!target)
			if (path_target.len) path_target = new/list()

			var/last_health = INFINITY

			for (var/mob/living/carbon/C in range(viewrange-2,src.loc))
				if (C.stat == 2 || !can_see(src,C,viewrange) || istype(C, /mob/living/carbon/human/zombie) || istype(C, /mob/living/carbon/monkey))
					continue
				if(C:stunned || C:paralysis || C:weakened)
					target = C
					break
				if(C:health < last_health)
					last_health = C:health
					target = C

			if(target)
				set_attack()
			else if(state != 2)
				set_idle()
				idle()

		else if(target)
			var/turf/distance = get_dist(src, target)
			set_attack()

			if(can_see(src,target,viewrange))
				if(distance <= 1 && !istype(src.wear_mask, /obj/item/clothing/mask))
					if(prob(25))
						for(var/mob/O in viewers(world.view,src))
							O.show_message("\red <B>[src] has attempted to bite [src.target]!</B>", 1, "\red You hear struggling.", 2)
					else
						for(var/mob/O in viewers(world.view,src))
							O.show_message("\red <B>[src.target] has been bitten by [src]!</B>", 1, "\red You hear struggling.", 2)
						var/mob/living/carbon/human/T = target
						T.bruteloss += rand(1,7)
						var/datum/organ/external/affecting
						if(T.organs["head"]) affecting = T.organs["head"]
						affecting.take_damage(rand(1,7), 0)
						playsound(get_turf(src), 'sound/items/eatfood.ogg', 50, 1)
						if(prob(25))
							target.contract_disease(new/datum/disease/z_virus)
						src.add_blood(src.target)
						if (prob(33))
							var/turf/location = src.target.loc
							if (istype(location, /turf/simulated))
								location.add_blood(src.target)
						if (src.wear_mask)
							src.wear_mask.add_blood(src.target)
						if (src.head)
							src.head.add_blood(src.target)
						if (src.glasses && prob(33))
							src.glasses.add_blood(src.target)
						if (src.gloves)
							src.gloves.add_blood(src.target)
						if (prob(15))
							if (src.wear_suit)
								src.wear_suit.add_blood(src.target)
							else if (src.w_uniform)
								src.w_uniform.add_blood(src.target)
					sleep(5)
					//target:paralysis = max(target:paralysis, 10)
				else if(distance <= 1 && !src.handcuffed && !istype(src.wear_suit, /obj/item/clothing/suit/straight_jacket))
					if(prob(25) && src.equipped())
						var/obj/item/weapon/A = src.equipped()
						A.attack(src.target, src)
					else if(prob(25))
						for(var/mob/O in viewers(world.view,src))
							O.show_message("\red <B>[src] has attempted to claw [src.target]!</B>", 1, "\red You hear struggling.", 2)
					else
						for(var/mob/O in viewers(world.view,src))
							O.show_message("\red <B>[src.target] has been clawed by [src]!</B>", 1, "\red You hear struggling.", 2)
						var/mob/living/carbon/human/T = target
						T.bruteloss += rand(1,7)
						var/datum/organ/external/affecting
						if(T.organs["head"]) affecting = T.organs["head"]
						affecting.take_damage(rand(1,7), 0)
						if(prob(12.5))
							target.contract_disease(new/datum/disease/z_virus)
						src.add_blood(src.target)
						if (prob(33))
							var/turf/location = src.target.loc
							if (istype(location, /turf/simulated))
								location.add_blood(src.target)
						if (src.wear_mask)
							src.wear_mask.add_blood(src.target)
						if (src.head)
							src.head.add_blood(src.target)
						if (src.glasses && prob(33))
							src.glasses.add_blood(src.target)
						if (src.gloves)
							src.gloves.add_blood(src.target)
						if (prob(15))
							if (src.wear_suit)
								src.wear_suit.add_blood(src.target)
							else if (src.w_uniform)
								src.w_uniform.add_blood(src.target)

				else
					step_towards(src,get_step_towards2(src , target))
					set_null()
					if(!slow_move)
						spawn(cycle_pause) src.process()
					else
						spawn(cycle_pause*2) src.process()
					return

			else
				if( !path_target.len )

					path_attack(target)
					if(!path_target.len)
						set_null()
						if(!slow_move)
							spawn(cycle_pause) src.process()
						else
							spawn(cycle_pause*2) src.process()
						return
				else
					var/turf/next = path_target[1]

					if(next in range(1,src))
						path_attack(target)

					if(!path_target.len)
						src.frustration += 5
					else
						next = path_target[1]
						path_target -= next
						step_towards(src,next)
						quick_move = 1

			if (get_dist(src, src.target) >= distance) src.frustration++
			else src.frustration--
			if(frustration >= 35) set_null()

		if(prob(3) && !src.stat == 2)
			if(prob(50))
				src.say(pick(zsay))
			else
				src.emote("moan")

		if(slow_move)
			spawn(cycle_pause*2)
				src.process()
		else if(quick_move)
			spawn(cycle_pause/2)
				src.process()
		else
			spawn(cycle_pause)
				src.process()


		for(var/obj/machinery/door/D in oview(1))
			D.Bumped(src)




	proc/idle()
		//set background = 1
		var/quick_move = 0

		if(state != 2 || src.stat == 2 || target) return

		step_rand(src)

		if(prob(3))
			if(prob(10))
				src.say(pick(zsay))
			else
				src.emote("moan")

		if(quick_move)
			spawn(cycle_pause/2)
				idle()
		else
			spawn(cycle_pause)
				idle()

	proc/path_idle(var/atom/trg)
		path_idle = AStar(src.loc, get_turf(trg), /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, null, null)
		//path_idle = reverselist(path_idle)

	proc/path_attack(var/atom/trg)
		target = trg
		path_target = AStar(src.loc, target.loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, null, null)
		//path_target = reverselist(path_target)


	proc/healthcheck()
		return


//Zombies!

/datum/disease/z_virus
	name = "T-Virus"
	max_stages = 5
	spread = "Contact"
	cure = "???"
	spread_type = SPECIAL
	cure_id = "zed"
	affected_species = list("Human", "Human/Zombie")

/datum/disease/z_virus/stage_act()
	..()
	if(istype(affected_mob, /mob/living/carbon/human/zombie) && !src.carrier)
		src.carrier = 1
		return
	switch(stage)
		if(1)
			if (prob(8))
				affected_mob << pick("\red Something about you doesnt feel right.","\red Your head starts to itch.")
		if(2)
			if (prob(8))
				affected_mob << "\red Your limbs feel numb."
				affected_mob.bruteloss += 1
				affected_mob.updatehealth()
			if (prob(9))
				affected_mob << "\red You feel ill..."
			if (prob(9))
				affected_mob << "\red You feel a pain in your stomache..."
		if(3)
			if (prob(8))
				affected_mob << text("\red []", pick("owww...","I want...","Please..."))
				affected_mob.bruteloss += 1
				affected_mob.updatehealth()
			if (prob(10))
				affected_mob << "\red You feel very ill."
				affected_mob.bruteloss += 5
				affected_mob.updatehealth()
			if (prob(4))
				affected_mob << "\red You feel a stabbing pain in your head."
				affected_mob.paralysis += 2
			if (prob(4))
				affected_mob << "\red Whats going to happen to me?"
		if(4)
			if (prob(10))
				affected_mob << pick("\red You feel violently sick.")
				affected_mob.bruteloss += 8
				affected_mob.updatehealth()
			if (prob(20))
				affected_mob.say(pick("Mmmmm.", "Hey... You look...", "Hsssshhhhh!"))
			if (prob(8))
				affected_mob << "\red You cant... feel..."
		if(5)
			affected_mob.toxloss += 10
			affected_mob.updatehealth()
			affected_mob << "You feel the life slowly slip away from you as you join the army of the undead.."
			affected_mob:Zombify()


/mob/living/carbon/human/proc/Zombify()
	if (src.monkeyizing)
		return
	update_icons() // update_clothing()
	var/mob/living/carbon/human/zombie/O = new/mob/living/carbon/human/zombie( src.loc )
	//Yay, Zombie!
	O.name = name
	O.r_hair = name
	O.g_hair = g_hair
	O.b_hair = b_hair
	O.h_style = h_style
	O.r_facial = r_facial
	O.g_facial = g_facial
	O.b_facial = b_facial
	O.f_style = f_style
	O.r_eyes = r_eyes
	O.g_eyes = g_eyes
	O.b_eyes = b_eyes
	O.s_tone = s_tone
	O.age = age

	O.real_name = real_name

	O.wear_mask = wear_mask
	O.l_hand = l_hand
	O.r_hand = r_hand
	O.wear_suit = wear_suit
	O.w_uniform = w_uniform
//	O.w_radio = null
	O.shoes = shoes
	O.belt = belt
	O.gloves = gloves
	O.glasses = glasses
	O.head = head
	O.ears = ears
	O.wear_id = wear_id
	O.r_store = r_store
	O.l_store = l_store
	O.back = back

	O.stand_icon = stand_icon
	O.lying_icon = lying_icon

	//O.last_b_state = last_b_state

	//O.face_standing = face_standing
	//O.face_lying = face_lying

	//O.hair_icon_state = hair_icon_state
	//O.face_icon_state = face_icon_state

	//O.body_standing = body_standing
	//O.body_lying = body_lying
	for(var/obj/Q in src)
		Q.loc = O
	O.update_icons()//update_clothing()
	src.ghostize()
	O.loc = src.loc
	del(src)
	return

/obj/item/weapon/reagent_containers/glass/bottle/t_virus
	name = "Z-Virus culture bottle"
	desc = "A small bottle. Contains Z-Virus virion in synthblood medium."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle3"
	amount_per_transfer_from_this = 5

	New()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/z_virus(0)
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)

///////////////////////////CURE//////////////////////////////////////////

datum/reagent/zed
	name = "Zombie Elixer"
	id = "zed"
	description = "For treating the Z-Virus."
	//reagent_state = LIQUID

	on_mob_life(var/mob/M)//no more mr. panacea
		holder.remove_reagent(src.id, 0.2)
		return



/obj/item/weapon/zedpen
	desc = "Small non-refillable auto-injector for curing the Z-Virus in early stages."
	name = "Z.E.D. Pen."
	icon = 'icons/obj/items.dmi'
	icon_state = "zed_1"
	flags = FPRINT | TABLEPASS/* | ONBELT*/
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15
	m_amt = 60

/obj/item/weapon/zedpen/attack_paw(mob/user as mob)
	return src.attack_hand(user)
	return

/obj/item/weapon/zedpen/New()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = src
	R.add_reagent("zed", 10)
	..()
	return

/obj/item/weapon/zedpen/attack(mob/M as mob, mob/user as mob)
	if (!( istype(M, /mob) ))
		return
	if (reagents.total_volume)
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\blue [] has been stabbed with [] by [].", M, src, user), 1)
//		user << "\red You stab [M] with the pen."
//		M << "\red You feel a tiny prick!"
		if(M.reagents) reagents.trans_to(M, 10)
		icon_state = "zed_0"
	return




/obj/item/weapon/storage/firstaid/zed
	name = "Zed-Kit"
	icon_state = "zedkit"
	item_state = "firstaid-zed"

/obj/item/weapon/storage/firstaid/zed/New()

	..()
	new /obj/item/weapon/zedpen( src )
	new /obj/item/weapon/zedpen( src )
	new /obj/item/weapon/zedpen( src )
	new /obj/item/weapon/zedpen( src )
	new /obj/item/weapon/zedpen( src )
	new /obj/item/weapon/zedpen( src )
	new /obj/item/device/healthanalyzer( src )
	return


////////////////////////////////////////////event code/////////////////////////////////////////

/obj/landmark/zspawn
	name = "zombie spawn"

/*
/client/update_admins(var/rank)
	..()
	if(rank == "Game Master"/* || rank == "Coder" || rank == "Primary Administrator" || rank == "Administrator"*/)
		src.verbs += /client/proc/zombie_event
*/

/client/proc/zombie_event()
	set category = "Special Verbs"
	set name = "Spawn Zombies"

//	if(!istype(ticker.mode, /datum/game_mode/biohazard))
//		if(src)
//			src << "\red Wrong game mode!"
//			return

	if(usr) message_admins("[key_name_admin(usr)] has spawned a zombie", 1)
	biohazard_alert(7)
	var/list/t = list()
	for(var/obj/landmark/zspawn/O in world)
		t += O
	if(!t.len)
		usr<<"No spawn points exist."
		return
	var/obj/landmark/s = pick(t)
	var/mob/living/carbon/human/zombie/Z = new/mob/living/carbon/human/zombie(s.loc)

	Z.gender = pick(MALE, FEMALE)

	/* DNA2 broke this
	var/flooks = new/list()
	var/mlooks = new/list()
	flooks += "0990CC0FF000000000DC0000033000902136F93"
	flooks += "0CC000033000000000DC0000033000C4308DEB4"
	flooks += "066000033000000000B90000033000E1E03FD3F"
	flooks += "066000033000000000690000033000A0F06C6D5"
	flooks += "0CC000000000000000EB0000000066D1F11EDA3"
	//flooks += "0FF0000FF000000000F50000000066B360B819"

	mlooks += "066000033000000000CD000000000071E0F7382"
	mlooks += "066000033000000000B9006603300037909B45A"
	mlooks += "000000000000000000690000000066487060580"
	mlooks += "000000000000000000CD0000000000638074390"
	mlooks += "066000033066000033CD00000000000D8D20B9B"

	if(Z.gender == MALE)
		Z.dna.unique_enzymes = pick(mlooks)
	else
		Z.dna.unique_enzymes = pick(flooks)
	*/

	Z.UpdateAppearance()

	if(Z.gender == MALE)
		Z.real_name = text("[] []", pick(first_names_male), pick(last_names))
	else
		Z.real_name = text("[] []", pick(first_names_female), pick(last_names))

	//var/a = pick("Janitor", "Medical Doctor", "Assistant", "Atmospheric Technician", "Security Officer", "Botanist", "Cargo Technician")
	//Z.Equip_Rank(a, 0)
	//Commented out by pygmy. Reason: Triggers my anti-spawn-at-menu code. Compromising this risks server.
	Z.loc = s.loc

/*
/////yellowAnimus zombie///////////

mob/var/zombieleader = 0
mob/var/zombieimmune = 0
/mob/living/carbon/proc/zombify()
	stat &= 1
	oxyloss = 0
	becoming_zombie = 0
	zombie = 1
	bodytemperature = 310.055
	see_in_dark = 4
	sight |= SEE_MOBS
	update_icons()
	src.verbs += /mob/living/carbon/proc/supersuicide
//	if(zombieleader)
//		src.verbs -= /mob/living/carbon/proc/zombierelease
	src << "\red<font size=3> You have become a zombie!"
	for(var/mob/O in viewers(src, null))
		O.show_message(text("\red <B>[src] seizes up and falls limp, \his eyes dead and lifeless...[src] is ZOMBIE! HARM CLAW! CLAW! CLAW!</B>"), 1)
//	if(ticker.mode.name == "Zombie Outbreak")
//		ticker.check_win()

/mob/living/carbon/proc/unzombify()
	zombie = 0
	see_in_dark = 2
	update_icons()
	src << "You have been cured from being a zombie!"

/mob/living/carbon/human/proc/zombie_bit(var/mob/living/carbon/human/biter)
	var/mob/living/carbon/human/biten = src
	if(zombie || becoming_zombie || !ishuman())
		biter << "\red <b>You mustn't bite [name], he is also infected.</b>"
		return
	if(stat > 1)//dead: it takes time to reverse death, but there is no chance of failure
		sleep(50)
		zombify()
		return
	if((istype(biten.wear_suit, /obj/item/clothing/suit/bio_suit) || istype(biten.wear_suit, /obj/item/clothing/suit/space)) || (istype(biten.head, /obj/item/clothing/head/bio_hood) || istype(biten.head, /obj/item/clothing/head/space)))
		if((istype(biten.head, /obj/item/clothing/head/bio_hood) || istype(biten.head, /obj/item/clothing/head/space)) && (istype(biten.wear_suit, /obj/item/clothing/suit/bio_suit) || istype(biten.wear_suit, /obj/item/clothing/suit/space)))
			if(prob(50))
				for(var/mob/M in viewers(src, null))
					if ((M.client && !( M.blinded )))
						M << "[biter.name] fails to bite [name]"
				return
		else if(prob(25))
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M << "[biter.name] fails to bite [name]"
			return
	for(var/mob/M in viewers(src, null))
		if ((M.client && !( M.blinded )))
			M << "[biter.name] bites [name]"
	if(zombieimmune)
		return
	if(prob(3))
		zombify()
	else if(prob(5))
		becoming_zombie = 1
		src << "You feel a strange itch"
		sleep(300)
		if(becoming_zombie)
			zombify()
	else if(prob(30))
		becoming_zombie = 1
		src << "You faintly feel a strange itch"
		sleep(800)
		if(becoming_zombie)
			src << "You feel a strange itch, stronger this time"
			sleep(400)
			if(becoming_zombie)
				zombify()

/mob/living/carbon/proc/zombie_infect()
	becoming_zombie = 1
	src << "You feel a strange itch"
	sleep(200)
	if(becoming_zombie)
		zombify()
/mob/living/carbon/proc/traitor_infect()
	becoming_zombie = 1
	zombieleader = 1
	src.verbs += /mob/living/carbon/proc/zombierelease
	src << "You have been implanted with a chemical canister you can either release it yourself or wait until it activates."
	sleep(3000)
	if(becoming_zombie)
		zombify()

/mob/living/carbon/proc/admin_infect()
	becoming_zombie = 1
	src << "You faintly feel a strange itch"
	sleep(800)
	if(becoming_zombie)
		src << "You feel a strange itch, stronger this time"
		sleep(400)
		if(becoming_zombie)
			zombify()
/mob/living/carbon/proc/supersuicide()
	set name = "Zombie suicide"
	set hidden = 0
	if(zombie == 1)
		switch(alert(usr,"Are you sure you wanna die?",,"Yes","No"))
			if("Yes")
				fireloss = 999
				src << "You died suprised?"
				return
			else
				src << "You live to see another day."
				return
	else
		src << "Only for zombies."

/mob/living/carbon/proc/zombierelease()
	set name = "Zombify"
	set desc = "Turns you into a zombie"
	if(zombieleader)
		zombify()

/////D2K5////////
/mob/living/carbon/human/var/ai_laststep_zombie = 0
/mob/living/carbon/human/var/ai_state_zombie = 0
/mob/living/carbon/human/var/ai_threatened_zombie = 0
/mob/living/carbon/human/var/ai_move_zombiedelay = 6
/mob/living/carbon/human/var/ai_pounced_zombie = 0
/mob/living/carbon/human/var/ai_attacked_zombie = 0
/mob/living/carbon/human/var/ai_frustration_zombie = 0
/mob/living/carbon/human/var/ai_throw_zombie = 0
/mob/living/carbon/human/var/trollface = 6
/mob/living/carbon/human/var/mob/living/carbon/human/tempmob
/mob/living/carbon/human/var/ai_target_zombie
/mob/living/carbon/human/var/ai_active_zombie
var/global/list/mob/living/carbon/human/zombies = list()

//NOTE TO SELF: BYONDS TIMING FUNCTIONS ARE INACCURATE AS FUCK
//ADD HELP INTEND.

//0 = Passive, 1 = Getting angry, 2 = Attacking , 3 = Helping, 4 = Idle , 5 = Fleeing(??)

/mob/living/carbon/human/proc/ai_init_zombie()
	ai_active_zombie = 1
	ai_laststep_zombie = 0
	ai_state_zombie = 0
	ai_target_zombie = null
	ai_threatened_zombie = 0
	ai_move_zombiedelay = 1
	ai_attacked_zombie = 0
	ai_loop_zombie()
	trollface = rand(8,15)
	if(prob(1))
		trollface = rand(4,8)

/mob/living/carbon/human/proc/ai_loop_zombie()
	if(client)
		ai_active_zombie = 0
		return

	spawn(0)

		while (ai_active_zombie)
			zombies += src
			if (stat == 2)
				ai_active_zombie = 0
				ai_target_zombie = 0
				return

			if(ai_incapacitated_zombie())
				sleep(10)
				continue

			/*var/turf/simulated/T = get_turf(src)
			if(!istype(get_turf(src), /turf/space) && (T.toxins > 500.0 || T.active_hotspot || T.oxygen < (MOLES_O2STANDARD/2) || T.carbon_dioxide > 7500.0))
				if(istype(get_turf(src), /turf/space))
					ai_avoid()*/
			ai_move_zombie()

			ai_action_zombie()
			sleep(trollface)

/mob/living/carbon/human/proc/ai_action_zombie()

	switch(ai_state_zombie)
		if(0) //Life is good.
			src.zone_sel = new /obj/screen/zone_sel( null )
			src.zone_sel.selecting = pick("head","chest")
			src.a_intent = "disarm"
			if(istype(src.loc, /obj/closet))
				src.ai_freeself_zombie()
				return

			ai_pickupweapon_zombie()
			ai_obstacle_zombie(1)
			ai_openclosets_zombie()
			if(!zombiez_on)
				zombiez_on = 1
//			var/tempmob

//			for (var/mob/living/carbon/M in view(7,src))
//				if ((istype(M, /mob/living/carbon) && !istype(src, /mob/living/carbon/human/zombie)) || M.stat == 2 || !M.client || M.stat == 1 || M == src) continue
//				if (!tempmob) tempmob = M
//				for(var/mob/living/carbon/L in oview(7,src))
//					if (L.ai_target_zombie == tempmob && prob(66)) continue
//				if (M.health < tempmob:health) tempmob = M
			if(tempmob)
				ai_target_zombie = tempmob
				ai_state_zombie = 1
				ai_threatened_zombie = world.timeofday
			sleep(-1)

		if(1)	//WHATS THAT?

			if(istype(src.loc, /obj/closet))
				src.ai_freeself_zombie()
				return

			if (get_dist(src,ai_target_zombie) > 20)
				ai_target_zombie = null
				ai_state_zombie = 0
				ai_threatened_zombie = 0
				if(prob(5))
					src.say(pick("brrrannngggee", "imshhuuu drrrrnnnnghh", "rrggrrggggghhh"))
				return

			if ( (world.timeofday - ai_threatened_zombie) > 20 ) //Oh, it is on now! >:C
				ai_state_zombie = 2
				if(prob(5))
					src.say(pick("SSSCCHRRARAAAAAAAA!", "RAAAAAAAAAAAAAAAAAAAA!", "RRGGHHHRHHRHHGGHRRRRRRRR RAAEAAAAAAAAA"))
				return

		if(2)	//Gonna kick your ass.

			src.a_intent = "hurt"

			var/mob/living/carbon/target = ai_target_zombie

			if(!target || ai_target_zombie == src)
				ai_frustration_zombie = 0
				ai_target_zombie = null
				ai_state_zombie = 0

			var/valid = ai_validpath_zombie()
			var/distance = get_dist(src,ai_target_zombie)

			ai_obstacle_zombie(0)
			ai_openclosets_zombie()
			ai_pickupweapon_zombie()

			if(istype(src.loc, /obj/closet))
				src.ai_freeself_zombie()
				return

			if (ai_frustration_zombie >= 100)
				ai_obstacle_zombie(0)
				ai_obstacle_zombie(0)
				ai_obstacle_zombie(0)

			if (ai_frustration_zombie >= 500)
				ai_frustration_zombie = 0
				ai_target_zombie = null
				ai_state_zombie = 0

			if(target && (target.stat == 2 || distance > 20 || (!src.see_invisible && target.invisibility) || (target.stat == 1 && prob(2))))
				ai_target_zombie = null
				ai_state_zombie = 0
				if(prob(5))
					src.say(pick("hunnnnnng!", "imshhuuu drrrrnnnnghh", "rrggrrggggghhh")) // I hope a lot of people die thinking zombies are drunk. -Nernums
				for (var/mob/G in oviewers())
					if (!G.client) continue
					G << "\red [src] loses interest."
				return

			if((target.weakened || target.stunned || target.paralysis) && istype(target.wear_mask, /obj/item/clothing/mask) && distance <= 1 && prob(75) && !ai_incapacitated_zombie())
				var/mask = target.wear_mask
				target.u_equip(mask)
				if (target.client)
					target.client.screen -= mask
				if (mask)
					mask:loc = target:loc
					mask:dropped(target)
					mask:layer = initial(mask:layer)
				for (var/mob/G in view(7,src))
					if (!G.client) continue
					G << "\red [src] rips off [ai_target_zombie]'s [mask]."

			else if ((target.weakened || target.stunned || target.paralysis) && target:wear_suit && distance <= 1 && prob(10) && !src.r_hand && !ai_incapacitated_zombie())
				var/suit = target:wear_suit
				target.u_equip(suit)
				if (target.client)
					target.client.screen -= suit
				if (suit)
					suit:loc = target:loc
					suit:dropped(target)
					suit:layer = initial(suit:layer)
				for (var/mob/G in view(7,src))
					if (!G.client) continue
					G << "\red [src] rips off [ai_target_zombie]'s [suit]."

			else if ((target.weakened || target.stunned || target.paralysis) && distance <= 1 && prob(80) && !src.r_hand && !ai_incapacitated_zombie())
				if(istype(target, /mob/living/carbon/human))
					var/mob/living/carbon/human/fix = target
					if(fix.organ_manager.head == 1 && prob(1))
						fix:removePart(src.organ_manager.head)
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] rips off [ai_target_zombie]'s head!"
					if(fix.organ_manager.l_hand == 1 && prob(1))
						fix:removePart("hand_left")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] chews off [ai_target_zombie]'s hand."
					if(fix.organ_manager.r_hand == 1 && prob(1))
						fix:removePart("hand_right")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] chews off [ai_target_zombie]'s hand."
					if(fix.organ_manager.l_arm == 1 && prob(1))
						fix:removePart("arm_left")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] rips off [ai_target_zombie]'s arm."
					if(fix.organ_manager.r_arm == 1 && prob(1))
						fix:removePart("arm_right")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] rips off [ai_target_zombie]'s arm."
					if(fix.organ_manager.l_foot == 1 && prob(1))
						fix:removePart("foot_left")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] bites off [ai_target_zombie]'s foot."
					if(fix.organ_manager.r_foot == 1 && prob(1))
						fix:removePart("foot_right")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] bites off [ai_target_zombie]'s foot."
					if(fix.organ_manager.l_leg == 1 && prob(1))
						fix:removePart("leg_left")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] rips off [ai_target_zombie]'s leg."
					if(fix.organ_manager.r_leg == 1 && prob(1))
						fix:removePart("leg_right")
						for (var/mob/G in view(7,src))
							if (!G.client) continue
							G << "\red [src] rips off [ai_target_zombie]'s leg."
				if (target && target.client)
					target.reagents.add_reagent("toxin", 5.5)

				for (var/mob/G in view(7,src))
					if (!G.client) continue
					G << "\red [src] chews on [ai_target_zombie]."


			if(prob(75) && distance > 1 && (world.timeofday - ai_attacked_zombie) > 100 && ai_validpath_zombie() && ((istype(src.r_hand, /obj/item/weapon/gun/projectile) && src.r_hand:loaded:len) || (istype(src.r_hand, /obj/item/weapon/gun/energy) && src.r_hand:charges)))
				var/obj/item/weapon/gun/W = src.r_hand
				W.afterattack(target, src, 0)
				if(prob(5))
					switch(pick(1,2))
						if(1)
							hearers(src) << "<B>[src.name]</B> makes groaning noises."
						if(2)
							src.say(pick("RRRUGUGHGEERHHH!", "SCRRAAAAY!", "wnnn urr braaangee, [target.name]!", "SSREEEERREEEEEEEEEEEECREE, [target.name]!"))

			if((prob(33) || ai_throw_zombie) && distance > 1 && ai_validpath_zombie() && src.r_hand && !((istype(src.r_hand, /obj/item/weapon/gun/projectile) && src.r_hand:loaded:len) || (istype(src.r_hand, /obj/item/weapon/gun/energy) && src.r_hand:charges)))
				var/obj/item/temp = src.r_hand
				temp.loc = src.loc
				src.r_hand = null
				temp.throw_at(target, 7, 1)
				for (var/mob/G in view(7,src))
					if (!G.client) continue
					G << "\red [src] throws the [temp] at [ai_target_zombie]."

			if(distance <= 1 && (world.timeofday - ai_attacked_zombie) > 100 && !ai_incapacitated_zombie() && ai_meleecheck_zombie())
				var/obj/item/temp = src.r_hand
				if(prob(10))
					src.say(pick("oh onnii-chann~~ dont look, it is embarassing [target.name]!", " BREEAAAAA!", "GSGREEEHHHAEEEEEEE!!")) //I dare any of you to think of a more fitting line. - Nernums
				if(!src.r_hand)
					if(prob(25))
						if(target)
							target.reagents.add_reagent("stoxin", 1)
					//	target.attack_paw(src) // retards bite
					//	if(prob(50))
					//		target.turnedon = 0
						for(var/mob/O in viewers(ai_target_zombie, null))
							O.show_message(text("\red <B>[src.name] bites []!</B>", ai_target_zombie))
					else

						//target.attack_hand(src) //We're a human!
						if(target)
							target.reagents.add_reagent("stoxin", 0.5)
						//if(prob(50))
						//	target.turnedon = 0
						for(var/mob/O in viewers(ai_target_zombie, null))
							O.show_message(text("\red <B>[src.name] has punched []!</B>", ai_target_zombie))
				else
					if(target)
						target.attackby(src.r_hand, src) //With a weapon ...
					//if(prob(50))
					//	target.turnedon = 0
					for(var/mob/O in viewers(ai_target_zombie, null))
						O.show_message(text("\red <B>[] has been attacked with [][] </B>", ai_target_zombie, temp, (src ? text(" by [].", src) : ".")), 1)
					ai_target_zombie:attackby(src.r_hand, src)

			if( (distance == 3) && (world.timeofday - ai_pounced_zombie) > 180 && ai_validpath_zombie())
				if(valid)
					ai_pounced_zombie = world.timeofday
					for (var/mob/G in view(7,src))
						if (!G.client) continue
						G << "\red [src] lunges at [ai_target_zombie]."

					if(((istype(target.r_hand, /obj/item/weapon/shield) || istype(target.l_hand, /obj/item/weapon/shield)) && prob(80)) || (istype(target.r_hand, /obj/item/weapon/shield) && istype(target.l_hand, /obj/item/weapon/shield) && prob(50)))
						if(src.buckled) return
						ai_target_zombie << "\blue You manage to block the attack with your shield."
						spawn(0)
							step_towards(src,ai_target_zombie)
							step_towards(src,ai_target_zombie)
					else
						if(src.buckled) return
						if(ai_target_zombie:weakened < 2) ai_target_zombie:weakened += 2
						spawn(0)
							step_towards(src,ai_target_zombie)
							step_towards(src,ai_target_zombie)

/mob/living/carbon/human/proc/ai_move_zombie()
	if(ai_incapacitated_zombie() || !ai_canmove_zombie()) return
	if( ai_state_zombie == 0 && ai_canmove_zombie() ) step_rand(src)
	if( ai_state_zombie == 2 && ai_canmove_zombie() )
		if(!ai_validpath_zombie() && get_dist(src,ai_target_zombie) <= 1)
			dir = get_step_towards(src,ai_target_zombie)
			ai_obstacle_zombie() //Remove.
		else
			step_towards(src,ai_target_zombie)



/mob/living/carbon/human/proc/ai_pickupweapon_zombie()

	var/obj/item/weapon/pickup

	for (var/obj/item/weapon/G in view(1,src))
		if(!istype(G.loc, /turf) || G.anchored) continue
		if(!src.r_hand && !pickup && G.force > 3)
			pickup = G
		else if(!src.r_hand && pickup && G.force > 3)
			if(G.force > pickup.force) pickup = G
		else if(src.r_hand && !pickup && G.force > 3)
			if(src:r_hand:force < G.force) pickup = G
		else if(src.r_hand && pickup && G.force > 3)
			if(pickup.force < G.force) pickup = G

	if(src.r_hand && pickup)
		src.r_hand:loc = get_turf(src)
		src.r_hand = null

	if(pickup && !src.r_hand)
		pickup.loc = src
		src.r_hand = pickup

/mob/living/carbon/human/proc/ai_avoid(/*var/turf/simulated/T*/)
	if(ai_incapacitated_zombie()) return
	var/turf/simulated/T = get_turf(src)
	var/turf/simulated/tempturf = T
	var/tempdir = null
	var/turf/simulated/testturf = null

	if(T.active_hotspot)
		for (var/dir1 in list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST))
			testturf = get_step(T,dir1)
			if (testturf.active_hotspot < tempturf.active_hotspot)
				tempdir = dir1
				tempturf = testturf
	if(T.toxins > 1.0)
		for (var/dir1 in list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST))
			testturf = get_step(T,dir1)
			if (testturf.toxins < tempturf.toxins)
				tempdir = dir1
				tempturf = testturf
	else if(T.carbon_dioxide > 20.0)
		for (var/dir1 in list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST))
			testturf = get_step(T,dir1)
			if (testturf.carbon_dioxide < tempturf.carbon_dioxide)
				tempdir = dir1
				tempturf = testturf
	else if (T.oxygen < (MOLES_O2STANDARD/2))
		for (var/dir1 in list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST))
			testturf = get_step(T,dir1)
			if (testturf.oxygen > tempturf.oxygen)
				tempdir = dir1
				tempturf = testturf

	step(src,tempdir)



/mob/living/carbon/human/proc/ai_canmove_zombie()
	if(!istype(src.loc,/turf)) return 0
	var/speed = (5 * ai_move_zombiedelay)
	if (!ai_laststep_zombie) ai_laststep_zombie = (world.timeofday - 5)
	if ((world.timeofday - ai_laststep_zombie) >= speed) return 1
	else return 0

/mob/living/carbon/human/proc/ai_incapacitated_zombie()
	if(stat || stunned || paralysis || eye_blind || weakened) return 1
	else return 0

/mob/living/carbon/human/proc/ai_validpath_zombie()

	var/list/L = new/list()

	var/mob/living/target = ai_target_zombie

	if(!istype(src.loc,/turf)) return 0

	if(!target) return 0 //WTF

	L = getline(src,target)

	for (var/turf/T in L)
		if (T.density)
			ai_frustration_zombie += 3
			return 0
		for (var/obj/D in T)
			if (D.density && !istype(D, /obj/closet) && D.anchored)
				ai_frustration_zombie += 3
				return 0
			else if (istype(D, /obj/closet))
				if(D:opened == 0) return 0

	return 1

/mob/living/carbon/human/proc/ai_meleecheck_zombie() //Simple right now.
	var/targetturf = get_turf(ai_target_zombie)
	var/myturf = get_turf(src)

	if(!istype(src.loc,/turf)) return 0

	if(locate(/obj/machinery/door/window) in myturf)
		for (var/obj/machinery/door/window/W in myturf)
			if(!W.CheckExit(src,targetturf)) return 0

	if(locate(/obj/machinery/door/window) in targetturf)
		for (var/obj/machinery/door/window/W in targetturf)
			if(!W.CheckPass(src,targetturf)) return 0

	return 1



/mob/living/carbon/human/proc/ai_freeself_zombie()
	if(!istype(src.loc, /obj/closet)) return
	var/obj/closet/C = src.loc
	if (C.opened)
		C.close()
		sleep(-1)
		C.open()
	else
		C.open()

/mob/living/carbon/human/proc/ai_obstacle_zombie(var/doorsonly)

	var/acted = 0

	if(ai_incapacitated_zombie()) return
	var/obj/organ/limb/arms/improvising = new /obj/organ/limb/arms
	var/obj/item/weapon/card/emag/improvising2 = new /obj/item/weapon/card/emag
	if(src.r_hand && !doorsonly) //So they dont smash windows while wandering around.

		if((locate(/obj/window) in get_step(src,dir))  && !acted)
			var/obj/window/W = (locate(/obj/window) in get_step(src,dir))
			W.attackby(src.r_hand, src)
			acted = 1
		else if((locate(/obj/window) in get_turf(src.loc))  && !acted)
			var/obj/window/W = (locate(/obj/window) in get_turf(src.loc))
			W.attackby(src.r_hand, src)
			acted = 1

		if((locate(/obj/grille) in get_step(src,dir))  && !acted)
			var/obj/grille/G = (locate(/obj/grille) in get_step(src,dir))
			if(!G.destroyed)
				G.attackby(src.r_hand, src)
				acted = 1

	else if(!doorsonly) //So they dont smash windows while wandering around.

		if((locate(/obj/window) in get_step(src,dir))  && !acted)
			var/obj/window/W = (locate(/obj/window) in get_step(src,dir))
			W.attackby(improvising, src)
			acted = 1
		else if((locate(/obj/window) in get_turf(src.loc))  && !acted)
			var/obj/window/W = (locate(/obj/window) in get_turf(src.loc))
			W.attackby(improvising, src)
			acted = 1

		if((locate(/obj/grille) in get_step(src,dir))  && !acted)
			var/obj/grille/G = (locate(/obj/grille) in get_step(src,dir))
			if(!G.destroyed)
				G.attackby(improvising, src)
				acted = 1


	if((locate(/obj/machinery/door) in get_step(src,dir)))
		var/obj/machinery/door/W = (locate(/obj/machinery/door) in get_step(src,dir))
		if(W.density) W.attack_hand(src)
		sleep(4)
		if(W.density) W.attackby(improvising, src)
		if(W.density && prob(1)) W.attackby(improvising2, src)
	else if((locate(/obj/machinery/door) in get_turf(src.loc)))
		var/obj/machinery/door/W = (locate(/obj/machinery/door) in get_turf(src.loc))
		if(W.density) W.attack_hand(src)
		sleep(4)
		if(W.density) W.attackby(improvising, src)
		if(W.density && prob(1)) W.attackby(improvising2, src)
/mob/living/carbon/human/proc/ai_openclosets_zombie()
	if(ai_incapacitated_zombie()) return
	for(var/obj/closet/C in view(1,src)) C.open()
	for(var/obj/secure_closet/S in view(1,src))
		if(!S.opened && !S.locked) attack_hand(src)

*/


