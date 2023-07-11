/datum/species/moth
	name = "\improper Mothman"
	plural_form = "Mothmen"
	id = SPECIES_MOTH
	species_traits = list(
		LIPS,
		HAS_MARKINGS,
		HAIR,
		FACEHAIR,
	)
	inherent_traits = list(
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_TACKLING_WINGED_ATTACKER,
		TRAIT_ANTENNAE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list("moth_markings" = "None")
	// external_organs = list(/obj/item/organ/external/wings/moth = "Plain", /obj/item/organ/external/antennae = "Plain") // SKYRAT EDIT - Fixing moths
	meat = /obj/item/food/meat/slab/human/mutant/moth
	liked_food = VEGETABLES | DAIRY | CLOTH
	disliked_food = FRUIT | GROSS | BUGS | GORE
	toxic_food = MEAT | RAW | SEAFOOD
	mutanttongue = /obj/item/organ/internal/tongue/moth
	mutanteyes = /obj/item/organ/internal/eyes/moth
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/moth
	wing_types = list(/obj/item/organ/external/wings/functional/moth/megamoth, /obj/item/organ/external/wings/functional/moth/mothra)
	payday_modifier = 0.75
	family_heirlooms = list(/obj/item/flashlight/lantern/heirloom_moth)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/moth,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/moth,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/moth,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/moth,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/moth,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/moth,
	)

/datum/species/moth/regenerate_organs(mob/living/carbon/C, datum/species/old_species, replace_current= TRUE, list/excluded_zones, visual_only)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		handle_mutant_bodyparts(H)

/datum/species/moth/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_moth_name()

	var/randname = moth_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/moth/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, delta_time, times_fired)
	. = ..()
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3 * REAGENTS_EFFECT_MULTIPLIER * delta_time)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * delta_time)

/datum/species/moth/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/melee/flyswatter))
		return 10 //flyswatters deal 10x damage to moths
	return 1


/datum/species/moth/randomize_features(mob/living/carbon/human/human_mob)
	human_mob.dna.features["moth_markings"] = pick(GLOB.moth_wings_list)
	randomize_external_organs(human_mob)

/datum/species/moth/get_scream_sound(mob/living/carbon/human/human)
	return 'sound/voice/moth/scream_moth.ogg'

/datum/species/moth/get_species_description()
	return "The Fluffy and loving moths are known for their big, colorful wings, \
	their beautiful smiles and their adorable squeaks. But don't let these traits fool you, \
	these moths are cunning and almsot certainly evil."

/datum/species/moth/get_species_lore()
	return list(
		"Lore written by Mef",

		"Eons ago, the moths lost their homeworld to some event unknown to them in the current age. \
		Their exodus left them on what's called the Grand Nomadic Fleet, hosting the majority of the universe's moth populations. \
		It was estimated by many historians that the Moths called the Grand Nomadic Fleet their permanent home for about 400 years, \
		bringing up the question, \"What happened to their homeworld that was so cataclysmic that none know about it to this day?\".",

		"In recent years, though, the stability of the Grand Nomadic Fleet has been taken into question, \
		with multiple fragments flying around with their own goals and ideals, though the original fleet remains the largest. \
		One of the most dividing issues for the Nomad Fleet was when they scouted a planet that piqued their interest, \
		a dwarf planet orbiting far from its sun. The planet is dark and covered with sparce vegetation aside from Mushrooms and Fungi, \
		which dominate the planet's environment with massive Mushroom trees and many bioluminescent vegetation and insects. \
		The planet has earned the name \"Motmaviitraklenestekomo\", or Moffenelle for none-moths.",

		"The settling of this planet has called for much concern within the fleet, as the planet is simply too small to support the bulk of the Fleet, \
		leaving a cloud of ships orbitting the planet while esteemed and upper-class moths live on the planet during its colonisation. \
		It's estimated by sociologists that the planet could support about 41% of the current Fleet, excluding the schisms of the Fleet, \
		so approximately 37% of the entire Mothic Population aboard Nomadic Fleets.",
	)

/datum/species/moth/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "feather-alt",
			SPECIES_PERK_NAME = "Precious Wings",
			SPECIES_PERK_DESC = "Moths can fly in pressurized, zero-g environments and safely land short falls using their wings.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "tshirt",
			SPECIES_PERK_NAME = "Meal Plan",
			SPECIES_PERK_DESC = "Moths can eat clothes for nourishment.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Ablazed Wings",
			SPECIES_PERK_DESC = "Moth wings are fragile, and can be easily burnt off.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "Bright Lights",
			SPECIES_PERK_DESC = "Moths need an extra layer of flash protection to protect \
				themselves, such as against security officers or when welding. Welding \
				masks will work.",
		),
	)

	return to_add
