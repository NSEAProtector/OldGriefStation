//Magazines are loaded directly into weapons
//Unlike boxes, they have no fumbling. Simply loading a magazine is instant

/obj/item/ammo_storage/magazine
	desc = "A magazine capable of holding bullets. Can be loaded into certain weapons."
	exact = 1 //we only load the thing we want to load

/obj/item/ammo_storage/magazine/mc9mm
	name = "magazine (9mm)"
	icon_state = "9x19p"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	max_ammo = 8
	sprite_modulo = 8
	multiple_sprites = 1

/obj/item/ammo_storage/magazine/mc9mm/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/a12mm
	name = "magazine (12mm)"
	icon_state = "12mm"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	max_ammo = 20
	m_amt = 3000
	multiple_sprites = 1
	sprite_modulo = 2


/obj/item/ammo_storage/magazine/a12mm/empty
	starting_ammo = 0
	m_amt = 500

/obj/item/ammo_storage/magazine/smg9mm
	name = "magazine (9mm)"
	icon_state = "smg9mm"
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	max_ammo = 18
	sprite_modulo = 3
	multiple_sprites = 1

/obj/item/ammo_storage/magazine/a50
	name = "magazine (.50)"
	icon_state = "50ae"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a50"
	max_ammo = 7
	m_amt = 1000
	multiple_sprites = 1
	sprite_modulo = 1

/obj/item/ammo_storage/magazine/a50/empty
	starting_ammo = 0
	m_amt = 200

/obj/item/ammo_storage/magazine/a75
	name = "magazine (.75)"
	icon_state = "75"
	ammo_type = "/obj/item/ammo_casing/a75"
	multiple_sprites = 1
	m_amt = 7000
	max_ammo = 8
	sprite_modulo = 8

/obj/item/ammo_storage/magazine/a75/empty
	starting_ammo = 0
	m_amt = 1000

/obj/item/ammo_storage/magazine/a762
	name = "magazine (a762)"
	icon_state = "a762"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a762"
	m_amt = 15000
	max_ammo = 50
	multiple_sprites = 1
	sprite_modulo = 10

/obj/item/ammo_storage/magazine/a762/empty
	starting_ammo = 0
	m_amt = 3000

/obj/item/ammo_storage/magazine/c45
	name = "magazine (.45)-lethal"
	icon_state = "45"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c45"
	m_amt = 1500
	max_ammo = 8
	multiple_sprites = 1
	sprite_modulo = 1

/obj/item/ammo_storage/magazine/c45/rubber
	name = "magazine (.45)"
	icon_state = "45"
	origin_tech = "combat=1"
	ammo_type = "/obj/item/ammo_casing/c45/rubber"
	m_amt = 1000
	max_ammo = 8
	multiple_sprites = 1
	sprite_modulo = 1

/obj/item/ammo_storage/magazine/uzi45
	name = "magazine (.45)"
	icon_state = "uzi45"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c45"
	max_ammo = 16
	multiple_sprites = 1
	sprite_modulo = 2


/obj/item/ammo_storage/magazine/c9mmp
	name = "magazine (9mm parabellum)"
	icon_state = "9x18p-60"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c9mmp"
	m_amt = 5000
	max_ammo = 30

/obj/item/ammo_storage/magazine/c9mmp/empty //twin ammo mags
	name = "magazine (9mm parabellum)"
	icon_state = "9x18p-30"
	ammo_type = "/obj/item/ammo_casing/c9mmp"
	m_amt = 2700
	max_ammo = 30

/obj/item/ammo_storage/magazine/c9mmp/empty/empty
	name = "magazines,(9mm parabellum) empry"
	starting_ammo = 0
	icon_state = "9x18p-0"
	m_amt = 200

/obj/item/ammo_storage/magazine/a556
	name = "magazine (5.56)"
	icon_state = "5.56"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a556"
	m_amt = 2500
	max_ammo = 30

/obj/item/ammo_storage/magazine/a556/empty
	starting_ammo = 0
	m_amt = 400

/obj/item/ammo_storage/magazine/a127s
	name = "magazine (12.7)"
	icon_state = "0.50s"
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/a127s"
	m_amt = 2000
	max_ammo = 15

/obj/item/ammo_storage/magazine/a127s/empty
	starting_ammo = 0
	m_amt = 500
