--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]

TEAM_CITIZEN = DarkRP.createJob("Мирный житель", {
	color = Color(20, 150, 20, 255),
	model = {
		"models/player/Group01/Female_01.mdl",
		"models/player/Group01/Female_02.mdl",
		"models/player/Group01/Female_03.mdl",
		"models/player/Group01/Female_04.mdl",
		"models/player/Group01/Female_06.mdl",
		"models/player/group01/male_01.mdl",
		"models/player/Group01/Male_02.mdl",
		"models/player/Group01/male_03.mdl",
		"models/player/Group01/Male_04.mdl",
		"models/player/Group01/Male_05.mdl",
		"models/player/Group01/Male_06.mdl",
		"models/player/Group01/Male_07.mdl",
		"models/player/Group01/Male_08.mdl",
		"models/player/Group01/Male_09.mdl"
	},
	description = [[Вы - гражданин. У вас нет конкретной задачи или специальной цели. Вы можете купить дом и жить мирной жизнью! Гражданин может устроиться на работу к Бизнесмену.]],
	weapons = {"weapon_fists"},
	command = "citizen",
	max = 0,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false
})

TEAM_POLICE = DarkRP.createJob("Гражданская Оборона", {
	color = Color(25, 25, 170, 255),
	model = {"models/player/police.mdl", "models/player/police_fem.mdl"},
	description = [[Вы - полицейский. Ваша обязанность - сохранять этот город в порядке от нарушителей. Вы подчиняетесь Шефу Полиции > Мэру.]],
	weapons = {"arrest_stick", "unarrest_stick", "weapon_mad_usp_match", "stunstick", "door_ram", "weaponchecker", "weapon_fists"},
	command = "cp",
	max = 4,
	salary = 300,
	admin = 0,
	vote = true,
	hasLicense = true,
	ammo = {
		["pistol"] = 60,
	}
})

TEAM_CHIEF = DarkRP.createJob("Шеф Гр. Обороны", {
	color = Color(20, 20, 255, 255),
	model = "models/player/combine_soldier_prisonguard.mdl",
	description = [[Вы - Шеф Полиции. Ваша задача управлять полицейскими и выдовать им указания. Вы можете выдавать лицензии. Вы подчиняетесь Мэру.]],
	weapons = {"arrest_stick", "weapon_mad_m3", "weapon_mad_p90", "unarrest_stick", "weapon_mad_357", "stunstick", "door_ram", "weaponchecker", "weapon_fists"},
	command = "chief",
	max = 1,
	salary = 350,
	admin = 0,
	vote = false,
	hasLicense = true,
	chief = true,
	NeedToChangeFrom = TEAM_POLICE,
	ammo = {
		["pistol"] = 60,
	}
})

TEAM_SAPER = DarkRP.createJob("Сапер", {
	color = Color(25, 25, 170, 255),
	model = {"models/player/swat.mdl"},
	description = [[Вы - сапер. Ваша обязанность - сохранять этот город от взрывов. Вы подчиняетесь Шефу Полиции > Мэру.]],
	weapons = {"arrest_stick", "unarrest_stick", "weapon_glock2", "stunstick", "door_ram", "weaponchecker", "weapon_fists", "weapon_defuserc4"},
	command = "saper",
	max = 2,
	salary = 325,
	admin = 0,
	vote = true,
	hasLicense = true,
	ammo = {
		["pistol"] = 60,
	}
})

TEAM_MAYOR = DarkRP.createJob("Мэр", {
	color = Color(150, 20, 20, 255),
	model = "models/player/breen.mdl",
	description = [[Вы - Мэр. Вы управляете этим городом, издаете законы. Можете продовать лицензии на ношение оружия. В чрезвычайных ситуациях можете устроить комендантский час.]],
	weapons = {"weapon_fists"},
	command = "mayor",
	max = 1,
	salary = 400,
	admin = 0,
	vote = true,
	hasLicense = false,
	mayor = true
})

TEAM_COOK = DarkRP.createJob("Повар", {
	color = Color(238, 99, 99, 255),
	model = "models/player/mossman.mdl",
	description = [[Вы повар, кормите голодающих.]],
	weapons = {"weapon_fists"},
	command = "cook",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	cook = true
})

