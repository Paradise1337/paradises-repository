/*---------------------------------------------------------------------------
/*---------------------------------------------------------------------------
English (example) language file
---------------------------------------------------------------------------

This is the english language file. The things on the left side of the equals sign are the things you should leave alone
The parts between the quotes are the parts you should translate. You can also copy this file and create a new language.

= Warning =
Sometimes when DarkRP is updated, new phrases are added.
If you don't translate these phrases to your language, it will use the English sentence.
To fix this, join your server, open your console and enter darkp_getphrases yourlanguage
For English the command would be:
	darkrp_getphrases "en"
because "en" is the language code for English.

You can copy the missing phrases to this file and translate them.

= Note =
Make sure the language code is right at the bottom of this file

= Using a language =
Make sure the convar gmod_language is set to your language code. You can do that in a server CFG file.
---------------------------------------------------------------------------*/

local my_language = {
	-- Admin things
	need_admin = "Вам нужно быть админом, чтобы  %s",
	need_sadmin = "Вам нужно быть суперадмином, чтобы %s",
	no_privilege = "У вас нет прав на это",
	no_jail_pos = "Отсутствует тюрьма",
	invalid_x = "Неверный %s! %s",

	-- F1 menu
	f1ChatCommandTitle = "Команды для чата",
	f1WikiTitle = "Страница Вики",
	f1Search = "Поиск...",

	-- Money things:
	price = "Цена: %s%d",
	reset_money = "%s сбросил все деньги игроков!",
	has_given = "%s дал вам %s",
	you_gave = "Вы дали %s %s",
	npc_killpay = "%s за убийство NPC!",
	profit = "Прибыль",
	loss = "Убыток",
	deducted_x = "Вычтенно %s%d",
	need_x = "Нужно %s%d",

	payday_message = "Зарплата! Вы получили %s!",
	payday_unemployed = "Вы не получите зарплату, так как вы безработный!",
	payday_missed = "Пропущена зарплата! (Вы арестованы)",

	property_tax = "Property tax! %s",
	property_tax_cant_afford = "You couldn't pay the taxes! Your property has been taken away from you!",
	taxday = "Tax Day! %s%% of your income was taken!",

	found_cheque = "Вы нашли чек %s%s и получили %s.",
	cheque_details = "This cheque is made out to %s.",
	cheque_torn = "You have torn up the cheque.",
	cheque_pay = "Сумма: %s",
	signed = "Подпись: %s",

	found_cash = "Вы нашли %s%d!",

	owner_poor = "The %s owner is too poor to subsidize this sale!",

	-- Police
	wanted = "В розыске!\nПричина: %s",
	youre_arrested = "Вы арестованы на %d секунд!",
	youre_arrested_by = "Вас арестовал: %s.",
	youre_unarrested_by = "Вас разарестовал: %s.",
	hes_arrested = "%s был арестован на %d секунд!",
	hes_unarrested = "%s был выпущен на свободу!",
	warrant_ordered = "%s получил ореда на %s. Причина: %s",
	warrant_request = "%s сделал запрос на ордер %s\nПричина: %s",
	warrant_request2 = "Ордер отправлен мэру %s!",
	warrant_approved = "Ордер был утвержден %s!\nПричина: %s\nОрдер от: %s",
	warrant_approved2 = "Вы теперь можете обыскать этот дом.",
	warrant_denied = "Мэр %s отказал вам в ордере.",
	warrant_expired = "Ордер на %s истек!",
	warrant_required = "Вам нужен ордер для открытия этой двери.",
	warrant_required_unfreeze = "Вам нужен ордер, чтобы разморозить этот проп.",
	warrant_required_unweld = "Вам нужен ордер, чтобы отварить этот проп.",
	wanted_by_police = "%s в розыске!\nПричина: %s\nСделал запрос: %s",
	wanted_by_police_print = "%s подал на %s в розыск, причина: %s",
	wanted_expired = "%s не найден полицией.",
	wanted_revoked = "%s не найден полицией.\nРозыск отменен: %s",
	cant_arrest_other_cp = "Вы не можете арестовать других полицейских!",
	must_be_wanted_for_arrest = "Игрок должен быть в розыске, чтобы арестовать его.",
	cant_arrest_fadmin_jailed = "Вы не можете арестовать игрока, когда он посажен админом.",
	cant_arrest_no_jail_pos = "Вы не можете арестовать игрока, пока отсутсвует тюрьма!",
	cant_arrest_spawning_players = "Вы не можете арестовать только что зашедшего игрока.",

	suspect_doesnt_exist = "Подозреваемый не найден.",
	actor_doesnt_exist = "Actor does not exist.",
	get_a_warrant = "Получить ордер",
	make_someone_wanted = "Подать на розыск",
	remove_wanted_status = "Отменить розыск",
	already_a_warrant = "На него уже есть ордер.",
	already_wanted = "Он уже в розыске.",
	not_wanted = "Подозреваемый не в розыске.",
	need_to_be_cp = "Вы состоите в полиции.",
	suspect_must_be_alive_to_do_x = "The suspect must be alive in order to %s.",
	suspect_already_arrested = "The suspect is already in jail.",

	-- Players
	health = "Здоровье: %s",
	job = "Работа: %s",
	salary = "Зарплата: %s%s",
	wallet = "Кошелек: %s%s",
	weapon = "Оружие: %s",
	kills = "Убийства: %s",
	deaths = "Смерти: %s",
	rpname_changed = "%s сменил RP имя на: %s",
	disconnected_player = "Вышешедший игрок",

	-- Teams
	need_to_be_before = "Вы сначала должны стать %s прежде чем %s",
	need_to_make_vote = "Вы должны начать голосование, чтобы стать %s!",
	team_limit_reached = "Нельзя стать %s, так как достигнут лимит",
	wants_to_be = "%s\nхочет стать\n%s",
	has_not_been_made_team = "%s не стал %s!",
	job_has_become = "%s стал %s!",

	-- Disasters
	meteor_approaching = "WARNING: Meteor storm approaching!",
	meteor_passing = "Meteor storm passing.",
	meteor_enabled = "Meteor Storms are now enabled.",
	meteor_disabled = "Meteor Storms are now disabled.",
	earthquake_report = "Earthquake reported of magnitude %sMw",
	earthtremor_report = "Earth tremor reported of magnitude %sMw",

	-- Keys, vehicles and doors
	keys_allowed_to_coown = "Вы можете купить дверь\n(Нажмите F2)\n",
	keys_other_allowed = "Со-владельцы:",
	keys_allow_ownership = "(Нажмите F2, чтобы разрешить покупать дверь)",
	keys_disallow_ownership = "(Нажмите F2, чтобы запретить покупать дверь)",
	keys_owned_by = "Владелец:",
	keys_unowned = "Нет владельца\n(Нажмите F2, чтобы купить дверь)",
	keys_everyone = "(Нажмите F2, чтобы разрешить всем)",
	door_unown_arrested = "Вы не можете покупать/продовать дверь, пока вы арестованы!",
	door_unownable = "Эту дверь нельзя купить!",
	door_sold = "Вы продали дверь за %s",
	door_already_owned = "Кто-то уже купил эту дверь!",
	door_cannot_afford = "У вас не хватает денег!",
	door_hobo_unable = "Вы не можете купить эту дверь будучи бомжом!",
	vehicle_cannot_afford = "У вас не хватает денег!",
	door_bought = "Вы купили эту дверь за %s%s",
	vehicle_bought = "Вы купили это т.с. за %s%s",
	door_need_to_own = "Вы должны купить эту дверь, прежде чем %s",
	door_rem_owners_unownable = "Вы не можете удалить владельцев, так как дверь недоступна!",
	door_add_owners_unownable = "Вы не можете добавить владельцев, так как дверь недоступна!",
	rp_addowner_already_owns_door = "%s уже владеет этой дверью!",
	add_owner = "Добавить владельца",
	remove_owner = "Удалить владельца",
	coown_x = "со-владеть %s",
	allow_ownership = "Разрешить покупку",
	disallow_ownership = "Запретить покупку",
	edit_door_group = "Редактировать доступ",
	door_groups = "Доступ групп",
	door_group_doesnt_exist = "Такой группы не существует!",
	door_group_set = "Доступ группе успешно выдан.",
	sold_x_doors_for_y = "Вы продали %d дверей за %s%d!",

	-- Entities
	drugs = "Наркотики",
	drug_lab = "Drug Lab",
	gun_lab = "Gun Lab",
	gun = "Оружие",
	microwave = "Микроволновка",
	food = "Еда",
	money_printer = "Принтер",

	sign_this_letter = "Подписать это письмо",
	signed_yours = "Ваш,",

	money_printer_exploded = "Твой принтер взорвался!",
	money_printer_overheating = "Ваш принтер пергрелся!",

	contents = "Контент: ",
	amount = "Кол-во: ",

	picking_lock = "Лом",

	cannot_pocket_x = "Вы не можете это подобрать!",
	object_too_heavy = "Эта вещь слишком тяжелая.",
	pocket_full = "Ваш карман полон!",
	pocket_no_items = "Ваш карман пуст.",
	drop_item = "Выбросить",

	bonus_destroying_entity = "Бонус за уничтожение запрещенного предмета.",

	switched_burst = "Switched to burst-fire mode.",
	switched_fully_auto = "Switched to fully automatic fire mode.",
	switched_semi_auto = "Switched to semi-automatic fire mode.",

	keypad_checker_shoot_keypad = "Shoot a keypad to see what it controls.",
	keypad_checker_shoot_entity = "Shoot an entity to see which keypads are connected to it",
	keypad_checker_click_to_clear = "Right click to clear.",
	keypad_checker_entering_right_pass = "Entering the right password",
	keypad_checker_entering_wrong_pass = "Entering the wrong password",
	keypad_checker_after_right_pass = "after having entered the right password",
	keypad_checker_after_wrong_pass = "after having entered the wrong password",
	keypad_checker_right_pass_entered = "Right password entered",
	keypad_checker_wrong_pass_entered = "Wrong password entered",
	keypad_checker_controls_x_entities = "This keypad controls %d entities",
	keypad_checker_controlled_by_x_keypads = "This entity is controlled by %d keypads",
	keypad_on = "ON",
	keypad_off = "OFF",
	seconds = "seconds",

	persons_weapons = "%s носит с собой:",
	has_no_weapons = "%s безоружен.",
	returned_persons_weapons = "Вы вернули %s его предметы.",
	no_weapons_confiscated = "%s не имеет конфискованых предмотов!",
	no_illegal_weapons = "%s не имеет ничего запрещенного.",
	confiscated_these_weapons = "Конфисковано следующее снаряжение:",
	checking_weapons = "Проверка снаряжения",

	shipment_antispam_wait = "Подождите, пока заспавниться предыдущий ящик.",

	-- Talking
	hear_noone = "Никто вас не слышит %s!",
	hear_everyone = "Весь сервер вас слышит!",
	hear_certain_persons = "Те, кто ваш слышит %s: ",

	whisper = "шепот",
	yell = "крик",
	advert = "[Реклама]",
	broadcast = "[Новости!]",
	radio = "радио",
	request = "ЗАПРОС!",
	group = "группа",
	demote = "УВОЛЬНЕНИЕ",
	ooc = "Общий чат",
	radio_x = "Радио %d",

	talk = "говорить",
	speak = "разговаривать",

	speak_in_ooc = "разговаривать в общем чате",
	perform_your_action = "выполнить ваши действия",
	talk_to_your_group = "сказать группе",

	channel_set_to_x = "Channgel set to %s!",

	-- Notifies
	disabled = "%s это не работает! %s",
	limit = "Вы достигли %s лимита!",
	have_to_wait = "Вы должны подождать %d секунд, перед тем, чтобы %s!",
	must_be_looking_at = "Вы должны смотреть на %s!",
	incorrect_job = "У вас нета профессия, чтобы %s",
	unavailable = "Это %s не доступно",
	unable = "Вы не можете %s. %s",
	cant_afford = "Вы не в состоянии, сделать %s",
	created_x = "%s создал %s",
	cleaned_up = "Ваш %s удален.",
	you_bought_x = "Вы купили %s за %s%d.",
	you_received_x = "Вы получили %s за %s.",

	created_first_jailpos = "Вы добавили первую камеру!",
	added_jailpos = "Вы добавили еще одну камеру!",
	reset_add_jailpos = "Вы удалили предыдущие камеры, и добавили одну.",
	created_spawnpos = "%s's spawn position created.",
	updated_spawnpos = "%s's spawn position updated.",
	do_not_own_ent = "Вы не владеете этим предметом!",
	cannot_drop_weapon = "Нельзя выбросить это оружие!",
	job_switch = "Профессия успешно сменена!",
	job_switch_question = "Поменять профессию с %s?",
	job_switch_requested = "Запрос на смену профессии.",

	cooks_only = "Только для повара.",

	-- Misc
	unknown = "Неизвестно",
	arguments = "аргументы",
	no_one = "никто",
	door = "дверь",
	vehicle = "транспорт",
	door_or_vehicle = "дверь/транспорт",
	driver = "Водитель: %s",
	name = "Имя: %s",
	locked = "Закрыто.",
	unlocked = "Открыто.",
	player_doesnt_exist = "Такого игрока не существует.",
	job_doesnt_exist = "Такая профессия не существует!",
	must_be_alive_to_do_x = "You must be alive in order to %s.",
	banned_or_demoted = "Запрщен/уволен",
	wait_with_that = "Подождите с этим.",
	could_not_find = "Не удалось найти %s",
	f3tovote = "Нажмите F3, чтобы проголосовать",
	listen_up = "Слушайте:", -- In rp_tell or rp_tellall
	nlr = "New Life Rule: Не мстить за убийство.",
	reset_settings = "Вы сбросили настройки на заводские!",
	must_be_x = "You must be a %s in order to be able to %s.",
	agenda_updated = "Повестка дня обновлена",
	job_set = "%s сменил его профессия на '%s'",
	demoted = "%s был уволен",
	demoted_not = "%s не был уволен",
	demote_vote_started = "%s начал голосование на увольнение %s",
	demote_vote_text = "Кандидат на увольнение:\n%s", -- '%s' is the reason here
	cant_demote_self = "Вы не можете уволить себя.",
	i_want_to_demote_you = "Я хочу вас уволить. Причина: %s",
	tried_to_avoid_demotion = "Вы пытались избежать увольнение. Вы уволены.", -- naughty boy!
	lockdown_started = "Мэр объявил ком.час, вернитесь в свои дома!",
	lockdown_ended = "Ком.час закончился",
	gunlicense_requested = "%s сделал запрос %s на лицензию",
	gunlicense_granted = "%s выдал %s лицензию",
	gunlicense_denied = "%s отказал %s в лицензии",
	gunlicense_question_text = "Выдал %s лицензию?",
	gunlicense_remove_vote_text = "%s начал голосование на удаление лицензии у %s",
	gunlicense_remove_vote_text2 = "Отменил лицензию:\n%s", -- Where %s is the reason
	gunlicense_removed = "%s лицензия отобрана!",
	gunlicense_not_removed = "%s лицензия не отобрана!",
	vote_specify_reason = "Вы должны написать причину!",
	vote_started = "Голосование начато",
	vote_alone = "Вы выйграли голосвание, потому что вы один.",
	you_cannot_vote = "Вы не можете голосовать!",
	x_cancelled_vote = "%s отменил послденее голосование.",
	jail_punishment = "Наказан за перезаход на сервер! Арестован на: %d seconds.",
	admin_only = "Только для админа!", -- When doing /addjailpos
	chief_or = "Шеф или ",-- When doing /addjailpos

	dead_in_jail = "Вы мертвы, ваш срок в тюрьме окончен!",
	died_in_jail = "%s умер в тюрьме!",

	credits_for = "CREDITS FOR %s\n",
	credits_see_console = "DarkRP credits printed to console.",

	rp_getvehicles = "Available vehicles for custom vehicles:",

	data_not_loaded_one = "Your data has not been loaded yet. Please wait.",
	data_not_loaded_two = "If this persists, try rejoining or contacting an admin.",

	cant_spawn_weapons = "Вы не можете заспавнить оружие.",
	drive_disabled = "Вождение в данный момент недоступно.",
	property_disabled = "Имущество в данный момент недоступно.",

	not_allowed_to_purchase = "Вы не можете купить этот предмет.",

	rp_teamban_hint = "rp_teamban [player name/ID] [team name/id]. Use this to ban a player from a certain team.",
	rp_teamunban_hint = "rp_teamunban [player name/ID] [team name/id]. Use this to unban a player from a certain team.",
	x_teambanned_y = "%s has banned %s from being a %s.",
	x_teamunbanned_y = "%s has unbanned %s from being a %s.",

	you_set_x_salary_to_y = "Вы изменили зарплату %s на %s%d.",
	x_set_your_salary_to_y = "%s вы изменили зарплату на %s%d.",
	you_set_x_money_to_y = "Вы изменили деньги %s на %s%d.",
	x_set_your_money_to_y = "%s изменил ваши деньги на %s%d.",
	you_set_x_name_to_y = "Ник %s был сменен вами на %s",
	x_set_your_name_to_y = "%s назначил вам имя %s",

	someone_stole_steam_name = "Кто-то использует ваш ник, мы добавили цифру 1 к его нику..", -- Uh oh
	already_taken = "Имя уже занято.",

	job_doesnt_require_vote_currently = "Эта профессия сейчас не требует голосования!",

	x_made_you_a_y = "%s сделал вас: %s!",

	-- The lottery
	lottery_started = "Лоттерея начата! Участие стоит %s%d?",
	lottery_entered = "Вы участвуете в лоттерее за %s",
	lottery_not_entered = "%s не учавствовал в лоттерее",
	lottery_noone_entered = "Никто не учавствовал в лоттерее",
	lottery_won = "%s выйграл лоттерею, и получил %s",

	-- Animations
	custom_animation = "Анимации!",
	bow = "Поклон",
	dance = "Танец",
	follow_me = "За мной!",
	laugh = "Смех",
	lion_pose = "Поза льва",
	nonverbal_no = "Нет",
	thumbs_up = "Палец вверх",
	wave = "Волна",

	-- Hungermod
	starving = "Голод!",

	-- AFK
	afk_mode = "AFK Mode",
	salary_frozen = "Ваша зарплата заморожена.",
	salary_restored = "С возвращением, ваша зарплата восстановлена.",
	no_auto_demote = "Вы не будете автоматически уволены.",
	youre_afk_demoted = "Вы были уволены, так как долго были в AFK. Введите /afk.",
	hes_afk_demoted = "%s уволен, так как долго был AFK.",
	afk_cmd_to_exit = "Введите /afk, чтобы снова начать играть.",
	player_now_afk = "Игрок %s сейчас AFK.",
	player_no_longer_afk = "%s выешл из AFK.",

	-- Hitmenu
	hit = "Цель",
	hitman = "Киллер",
	current_hit = "Цель: %s",
	cannot_request_hit = "Нельзя его убить! %s",
	hitmenu_request = "Сделать запрос",
	player_not_hitman = "Этот игрок не киллер!",
	distance_too_big = "Дистанция до цели слишком большая.",
	hitman_no_suicide = "Киллер не убил себя.",
	hitman_no_self_order = "Киллер не может принять заказ на самого себя.",
	hitman_already_has_hit = "Киллер уже занят.",
	price_too_low = "Цена слишком низкая!",
	hit_target_recently_killed_by_hit = "Цель уже была заказана,",
	customer_recently_bought_hit = "Заказчик уже сделал заказ.",
	accept_hit_question = "Принять заказ от %s\nцель: %s за %s%d?",
	hit_requested = "Цель запрошена!",
	hit_aborted = "Цель отменена! %s",
	hit_accepted = "Цель принята!",
	hit_declined = "Киллер отказал вам!",
	hitman_left_server = "Киллер вышел с сервера!",
	customer_left_server = "Заказчик вышел с сервера!",
	target_left_server = "Цель вышла с сервера!",
	hit_price_set_to_x = "Цена убийства %s%d.",
	hit_complete = "Убийство от %s завершено!",
	hitman_died = "Киллер мертв!",
	target_died = "Цель мертва!",
	hitman_arrested = "Киллер арестован!",
	hitman_changed_team = "Киллер сменил имя!",
	x_had_hit_ordered_by_y = "%s had an active hit ordered by %s",

	-- Vote Restrictions
	hobos_no_rights = "Бомжи не могут голосовать!",
	gangsters_cant_vote_for_government = "Бандит не может голосовать!",
	government_cant_vote_for_gangsters = "Служащий не может голосовать!",

	-- VGUI and some more doors/vehicles
	vote = "Голосование",
	time = "Время: %d",
	yes = "Да",
	no = "Нет",
	ok = "OK",
	cancel = "Отменить",
	add = "Добавить",
	remove = "Удалить",
	none = "Пусто",

	x_options = "Опции %s",
	sell_x = "Продать %s",
	set_x_title = "Назначить %s название",
	set_x_title_long = "Изменить название %s.",
	jobs = "Профессии",
	buy_x = "Купить %s",

	-- F4menu
	no_extra_weapons = "У этой профессии нет особого снаряжения",
	become_job = "Стать...",
	create_vote_for_job = "Создать голосование",
	shipments = "Коробки",
	F4guns = "Оружие",
	F4entities = "Разное",
	F4ammo = "Патроны",
	F4vehicles = "Транспорт",

	-- Tab 1
	give_money = "Дать денег(тому, на кого смотрите)",
	drop_money = "Выбросить деньги",
	change_name = "Изменить имя",
	go_to_sleep = "Уснуть/проснуться",
	drop_weapon = "Выбросить оружие(которе в руках)",
	buy_health = "Купить HP(%s)",
	request_gunlicense = "Запросить лицензию",
	demote_player_menu = "Уволить игрока",


	searchwarrantbutton = "Объявить в розыск",
	unwarrantbutton = "Закрыть дело на...",
	noone_available = "Не доступно",
	request_warrant = "Запросить ордер на...",
	make_wanted = "Открыть дело на...",
	make_unwanted = "Закрыть дело на...",
	set_jailpos = "Назначить тюремную камеру",
	add_jailpos = "Добавить тюремную камеру",

	set_custom_job = "Сменить название професии(Нажмите Enter для активации)",

	set_agenda = "Редактировать повестку дня(Нажмите Enter для активации)",

	initiate_lockdown = "Начать ком.час",
	stop_lockdown = "Остановить ком.час",
	start_lottery = "Начать лоттерею",
	give_license_lookingat = "Дать лицензию(тому, на кого смотрите)",

	laws_of_the_land = "LAWS OF THE LAND",
	law_added = "Law added.",
	law_removed = "Law removed.",
	law_too_short = "Law too short.",
	laws_full = "The laws are full.",
	default_law_change_denied = "You are not allowed to change the default laws.",

	-- Second tab
	job_name = "Название: ",
	job_description = "Описание: ",
	job_weapons = "Снаряжение: ",

	-- Entities tab
	buy_a = "Buy %s: %s",

	-- Licenseweaponstab
	license_tab = [[License weapons

	Tick the weapons people should be able to get WITHOUT a license!
	]],
	license_tab_other_weapons = "Other weapons:",

	zombie_spawn_removed = "You have removed this zombie spawn.",
	zombie_spawn = "Zombie Spawn",
	zombie_disabled = "Zombies are now disabled.",
	zombie_enabled = "Zombies are now enabled.",
	zombie_maxset = "Maximum amount of zombies is now set to %s",
	zombie_spawn_added = "You have added a zombie spawn.",
	zombie_spawn_not_exist = "Zombie Spawn %s does not exist.",
	zombie_leaving = "Zombies are leaving.",
	zombie_approaching = "WARNING: Zombies are approaching!",
	zombie_toggled = "Zombies toggled.",
}

-- The language code is usually (but not always) a two-letter code. The default language is "en".
-- Other examples are "nl" (Dutch), "de" (German)
-- If you want to know what your language code is, open GMod, select a language at the bottom right
-- then enter gmod_language in console. It will show you the code.
-- Make sure language code is a valid entry for the convar gmod_language.
DarkRP.addLanguage("en", my_language)