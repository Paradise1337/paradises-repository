--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

Add entities under the following line:
---------------------------------------------------------------------------]]

DarkRP.createEntity("Микроволновка", {
		ent = "microwave",
		model = "models/props/cs_office/microwave.mdl",
		price = 400,
		max = 1,
		cmd = "buymicrowaveup",
		allowed = TEAM_COOK
})

DarkRP.createEntity("Улучшаемый Денежный Принтер", {
        ent = "adv_money_printer",
        model = "models/props_c17/consolebox01a.mdl",
        price = 2000, -- Change this number to change the price of the printer In-Game ;p
        max = 2,
        cmd = "/buyupgrademoneyprinter"
})
 
 

DarkRP.createEntity("Гриб", {
	ent = "durgz_mushroom",
	model = "models/ipha/mushroom_small.mdl",
	price = 1500,
	max = 1,
	cmd = "buymushroom",
	allowed = TEAM_DRUG
})

DarkRP.createEntity("Аспирин", {
	ent = "durgz_aspirin",
	model = "models/jaanus/aspbtl.mdl",
	price = 500,
	max = 1,
	cmd = "buyaspirin",
	allowed = TEAM_DRUG
})



DarkRP.createEntity("Сигареты", {
	ent = "durgz_cigarette",
	model = "models/boxopencigshib.mdl",
	price = 300,
	max = 1,
	cmd = "buycigarette",
	allowed = TEAM_DRUG
})



DarkRP.createEntity("Кокаин", {
	ent = "durgz_cocaine",
	model = "models/cocn.mdl",
	price = 10000,
	max = 1,
	cmd = "buycocaine",
	allowed = TEAM_BLACK
})



DarkRP.createEntity("Героин", {
	ent = "durgz_heroine",
	model = "models/katharsmodels/syringe_out/syringe_out.mdl",
	price = 1000,
	max = 1,
	cmd = "buyheroine",
	allowed = TEAM_DRUG
})




DarkRP.createEntity("Лсд", {
	ent = "durgz_lsd",
	model = "models/smile/smile.mdl",
	price = 1200,
	max = 1,
	cmd = "buylsd",
	allowed = TEAM_DRUG
})



DarkRP.createEntity("Марихуана", {
	ent = "durgz_weed",
	model = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
	price = 1100,
	max = 1,
	cmd = "buyweed",
	allowed = TEAM_DRUG
})


DarkRP.createEntity("П.К.П", {
	ent = "durgz_pcp",
	model = "models/marioragdoll/super mario galaxy/star/star.mdl",
	price = 700,
	max = 1,
	cmd = "buypcp",
	allowed = TEAM_DRUG
})

