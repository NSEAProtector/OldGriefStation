/////////////////////////////////////
/////////////GUN PARTS///////////////
/////////////////////////////////////
/*Contains:
 - Silencer
 - Scope
*/
/obj/item/gun_part
	icon = 'icons/obj/guns/gun.dmi'
	w_class = 2

/obj/item/gun_part/silencer
	name = "silencer"
	icon_state = "silencer"
	desc = "a silencer, can be attached on tactical pistols"
	origin_tech = "material=1;combat=1"
	m_amt = 500

/obj/item/gun_part/scope
	name = "scope"
	icon_state = "scope"
	desc = "basic scope, used on sniper rifles, rifles, tactical SMG."
	origin_tech = "material=1;combat=1"
	m_amt = 200
	g_amt = 100
