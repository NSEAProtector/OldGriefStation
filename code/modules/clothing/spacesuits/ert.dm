/*
/obj/item/clothing/head/helmet/space/rig/ert
	name = "emergency response team helmet"
	desc = "A helmet worn by members of the NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "helm-command"
	armor = list(melee = 50, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 60)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	var/obj/machinery/camera/camera
	species_restricted = list("exclude","Vox")
/obj/item/clothing/head/helmet/space/rig/ert/attack_self(mob/user)
	if(camera)
		..(user)
	else
		camera = new /obj/machinery/camera(src)
		camera.network = list("ERT")
		cameranet.removeCamera(camera)
		camera.c_tag = user.name
		user << "\blue User scanned as [camera.c_tag]. Camera activated."

/obj/item/clothing/head/helmet/space/rig/ert/examine()
	..()
	if(get_dist(usr,src) <= 1)
		usr << "This helmet has a built-in camera. It's [camera ? "" : "in"]active."

/obj/item/clothing/head/helmet/space/rig/ert
	name = "emergency response team suit"
	desc = "A suit worn by members of the NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "suit-command"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_storage,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/tank/emergency_nitrogen)
	slowdown = 1
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 60)
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank, /obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/crowbar, \
	/obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool, /obj/item/weapon/wirecutters, /obj/item/weapon/wrench, /obj/item/device/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer, /obj/item/weapon/gun/energy/laser, /obj/item/weapon/gun/energy/pulse_rifle, \
	/obj/item/weapon/gun/energy/taser, /obj/item/weapon/melee/baton, /obj/item/weapon/gun/energy/gun)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE
	species_restricted = list("exclude","Vox")
------------------------Ak72ti ert fix V*/
/obj/item/clothing/head/helmet/space/rig/ert
	name = "emergency response team helmet"
	desc = "A helmet worn by members of the NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "rig0-ert_admin"
	item_state = "helm-command"
	_color = "ert_admin"
	armor = list(melee = 60, bullet = 60, laser = 40,energy = 15, bomb = 30, bio = 100, rad = 60)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	species_restricted = list("exclude","Vox")

	var/cam_mod = 0
	var/obj/machinery/camera/camera

/obj/item/clothing/head/helmet/space/rig/ert/attack_self(mob/user)
	if(cam_mod)
		if(camera)
			..(user)
		else
			camera = new /obj/machinery/camera(src)
			camera.network = list("ERT")
			cameranet.removeCamera(camera)
			camera.c_tag = user.name
			user << "\blue User scanned as [camera.c_tag]. Camera activated."

/obj/item/clothing/head/helmet/space/rig/ert/examine()
	..()
	if(get_dist(usr,src) <= 1)
		usr << "This helmet has a built-in camera. It's [camera ? "" : "in"]active."

/obj/item/clothing/suit/space/rig/ert
	name = "emergency response team suit"
	desc = "A suit worn by members of the NanoTrasen Emaergency Response Team. Armoured, space ready, and fire resistant."
	icon_state = "ert_commander"
	item_state = "suit-command"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_storage,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)
	slowdown = 0.4
	armor = list(melee = 70, bullet = 60, laser = 40,energy = 15, bomb = 30, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank, /obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/crowbar, \
	/obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool, /obj/item/weapon/wirecutters, /obj/item/weapon/wrench, /obj/item/device/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer)
	siemens_coefficient = 0.6


//Commander
/obj/item/clothing/head/helmet/space/rig/ert/commander
	name = "emergency response team commander helmet"
	desc = "A helmet worn by the commander of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "rig0-ert_commander"
	_color = "ert_commander"
	species_restricted = list("exclude","Vox")
	cam_mod = 1

/obj/item/clothing/suit/space/rig/ert/commander
	name = "emergency response team commander suit"
	desc = "A suit worn by the commander of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"

//Security
/obj/item/clothing/head/helmet/space/rig/ert/security
	name = "emergency response team security helmet"
	desc = "A helmet worn by the security members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "rig0-ert_security"
	_color = "ert_security"
	item_state = "syndicate-helm-black-red"
	species_restricted = list("exclude","Vox")

/obj/item/clothing/suit/space/rig/ert/security
	name = "emergency response team security suit"
	desc = "A suit worn by the security members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_security"

//Engineer
/obj/item/clothing/head/helmet/space/rig/ert/engineer
	name = "emergency response team engineer helmet"
	desc = "A helmet worn by the engineering members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "rig0-ert_engineer"
	_color = "ert_engineer"
	species_restricted = list("exclude","Vox")

/obj/item/clothing/suit/space/rig/ert/engineer
	name = "emergency response team engineer suit"
	desc = "A suit worn by the engineering members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_engineer"

//Medical
/obj/item/clothing/head/helmet/space/rig/ert/medical
	name = "emergency response team medical helmet"
	desc = "A helmet worn by the medical members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "rig0-ert_medical"
	_color = "ert_medical"
	species_restricted = list("exclude","Vox")

/obj/item/clothing/suit/space/rig/ert/medical
	name = "emergency response team medical suit"
	desc = "A suit worn by the medical members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_medical"