TEAM_GUN = DarkRP.createJob("Оружейник", {
	color = Color(255, 140, 0, 255),
	model = "models/player/monk.mdl",
	description = [[Вы - Продавец Оружия. Вы продаете оружие от пистолетов до снайперских винтовок!]],
	weapons = {"weapon_fists"},
	command = "gundealer",
	max = 2,
	salary = 250,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_MEDIC = DarkRP.createJob("Доктор", {
	color = Color(47, 79, 79, 255),
	model = "models/player/kleiner.mdl",
	description = [[Вы - Доктор. Вы лечите людей за деньги, можете открыть свою больницу. Вы должны вылечить сотрудника полиции бесплатно, если он попросит.]],
	weapons = {"med_kit", "weapon_fists"},
	command = "medic",
	max = 3,
	salary = 230,
	admin = 0,
	vote = false,
	hasLicense = false,
	medic = true
})

TEAM_HOBO = DarkRP.createJob("Бомж", {
	color = Color(80, 45, 0, 255),
	model = "models/player/corpse1.mdl",
	description = [[Вы - Бродяга. Бродяга всегда в грязи и он всегда требует немного денег на пропитание]],
	weapons = {"weapon_bugbait", "weapon_fists"},
	command = "hobo",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	hobo = true
})

TEAM_MAD = DarkRP.createJob("Путана", {
	color = Color(0, 255, 255, 255),
	model = "models/player/p2_chell.mdl",
	description = [[Тяжкая жизнь независимой женщины завела вас на работу проститутки.]],
	weapons = {"weapon_fists"},
	command = "intim",
	max = 5,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false,
})

TEAM_OHRANA = DarkRP.createJob("Охранник", {
	color = Color(25, 25, 25, 255),
	model = "models/player/odessa.mdl",
	description = [[Вы - охранник. Вы охраняете своего нанимателя/дом/магазин за деньги.]],
	weapons = {"weapon_fists", "stunstick"},
	command = "object",
	max = 3,
	salary = 180,
	admin = 0,
	vote = false,
	hasLicense = true
})


TEAM_HITMAN = DarkRP.createJob("Наемный убийца", {
	color = Color(255, 0, 255),
	model = "models/player/barney.mdl",
	description = [[Вы - Хитман. Вы убиваете за деньги и выполняете свою работу чисто и быстро.]],
	weapons = {"weapon_fists", "climb_swep2", "lockpick"},
	command = "killer",
	max = 2,
	salary = 70,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_GANG = DarkRP.createJob("Гангстер", {
	color = Color(75, 75, 75, 255),
	model = {
		"models/player/Group03/Female_01.mdl",
		"models/player/Group03/Female_02.mdl",
		"models/player/Group03/Female_03.mdl",
		"models/player/Group03/Female_04.mdl",
		"models/player/Group03/Female_06.mdl",
		"models/player/group03/male_01.mdl",
		"models/player/Group03/Male_02.mdl",
		"models/player/Group03/male_03.mdl",
		"models/player/Group03/Male_04.mdl",
		"models/player/Group03/Male_05.mdl",
		"models/player/Group03/Male_06.mdl",
		"models/player/Group03/Male_07.mdl",
		"models/player/Group03/Male_08.mdl",
		"models/player/Group03/Male_09.mdl"},
	description = [[Вы - Гангстер. Вы грабите людей, убиваете по приказу Мафиози. Вы подчиняетесь Мафиози.
]],
	weapons = {"weapon_fists"},
	command = "gangster",
	max = 8,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_GANG = DarkRP.createJob("Мафиози", {
	color = Color(75, 75, 75, 255),
	model = {
	  	"models/humans/mafia/male_04.mdl",
	  	"models/humans/mafia/male_08.mdl",
      "models/humans/mafia/male_02.mdl",
      "models/humans/mafia/male_04.mdl",
      "models/humans/mafia/male_06.mdl",
      "models/humans/mafia/male_07.mdl",
      "models/humans/mafia/male_09.mdl"},
	description = [[Вы - Мафиози. Вы приказываете своим гангстерам выполнять работу. Работу вы можете писать в новости.]],
	weapons = {"climb_swep2", "weapon_fists", "lockpick"},
	command = "Mobboss",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false
})


TEAM_BOP = DarkRP.createJob("Вор", {
	color = Color(47, 79, 79, 255),
	model = "models/player/arctic.mdl",
	description = [[Вы - вор. Вы можете взламывать двери и обворовывать ничего не подозревающих людей! Вор может вступить в группировку и участвовать в рейдах.]],
	weapons = {"weapon_fists", "keypad_cracker", "lockpick", "climb_swep2"},
	command = "vor",
	max = 3,
	salary = 55,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_UP = DarkRP.createJob("Корманник", {
	color = Color(47, 79, 79, 255),
	model = "models/player/group03/male_04.mdl",
	description = [[Вы - корманник, воруеете без лишних глаз деньги у людей. Не можете состоять в банде.]],
	weapons = {"weapon_fists", "keypad_cracker", "lockpick", "moneythief"},
	command = "moneythief",
	max = 2,
	salary = 55,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_DRUG = DarkRP.createJob("Наркодилер", {
	color = Color(25, 25, 25, 255),
	model = "models/player/group03m/male_02.mdl",
	description = [[Вы - Продавец Наркотиков. У вас есть все виды наркотиков: от обычной марихуаны до смертельного героина.]],
	weapons = {"weapon_fists"},
	command = "drugs",
	max = 2,
	salary = 34,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_TERROR = DarkRP.createJob("Террорист", {
	color = Color(47, 79, 79, 255),
	model = "models/player/phoenix.mdl",
	description = [[Вы - террорист. Вы можете взрывать населенные пункты, и терроризировать месное население. Не может взрывать сразу в нескольких местах, взрывает раз в час.]],
	weapons = {"weapon_fists", "climb_swep2"},
	command = "terror",
	max = 1,
	salary = 55,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_ADMIN = DarkRP.createJob("Администратор", {
	color = Color(47, 79, 79, 255),
	model = "models/player/combine_super_soldier.mdl",
	description = [[Работать, работать, и еще раз работать...]],
	weapons = {"weapon_fists"},
	command = "admin",
	max = 0,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = true,
    customCheck = function(ply) return table.HasValue({"admin", "superadmin", "owner"}, ply:GetNWString("usergroup")) end,
    CustomCheckFailMsg = "Эта профессия только для Администрации" -- Allows you to tell the user what went wrong when attempting to switch jobs
})

TEAM_MOBS = DarkRP.createJob("Шпион", {
	color = Color(15, 219, 255),
	model = {
	 "models/player/eli.mdl",
	 "models/player/barney.mdl",
	 "models/player/arctic.mdl",
	 "models/player/group03m/male_02.mdl",
	 "models/player/police.mdl",
	 "models/player/breen.mdl",
	 "models/humans/mafia/male_02.mdl"},
	description = [[Убивает за деньги скрываясь под формой. Доступен только донатерам.]],
	weapons = {"weapon_mad_knife", "weapon_fists", "weapon_spyknife", "climb_swep2", "lockpick"},
	command = "invis",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
    customCheck = function(ply) return table.HasValue({"Donater", "admin", "superadmin", "owner", "usеr", "Модератор"}, ply:GetNWString("usergroup")) end,
    CustomCheckFailMsg = "Эта профессия только для индивидуальных игроков." -- Allows you to tell the user what went wrong when attempting to switch jobs
})

TEAM_BLACK = DarkRP.createJob("Торговец подпольным оружием", {
	color = Color(25, 25, 25, 255),
	model = "models/player/leet.mdl",
	description = [[Вы - Продавец Черного Рынка. У вас есть то, чего нет у обычных продавцов. Будтье осторожны, всё ваше оружие противозаконное.]],
	weapons = {"weapon_fists", "climb_swep2"},
	command = "blackshop",
	max = 2,
	salary = 300,
	admin = 0,
	vote = false,
	hasLicense = false,
	customCheck = function(ply) return table.HasValue({"Donater", "admin", "superadmin", "Owner", "usеr", "Модератор"}, ply:GetNWString("usergroup")) end,
    CustomCheckFailMsg = "Эта профессия только для индивидуальных игроков." -- Allows you to tell the user what went wrong when attempting to switch jobs
})






--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN


--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_CHIEF] = true,
	[TEAM_MAYOR] = true,
}

--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_MOBS)
DarkRP.addHitmanTeam(TEAM_HITMAN)
