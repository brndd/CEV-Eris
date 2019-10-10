/obj/item/organ_module/armor
	name = "subdermal armor"

/obj/item/organ_module/armor/passive
	name = "subdermal armor"
	desc = "A set of subdermal steel plates, designed to provide additional impact protection while remaining lightweight."
	allowed_organs = list(BP_CHEST)
	icon_state = "armor-chest"

/obj/item/organ_module/armor/passive/onInstall(obj/item/organ/external/E)
	E.brute_mod -= 0.3

/obj/item/organ_module/armor/passive/onRemove(obj/item/organ/external/E)
	E.brute_mod += 0.3


/obj/item/organ_module/armor/liquid
	name = "Aper armor"
	allowed_organs = list()		//can't be directly installed






