/obj/item/weapon/weapon_module/silencer
    name = "silencer"
    desc = "Konata Co. Brand Silencer"
    icon = null // YOUR SPRITE HERE
    icon_state = "silencer"
    weapon_icon_state = "silencer"
    draw_priority = 10

    AttachCheck(var/obj/item/weapon/gun/Gun)
        if(istype(Gun, /obj/item/weapon/gun/projectile/))
            if(istype(Gun, /obj/item/weapon/gun/projectile/shotgun) || istype(Gun, /obj/item/weapon/gun/projectile/silenced) || istype(Gun, /obj/item/weapon/gun/projectile/gyropistol))
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
        if(istype(src.loc, /obj/item/weapon/gun/projectile/))
            src.loc:silenced = 0
        return