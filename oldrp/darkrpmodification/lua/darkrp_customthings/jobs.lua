
TEAM_CITIZEN = DarkRP.createJob("Горожанин", {
	color = Color(0, 100, 0, 255),
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
	description = [[Вы безпечный горожанин, гуляйте по городу,
устраивайтесь на работу.
У вас даже будет пособие по безработице.]],
	weapons = {},
	command = "citizen",
	max = 0,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_GUN = DarkRP.createJob("Продавец оружия", {
	color = Color(255, 140, 0, 255),
	model = "models/player/monk.mdl",
	description = [[Вы продавец оружия, 
в вашем запасе небольшой выбор пистолетов и дробовиков, 
но главное, 
у вас есть различные модификации как для пистолетов, так и для серьезного оружия!]],
	weapons = {},
	command = "gundealer",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_MJGUN = DarkRP.createJob("Мажорный продовец оружия", {
	color = Color(0, 200, 255, 255),
	model = "models/player/monk.mdl",
	description = [[Вы продавец оружия, 
в вашем запасе небольшой выбор пистолетов и дробовиков, 
но главное, 
у вас есть различные модификации как для пистолетов, так и для серьезного оружия!]],
	weapons = {},
	command = "mjgundealer",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	customCheck = function(ply) return ply:IsVIP() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})

TEAM_MEDIC = DarkRP.createJob("Доктор", {
	color = Color(127, 163, 111, 255),
	model = "models/player/kleiner.mdl",
	description = [[Вы доктор, вы как волшебник, 
лечите любые болезни специальным приспособлением, 
украденым у военных, которых кстати, стоит опасаться, 
ведь у них серьезные планы на вас.]],
	weapons = {"med_kit"},
	command = "medic",
	max = 3,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false,
	medic = true
})

TEAM_HOBO = DarkRP.createJob("БОМЖ", {
	color = Color(71, 37, 0, 255),
	model = "models/jessev92/player/misc/saddam.mdl",
	description = [[Вы Без Определенного Места Жительства, 
зато у вас есть какашки, которыми вы можете пуляться не стесняясь, 
но опосайтесь копов.]],
	weapons = {}, 
	command = "hobo",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
	hobo = true,
	/*customCheck = function(ply) return ply:GetNWInt("LevelXP") >= 20 or ply:IsSuperAdmin() end,
	CustomCheckFailMsg = "У вас еще нет 20 уровня!"*/
})

TEAM_BM = DarkRP.createJob("Бизнесмен", {
	color = Color(191, 127, 255, 255),
	model = {
	"models/player/hostage/hostage_01.mdl",
	"models/player/hostage/hostage_02.mdl",
	"models/player/hostage/hostage_03.mdl",
	"models/player/hostage/hostage_04.mdl"
	},
	description = [[Вы бизнесмен. Откройте свое дело, зарабатывайте деньги. 
Например: Парк аттракционов или же хранение принтеров(с разрешения мера/шефа). 
Фантазия в помощь!]],
	weapons = {},
	command = "bm",
	max = 3,
	salary = 70,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_COOK = DarkRP.createJob("Повар", {
	color = Color(255, 127, 223, 255),
	model = "models/player/mossman.mdl",
	description = [[Вы повар. Обустройте какую-нибудь площадь под кафе 
и продавайте еду.]],
	weapons = {},
	command = "cook",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	cook = true
})

TEAM_PROST = DarkRP.createJob("Проститутка", {
	color = Color(255, 127, 223, 255),
	model = "models/player/alyx.mdl",
	description = [[Вы повар. Обустройте какую-нибудь площадь под кафе 
и продавайте еду.]],
	weapons = {},
	command = "prost",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	customCheck = function(ply) return ply:IsSuperVIP() or ply:IsAdmin() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})

/* --- Плохие --- */
TEAM_GANG = DarkRP.createJob("Бандит", {
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
	description = [[Вы низшая ступень крупного бандитского сообщества.
У вас есть небольшое преймущество перед обычными гражданами, 
вы можете грабить, убивать, насиловать. Но помните, 
на все ваши действия должны быть причины(Иначе BNA!!11).]],
	weapons = {"climb_swep2"},
	command = "gangster",
	max = 5,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_TER = DarkRP.createJob("Террорист", {
	color = Color(50, 50, 50, 255),
	model = {"models/code_gs/robber/robberplayer.mdl"},
	description = [[У вас есть небольшое преймущество перед обычными гражданами, 
вы можете грабить, убивать, насиловать. Но помните, 
на все ваши действия должны быть причины(Иначе BNA!!11).]],
	weapons = {"climb_swep2"},
	command = "ter",
	max = 5,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	customCheck = function(ply) return ply:IsSuperVIP() or ply:IsAdmin() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})


TEAM_JOSTLER = DarkRP.createJob("Карманник", {
	color = Color(75, 75, 75, 255),
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
		"models/player/Group01/Male_09.mdl"},
	description = [[Вы можете воровать деньги.]],
	weapons = {"climb_swep2", "moneythief"},
	command = "jostler",
	max = 2,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_MOB = DarkRP.createJob("Мафиози", {
	color = Color(25, 25, 25, 255),
	model = {"models/player/leet.mdl"},
	description = [[Вы глава криминального мира. 
Под вами ходят тысячи бандитов, 
которым только дай интересное задание, 
они с руками его отгрызут.]],
	weapons = {"lockpick", "unarrest_stick", "climb_swep2"},
	command = "mobboss",
	max = 1,
	salary = 60,
	admin = 0,
	vote = false,
	hasLicense = false,
	help = {
		"As the Mob boss, you decide what you want the other Gangsters to do.",
		"You get an Unarrest Stick which you can use to break people out of jail.",
		"/agenda <Message> Sets the Gangsters' agenda. Use // to go to the next line."
	}
})


TEAM_HITMAN = DarkRP.createJob("Киллер", {
	color = Color(95, 127, 63, 255),
	model = {"models/player/gman_high.mdl"},
	description = [[Вы безжалостный убийца. Убивайте людей за деньги, что тут еще сказать.]],
	weapons = {"climb_swep2", "lockpick"},
	command = "hitman",
	max = 3,
	salary = 45,
	admin = 0,
	vote = true,
	hasLicense = false,
	candemote = true
})

TEAM_BMD = DarkRP.createJob("Подпольный торговец", {
	color = Color(255, 191, 0, 255),
	model = {"models/code_gs/robber/robberplayer.mdl"},
	description = [[Вы продавец нелегальных товаров. У вас есть все, что душе угодно. И все, 
что не угодно полиции. Вам стоит опасаться хранителей порядка.]],
	weapons = {"climb_swep2"},
	command = "bmd",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_SCIENT = DarkRP.createJob("Подпольный ученый", {
	color = Color(255, 191, 0, 255),
	model = {"models/code_gs/robber/robberplayer.mdl"},
	description = [[Вы продавец нелегальных товаров. У вас есть все, что душе угодно. И все, 
что не угодно полиции. Вам стоит опасаться хранителей порядка.]],
	weapons = {"climb_swep2"},
	command = "scient",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
	customCheck = function(ply) return ply:IsAdmin() end,
	CustomCheckFailMsg = "Вы не донатор!"
})

TEAM_THIEF = DarkRP.createJob("Вор", {
	color = Color(75, 75, 75, 255),
	model = {"models/player/arctic.mdl"},
	description = [[Вы вор. У вас есть все, чтобы взломать/открыть чужие замки/двери/кейпады.]],
	weapons = {"climb_swep2", "lockpick", "keypad_cracker"},
	command = "thief",
	max = 4,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_DRUG = DarkRP.createJob("Драгдиллер", {
	color = Color(255, 127, 127, 255),
	model = {"models/player/eli.mdl"},
	description = [[Продавайте наркоту, но опасайтесь копов.]],
	weapons = {"climb_swep2"},
	command = "drugdealer",
	max = 4,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
	customCheck = function(ply) return ply:IsVIP() end,
	CustomCheckFailMsg = "Вы не донатор!"
})

/* --- Полиция --- */
TEAM_SEC = DarkRP.createJob("Охранник", {
	color = Color(63, 127, 127, 255),
	model = "models/player/fisherman.mdl",
	description = [[Вы охранник. Ваша задача найти магазин и попробовать
устроится туда на работу, а после охранять его.]],
	weapons = {"stunstick"},
	command = "security",
	max = 5,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_PVT = DarkRP.createJob("Рядовой", {
	color = Color(0, 161, 255, 255),
	model = {
	"models/player/nypd/male_02.mdl",
	"models/player/nypd/male_04.mdl",
	"models/player/nypd/male_09.mdl",
	"models/player/nypd/male_05.mdl",
	"models/player/nypd/male_06.mdl",
	"models/player/nypd/male_07.mdl",
	"models/player/nypd/male_08.mdl"
	},
	description = [[Вы защитник обычных граждан, хранитель порядка.
Гоняйте противных бомжей с улиц, слушайте жалобы горожан.]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "weapon_mad_usp"},
	command = "pvt",
	max = 5,
	salary = 65,
	admin = 0,
	vote = true,
	hasLicense = true,
	help = {
		"Please don't abuse your job",
		"When you arrest someone they are auto transported to jail.",
		"They are auto let out of jail after some time",
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect",
		"Type /jailpos to set the jail position"
	},
	--customCheck = function(ply) return ply:GetNWString("EV_UserGroup") == "wlcp" or ply:GetNWString("EV_UserGroup") == "donatewl" or ply:IsSuperAdmin() end,
	--CustomCheckFailMsg = "Вы не в вайтлисте!"
})

TEAM_LT = DarkRP.createJob("Лейтенант", {
	color = Color(0, 161, 255, 255),
	model = {
	"models/player/nypd/male_02.mdl",
	"models/player/nypd/male_04.mdl",
	"models/player/nypd/male_09.mdl",
	"models/player/nypd/male_05.mdl",
	"models/player/nypd/male_06.mdl",
	"models/player/nypd/male_07.mdl",
	"models/player/nypd/male_08.mdl"
	},
	description = [[Вы защитник обычных граждан, хранитель порядка.
Гоняйте противных бомжей с улиц, слушайте жалобы горожан.]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "weapon_mad_auto_glock"},
	command = "lt",
	max = 3,
	salary = 65,
	admin = 0,
	vote = true,
	hasLicense = true,
	help = {
		"Please don't abuse your job",
		"When you arrest someone they are auto transported to jail.",
		"They are auto let out of jail after some time",
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect",
		"Type /jailpos to set the jail position"
	},
	NeedToChangeFrom = TEAM_PVT
})

TEAM_CAPTAIN = DarkRP.createJob("Капитан", {
	color = Color(0, 161, 255, 255),
	model = {
	"models/player/nypd/male_02.mdl",
	"models/player/nypd/male_04.mdl",
	"models/player/nypd/male_09.mdl",
	"models/player/nypd/male_05.mdl",
	"models/player/nypd/male_06.mdl",
	"models/player/nypd/male_07.mdl",
	"models/player/nypd/male_08.mdl"
	},
	description = [[Вы защитник обычных граждан, хранитель порядка.
Гоняйте противных бомжей с улиц, слушайте жалобы горожан.]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "weapon_mad_dual", "weapon_mad_galil"},
	command = "CAPTAIN",
	max = 5,
	salary = 65,
	admin = 0,
	vote = true,
	hasLicense = true,
	help = {
		"Please don't abuse your job",
		"When you arrest someone they are auto transported to jail.",
		"They are auto let out of jail after some time",
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect",
		"Type /jailpos to set the jail position"
	},
	NeedToChangeFrom = TEAM_LT
})

TEAM_COL = DarkRP.createJob("Полковник", {
	color = Color(0, 63, 255, 255),
	model = {
	"models/player/nypd/male_02.mdl",
	"models/player/nypd/male_04.mdl",
	"models/player/nypd/male_09.mdl",
	"models/player/nypd/male_05.mdl",
	"models/player/nypd/male_06.mdl",
	"models/player/nypd/male_07.mdl",
	"models/player/nypd/male_08.mdl",
	"models/player/nypd/male_07.mdl",
	"models/player/nypd/male_08.mdl",
	"models/player/nypd/male_09.mdl"
	},
	description = [[У вас есть груда пончиков и уютный офис, 
раздавайте приказы(в отсутсвии мэра), допрашивайте заключенных. ]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "weapon_mad_deagle", "weapon_mad_galil"},
	command = "col",
	max = 1,
	salary = 75,
	admin = 0,
	vote = true,
	hasLicense = true,
	chief = true,
	NeedToChangeFrom = TEAM_CAPTAIN,
	customCheck = function(ply) return ply:IsVIP() end,
	CustomCheckFailMsg = "Вы не VIP!"
})

TEAM_MAYOR = DarkRP.createJob("Мэр", {
	color = Color(127, 0, 0, 255),
	model = "models/player/breen.mdl",
	description = [[Вы мэр, управляйте городом]],
	weapons = {},
	command = "mayor",
	max = 1,
	salary = 85,
	admin = 0,
	vote = true,
	hasLicense = false,
	mayor = true,
	help = {
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect.",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect.",
		"Type /lockdown to initiate a lockdown",
		"Type /unlockdown to end a lockdown",
		"Type /placelaws to place a screen containing the laws.",
		"Type /addlaw and /removelaw to edit the laws."
	}
	 --customCheck = function(ply) return ply:GetNWString("EV_UserGroup") == "wlcp" or ply:GetNWString("EV_UserGroup") == "donatewl" or ply:IsSuperAdmin() end,
	 --CustomCheckFailMsg = "Вы не в вайтлисте!"
})

TEAM_DEPUTYM = DarkRP.createJob("Заместитель мэра", {
	color = Color(127, 36, 0, 255),
	model = "models/player/hostage/hostage_01.mdl",
	description = [[Вы заместитель главы города!
Ваша задача во всем помогать меру,
так сказать делать за него то, что он сам не
успевает.]],
	weapons = {},
	command = "deputym",
	max = 1,
	salary = 85,
	admin = 0,
	vote = true,
	hasLicense = false,
	mayor = true,
	help = {
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect.",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect.",
		"Type /lockdown to initiate a lockdown",
		"Type /unlockdown to end a lockdown",
		"Type /placelaws to place a screen containing the laws.",
		"Type /addlaw and /removelaw to edit the laws."
	},
	customCheck = function(ply) return ply:IsSuperVIP() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})

TEAM_SWAT = DarkRP.createJob("SWAT", {
	color = Color(63, 79, 127, 255),
	model = {
	"models/player/swat.mdl"
	},
	description = [[Вы боец группы Беркут. Вы можете проявлять активность, 
только в том случаи, когда происходит полнейший хаос.]],
	weapons = {"arrest_stick", "unarrest_stick", "weapon_mad_glock", "weapon_mad_p90", "stunstick", "door_ram", "weaponchecker"},
	command = "swat",
	max = 2,
	salary = 45,
	admin = 0,
	vote = true,
	hasLicense = true
})

TEAM_RIOT = DarkRP.createJob("RIOT", {
	color = Color(96, 63, 127, 255),
	model = {
	"models/player/riot.mdl"
	},
	description = [[Вы боец группы Беркут. Вы можете проявлять активность, 
только в том случаи, когда происходит полнейший хаос.]],
	weapons = {"arrest_stick", "unarrest_stick", "weapon_mad_ak47", "weapon_mad_sg550", "weapon_mad_m3", "weapon_mad_357", "stunstick", "door_ram", "weaponchecker"},
	command = "riot",
	max = 3,
	salary = 45,
	admin = 0,
	vote = true,
	hasLicense = true,
	customCheck = function(ply) return ply:IsSuperVIP() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})


TEAM_URBAN = DarkRP.createJob("URBAN", {
	color = Color(137, 63, 63, 255),
	model = {
	"models/player/urban.mdl"
	},
	description = [[Вы боец группы Беркут. Вы можете проявлять активность, 
только в том случаи, когда происходит полнейший хаос.]],
	weapons = {"arrest_stick", "unarrest_stick", "weapon_mad_m4", "weapon_mad_357", "stunstick", "door_ram", "weaponchecker"},
	command = "urban",
	max = 3,
	salary = 45,
	admin = 0,
	vote = true,
	hasLicense = true,
	customCheck = function(ply) return ply:IsVIP() end,
	CustomCheckFailMsg = "У вас нет привелегий для этого!"
})
/*---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------*/
GAMEMODE.DefaultTeam = TEAM_CITIZEN


/*---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------*/
GAMEMODE.CivilProtection = {
	[TEAM_PVT] = true,
	[TEAM_LT] = true,
	[TEAM_CAPTAIN] = true,
	[TEAM_COL] = true,
	[TEAM_MAYOR] = true,
	[TEAM_SWAT] = true,
	[TEAM_RIOT] = true,
	[TEAM_URBAN] = true,
}

/*---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------*/
DarkRP.addHitmanTeam(TEAM_HITMAN)
--DarkRP.addHitmanTeam(TEAM_SPY)
