/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	var/embed = 1

	on_hit(var/atom/target, var/blocked = 0)
		if (..(target, blocked))
			var/mob/living/L = target
			shake_camera(L, 3, 2)
			return 1
		return 0

/obj/item/projectile/bullet/weakbullet
	icon_state = "bbshell"
	damage = 10
	stun = 5
	weaken = 5
	embed = 0
/obj/item/projectile/bullet/weakbullet/booze
	on_hit(var/atom/target, var/blocked = 0)
		if(..(target, blocked))
			var/mob/living/M = target
			M.dizziness += 20
			M:slurring += 20
			M.confused += 20
			M.eye_blurry += 20
			M.drowsyness += 20
			if(M.dizziness <= 150)
				M.make_dizzy(150)
				M.dizziness = 150
			for(var/datum/reagent/ethanol/A in M.reagents.reagent_list)
				M.paralysis += 2
				M.dizziness += 10
				M:slurring += 10
				M.confused += 10
				M.eye_blurry += 10
				M.drowsyness += 10
				A.volume += 5 //Because we can
				M.dizziness += 10
			return 1
		return 0

/obj/item/projectile/bullet/midbullet //12mm
	damage = 15
	stun = 2
	weaken = 2

/obj/item/projectile/bullet/midbullet2 //7 62
	damage = 25

/obj/item/projectile/bullet/midbulleta //0.50s
	damage = 35

/obj/item/projectile/bullet/midbullet3 //5 56
	damage = 20

/obj/item/projectile/bullet/suffocationbullet//How does this even work?
	name = "co bullet"
	damage = 20
	damage_type = OXY

/obj/item/projectile/bullet/cyanideround
	name = "poison bullet"
	damage = 40
	damage_type = TOX

/obj/item/projectile/bullet/explodingshot//I think this one needs something for the on hit
	name = "exploding bullet"
	damage = 30

	on_hit(var/atom/target, var/blocked = 0)
		explosion(target, -1, 0, 2)
		return 1

/obj/item/projectile/bullet/stunshot
	name = "stunshot"
	icon_state = "sshell"
	damage = 5
	stun = 10
	weaken = 10
	stutter = 10

/obj/item/projectile/bullet/a762
	damage = 30

/obj/item/projectile/bullet/a556
	damage = 20
	stutter = 10

/obj/item/projectile/bullet/c50
	name = "A .50AE bullet"
	damage = 60