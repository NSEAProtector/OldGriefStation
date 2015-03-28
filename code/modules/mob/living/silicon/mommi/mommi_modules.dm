/obj/item/weapon/robot_module/mommi
	name = "mobile mmi robot module"


	New()
		src.modules += new /obj/item/borg/sight/meson(src)
		src.emag = new /obj/item/borg/stun(src)
		src.emag = new /obj/item/weapon/gun/energy/laser/cyborg(src)
		//src.modules += new /obj/item/device/flashlight(src)   // Broken
		src.modules += new /obj/item/weapon/weldingtool/largetank(src)
//		src.modules += new /obj/item/weapon/screwdriver(src)
//		src.modules += new /obj/item/weapon/wrench(src)
//		src.modules += new /obj/item/weapon/crowbar(src)
//		src.modules += new /obj/item/weapon/wirecutters(src)
//		src.modules += new /obj/item/device/multitool(src)
		src.modules += new /obj/item/device/t_scanner(src)
		src.modules += new /obj/item/device/analyzer(src)
		src.modules += new /obj/item/weapon/extinguisher(src) // Space asshole
		src.modules += new /obj/item/weapon/pipe_dispenser(src)
		src.modules += new /obj/item/weapon/tile_painter(src)
		src.modules += new /obj/item/blueprints/mommiprints(src)
		src.modules += new /obj/item/weapon/rcd/borg(src)
		src.modules += new /obj/item/weapon/switchtool(src)
		src.modules += new /obj/item/weapon/extinguisher/foam(src)
		src.modules += new /obj/item/device/healthanalyzer(src)
		src.modules += new /obj/item/device/flash(src)
//		src.modules += new /obj/item/device/assembly/signaler(src)
//		src.modules += new /obj/item/device/assembly/igniter(src)
//		src.modules += new /obj/item/weapon/circuitboard/airlock(src)
//		src.modules += new /obj/item/weapon/module/power_control(src)
//		src.modules += new /obj/item/weapon/circuitboard/air_alarm(src)
//		src.modules += new /obj/item/weapon/cell/high(src)
//		src.modules += new /obj/item/device/assembly/prox_sensor(src)
//		src.modules += new /obj/item/device/assembly/voice(src)
//		src.modules += new /obj/item/device/assembly/speaker(src)
//		src.modules += new /obj/item/weapon/light/tube(src)
//		src.modules += new /obj/item/weapon/light/bulb(src)
		src.modules += new /obj/item/device/assembly/speaker/mommi(src)

		// Added this back in since it made the MoMMI practically useless for engineering stuff.
		var/obj/item/stack/sheet/metal/cyborg/M = new /obj/item/stack/sheet/metal/cyborg(src)
		M.amount = 50
		src.modules += M

		// It's really fun to make glass windows, break them, welder them and add rods to it to repair minor damage - No-one ever
		var/obj/item/stack/sheet/rglass/cyborg/R = new /obj/item/stack/sheet/rglass/cyborg(src)
		R.amount = 50
		src.modules += R

		var/obj/item/stack/sheet/glass/cyborg/G = new /obj/item/stack/sheet/glass/cyborg(src)
		G.amount = 50
		src.modules += G

		var/obj/item/weapon/cable_coil/W = new /obj/item/weapon/cable_coil(src)
		W.amount = 50
		W.max_amount = 50 // Override MAXCOIL
		src.modules += W

		var/obj/item/stack/rods/O = new /obj/item/stack/rods(src)
		O.amount = 50
		src.modules += O
/*
		var/obj/item/device/assembly/signaler/Q = new /obj/item/device/assembly/signaler(src)
		Q.amount = 10
		Q.max_amount = 10
		src.modules += Q

		var/obj/item/device/assembly/igniter/E = new /obj/item/device/assembly/igniter(src)
		E.amount = 10
		E.max_amount = 10
		src.modules += E

		var/obj/item/weapon/circuitboard/airlock/T = new /obj/item/weapon/circuitboard/airlock(src)
		T.amount = 10
		T.max_amount = 10
		src.modules += T

		var/obj/item/weapon/module/power_control/Y = new /obj/item/weapon/module/power_control(src)
		Y.amount = 10
		Y.max_amount = 10
		src.modules += Y

		var/obj/item/weapon/circuitboard/air_alarm/U =  new /obj/item/weapon/circuitboard/air_alarm(src)
		U.amount = 10
		U.max_amount = 10
		src.modules += U

		var/obj/item/weapon/cell/high/I = new /obj/item/weapon/cell/high(src)
		I.amount = 5
		I.max_amount = 5
		src.modules += I

		var/obj/item/device/assembly/voice/P = new /obj/item/device/assembly/voice(src)
		P.amount = 10
		P.max_amount = 10
		src.modules += P

		var/obj/item/device/assembly/speaker/A = new /obj/item/device/assembly/speaker(src)
		A.amount = 10
		A.max_amount = 10
		src.modules += A

		var/obj/item/weapon/light/tube/S = new /obj/item/weapon/light/tube(src)
		S.amount = 15
		S.max_amount = 15
		src.modules += S

		var/obj/item/weapon/light/bulb/F = new /obj/item/weapon/light/bulb(src)
		F.amount = 15
		F.max_amount = 15
		src.modules += F
*/
		return

	respawn_consumable(var/mob/living/silicon/robot/R)
		var/list/what = list (
			/obj/item/stack/sheet/metal/cyborg,
			/obj/item/stack/sheet/glass,
			/obj/item/weapon/cable_coil,
			/obj/item/stack/sheet/rglass/cyborg,
			/obj/item/stack/rods,
		)
		for (var/T in what)
			if (!(locate(T) in src.modules))
				src.modules -= null
				var/O = new T(src)
				if(istype(O,/obj/item/weapon/cable_coil))
					O:max_amount = 50
				src.modules += O
				O:amount = 1
		return