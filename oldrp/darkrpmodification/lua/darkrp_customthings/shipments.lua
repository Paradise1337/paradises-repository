--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]

AddCustomShipment('.338 AI AWM', {
	model = 'models/weapons/w_snip_awp.mdl',
	entity = 'weapon_mad_awm',
	price = 25000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('.45 HK UMP-45', {
	model = 'models/weapons/w_smg_ump45.mdl',
	entity = 'weapon_mad_ump',
	price = 13000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('.45 HK USP', {
	model = 'models/weapons/w_pist_usp.mdl',
	entity = 'weapon_mad_usp',
	price = 7000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('.50 DESERT EAGLE', {
	model = 'models/weapons/w_pist_deagle.mdl',
	entity = 'weapon_mad_deagle',
	price = 10000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('4.6MM HK MP7A1', {
	model = 'models/weapons/w_smg1.mdl',
	entity = 'weapon_mad_mp7',
	price = 14000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('5.56MM FAMAS F1', {
	model = 'models/weapons/w_rif_famas.mdl',
	entity = 'weapon_mad_famas',
	price = 15000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('5.56MM M249 SAW', {
	model = 'models/weapons/w_mach_m249para.mdl',
	entity = 'weapon_mad_m249',
	price = 30000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('5.56X39MM STEYR AUG A1', {
	model = 'models/weapons/w_rif_aug.mdl',
	entity = 'weapon_mad_aug',
	price = 17000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('5.56X45 M4A1', {
	model = 'models/weapons/w_rif_m4a1.mdl',
	entity = 'weapon_mad_m4',
	price = 20000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('5.7MM FN P90', {
	model = 'models/weapons/w_smg_p90.mdl',
	entity = 'weapon_mad_p90',
	price = 15000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('7.62MM AK-47', {
	model = 'models/weapons/w_rif_ak47.mdl',
	entity = 'weapon_mad_ak47',
	price = 20000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('7.62MM STEYR SCOUT SNIPER', {
	model = 'models/weapons/w_snip_scout.mdl',
	entity = 'weapon_mad_scout',
	price = 14000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('7.62MM HK G3SG1 SNIPER', {
	model = 'models/weapons/w_snip_g3sg1.mdl',
	entity = 'weapon_mad_g3',
	price = 16000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('9MM AUTOMATIC GLOCK 18', {
	model = 'models/weapons/w_pist_glock18.mdl',
	entity = 'weapon_mad_auto_glock',
	price = 11000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('9MM HK MP-5A5', {
	model = 'models/weapons/w_smg_mp5.mdl',
	entity = 'weapon_mad_mp5',
	price = 13000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('9MM HK USP MATCH', {
	model = 'models/weapons/w_pistol.mdl',
	entity = 'weapon_mad_usp_match',
	price = 8000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('AR-2 PULSE-RIFLE', {
	model = 'models/weapons/w_irifle.mdl',
	entity = 'weapon_mad_ar2',
	price = 24000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('BENELLI M4 SUPER 90', {
	model = 'models/weapons/w_shot_xm1014.mdl',
	entity = 'weapon_mad_xm1014',
	price = 20000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('BENELLI M3 SUPER 90', {
	model = 'models/weapons/w_shot_m3super90.mdl',
	entity = 'weapon_mad_m3',
	price = 21000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_GUN},
})

AddCustomShipment('EXPLOSIVE C4', {
	model = 'models/weapons/w_c4.mdl',
	entity = 'weapon_mad_c4',
	price = 400000,
	amount = 1,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('HUNTING CROSSBOW', {
	model = 'models/weapons/w_crossbow.mdl',
	entity = 'weapon_mad_crossbow',
	price = 3000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('KNIFE', {
	model = 'models/weapons/w_knife_t.mdl',
	entity = 'weapon_mad_knife',
	price = 7000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD, TEAM_GUN, TEAM_MOBS},
})

AddCustomShipment('4.6MM HK MP7A1', {
	model = 'models/weapons/w_smg1.mdl',
	entity = 'weapon_mad_mp7',
	price = 13000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

AddCustomShipment('Отмычка', {
	model = 'models/weapons/w_crowbar.mdl',
	entity = 'lockpick',
	price = 5000,
	amount = 5,
	seperate = false,
	pricesep = 200,
	noship = false,
	allowed = {TEAM_BMD},
})

