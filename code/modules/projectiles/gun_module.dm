/obj/item/weapon/weapon_module
	name = "weapon module"
	desc = "unknown impossible shit"
	icon = null
	icon_state = ""
	var/weapon_icon_state = "" // ������ ������ �� ������
	var/connect_error_reason = "" // ���, �� ��������� ������������/����������� ����, �� � �������, ������� ��� � ����.

	var/middle_click_hook = 0

	var/draw_priority = 0 // ��������� ���������

	proc/AttachCheck(var/obj/item/weapon/gun/Gun)
		// ���������� ��������, �� ������ ����������� ������������ ������
		return 1

	proc/DetachCheck()
		// �������� ����������� ����� ��� ������. � ������ ��������� ��� src.loc.
		return 1

	proc/Attach(var/obj/item/weapon/gun/Gun)
		// DO YOUR SHITTY MAGIC HERE
		return

	proc/Detach()
		// � ������ ������ �� �����. � ������ ��������� ��� src.loc.
		return

	proc/middle_click_proc(var/atom/A)
		// ���+Ctrl ����� ���� �����
		return

/obj/item/weapon/gun/proc/sort_modules()
	var/list/temp = list()
	while(modules.len)
		var/obj/item/weapon/weapon_module/min = modules[1]
		for(var/obj/item/weapon/weapon_module/M in modules)
			if(M.draw_priority < min.draw_priority)
				min = M
		temp += min
		modules -= min
	modules = temp
		return

//////////////////////////////////////////////������ �� �����.. �� ��� ��� �� ���..\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/*
/obj/item/weapon/weapon_module/tacsilencer
	name = "Tactical silencer"
	desc = "Konata Co. Brand Silencer"
	icon = null // YOUR SPRITE HERE
	icon_state = "silencer"
	weapon_icon_state = "silencer"
	draw_priority = 10

	AttachCheck(var/obj/item/weapon/gun/Gun)
		if(istype(Gun, /obj/item/weapon/gun/projectile/))
			if(istype(Gun, /obj/item/weapon/gun/projectile/shotgun))
				connect_error_reason = "how you can attach [src] to [Gun]?"
				return 0
			return 1
		else
			connect_error_reason = "how you can attach [src] to [Gun]?"
			return 0

	DetachCheck()
		return 1

	Attach(var/obj/item/weapon/gun/Gun)
		Gun.silenced = 1
		return

	Detach()
		if(istype(src.loc, /obj/item/weapon/gun/projectile/)) // На всякий случай
			src.loc:silenced = 0
		return

/obj/item/weapon/weapon_module/Ammo556test
	name = "5.56ammo magasine"
	desc = "Konata Co. Tactical ammo supply"
	icon = null // YOUR SPRITE HERE
	icon_state = "grenatea"
	weapon_icon_state = "ammoa"
	draw_priority = 8

	AttachCheck(var/obj/item/weapon/gun/Gun)
		if(istype(Gun, /obj/item/weapon/gun/projectile/))
			if(istype(Gun, /obj/item/weapon/gun/projectile/automatic/k4m))
				connect_error_reason = "how you can attach [src] to [Gun]?"
				return 0
			return 1
		else
			connect_error_reason = "how you can attach [src] to [Gun]?"
			return 0

	DetachCheck()
		return 1

	Attach(var/obj/item/weapon/gun/Gun)
		return

	Detach()
		if(istype(src.loc, /obj/item/weapon/gun/projectile/))
		return
*/