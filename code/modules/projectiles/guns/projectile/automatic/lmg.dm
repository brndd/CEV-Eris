/obj/item/weapon/gun/projectile/automatic/lmg
	name = "L6 SAW"
	desc = "A rather traditionally made L6 SAW with a pleasantly lacquered wooden pistol grip. This one is unmarked."
	icon = 'icons/obj/guns/projectile/l6.dmi'
	var/icon_base
	icon_base = "l6"
	icon_state = "l6closed-empty"
	item_state = "l6closedmag"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	slot_flags = 0
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	mag_well = MAG_WELL_BOX
	magazine_type = /obj/item/ammo_magazine/a762
	tac_reloads = FALSE
	matter = list(MATERIAL_PLASTEEL = 40, MATERIAL_PLASTIC = 15, MATERIAL_WOOD = 5)
	price_tag = 5000
	unload_sound 	= 'sound/weapons/guns/interact/lmg_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/lmg_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/lmg_cock.ogg'
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	recoil_buildup = 0.3 //machinegun level

	firemodes = list(
		FULL_AUTO_600,
		BURST_5_ROUND,
		BURST_8_ROUND
		)

	var/cover_open = 0

/obj/item/weapon/gun/projectile/automatic/lmg/special_check(mob/user)
	if(cover_open)
		to_chat(user, SPAN_WARNING("[src]'s cover is open! Close it before firing!"))
		return 0
	return ..()

/obj/item/weapon/gun/projectile/automatic/lmg/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	to_chat(user, SPAN_NOTICE("You [cover_open ? "open" : "close"] [src]'s cover."))
	update_icon()

/obj/item/weapon/gun/projectile/automatic/lmg/attack_self(mob/user as mob)
	if(cover_open)
		toggle_cover(user) //close the cover
		playsound(src.loc, 'sound/weapons/guns/interact/lmg_close.ogg', 100, 1)
	else
		return ..() //once closed, behave like normal

/obj/item/weapon/gun/projectile/automatic/lmg/attack_hand(mob/user as mob)
	if(!cover_open && user.get_inactive_hand() == src)
		toggle_cover(user) //open the cover
		playsound(src.loc, 'sound/weapons/guns/interact/lmg_open.ogg', 100, 1)
	else
		return ..() //once open, behave like normal

/obj/item/weapon/gun/projectile/automatic/lmg/equipped(var/mob/user, var/slot)
	.=..()
	update_icon()

/obj/item/weapon/gun/projectile/automatic/lmg/update_icon()
	icon_state = "[icon_base][cover_open ? "open" : "closed"][ammo_magazine ? round(ammo_magazine.stored_ammo.len, 25) : "-empty"]"
	set_item_state("-[cover_open ? "open" : null][ammo_magazine ?"mag":"nomag"]", hands = TRUE)
	set_item_state("-[ammo_magazine ?"mag":"nomag"]", back = TRUE)
	update_wear_icon()

/obj/item/weapon/gun/projectile/automatic/lmg/load_ammo(var/obj/item/A, mob/user)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("You need to open the cover to load [src]."))
		return
	..()

/obj/item/weapon/gun/projectile/automatic/lmg/unload_ammo(mob/user, var/allow_dump=1)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("You need to open the cover to unload [src]."))
		return
	..()


/obj/item/weapon/gun/projectile/automatic/lmg/pk
	name = "Pulemyot Kalashnikova"
	desc = "\"Kalashnikov's Machinegun\", a well preserved and maintained antique weapon of war."
	icon = 'icons/obj/guns/projectile/pk.dmi'
	icon_base = "pk"
	icon_state = "pkclosed-empty"
	item_state = "pkclosedmag"

/obj/item/weapon/gun/projectile/automatic/lmg/pk/update_icon()
	icon_state = "[icon_base][cover_open ? "open" : "closed"][ammo_magazine ? round(ammo_magazine.stored_ammo.len, 25) : "-empty"]"
	set_item_state(ammo_magazine ? null : "-empty")
	update_wear_icon()
