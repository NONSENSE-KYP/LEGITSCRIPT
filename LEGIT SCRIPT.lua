--Define
scriptver = "1.0.9"
notifycolor = 175
notifyset = 2
inputstyle = 0
renderfont = 0
--API Simplification
newfunc = menu.add_feature
newplfunc = menu.add_player_feature
CD = system.wait
TSE = script.trigger_script_event
joaat = gameplay.get_hash_key
cleartask = ped.clear_ped_tasks_immediately

--Input Resolver
function getinput(textabouve, default, maxlength, inputtype)
	textabouve = textabouve or "请输入"
	if notifyset == 0 then
		return input.get(textabouve, default, maxlength, inputtype)
	elseif notifyset == 1 then
		gameplay.display_onscreen_keyboard(textabove, default, maxlength)
		while (gameplay.update_onscreen_keyboard() == false) do
			CD(0)
		end	
		return gameplay.get_onscreen_keyboard_result()
	end
end
--Logger
function logg(content)
    local ostime = os.date("%Y-%m-%d %H:%M:%S")
    local f = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\2Take1Menu.log", "a+")
    print("[" .. ostime .. "]" .. " " .. content)
    f:write("[" .. ostime .. "]" .. " " .. content .. "\n")
    f:close()
end
--Config Creator
local funclist = {
	{"fakegod", "bool"},
	{"fakegodnum", "int"},
	{"kickhostloop", "bool"},
	{"kickshloop", "bool"},
	{"hostlist", "bool"},
	{"modderdetect", "bool"},
	{"admasterswitch", "bool"},
	{"adrecovery", "bool"},
	{"adsexual", "bool"},
	{"adkick", "bool"},
	{"adcrash", "bool"},
	{"adcrap", "bool"},
	{"adnotbelieve", "bool"},
	{"adoverride", "bool"},
	{"chatcommand", "bool"},
	{"platespeedo", "bool"},
	{"unlockable", "bool"},
	{"mk2instacharge", "bool"},
	{"automissile", "bool"},
	{"rgbheadlight", "bool"},
	{"rgbtire", "bool"},
	{"rgbneon", "bool"},
	{"rgbpaint", "bool"},
	{"modelchangedetect", "bool"},
	{"spectatedetect", "bool"},
	{"karmavk", "bool"},
	{"karmact", "bool"},
	{"lobbyinfo", "bool"},
	{"playerinfo", "bool"},
	{"playerspeedo", "bool"},
	{"notifypref", "int"},
	{"inputpref", "int"},
	{"fontpref", "int"},
	{"fontsize", "float"},
	{"rgbrender", "bool"},
}
local funclistbackend = 
{
	fakegod,
	fakegodnum,
	kickhost,
	kicksh,
	hostlist,
	seshackdetkt,
	admain,
	recovery,
	sex,
	autokick,
	autocrash,
	fraud,
	blankreplace,
	chatcommandswitch,
	platespeedo,
	unlockable,
	mk2instacharge,
	automissile,
	rainbowlight,
	rainbowtire,
	rainbowneon,
	rainbowcolor,
	mdlchgdetkt,
	spectatedetkt,
	karmavotekick,
	karmafreeze,
	lobbyinfo,
	playerinfo,
	speedo,
	notifypref,
	fontpref,
	fontsize,
	rainbowall
}

function createconfig()
	if (utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini") == false) then
		local f = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini", "w+")
		f:write("[LEGIT SCRIPT CONFIG]\n")
		f:close()
	end
	local cfg = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini", "a+")
	local cfgstr = cfg:read("*a")
	for i = 1 , #funclist do
		if not (string.match(cfgstr,funclist[i][1])) then
			if (funclist[i][2] == "bool") then
				cfg:write(funclist[i][1].."=".."false\n")
			else
				cfg:write(funclist[i][1].."=".."0\n")
			end
		end
	end
	cfg:close()
end
createconfig()
--Notification
function NOTG(cont, above)
	above = above or "LEGIT SCRIPT"
    if notifyset == 0 then
        ui.notify_above_map(cont, above, notifycolor)
    elseif notifyset == 1 then
        menu.notify(cont, above, 5, notifycolor)
    elseif notifyset == 2 then
        ui.notify_above_map(cont, above, notifycolor)
        menu.notify(cont, above, 5, notifycolor)
    end
end

--Initialization
print(
    "#   ###  ## ### ###      ##  ## ##  ### ##  ###" ..
        "\n#   #   #    #   #      #   #   # #  #  # #  #" ..
            "\n#   ##  # #  #   #       #  #   ##   #  ##   #" ..
                "\n#   #   # #  #   #        # #   # #  #  #    #" .. "\n### ###  ## ###  #      ##   ## # # ### #    #"
)
logg("[Initialization] LEGIT SCRIPT INITIALIZED")
logg("[Initialization] Menu Version: " .. menu.get_version())
logg("[Initialization] Script Version: " .. scriptver)
function threadcheck()
    if menu.is_threading_mode(1) then
        logg("[Initialization] Menu Threading Mode: Hijack")
    end
    if menu.is_threading_mode(2) then
        logg("[Initialization] Menu Threading Mode: Fiber")
        logg("[Initialization] Please Change Your Threading Mode To Hijack.")
    end
end
threadcheck()
function trusttest()
    if not menu.is_trusted_mode_enabled() then
        logg("[Initialization] Please enable trust mode in menu settings.")
        NOTG("请打开信任模式")
    end
end
trusttest()
--Model&Hash Lists
sceneriolist = {
    {"WORLD_HUMAN_AA_COFFEE", "拿杯咖啡"},
    {"WORLD_HUMAN_AA_SMOKE", "手上夹根烟"},
    {"PROP_HUMAN_ATM", "提款机取钱"},
    {"PROP_HUMAN_BBQ", "凭空BBQ烤肉"},
    {"WORLD_HUMAN_BINOCULARS", "拿望远镜看"},
    {"WORLD_BOAR_GRAZING", "狗交配"},
    {"PROP_HUMAN_BUM_BIN", "半身不遂"},
    {"WORLD_HUMAN_BUM_FREEWAY", "拿出求救信"},
    {"PROP_HUMAN_BUM_SHOPPING_CART", "靠着栏杆呆着"},
    {"WORLD_HUMAN_BUM_SLUMPED", "躺着"},
    {"WORLD_HUMAN_BUM_STANDING", "揣手手"},
    {"WORLD_HUMAN_BUM_WASH", "有点累了"},
    {"WORLD_HUMAN_CAR_PARK_ATTENDANT", "拿荧光棒挥舞"},
    {"WORLD_CAT_SLEEPING_GROUND", "猫睡觉"},
    {"WORLD_CAT_SLEEPING_LEDGE", "猫睡觉2"},
    {"WORLD_HUMAN_CHEERING", "拍手叫好"},
    {"WORLD_CHICKENHAWK_FEEDING", "鹰吃食"},
    {"WORLD_CHICKENHAWK_STANDING", "鹰站立"},
    {"WORLD_HUMAN_CLIPBOARD", "拿出清单"},
    {"WORLD_HUMAN_CONST_DRILL", "凿地"},
    {"WORLD_HUMAN_COP_IDLES", "闲着没事"},
    {"WORLD_CORMORANT_STANDING", "鸬鹚站立"},
    {"WORLD_COW_GRAZING", "牛吃草"},
    {"WORLD_COYOTE_HOWL", "狼嚎"},
    {"WORLD_COYOTE_REST", "狼休息"},
    {"CODE_HUMAN_CROSS_ROAD_WAIT", "十字路口等待"},
    {"WORLD_CROW_FEEDING", "乌鸦吃食"},
    {"WORLD_CROW_STANDING", "乌鸦站立"},
    {"WORLD_DEER_GRAZING", "鹿吃草"},
    {"WORLD_DOG_BARKING_RETRIEVER", "狗叫(猎犬动作)"},
    {"WORLD_DOG_BARKING_ROTTWEILER", "狗叫(罗特维尔犬动作)"},
    {"WORLD_DOG_BARKING_SHEPHERD", "狗叫(牧羊犬动作)"},
    {"WORLD_DOG_BARKING_SMALL", "小狗叫"},
    {"WORLD_DOG_SITTING_RETRIEVER", "狗坐(猎犬动作)"},
    {"WORLD_DOG_SITTING_ROTTWEILER", "狗坐(罗特维尔犬动作)"},
    {"WORLD_DOG_SITTING_SHEPHERD", "狗叫(牧羊犬动作)"},
    {"WORLD_DOG_SITTING_SMALL", "小狗坐"},
    {"WORLD_HUMAN_DRINKING", "拿着饮料"},
    {"WORLD_HUMAN_DRUG_DEALER", "抽根华子(有吸烟动作)"},
    {"WORLD_HUMAN_DRUG_DEALER_HARD", "不抽华子了 (踩烟动作)"},
    {"WORLD_HUMAN_GARDENER_LEAF_BLOWER", "拿吸尘器吸草"},
    {"WORLD_HUMAN_GARDENER_PLANT", "蹲下拔草"},
    {"WORLD_HUMAN_GOLF_PLAYER", "拿出高尔夫球杆呆着"},
    {"WORLD_HUMAN_GUARD_STAND", "保安专属动作"},
    {"WORLD_GULL_FEEDING", "海鸥啄食"},
    {"WORLD_GULL_STANDING", "海鸥站立"},
    {"WORLD_HUMAN_HAMMERING", "拿个锤子瞎砸"},
    {"WORLD_HEN_PECKING", "母鸡啄米"},
    {"WORLD_HEN_STANDING", "母鸡站立"},
    {"WORLD_HUMAN_HIKER_STANDING", "揪着自己脖领子"},
    {"WORLD_HUMAN_HUMAN_STATUE", "行为艺术宁懂么？"},
    {"WORLD_HUMAN_JANITOR", "扫地"},
    {"WORLD_HUMAN_JOG", "慢跑"},
    {"WORLD_HUMAN_JOG_STANDING", "站着慢跑"},
    {"WORLD_HUMAN_LEANING", "柜姐专属姿势（男角色用非常娘炮）"},
    {"WORLD_HUMAN_MAID_CLEAN", "擦擦空气"},
    {"CODE_HUMAN_MEDIC_KNEEL", "擦擦下巴不知道找啥"},
    {"CODE_HUMAN_MEDIC_TEND_TO_DEAD", "半蹲下来（类似单膝下跪）"},
    {"CODE_HUMAN_MEDIC_TIME_OF_DEATH", "拿出笔记写"},
    {"WORLD_HUMAN_MOBILE_FILM_SHOCKING", "拿出手机拍照(老臭美了)"},
    {"WORLD_MOUNTAIN_LION_REST", "狮子休息"},
    {"PROP_HUMAN_MUSCLE_CHIN_UPS", "狮子游荡"},
    {"PROP_HUMAN_MUSCLE_CHIN_UPS_ARMY", "引体向上(军人)"},
    {"PROP_HUMAN_MUSCLE_CHIN_UPS_PRISON", "引体向上(犯人)"},
    {"WORLD_HUMAN_MUSCLE_FLEX", "秀秀身材（闻闻咯吱窝）"},
    {"WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", "举杠铃玩"},
    {"WORLD_HUMAN_MUSICIAN", "玩玩乐器（再按可切换其他乐器 随机）"},
    {"WORLD_HUMAN_PAPARAZZI", "拿出单反相机"},
    {"PROP_HUMAN_PARKING_METER", "玩空气手机"},
    {"WORLD_HUMAN_PARTYING", "拿出啤酒 边喝边晃悠"},
    {"WORLD_HUMAN_PICNIC", "累了找地方坐一会儿"},
    {"WORLD_PIG_GRAZING", "猪吃东西"},
    {"WORLD_PIGEON_FEEDING", "鸽子吃食"},
    {"WORLD_PIGEON_STANDING", "鸽子站立"},
    {"CODE_HUMAN_POLICE_CROWD_CONTROL", "警察呆着"},
    {"CODE_HUMAN_POLICE_INVESTIGATE", "警察叉腰"},
    {"WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "单手叉腰（死娘炮）"},
    {"WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "喝多了的婊子（夹腿）"},
    {"WORLD_HUMAN_PUSH_UPS", "俯卧撑"},
    {"WORLD_RABBIT_EATING", "兔子吃东西"},
    {"WORLD_RATS_EATING", "老鼠吃东西"},
    {"PROP_HUMAN_SEAT_ARMCHAIR", "坐着看"},
    {"PROP_HUMAN_SEAT_BAR", "上课坐课桌听讲"},
    {"PROP_HUMAN_SEAT_BENCH", "坐着"},
    {"PROP_HUMAN_SEAT_BENCH_DRINK", "拿着咖啡坐着"},
    {"PROP_HUMAN_SEAT_BENCH_DRINK_BEER", "拿着啤酒坐着"},
    {"PROP_HUMAN_SEAT_BENCH_FOOD", "拿着面包坐着"},
    {"PROP_HUMAN_SEAT_BUS_STOP_WAIT", "坐着看戏"},
    {"PROP_HUMAN_SEAT_CHAIR", "坐着呆着"},
    {"PROP_HUMAN_SEAT_CHAIR_DRINK", "拿着咖啡坐着"},
    {"PROP_HUMAN_SEAT_CHAIR_DRINK_BEER", "拿着酒坐着"},
    {"PROP_HUMAN_SEAT_CHAIR_FOOD", "拿着面包坐着"},
    {"PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "纯坐着"},
    {"PROP_HUMAN_SEAT_CHAIR_UPRIGHT", "纯坐着"},
    {"PROP_HUMAN_SEAT_DECKCHAIR", "拿出瓶装饮料"},
    {"PROP_HUMAN_SEAT_DECKCHAIR_DRINK", "拿出瓶装饮料2"},
    {"WORLD_HUMAN_SEAT_LEDGE", "在高处坐着"},
    {"WORLD_HUMAN_SEAT_LEDGE_EATING", "在高处坐着吃甜甜圈"},
    {"PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS", "举着杠铃"},
    {"PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON", "举着杠铃(犯人)"},
    {"WORLD_HUMAN_SEAT_STEPS", "在楼梯上坐着"},
    {"PROP_HUMAN_SEAT_STRIP_WATCH", "坐着摇头"},
    {"PROP_HUMAN_SEAT_SUNLOUNGER", "沙滩躺椅上躺着"},
    {"WORLD_HUMAN_SEAT_WALL", "在高处坐着2"},
    {"WORLD_HUMAN_SEAT_WALL_EATING", "在高处坐着吃甜甜圈2"},
    {"WORLD_HUMAN_SECURITY_SHINE_TORCH", "拿出手电"},
    {"WORLD_HUMAN_SIT_UPS", "仰卧起坐"},
    {"WORLD_HUMAN_SMOKING", "抽根华子（完整版动作）"},
    {"WORLD_HUMAN_SMOKING_POT", "抽根华子（完整版动作2）"},
    {"WORLD_HUMAN_STAND_FIRE", "坐立不安"},
    {"WORLD_HUMAN_STAND_FISHING", "拿出鱼竿钓鱼"},
    {"WORLD_HUMAN_STAND_MOBILE", "玩会儿手机"},
    {"WORLD_HUMAN_STAND_MOBILE_UPRIGHT", "玩会儿手机2"},
    {"WORLD_HUMAN_STRIP_WATCH_STAND", "身体瞎晃悠"},
    {"WORLD_HUMAN_STUPOR", "喝多了坐地上了"},
    {"WORLD_HUMAN_SUNBATHE", "爬地上待会儿"},
    {"WORLD_HUMAN_SUNBATHE_BACK", "躺地上手托着脑袋（老惬意了）"},
    {"WORLD_HUMAN_TENNIS_PLAYER", "拿出网球拍"},
    {"WORLD_HUMAN_TOURIST_MAP", "拿出地图"},
    {"WORLD_HUMAN_TOURIST_MOBILE", "拿出手机"},
    {"WORLD_HUMAN_VEHICLE_MECHANIC", "被车撞到了 (碰瓷儿)"},
    {"WORLD_HUMAN_WELDING", "电焊工"},
    {"WORLD_HUMAN_WINDOW_SHOP_BROWSE", "眼神直勾的"},
    {"WORLD_HUMAN_YOGA", "瑜伽（再按可切换另一套动作）"}
}
--PTFX List
ptfxlist = {
    {"sp_petrolcan_splash_CS", "cut_agencyheist"},
    {"cs_agency_toaster_smoke", "cut_agencyheist"},
    {"cs_weap_petrol_can", "cut_agencyheist"},
    {"cs_amb_tv_peeing", "cut_amb_tv"},
    {"liquid_splash_pee", "cut_amb_tv"},
    {"cs_mich1_lighter_flame", "cut_amb_tv"},
    {"cs_amb_tv_book_burn", "cut_amb_tv"},
    {"cs_amb_tv_sauna_steam", "cut_amb_tv"},
    {"cs_mich1_lighter_sparks", "cut_amb_tv"},
    {"cs_arena_car_exhaust", "cut_arena"},
    {"cs_arm2_muz_smg", "cut_armenian1"},
    {"cs_ped_foot_dusty", "cut_armenian1"},
    {"eject_minigun", "cut_armenian2"},
    {"eject_auto", "cut_armenian2"},
    {"muz_assault_rifle", "cut_armenian2"},
    {"cs_bike_exhaust", "cut_armenian2"},
    {"blood_entry", "cut_armenian2"},
    {"eject_pistol", "cut_armenian2"},
    {"muz_smg", "cut_armenian2"},
    {"muz_pistol", "cut_armenian2"},
    {"veh_exhaust_car", "cut_armenian2"},
    {"cs_dry_ice_point", "cut_bigscore"},
    {"cs_dry_ice_freezer_floor", "cut_bigscore"},
    {"cs_dry_ice_freezer_door", "cut_bigscore"},
    {"cs_bigscr_eject_shotgun", "cut_bigscr"},
    {"cs_bigscr_muz_shotgun", "cut_bigscr"},
    {"cs_bigscr_muz_ar", "cut_bigscr"},
    {"cs_bigscr_beer_spray", "cut_bigscr"},
    {"cs_bigscr_eject_auto", "cut_bigscr"},
    {"cs_bigscr_cig_smoke", "cut_bigscr"},
    {"cs_bigscr_muz_smg", "cut_bigscr"},
    {"cs_bigscr_cig_exhale_mouth", "cut_bigscr"},
    {"cut_bigscr_vomit", "cut_bigscr"},
    {"cs_wheel_fric_sand_Bike", "cut_carsteal1"},
    {"veh_exhaust_car", "cut_carsteal1"},
    {"cs_car2_bang_blood", "cut_carsteal5"},
    {"veh_exhaust_car", "cut_carsteal5"},
    {"cs_ch1_bourbon_pour", "cut_chinese1"},
    {"cs_dry_ice_point", "cut_chinese1"},
    {"cs_ch1_veh_exhaust_car", "cut_chinese1"},
    {"cs_head_kick_blood", "cut_chinese1"},
    {"cs_cig_exhale_mouth", "cut_chinese1"},
    {"cs_cig_smoke", "cut_chinese1"},
    {"cs_dry_ice_freezer_floor", "cut_chinese1"},
    {"cs_dry_ice_freezer_door", "cut_chinese1"},
    {"cs_cig_exhale_nose", "cut_chinese1"},
    {"cs_ch1_head_bang_blood", "cut_chinese1"},
    {"ent_amb_sparking_wires_sm_sp", "cut_exile1"},
    {"cs_ex1_plane_spark_L", "cut_exile1"},
    {"cs_ex1_plane_spark_R", "cut_exile1"},
    {"ent_amb_peeing", "cut_exile1"},
    {"liquid_splash_pee", "cut_exile1"},
    {"bul_carmetal", "cut_exile1"},
    {"bullet_shotgun_tracer", "cut_exile1"},
    {"cs_ex1_plane_debris_trail", "cut_exile1"},
    {"cs_ex1_wing_smoulder", "cut_exile1"},
    {"eject_shotgun", "cut_exile1"},
    {"cs_ex1_plane_break_L", "cut_exile1"},
    {"muz_shotgun", "cut_exile1"},
    {"cs_ex1_plane_impacts", "cut_exile1"},
    {"cs_ex1_sparking_wires_sm", "cut_exile1"},
    {"cs_ex1_plane_break_R", "cut_exile1"},
    {"cs_ex1_elec_malfunction", "cut_exile1"},
    {"muz_pistol", "cut_exile1"},
    {"cs_ex1_cargo_fire", "cut_exile1"},
    {"cs_exile2_gas_liquid_pour", "cut_exile2"},
    {"wheel_fric_sand", "cut_exile2"},
    {"cs_fridge_door_cold_mist", "cut_exile2"},
    {"cs_ex2_jeep_crash", "cut_exile2"},
    {"sp_petrolcan_splash_CS", "cut_exile2"},
    {"cs_exile2_iron_steam", "cut_exile2"},
    {"scr_ex2_jeep_engine_fire", "cut_exile2"},
    {"cs_weap_petrol_can", "cut_exile2"},
    {"cs_ex3_wheel_spin", "cut_exile3"},
    {"cs_ex1_water_body", "cut_exile3"},
    {"cs_ex1_water_box", "cut_exile3"},
    {"cs_ex3_sand_dust", "cut_exile3"},
    {"cs_ex1_water_arms", "cut_exile3"},
    {"cs_ex3_water_drips", "cut_exile3"},
    {"cs_extr_bang_dirt", "cut_extreme"},
    {"cs_ped_foot_dusty", "cut_extreme"},
    {"cs_cig_smoke_stub_out", "cut_family1"},
    {"cs_cig_exhale_mouth", "cut_family1"},
    {"cs_cig_smoke", "cut_family1"},
    {"cs_fam6_hair_snip", "cut_family1"},
    {"cs_mich1_lighter_flame", "cut_family1"},
    {"cs_cig_exhale_nose", "cut_family1"},
    {"cs_fam1_bourbon_pour", "cut_family1"},
    {"cs_mich1_lighter_sparks", "cut_family1"},
    {"veh_exhaust_car", "cut_family1"},
    {"cs_cig_smoke_stub_out", "cut_family2"},
    {"cs_cig_exhale_mouth", "cut_family2"},
    {"cs_cig_smoke_inhale", "cut_family2"},
    {"cs_cig_smoke", "cut_family2"},
    {"cs_fam2_radio_splash", "cut_family2"},
    {"cs_fam2_foot_sand", "cut_family2"},
    {"cs_fam2_ped_splash", "cut_family2"},
    {"ped_water_drips", "cut_family2"},
    {"cs_cig_exhale_nose", "cut_family2"},
    {"cs_fam2_ped_water_splash", "cut_family2"},
    {"cs_water_splash_jetski", "cut_family2"},
    {"cs_fam3_drool_drip", "cut_family3"},
    {"cs_cig_smoke", "cut_family3"},
    {"cs_fam3_brk_pot_plant", "cut_family3"},
    {"cs_fam3_cig_exhale_mouth", "cut_family3"},
    {"cs_mich1_lighter_flame", "cut_family3"},
    {"cs_cig_exhale_nose", "cut_family3"},
    {"cs_mich1_lighter_sparks", "cut_family3"},
    {"cs_fam4_fridge_door", "cut_family4"},
    {"cs_fam4_juice_pour", "cut_family4"},
    {"cs_fam4_water_pour", "cut_family4"},
    {"cs_fam4_juice_spit", "cut_family4"},
    {"cs_fam4_juice_splash", "cut_family4"},
    {"cs_fam4_shot_chandelier", "cut_family4"},
    {"cs_fam4_whiskey_splash", "cut_family4"},
    {"wheel_decal_water_deep", "cut_family4"},
    {"cs_fam4_liquid_broccoli", "cut_family4"},
    {"cs_fam4_juice_shot", "cut_family4"},
    {"cs_fam4_whiskey_pour", "cut_family4"},
    {"water_splash_veh_wade", "cut_family4"},
    {"muz_pistol", "cut_family4"},
    {"cs_fam5_water_splash_ped_out", "cut_family5"},
    {"cs_fam5_water_splash_ped", "cut_family5"},
    {"cs_alien_light_bed", "cut_family5"},
    {"cs_fam5_bourbon_pour", "cut_family5"},
    {"cs_alien_hand_light", "cut_family5"},
    {"cs_cig_exhale_mouth", "cut_family5"},
    {"cs_cig_smoke", "cut_family5"},
    {"cs_fam5_water_splash_ped_in", "cut_family5"},
    {"ped_breath_water", "cut_family5"},
    {"cs_fam4_whiskey_splash", "cut_family5"},
    {"cs_mich1_lighter_flame", "cut_family5"},
    {"cs_cig_exhale_nose", "cut_family5"},
    {"cs_fam5_ped_water_drips", "cut_family5"},
    {"cs_fam5_water_splash_ped_wade", "cut_family5"},
    {"ped_underwater_trails", "cut_family5"},
    {"cs_fam5_michael_pool_splash", "cut_family5"},
    {"cs_mich1_lighter_sparks", "cut_family5"},
    {"cs_fib2_blood_hand", "cut_fbi2"},
    {"veh_downwash", "cut_fbi2"},
    {"ped_foot_dirt_dry", "cut_fbi2"},
    {"cs_wheel_fric_sand_Bike", "cut_fbi3"},
    {"cs_cig_exhale_mouth", "cut_fbi3"},
    {"cs_cig_smoke", "cut_fbi3"},
    {"cs_mich1_lighter_flame", "cut_fbi3"},
    {"cs_cig_exhale_nose", "cut_fbi3"},
    {"cs_mich1_lighter_sparks", "cut_fbi3"},
    {"cs_fib3_syringe", "cut_fbi3"},
    {"cs_water_stone_throw", "cut_fbi4"},
    {"cs_fbi5a_blood_entry", "cut_fbi5a"},
    {"wheel_fric_sand", "cut_fbi5a"},
    {"cs_fbi5a_muz_pistol", "cut_fbi5a"},
    {"ped_talk_water", "cut_fbi5a"},
    {"cs_trev1_dusty_kick", "cut_fbi5a"},
    {"ped_water_drips", "cut_fbi5a"},
    {"ped_foot_dusty", "cut_fbi5b"},
    {"cs_cig_exhale_mouth", "cut_fbi5b"},
    {"cs_cig_smoke", "cut_fbi5b"},
    {"cs_cig_exhale_nose", "cut_fbi5b"},
    {"veh_exhaust_hidden", "cut_finale1"},
    {"cs_wheel_fric_sand_Bike", "cut_finale1"},
    {"cs_finale2_dust_cloud", "cut_finale1"},
    {"cs_finale1_car_explosion_surge_spawn", "cut_finale1"},
    {"cs_fin_car_radiator_smoke", "cut_finale1"},
    {"cs_finale1_car_splash_impact", "cut_finale1"},
    {"cs_fin_bul_carmetal", "cut_finale1"},
    {"cs_cig_exhale_mouth", "cut_finale1"},
    {"cs_finale1_car_splash", "cut_finale1"},
    {"cs_fbi5a_muz_pistol", "cut_finale1"},
    {"cs_cig_exhale_mouth_finale", "cut_finale1"},
    {"cs_cig_smoke", "cut_finale1"},
    {"wheel_fric_dirt_dry", "cut_finale1"},
    {"cs_fin_car_impact", "cut_finale1"},
    {"bang_carmetal", "cut_finale1"},
    {"cs_mich1_lighter_flame", "cut_finale1"},
    {"cs_fin_car_cliff_debris", "cut_finale1"},
    {"veh_exhaust_truck", "cut_finale1"},
    {"cs_finale1_car_explosion", "cut_finale1"},
    {"cs_cig_exhale_nose", "cut_finale1"},
    {"cs_finale_car_explosion_splashes_spawn", "cut_finale1"},
    {"exp_grd_rpg_spawn", "cut_finale1"},
    {"cs_fin_bang_carmetal", "cut_finale1"},
    {"cs_finale3_punch_blood", "cut_finale1"},
    {"cs_mich1_lighter_sparks", "cut_finale1"},
    {"cs_water_splash_jetski", "cut_finale1"},
    {"veh_exhaust_car", "cut_finale1"},
    {"cs_franklin0_scrape_bike", "cut_franklin0"},
    {"wheel_burnout", "cut_franklin0"},
    {"wheel_fric_hard_Bike", "cut_franklin0"},
    {"cs_franklin0_dog_shake", "cut_franklin0"},
    {"cs_franklin0_dog_drool", "cut_franklin0"},
    {"veh_exhaust_car", "cut_franklin0"},
    {"cs_frank1_coke_sniff", "cut_franklin1"},
    {"cs_frank1_coke_impact", "cut_franklin1"},
    {"cs_franklin1_dry_wall", "cut_franklin1"},
    {"cs_frank1_coke_drip", "cut_franklin1"},
    {"cs_water_splash_jetski", "cut_franklin1"},
    {"cs_gr_muz_assault_rifle", "cut_gr_intro"},
    {"exp_hum_fin_heli_sp", "cut_humane_fin"},
    {"ped_foot_dusty", "cut_humane_fin"},
    {"exp_hum_fin_heli_spawn", "cut_humane_fin"},
    {"sp_hum_fin_heli_fire_trail", "cut_humane_fin"},
    {"exp_hum_fin_heli", "cut_humane_fin"},
    {"wheel_fric_hard_dusty", "cut_humane_fin"},
    {"veh_exhaust_car", "cut_humane_fin"},
    {"bul_concrete", "cut_humane_key"},
    {"bul_carmetal", "cut_humane_key"},
    {"blood_entry", "cut_humane_key"},
    {"eject_pistol", "cut_humane_key"},
    {"muz_pistol", "cut_humane_key"},
    {"bullet_tracer_xm_thruster_mg", "cut_iaaj"},
    {"muz_xm_thruster_mg", "cut_iaaj"},
    {"veh_thruster_jet", "cut_iaaj"},
    {"veh_xm_thruster_afterburner", "cut_iaaj"},
    {"cs_jewel_door_smoke", "cut_jewelheist"},
    {"cs_jh_bourbon_pour", "cut_jewelheist"},
    {"cs_cig_exhale_mouth", "cut_jewelheist"},
    {"cs_cig_smoke", "cut_jewelheist"},
    {"cs_jewel_grenade_burst", "cut_jewelheist"},
    {"cs_cig_exhale_nose", "cut_jewelheist"},
    {"scr_jewel_haze", "cut_jewelheist"},
    {"cs_jh_bourbon_pour", "cut_jh_trev"},
    {"cs_trev1_crackpipe_smoke", "cut_jh_trev"},
    {"cs_head_kick_blood", "cut_jh_trev"},
    {"cs_trev1_beer_bottle", "cut_jh_trev"},
    {"cs_cig_exhale_mouth", "cut_jh_trev"},
    {"cs_cig_smoke", "cut_jh_trev"},
    {"cs_trev1_dusty_kick", "cut_jh_trev"},
    {"cs_trev1_lighter_sparks", "cut_jh_trev"},
    {"cs_trev1_trailer_wash", "cut_jh_trev"},
    {"cs_trev1_lighter_flame", "cut_jh_trev"},
    {"cs_cig_exhale_nose", "cut_jh_trev"},
    {"scr_josh3_house_smoked", "cut_josh_4"},
    {"cs_lemar_blood_entry", "cut_lamar1"},
    {"blood_entry", "cut_lamar1"},
    {"cs_cig_smoke_lamar", "cut_lamar1"},
    {"muz_pistol", "cut_lamar1"},
    {"cs_cig_exhale_mouth", "cut_lester1a"},
    {"cs_cig_smoke", "cut_lester1a"},
    {"cs_mich1_lighter_flame", "cut_lester1a"},
    {"cs_cig_exhale_nose", "cut_lester1a"},
    {"cs_lest1_cig_smoke", "cut_lester1a"},
    {"cs_mich1_lighter_sparks", "cut_lester1a"},
    {"scr_blood_head_entry", "cut_lester1b"},
    {"cs_lest1_phone_exp", "cut_lester1b"},
    {"scr_exp_phone_head", "cut_lester1b"},
    {"scr_camera_flash", "cut_lester1b"},
    {"scr_blood_head_exit", "cut_lester1b"},
    {"cs_sol1_plane_wreck_smoke", "cut_martin1"},
    {"scr_sol1_plane_wreck", "cut_martin1"},
    {"cs_martin1_wheel_dust", "cut_martin1"},
    {"cs_mich1_pick_dirt_impact", "cut_michael1"},
    {"cs_cig_smoke_stub_out", "cut_michael1"},
    {"cs_mich1_spade_dirt_throw", "cut_michael1"},
    {"cs_mich1_tool_dirt_impact", "cut_michael1"},
    {"cs_cig_exhale_mouth", "cut_michael1"},
    {"cs_ped_foot_snow", "cut_michael1"},
    {"cs_cig_smoke", "cut_michael1"},
    {"cs_mich1_breath", "cut_michael1"},
    {"cs_mich1_pick_dirt_trail", "cut_michael1"},
    {"bul_carmetal", "cut_michael1"},
    {"veh_exhaust_vulkan", "cut_michael1"},
    {"cs_mich1_spade_dirt_impact", "cut_michael1"},
    {"cs_mich1_spade_dirt_trail", "cut_michael1"},
    {"eject_pistol", "cut_michael1"},
    {"cs_cig_exhale_nose", "cut_michael1"},
    {"muz_pistol", "cut_michael1"},
    {"eject_auto", "cut_michael2"},
    {"cs_bul_concrete", "cut_michael2"},
    {"muz_assault_rifle", "cut_michael2"},
    {"cs_mich2_blood_nose", "cut_michael2"},
    {"liquid_splash_blood", "cut_michael2"},
    {"cs_ped_foot_snow", "cut_michael2"},
    {"cs_mich_bul_carmetal", "cut_michael2"},
    {"cs_mich2_mud_flower", "cut_michael2"},
    {"cs_chaingun_muz", "cut_michael2"},
    {"eject_pistol", "cut_michael2"},
    {"muz_pistol", "cut_michael2"},
    {"cs_mich2_blood_head_leak", "cut_michael2"},
    {"eject_auto", "cut_minute2"},
    {"muz_assault_rifle", "cut_minute2"},
    {"cs_mich3_blood_entry", "cut_minute2"},
    {"ped_foot_dusty", "cut_minute2"},
    {"cs_mich3_blood_exit", "cut_minute2"},
    {"cs_rc_minuteman1_spit", "cut_minute2"},
    {"eject_pistol", "cut_minute2"},
    {"cs_mich3_head_shot", "cut_minute2"},
    {"muz_pistol", "cut_minute2"},
    {"cs_dst_impotent_rage_toy", "cut_narcotic_bike"},
    {"cs_nar_fin_trevor_splash", "cut_narcotic_fin"},
    {"cs_nar_fin_trevor_arm_drips", "cut_narcotic_fin"},
    {"cs_fam5_water_splash_ped_out", "cut_narcotic_fin"},
    {"cs_fam2_ped_splash", "cut_narcotic_fin"},
    {"eject_pistol", "cut_narcotic_fin"},
    {"muz_pistol", "cut_narcotic_fin"},
    {"bul_dirt", "cut_narcotic_fin"},
    {"cs_omega2_ambient_smoke", "cut_omega2"},
    {"cs_omega2_ufo", "cut_omega2"},
    {"bul_wood_splinter", "cut_pacific_fin"},
    {"water_boat_wash", "cut_pacific_fin"},
    {"water_boat_prop", "cut_pacific_fin"},
    {"wheel_fric_hard", "cut_pacific_fin"},
    {"cs_pac_fin_skid_smoke", "cut_pacific_fin"},
    {"water_boat_dinghy_bow", "cut_pacific_fin"},
    {"cs_paleto_vomit", "cut_paletoscore"},
    {"scr_paleto_banknotes", "cut_paletoscore"},
    {"cs_cbh_heli_gas_sign", "cut_paletoscore"},
    {"cs_cbh_heli_roof", "cut_paletoscore"},
    {"wheel_fric_sand", "cut_paletoscore"},
    {"cs_cig_exhale_mouth", "cut_paletoscore"},
    {"cs_paleto_blowtorch", "cut_paletoscore"},
    {"ent_amb_peeing", "cut_paletoscore"},
    {"cs_cig_smoke", "cut_paletoscore"},
    {"liquid_splash_pee", "cut_paletoscore"},
    {"bul_carmetal", "cut_paletoscore"},
    {"bullet_shotgun_tracer", "cut_paletoscore"},
    {"cs_paleto_bowl_steam", "cut_paletoscore"},
    {"cs_paleto_torch", "cut_paletoscore"},
    {"muz_minigun_alt", "cut_paletoscore"},
    {"eject_shotgun", "cut_paletoscore"},
    {"muz_shotgun", "cut_paletoscore"},
    {"cs_cig_exhale_nose", "cut_paletoscore"},
    {"liquid_splash_water", "cut_paletoscore"},
    {"cs_paleto_gate_kick", "cut_paletoscore"},
    {"cs_cbh_heli_smoke", "cut_paletoscore"},
    {"muz_minigun", "cut_paletoscore"},
    {"veh_exhaust_car", "cut_paletoscore"},
    {"cs_pls_sub_water_drips", "cut_portoflsheist"},
    {"cs_pls_head_bang_blood", "cut_portoflsheist"},
    {"cs_pls_ped_splash", "cut_portoflsheist"},
    {"cs_pls_tea_pour", "cut_portoflsheist"},
    {"cs_ped_foot_dusty", "cut_portoflsheist"},
    {"cs_cig_exhale_mouth", "cut_prison_break"},
    {"cs_cig_smoke_inhale", "cut_prison_break"},
    {"cs_cig_smoke", "cut_prison_break"},
    {"cs_cig_exhale_nose", "cut_prison_break"},
    {"cs_prologue_brad_blood", "cut_prologue"},
    {"eject_auto", "cut_prologue"},
    {"cs_pro_wheel_snow", "cut_prologue"},
    {"scr_prol_ped_slush", "cut_prologue"},
    {"cs_pro_train_sparks", "cut_prologue"},
    {"cs_pro_muz_shotgun", "cut_prologue"},
    {"cs_cig_exhale_mouth", "cut_prologue"},
    {"cs_prologue_tree_crash", "cut_prologue"},
    {"cs_ped_foot_snow", "cut_prologue"},
    {"cs_prologue_michael_shot", "cut_prologue"},
    {"cs_cig_smoke", "cut_prologue"},
    {"cs_pro_car_train_impact", "cut_prologue"},
    {"cs_prologue_train_crash", "cut_prologue"},
    {"cs_cig_exhale_mouth_prologue", "cut_prologue"},
    {"cs_pro_car_crash_snow", "cut_prologue"},
    {"cs_pro_blood_exit", "cut_prologue"},
    {"wheel_fric_snow_loose", "cut_prologue"},
    {"cs_pro_ped_breath", "cut_prologue"},
    {"wheel_burnout_snow", "cut_prologue"},
    {"cs_pro_car_impact", "cut_prologue"},
    {"cs_pro_muz_assault_rifle", "cut_prologue"},
    {"cs_cig_smoke_prologue", "cut_prologue"},
    {"cs_cig_exhale_nose", "cut_prologue"},
    {"cs_prologue_tire_mist", "cut_prologue"},
    {"ped_wade_snow", "cut_prologue"},
    {"cs_pro_bul_carmetal", "cut_prologue"},
    {"cs_pro_glass_smash", "cut_prologue"},
    {"veh_exhaust_car", "cut_prologue"},
    {"cs_doobie_smoke", "cut_rcbarry1"},
    {"cs_cig_exhale_mouth", "cut_rcbarry1"},
    {"cs_cig_smoke_inhale", "cut_rcbarry1"},
    {"cs_cig_smoke", "cut_rcbarry1"},
    {"cs_mich1_lighter_flame", "cut_rcbarry1"},
    {"cs_mich1_lighter_sparks", "cut_rcbarry1"},
    {"cs_cig_exhale_mouth", "cut_rcbarry2"},
    {"cs_cig_smoke", "cut_rcbarry2"},
    {"cs_camera_flash", "cut_rcdale1"},
    {"cs_rcdale1_bourbon_pour", "cut_rcdale1"},
    {"cs_rcepsilon_cola_can", "cut_rcepsilon"},
    {"liquid_splash_paint", "cut_rcepsilon"},
    {"liquid_spray_paint", "cut_rcepsilon"},
    {"cs_camera_flash", "cut_rcnigel2"},
    {"veh_panel_shut_car", "cut_rcnigel2"},
    {"cs_rcpap3_makeup", "cut_rcpaparazzo1"},
    {"cs_rcpap1_camera", "cut_rcpaparazzo1"},
    {"cs_rcpap3_litter", "cut_rcpaparazzo1"},
    {"cs_xm_lighter_flame", "cut_sil"},
    {"cs_xm_cig_exhale_mouth", "cut_sil"},
    {"cs_xm_cig_smoke", "cut_sil"},
    {"cs_xm_lighter_sparks", "cut_sil"},
    {"cs_xm_pred_cloak_full", "cut_sil"},
    {"cs_xm_pred_minigun_muz_flash", "cut_sil"},
    {"cs_xm_pred_cloak_startup", "cut_sil"},
    {"bullet_tracer_xm_thruster_mg", "cut_silj"},
    {"muz_xm_thruster_mg", "cut_silj"},
    {"cs_xm_muz_pistol", "cut_silj"},
    {"veh_thruster_jet", "cut_silj"},
    {"veh_xm_thruster_afterburner", "cut_silj"},
    {"cs_xm_prop_stromberg", "cut_silj"},
    {"cs_xm_eject_pistol", "cut_silj"},
    {"cs_xm_strom_underwater_trail", "cut_silj"},
    {"cs_sol2_coffee_steam", "cut_solomon1"},
    {"ped_foot_dusty", "cut_solomon1"},
    {"muz_pistol", "cut_solomon1"},
    {"scr_sol1_plane_smoke", "cut_solomon1"},
    {"cs_sol3b_tarmac_exp", "cut_solomon3b"},
    {"cs_cig_exhale_mouth", "cut_solomon3b"},
    {"cs_cig_smoke", "cut_solomon3b"},
    {"cs_cig_exhale_nose", "cut_solomon3b"},
    {"cs_sol3b_camera", "cut_solomon3b"},
    {"cs_sol5_blood_head_shot", "cut_solomon5"},
    {"muz_pistol", "cut_solomon5"},
    {"exp_hydrant", "=cut_test"},
    {"fire_petroltank_car", "cut_test"},
    {"cs_cig_exhale_mouth", "cut_test"},
    {"exp_hydrant_decals_sp", "cut_test"},
    {"cs_cig_smoke", "cut_test"},
    {"cs_pls_head_bang_blood", "cut_test"},
    {"cs_mich1_lighter_flame", "cut_test"},
    {"cs_cig_exhale_nose", "cut_test"},
    {"cs_mich1_lighter_sparks", "cut_test"},
    {"water_splash_ped_wade", "cut_trevor1"},
    {"veh_exhaust_hidden", "cut_trevor1"},
    {"cs_trev1_blood_pool", "cut_trevor1"},
    {"cs_trev1_crackpipe_smoke", "cut_trevor1"},
    {"cs_head_kick_blood", "cut_trevor1"},
    {"water_splash_ped_out", "cut_trevor1"},
    {"water_splash_ped_in", "cut_trevor1"},
    {"cs_trev1_ankle_water", "cut_trevor1"},
    {"cs_trev1_beer_bottle", "cut_trevor1"},
    {"cs_trev1_ped_water_splash", "cut_trevor1"},
    {"cs_trev1_wheel_spin_sand", "cut_trevor1"},
    {"cs_trev1_wheel_fric_sand_Bike", "cut_trevor1"},
    {"cs_trev1_dusty_kick", "cut_trevor1"},
    {"ped_breath_water", "cut_trevor1"},
    {"cs_trev1_lighter_sparks", "cut_trevor1"},
    {"wheel_fric_dirt_dry", "cut_trevor1"},
    {"water_splash_ped", "cut_trevor1"},
    {"veh_exhaust_truck", "cut_trevor1"},
    {"cs_trev1_trailer_wash", "cut_trevor1"},
    {"cs_meth_pipe_smoke", "cut_trevor1"},
    {"ped_water_drips", "cut_trevor1"},
    {"cs_trev1_lighter_flame", "cut_trevor1"},
    {"ped_underwater_trails", "cut_trevor1"},
    {"veh_exhaust_car", "cut_trevor1"},
    {"muz_assault_rifle", "cut_trevor2"},
    {"ped_foot_dusty", "cut_trevor2"},
    {"cs_trev5_water_pour", "cut_trevor3"},
    {"cs_trev3_dusty_body", "cut_trevor3"},
    {"cs_trev3_soap_suds", "cut_trevor3"},
    {"cs_trev5_door_splinter", "cut_trevor3"},
    {"cs_trev4_blood_splatter", "cut_trevor4"},
    {"cs_trev5_door_splinter", "cut_trevor5"},
    {"ent_ray_heli_aprtmnt_trail", "des_apartment_block"},
    {"ent_ray_big_drill_start_sparks", "des_bigjobdrill"},
    {"ent_ray_big_drill_start", "des_bigjobdrill"},
    {"sp_fbi_collapse_debris", "des_bigjobdrill"},
    {"ent_ray_big_drill_ibt", "des_bigjobdrill"},
    {"ent_ray_big_drill_trail", "des_bigjobdrill"},
    {"ent_ray_big_drill_ground_dust", "des_bigjobdrill"},
    {"ent_ray_big_drill_cloud", "des_bigjobdrill"},
    {"ent_ray_big_drill_sparks", "des_bigjobdrill"},
    {"ent_ray_big_drill_loop", "des_bigjobdrill"},
    {"ent_ray_ex1_plane_spark_R", "des_bi_plane"},
    {"ent_ray_ex1_plane_break_L", "des_bi_plane"},
    {"ent_ray_ex1_plane_spark_L", "des_bi_plane"},
    {"ent_ray_ex1_plane_break_R", "des_bi_plane"},
    {"ent_ray_arm3_sparking_wires", "des_car_show_room"},
    {"ent_ray_arm3_paper", "des_car_show_room"},
    {"ent_ray_arm3_wood_splinter", "des_car_show_room"},
    {"ent_ray_arm3_window_break", "des_car_show_room"},
    {"ent_ray_ch2_farm_CS_lights", "des_farmhouse"},
    {"ent_ray_ch2_farm_exp", "des_farmhouse"},
    {"ent_ray_ch2_farm_exp_porch_window", "des_farmhouse"},
    {"ent_ray_ch2_farm_fire_light", "des_farmhouse"},
    {"ent_ray_ch2_farm_dust_terrain", "des_farmhouse"},
    {"ent_ray_fbi5a_stairs_dust_fill", "des_fibstairs"},
    {"ent_ray_fbi5a_stairs_fragment", "des_fibstairs"},
    {"ent_ray_fbi5a_stairs_silt_fall", "des_fibstairs"},
    {"ent_ray_fbi5a_ceiling_impacts", "des_fib_ceiling"},
    {"ent_ray_fbi5a_ceiling_sprinkler", "des_fib_ceiling"},
    {"sp_agency_sparking_wires", "des_fib_ceiling"},
    {"ent_ray_fbi5a_ceiling_cable", "des_fib_ceiling"},
    {"ent_ray_fbi5a_ceiling_debris", "des_fib_ceiling"},
    {"ent_ray_fbi5a_sparking_wires", "des_fib_ceiling"},
    {"ent_ray_fbi_door_exp", "des_fib_door"},
    {"ent_ray_fbi5a_ramp_explosion", "des_fib_floor"},
    {"ent_ray_fbi5a_ramp_fragment", "des_fib_floor"},
    {"ent_ray_fbi5a_ramp_dust_impact", "des_fib_floor"},
    {"ent_ray_fbi5a_ramp_metal_imp", "des_fib_floor"},
    {"ent_ray_fbi2_window_break", "des_fib_glass"},
    {"ent_ray_fbi2_glass_drop", "des_fib_glass"},
    {"ent_ray_finale1_liquid_petrol", "des_finale"},
    {"ent_ray_finale1_liquid_nitro", "des_finale"},
    {"ent_ray_fam3_glass_break", "des_french_doors"},
    {"ent_ray_fam4_fruit_bowl", "des_fruit_bowl"},
    {"ent_ray_paleto_gas_plume_L", "des_gas_station"},
    {"ent_ray_paleto_gas_explosion", "des_gas_station"},
    {"ent_ray_paleto_gas_window_break", "des_gas_station"},
    {"ent_ray_paleto_gas_dust_terrain", "des_gas_station"},
    {"ent_ray_paleto_gas_plume", "des_gas_station"},
    {"ent_ray_paleto_gas_debris_trails", "des_gas_station"},
    {"ent_ray_paleto_gas_exp_tiles", "des_gas_station"},
    {"ent_ray_hospital_glass", "des_hospitaldoors"},
    {"ent_ray_meth_dust_terrain", "des_methtrailer"},
    {"ent_ray_meth_explosion", "des_methtrailer"},
    {"sp_prologue_debris", "des_prologue_door"},
    {"ent_ray_pro_door_sparks", "des_prologue_door"},
    {"ent_ray_pro_door_sprinkler", "des_prologue_door"},
    {"ent_ray_pro_door_light_glass", "des_prologue_door"},
    {"ent_ray_pro1_water_splash_spawn", "des_prologue_door"},
    {"ent_ray_pro_door_ceiling_debris", "des_prologue_door"},
    {"ent_ray_pro_door_embers", "des_prologue_door"},
    {"ent_ray_pro_door_fireball_light", "des_prologue_door"},
    {"ent_ray_pro_door_steam", "des_prologue_door"},
    {"ent_ray_pro_tree_crash", "des_pro_tree_crash"},
    {"ent_ray_pro_tree_crash_snow_slush", "des_pro_tree_crash"},
    {"ent_ray_pro_tree_crash_snow", "des_pro_tree_crash"},
    {"ent_ray_scaf_explosion", "des_scaffolding"},
    {"ent_ray_fam3_dust_motes", "des_scaffolding"},
    {"ent_ray_scaf_spark_bursts", "des_scaffolding"},
    {"exp_grd_petrol_pump_spawn", "des_scaffolding"},
    {"ent_ray_scaf_dust_clouds", "des_scaffolding"},
    {"ent_ray_scaf_wood_frags", "des_scaffolding"},
    {"ent_ray_scaf_fire_trails", "des_scaffolding"},
    {"ent_ray_shipwreck_exp_underwater", "des_shipwreck"},
    {"ent_ray_shipwreck_exp", "des_shipwreck"},
    {"ent_ray_shipwreck_fire_window", "des_shipwreck"},
    {"ent_ray_shipwreck_splash_L", "des_shipwreck"},
    {"ent_ray_shipwreck_pipe_impacts", "des_shipwreck"},
    {"ent_ray_shipwreck_exp_window", "des_shipwreck"},
    {"ent_ray_shipwreck_water_churn", "des_shipwreck"},
    {"ent_ray_shipwreck_splash_S", "des_shipwreck"},
    {"ent_ray_shipwreck_container_trail", "des_shipwreck"},
    {"ent_ray_shipwreck_smoke_plume", "des_shipwreck"},
    {"ent_ray_shipwreck_sparks", "des_shipwreck"},
    {"ent_ray_shipwreck_wood_debris", "des_shipwreck"},
    {"ent_ray_fbi4_sparks_point", "des_smash2"},
    {"ent_ray_fbi4_truck_slam", "des_smash2"},
    {"ent_ray_fbi4_wall_dust", "des_smash2"},
    {"ent_ray_fbi4_sparks_line", "des_smash2"},
    {"ent_ray_fbi4_wall_debris", "des_smash2"},
    {"ent_ray_fbi4_terrain_dust", "des_smash2"},
    {"ent_ray_fbi4_wall_dust_mote", "des_smash2"},
    {"ent_ray_fam3_creaking_dust", "des_stilthouse"},
    {"ent_ray_fam3_terrain_dust", "des_stilthouse"},
    {"ent_ray_fam3_concrete_frags", "des_stilthouse"},
    {"ent_ray_fam3_wood_frags", "des_stilthouse"},
    {"ent_ray_fam3_falling_leaves", "des_stilthouse"},
    {"ent_ray_fam3_dust_linger", "des_stilthouse"},
    {"ent_ray_fam3_windows", "des_stilthouse"},
    {"ent_ray_fam3_deck_fracture", "des_stilthouse"},
    {"ent_ray_fam3_wall_glass", "des_stilthouse"},
    {"ent_ray_fam3_dust_cloud", "des_stilthouse"},
    {"ent_ray_fam3_dust_trails", "des_stilthouse"},
    {"ent_ray_tanker_exp_sp", "des_tanker_crash"},
    {"ent_ray_tanker_exp", "des_tanker_crash"},
    {"exp_grd_petrol_pump_spawn", "des_tanker_crash"},
    {"ent_ray_tanker_exp_spawn", "des_tanker_crash"},
    {"sp_fire_trail_tanker_exp", "des_tanker_crash"},
    {"ent_ray_trailerpark_dust_terrain", "des_trailerpark"},
    {"ent_ray_trailerpark_window", "des_trailerpark"},
    {"ent_ray_trailerpark_fires", "des_trailerpark"},
    {"ent_ray_trailerpark_explosion_L", "des_trailerpark"},
    {"ent_ray_train_water_wash", "des_train_crash"},
    {"ent_ray_train_sparks", "des_train_crash"},
    {"ent_ray_train_debris_splash", "des_train_crash"},
    {"ent_ray_train_dust_silt", "des_train_crash"},
    {"ent_ray_meth_dust_settle", "des_train_crash"},
    {"ent_ray_train_debris2", "des_train_crash"},
    {"ent_ray_train_glass", "des_train_crash"},
    {"ent_ray_train_debris_water_splash", "des_train_crash"},
    {"ent_ray_train_debris", "des_train_crash"},
    {"scr_trev1_crash_dust", "des_train_crash"},
    {"ent_ray_train_debris_splash_spawn", "des_train_crash"},
    {"ent_ray_train_falling_debris", "des_train_crash"},
    {"ent_ray_train_impact", "des_train_crash"},
    {"ent_ray_train_splash", "des_train_crash"},
    {"ent_ray_train_sparks_trails", "des_train_crash"},
    {"ent_ray_train_smoke", "des_train_crash"},
    {"ent_sht_electrical_box_sp", "des_tv_smash"},
    {"ent_ray_fam2_tv_smash", "des_tv_smash"},
    {"ent_ray_pro1_sprinkler_burst", "des_vaultdoor"},
    {"ent_ray_pro1_floating_cash", "des_vaultdoor"},
    {"ent_ray_pro1_water_splash_spawn", "des_vaultdoor"},
    {"ent_ray_pro1_light_glass", "des_vaultdoor"},
    {"ent_ray_pro_door_steam", "des_vaultdoor"},
    {"ent_ray_pro1_vault_exp2", "des_vaultdoor"},
    {"ent_ray_pro1_residual_smoke", "des_vaultdoor"},
    {"ent_ray_pro1_sparking_wires", "des_vaultdoor"},
    {"ent_ray_pro1_bolt_sparks", "des_vaultdoor"},
    {"ent_ray_pro1_wall_smashed", "des_vaultdoor"},
    {"ent_ray_pro1_ceiling_debris", "des_vaultdoor"},
    {"ent_ray_pro1_concrete_impacts", "des_vaultdoor"},
    {"ent_ray_pro1_floor_sparks", "des_vaultdoor"},
    {"scr_drill_overheat", "fm_mission_controler"},
    {"scr_drill_debris", "fm_mission_controler"},
    {"scr_drill_out", "fm_mission_controler"},
    {"scr_heist_ornate_thermal_burn_patch", "pat_heist"},
    {"scr_indep_firework_grd_burst", "proj_indep_firework"},
    {"scr_indep_launcher_sparkle_spawn", "proj_indep_firework"},
    {"scr_indep_firework_air_burst", "proj_indep_firework"},
    {"proj_indep_flare_trail", "proj_indep_firework"},
    {"scr_firework_indep_burst_rwb", "proj_indep_firework_v2"},
    {"scr_firework_indep_spiral_burst_rwb", "proj_indep_firework_v2"},
    {"scr_xmas_firework_sparkle_spawn", "proj_indep_firework_v2"},
    {"scr_firework_indep_ring_burst_rwb", "proj_indep_firework_v2"},
    {"scr_xmas_firework_burst_fizzle", "proj_indep_firework_v2"},
    {"scr_firework_indep_repeat_burst_rwb", "proj_indep_firework_v2"},
    {"scr_firework_xmas_ring_burst_rgw", "proj_xmas_firework"},
    {"scr_firework_xmas_burst_rgw", "proj_xmas_firework"},
    {"scr_firework_xmas_repeat_burst_rgw", "proj_xmas_firework"},
    {"scr_firework_xmas_spiral_burst_rgw", "proj_xmas_firework"},
    {"scr_xmas_firework_sparkle_spawn", "proj_xmas_firework"},
    {"exp_air_snowball", "proj_xmas_snowball"},
    {"proj_snowball_fuse", "proj_xmas_snowball"},
    {"exp_grd_snowball", "proj_xmas_snowball"},
    {"proj_snowball_trail", "proj_xmas_snowball"},
    {"scr_emp_prop_light", "scr_adversary"},
    {"scr_fbi_mop_drips", "scr_agencyheist"},
    {"scr_agency3a_door_hvy_trig", "scr_agencyheist"},
    {"scr_fbi_build_exp_spawn", "scr_agencyheist"},
    {"scr_fbi_ext_blaze", "scr_agencyheist"},
    {"scr_fbi_falling_debris", "scr_agencyheist"},
    {"scr_agency_atrium_glass", "scr_agencyheist"},
    {"scr_agency3a_door_hvy_stat", "scr_agencyheist"},
    {"scr_fbi_ext_rooftop", "scr_agencyheist"},
    {"scr_fbi_exp_building", "scr_agencyheist"},
    {"sp_fire_trail", "scr_agencyheist"},
    {"scr_fbi_mop_squeeze", "scr_agencyheist"},
    {"scr_env_agency3a_arrive_deb", "scr_agencyheist"},
    {"env_smoke_fbi_stairs", "scr_agencyheist"},
    {"scr_fbi_dd_breach_smoke", "scr_agencyheist"},
    {"scr_fbi_shaft_falling_debris", "scr_agencyheist"},
    {"scr_agency3b_blding_smoke", "scr_agencyheistb"},
    {"scr_agency3b_wood_splinter", "scr_agencyheistb"},
    {"scr_fbi5b_fragment", "scr_agencyheistb"},
    {"scr_agency3b_linger_smoke", "scr_agencyheistb"},
    {"scr_agency3b_heli_expl", "scr_agencyheistb"},
    {"scr_agency_atrium_silt", "scr_agencyheistb"},
    {"scr_agency_atrium_glass", "scr_agencyheistb"},
    {"scr_agency3b_proj_rpg_trail", "scr_agencyheistb"},
    {"sp_fbi_collapse_debris", "scr_agencyheistb"},
    {"scr_agency3b_shot_chopper", "scr_agencyheistb"},
    {"proj_grenade_trail", "scr_agencyheistb"},
    {"sp_ent_sparking_wires", "scr_agencyheistb"},
    {"scr_env_agency3b_smoke", "scr_agencyheistb"},
    {"scr_agency3b_heli_spawn", "scr_agencyheistb"},
    {"scr_fbi5b_silt_fall", "scr_agencyheistb"},
    {"scr_agency_door_haze", "scr_agencyheistb"},
    {"ent_amb_fbi_live_wires", "scr_agencyheistb"},
    {"scr_agency_heli_slide_dust", "scr_agencyheistb"},
    {"scr_agency3b_heli_exp_trail", "scr_agencyheistb"},
    {"scr_agency3b_elec_box", "scr_agencyheistb"},
    {"ent_anim_dog_poo", "scr_amb_chop"},
    {"liquid_splash_pee", "scr_amb_chop"},
    {"ent_anim_dog_peeing", "scr_amb_chop"},
    {"exp_yacht_defence_plane", "scr_apartment_mp"},
    {"scr_apa_jacuzzi_wade", "scr_apartment_mp"},
    {"scr_finders_flare", "scr_apartment_mp"},
    {"scr_apa_jacuzzi_steam_sp", "scr_apartment_mp"},
    {"proj_yacht_defence_trail", "scr_apartment_mp"},
    {"scr_apa_jacuzzi_steam", "scr_apartment_mp"},
    {"muz_yacht_defence", "scr_apartment_mp"},
    {"scr_finders_package_flare", "scr_apartment_mp"},
    {"scr_apa_jacuzzi_drips", "scr_apartment_mp"},
    {"cs_water_boat_prop", "scr_armenian1"},
    {"cs_water_boat_Jetmax_bow", "scr_armenian1"},
    {"scr_arm1_wheel_skid", "scr_armenian1"},
    {"ent_anim_leaf_blower", "scr_armenian3"},
    {"scr_ar_trail_smoke_slow", "scr_ar_planes"},
    {"scr_ar_trail_smoke", "scr_ar_planes"},
    {"scr_as_target_shot_extra_small", "scr_as_target"},
    {"scr_as_target_shot_medium", "scr_as_target"},
    {"scr_as_target_shot_large", "scr_as_target"},
    {"scr_as_target_shot_small", "scr_as_target"},
    {"scr_as_trans_smoke", "scr_as_trans"},
    {"scr_as_trap_zone_circle", "scr_as_trap"},
    {"scr_as_trap_zone_rectangle", "scr_as_trap"},
    {"scr_ba_bb_flare", "scr_ba_bb"},
    {"scr_ba_bb_package_flare", "scr_ba_bb"},
    {"scr_ba_bb_leaflet_drop", "scr_ba_bb"},
    {"scr_ba_bb_plane_smoke_trail", "scr_ba_bb"},
    {"scr_ba_bomb_destroy", "scr_ba_bomb"},
    {"scr_ba_club_drink_pour", "scr_ba_club"},
    {"scr_ba_club_drink_pour_splash", "scr_ba_club"},
    {"scr_ba_club_champagne_spray", "scr_ba_club"},
    {"scr_ba_club_smoke_machine", "scr_ba_club"},
    {"scr_ba_club_smoke", "scr_ba_club"},
    {"scr_barbers_haircut", "scr_barbershop"},
    {"scr_bigscore_peeing", "scr_bigscore"},
    {"liquid_splash_pee", "scr_bigscore"},
    {"scr_bigscore_ramp_sparks", "scr_bigscore"},
    {"scr_bigscore_rpg_trail", "scr_bigscore"},
    {"scr_bigscore_tyre_spiked", "scr_bigscore"},
    {"scr_adversary_ped_light_good", "scr_bike_adversary"},
    {"scr_adversary_wheel_lightning", "scr_bike_adversary"},
    {"scr_adversary_weap_smoke", "scr_bike_adversary"},
    {"scr_adversary_weap_glow", "scr_bike_adversary"},
    {"scr_adversary_ped_light_bad", "scr_bike_adversary"},
    {"scr_adversary_gunsmith_weap_smoke", "scr_bike_adversary"},
    {"scr_adversary_judgement_lens_dirt", "scr_bike_adversary"},
    {"scr_adversary_trail_lightning", "scr_bike_adversary"},
    {"scr_adversary_foot_flames", "scr_bike_adversary"},
    {"scr_adversary_gunsmith_weap_change", "scr_bike_adversary"},
    {"scr_adversary_judgement_ash", "scr_bike_adversary"},
    {"scr_adversary_slipstream_formation", "scr_bike_adversary"},
    {"scr_adversary_ped_glow", "scr_bike_adversary"},
    {"scr_adversary_slipstream", "scr_bike_adversary"},
    {"scr_bike_meth_propylene_pour", "scr_bike_business"},
    {"scr_bike_meth_sodium_pour", "scr_bike_business"},
    {"scr_bike_cfid_camera_flash", "scr_bike_business"},
    {"scr_bike_coc_cocaine_box_pour", "scr_bike_business"},
    {"scr_bike_weed_fog", "scr_bike_business"},
    {"scr_bike_spraybottle_spray", "scr_bike_business"},
    {"scr_bike_coc_cocaine_scoop_pour", "scr_bike_business"},
    {"scr_bike_weed_fog_upgrade", "scr_bike_business"},
    {"scr_bike_meth_meth_scoop_pour", "scr_bike_business"},
    {"scr_contact_sniper_kill", "scr_bike_contact"},
    {"scr_bike_truck_weed_smoke", "scr_bike_contraband"},
    {"scr_bike_truck_weed_smoke_cabin", "scr_bike_contraband"},
    {"scr_heist_biolab_flare_underwater", "scr_biolab_heist"},
    {"scr_heist_biolab_flare", "scr_biolab_heist"},
    {"scr_heist_carrier_elec_fire_sp", "scr_carrier_heist"},
    {"scr_heist_carrier_elec_fire", "scr_carrier_heist"},
    {"scr_carsteal3_tyre_spikes", "scr_carsteal3"},
    {"scr_carsteal4_tyre_spiked", "scr_carsteal3"},
    {"scr_carsteal3_eject", "scr_carsteal3"},
    {"scr_carsteal4_trailer_scrape", "scr_carsteal4"},
    {"scr_carsteal5_car_muzzle_flash", "scr_carsteal4"},
    {"scr_carsteal4_tyre_spikes", "scr_carsteal4"},
    {"scr_carsteal4_wheel_burnout", "scr_carsteal4"},
    {"scr_carsteal5_tyre_spiked", "scr_carsteal4"},
    {"ent_amb_car_wash_jet_soap", "scr_carwash"},
    {"ent_amb_car_wash", "scr_carwash"},
    {"ent_amb_car_wash_jet", "scr_carwash"},
    {"ent_amb_car_wash_steam", "scr_carwash"},
    {"scr_chin1_freezer_gust", "scr_chinese2"},
    {"cs_dry_ice_freezer_door", "scr_chinese2"},
    {"scr_petrol_trail_fire", "scr_chinese2"},
    {"scr_alarm_damage_sparks", "scr_cncpolicestationbustout"},
    {"ent_anim_cig_exhale_mth_car", "scr_director_mode"},
    {"ent_anim_cig_exhale_nse_car", "scr_director_mode"},
    {"ent_anim_cig_smoke_car", "scr_director_mode"},
    {"proj_indep_flare_trail", "scr_dlc_independence"},
    {"scr_ped_foot_banknotes", "scr_exec_ambient_fm"},
    {"scr_ex1_cargo_smoke", "scr_exile1"},
    {"scr_ex1_dust_settle", "scr_exile1"},
    {"ent_amb_sparking_wires_sm_sp", "scr_exile1"},
    {"scr_ex1_plane_exp_sp", "scr_exile1"},
    {"scr_ex1_cargo_engine_trail", "scr_exile1"},
    {"scr_ex1_plane_exp", "scr_exile1"},
    {"scr_ex1_cargo_engine_burst", "scr_exile1"},
    {"scr_ex1_dust_impact", "scr_exile1"},
    {"scr_ex1_heatseeker", "scr_exile1"},
    {"scr_ex1_cargo_debris", "scr_exile1"},
    {"scr_ex1_moving_cloud", "scr_exile1"},
    {"cs_ex1_sparking_wires_sm", "scr_exile1"},
    {"scr_ex1_water_exp_sp", "scr_exile1"},
    {"cs_ex1_cargo_fire", "scr_exile1"},
    {"scr_ex2_rpg_trail", "scr_exile2"},
    {"scr_ex2_chop_trail", "scr_exile2"},
    {"scr_ex2_car_impact", "scr_exile2"},
    {"scr_ex2_car_slide", "scr_exile2"},
    {"scr_ex2_jeep_engine_fire", "scr_exile2"},
    {"ent_ray_train_debris_splash", "scr_exile3"},
    {"scr_ex3_engine_fire", "scr_exile3"},
    {"cs_fam5_water_splash_ped_out", "scr_exile3"},
    {"cs_fam5_water_splash_ped_in", "scr_exile3"},
    {"water_splash_ped", "scr_exile3"},
    {"scr_ex3_container_smoke", "scr_exile3"},
    {"ent_ray_train_debris_splash_spawn", "scr_exile3"},
    {"scr_ex3_water_dinghy_wash", "scr_exile3"},
    {"ent_ray_train_falling_debris", "scr_exile3"},
    {"cs_fam5_water_splash_ped_wade", "scr_exile3"},
    {"ent_ray_train_splash", "scr_exile3"},
    {"cs_fam5_michael_pool_splash", "scr_exile3"},
    {"cs_cig_exhale_mouth", "scr_family1"},
    {"cs_cig_smoke", "scr_family1"},
    {"scr_fam1_blood_headshot", "scr_family1"},
    {"scr_fam1_veh_smoke", "scr_family1"},
    {"cs_cig_exhale_nose", "scr_family1"},
    {"scr_fam3_wheelspin_dirt", "scr_family3"},
    {"ent_ray_fam3_dust_settle", "scr_family3"},
    {"scr_fam4_truck_vent", "scr_family4"},
    {"scr_fam4_trailer_sparks", "scr_family4"},
    {"scr_trev_puke", "scr_family5"},
    {"scr_trev_puke_splash_grd", "scr_family5"},
    {"scr_puke_in_car", "scr_family5"},
    {"scr_fam_door_smoke", "scr_family5"},
    {"scr_fam_bong_smoke", "scr_family5"},
    {"cs_fam6_hair_snip", "scr_family6"},
    {"scr_trev_amb_puke", "scr_familyscenem"},
    {"scr_trev_puke", "scr_familyscenem"},
    {"scr_trev_puke_splash_grd", "scr_familyscenem"},
    {"scr_puke_in_car", "scr_familyscenem"},
    {"scr_fam_door_smoke", "scr_familyscenem"},
    {"scr_tracey_puke", "scr_familyscenem"},
    {"scr_pts_gardner_watering", "scr_familyscenem"},
    {"cs_mich1_lighter_flame", "scr_familyscenem"},
    {"scr_pts_vomit_water", "scr_familyscenem"},
    {"scr_meth_pipe_smoke", "scr_familyscenem"},
    {"scr_pts_headsplash_trev", "scr_familyscenem"},
    {"liquid_splash_water", "scr_familyscenem"},
    {"scr_fam_bong_smoke", "scr_familyscenem"},
    {"scr_pts_footsplash", "scr_familyscenem"},
    {"scr_pts_headsplash", "scr_familyscenem"},
    {"scr_fam_moonshine_pour", "scr_familyscenem"},
    {"scr_pts_digging", "scr_familyscenem"},
    {"cs_mich1_lighter_sparks", "scr_familyscenem"},
    {"scr_pts_flush", "scr_familyscenem"},
    {"cs_cig_exhale_mouth", "scr_fbi1"},
    {"cs_cig_smoke", "scr_fbi1"},
    {"scr_fbi1_litter", "scr_fbi1"},
    {"cs_cig_exhale_nose", "scr_fbi1"},
    {"scr_fbi_autopsy_blood", "scr_fbi1"},
    {"scr_fbi3_dirty_wtr_splash_sp", "scr_fbi3"},
    {"scr_fbi3_elec_smoulder", "scr_fbi3"},
    {"cs_cig_exhale_mouth", "scr_fbi3"},
    {"scr_fbi3_blood_extraction", "scr_fbi3"},
    {"cs_cig_smoke", "scr_fbi3"},
    {"scr_fbi3_dirty_water_pour", "scr_fbi3"},
    {"scr_fbi3_blood_throwaway", "scr_fbi3"},
    {"scr_fbi3_blood_mouth", "scr_fbi3"},
    {"cs_cig_exhale_nose", "scr_fbi3"},
    {"scr_fbi3_elec_sparks", "scr_fbi3"},
    {"scr_fbi4_trucks_crash", "scr_fbi4"},
    {"exp_fbi4_doors_post", "scr_fbi4"},
    {"exp_fbi4_doors", "scr_fbi4"},
    {"scr_bio_cutter_nozzle", "scr_fbi5a"},
    {"muz_assault_rifle", "scr_fbi5a"},
    {"scr_bio_cutter_flame", "scr_fbi5a"},
    {"scr_bio_grille_cutting", "=scr_fbi5a"},
    {"scr_fbi5_dry_ice", "scr_fbi5a"},
    {"water_splash_ped_bubbles", "scr_fbi5a"},
    {"scr_tunnel_vent_bubbles", "scr_fbi5a"},
    {"ped_talk_water", "scr_fbi5a"},
    {"bul_carmetal", "scr_fbi5a"},
    {"scr_fbi5a_flare", "scr_fbi5a"},
    {"scr_bio_flare", "scr_fbi5a"},
    {"scr_bio_grille_break", "=scr_fbi5a"},
    {"scr_fbi5_ped_water_splash", "scr_fbi5a"},
    {"scr_bio_grille_singed", "scr_fbi5a"},
    {"cs_cig_exhale_mouth", "scr_fbi5b"},
    {"cs_cig_smoke", "scr_fbi5b"},
    {"cs_cig_exhale_nose", "scr_fbi5b"},
    {"scr_fin_trev_car_impact", "scr_finale1"},
    {"scr_fin_env_trev_sky", "scr_finale1"},
    {"scr_fin_fire_petrol_trev", "scr_finale1"},
    {"muz_pistol", "scr_finale1"},
    {"scr_finale2_blood_entry", "scr_finale2"},
    {"ent_anim_cig_exhale_mth_car", "scr_fm_mp_missioncreator"},
    {"scr_mp_generic_dst", "scr_fm_mp_missioncreator"},
    {"ent_anim_cig_exhale_nse", "scr_fm_mp_missioncreator"},
    {"scr_mp_drug_dst", "scr_fm_mp_missioncreator"},
    {"scr_sh_cig_exhale_nose", "scr_fm_mp_missioncreator"},
    {"ent_anim_cig_smoke", "scr_fm_mp_missioncreator"},
    {"scr_sh_cig_smoke", "scr_fm_mp_missioncreator"},
    {"scr_mp_elec_dst", "scr_fm_mp_missioncreator"},
    {"ent_amb_shower", "scr_fm_mp_missioncreator"},
    {"ent_amb_shower_steam", "scr_fm_mp_missioncreator"},
    {"scr_sh_lighter_flame", "scr_fm_mp_missioncreator"},
    {"scr_sh_cig_exhale_mouth", "scr_fm_mp_missioncreator"},
    {"ent_anim_cig_exhale_mth", "scr_fm_mp_missioncreator"},
    {"ent_anim_cig_exhale_nse_car", "scr_fm_mp_missioncreator"},
    {"scr_mp_dust_cloud", "scr_fm_mp_missioncreator"},
    {"scr_sh_lighter_sparks", "scr_fm_mp_missioncreator"},
    {"scr_sh_bong_smoke", "scr_fm_mp_missioncreator"},
    {"ent_anim_cig_smoke_car", "scr_fm_mp_missioncreator"},
    {"scr_crate_drop_beacon", "scr_fm_mp_missioncreator"},
    {"scr_franklin0_chop_trail", "scr_franklin0"},
    {"scr_gr_bunk_drill_spark", "scr_gr_bunk"},
    {"scr_gr_bunk_clean_debris", "scr_gr_bunk"},
    {"scr_gr_bunk_lathe_metal_shards", "scr_gr_bunk"},
    {"scr_gr_bunk_mill_hose_spray", "scr_gr_bunk"},
    {"scr_gr_bunk_clean_blow_debris", "scr_gr_bunk"},
    {"scr_gr_bunk_mill_metal_shards", "scr_gr_bunk"},
    {"scr_gr_bunk_drill_smoke", "scr_gr_bunk"},
    {"scr_gr_def_package_flare", "scr_gr_def"},
    {"scr_gr_sw_engine_smoke", "scr_gr_def"},
    {"scr_gr_def_flare", "scr_gr_def"},
    {"scr_gr_warp_in", "scr_gr_def"},
    {"ent_amb_insect_plane", "scr_hunting"},
    {"scr_ie_export_fire_ring", "scr_ie_export"},
    {"scr_ie_export_package_flare", "scr_ie_export"},
    {"scr_ie_export_flare", "scr_ie_export"},
    {"scr_ie_bul_coc_bag", "scr_ie_svm_phantom2"},
    {"scr_dst_cocaine", "scr_ie_svm_technical2"},
    {"scr_impexp_tw_rpg_trail", "scr_ie_tw"},
    {"scr_impexp_tw_take_zone", "scr_ie_tw"},
    {"scr_ie_vv_vehicle_damage", "scr_ie_vv"},
    {"scr_ie_vv_muzzle_flash", "scr_ie_vv"},
    {"scr_impexp_jug_outfit_swap", "scr_impexp_jug"},
    {"scr_ie_jug_mask_flame", "scr_impexp_jug"},
    {"scr_ie_jug_mask_steam", "scr_impexp_jug"},
    {"scr_impexp_dst_crate", "scr_impexp_ploughed"},
    {"scr_indep_firework_sparkle_spawn", "scr_indep_fireworks"},
    {"scr_indep_firework_starburst", "scr_indep_fireworks"},
    {"scr_indep_firework_shotburst", "scr_indep_fireworks"},
    {"scr_indep_firework_trailburst", "scr_indep_fireworks"},
    {"scr_indep_firework_trailburst_spawn", "scr_indep_fireworks"},
    {"scr_indep_firework_burst_spawn", "scr_indep_fireworks"},
    {"scr_indep_firework_trail_spawn", "scr_indep_fireworks"},
    {"scr_indep_firework_fountain", "scr_indep_fireworks"},
    {"mp_parachute_smoke_indep", "scr_indep_parachute"},
    {"wheel_fric_hard_tank_indep", "scr_indep_wheelsmoke"},
    {"wheel_fric_hard_Bike_indep", "scr_indep_wheelsmoke"},
    {"wheel_fric_hard_indep", "scr_indep_wheelsmoke"},
    {"wheel_burnout_indep", "scr_indep_wheelsmoke"},
    {"scr_jewel_fog_volume", "scr_jewelheist"},
    {"cs_bike_exhaust", "scr_jewelheist"},
    {"scr_jewel_cab_smash", "scr_jewelheist"},
    {"scr_jewel_haze", "scr_jewelheist"},
    {"scr_jew_bike_burnout", "scr_jewelheist"},
    {"scr_josh3_light_explosion", "scr_josh3"},
    {"scr_josh3_fires", "scr_josh3"},
    {"exp_grd_petrol_pump_spawn", "scr_josh3"},
    {"scr_josh3_explosion", "scr_josh3"},
    {"scr_josh3_exp_debris", "scr_josh3"},
    {"scr_josh3_house_smoked", "scr_josh3"},
    {"scr_lamar1_door_breach", "scr_lamar1"},
    {"scr_lamar1_fire_spread", "scr_lamar1"},
    {"scr_lamar1_fire_spread1", "scr_lamar1"},
    {"scr_env_agency3b_smoke", "scr_lamar1"},
    {"cs_cig_exhale_mouth", "scr_lester1a"},
    {"cs_cig_smoke", "scr_lester1a"},
    {"cs_cig_exhale_nose", "scr_lester1a"},
    {"scr_lowrider_flare", "scr_lowrider"},
    {"scr_sol1_plane_tail_fire", "scr_martin1"},
    {"scr_sol1_fire_trail", "scr_martin1"},
    {"scr_sol1_sniper_impact", "scr_martin1"},
    {"ent_amb_elec_crackle_sp", "scr_martin1"},
    {"sp_scr_sol1_fire_drip_trail", "scr_martin1"},
    {"scr_sol1_plane_smoke_loop", "scr_martin1"},
    {"scr_sol1_plane_crash_dust", "scr_martin1"},
    {"scr_sol1_plane_wreck", "scr_martin1"},
    {"scr_sol1_plane_engine_fire", "scr_martin1"},
    {"scr_sol1_fire_drip", "scr_martin1"},
    {"scr_sol1_fire_spot", "scr_martin1"},
    {"scr_sol1_plane_elec_crackle", "scr_martin1"},
    {"scr_sol1_plane_smoke", "scr_martin1"},
    {"scr_mich2_spark_impact", "scr_michael2"},
    {"scr_abattoir_ped_sliced", "scr_michael2"},
    {"cs_cig_exhale_mouth", "scr_michael2"},
    {"scr_mich2_blood_stab", "scr_michael2"},
    {"cs_cig_smoke", "scr_michael2"},
    {"scr_abattoir_ped_minced", "scr_michael2"},
    {"scr_acid_bath_splash", "scr_michael2"},
    {"scr_pts_headsplash", "scr_michael2"},
    {"scr_mich3_heli_fire", "scr_michael2"},
    {"scr_golf_ball_trail", "scr_minigamegolf"},
    {"scr_golf_strike_bunker", "scr_minigamegolf"},
    {"scr_golf_landing_thick_grass", "scr_minigamegolf"},
    {"scr_golf_strike_thick_grass", "scr_minigamegolf"},
    {"scr_golf_tee_perfect", "scr_minigamegolf"},
    {"scr_golf_strike_fairway_bad", "scr_minigamegolf"},
    {"scr_golf_strike_fairway", "scr_minigamegolf"},
    {"scr_golf_hit_branches", "scr_minigamegolf"},
    {"scr_golf_landing_bunker", "scr_minigamegolf"},
    {"scr_golf_landing_water", "scr_minigamegolf"},
    {"scr_stuntplane_trail", "scr_minigamepilot"},
    {"scr_stuntplane_trail", "scr_minigamestuntplane"},
    {"scr_tennis_ball_trail", "scr_minigametennis"},
    {"ent_anim_cig_exhale_mth_car", "scr_mp_cig"},
    {"ent_anim_cig_exhale_nse", "scr_mp_cig"},
    {"ent_anim_cig_smoke", "scr_mp_cig"},
    {"ent_anim_cig_exhale_mth", "scr_mp_cig"},
    {"ent_anim_cig_exhale_nse_car", "scr_mp_cig"},
    {"ent_anim_cig_smoke_car", "scr_mp_cig"},
    {"ent_anim_lighter_sparks_plane", "scr_mp_cig_plane"},
    {"ent_anim_cig_exhale_mth_plane", "scr_mp_cig_plane"},
    {"ent_anim_lighter_flame_plane", "scr_mp_cig_plane"},
    {"ent_anim_cig_smoke_plane", "scr_mp_cig_plane"},
    {"ent_anim_cig_exhale_nse_plane", "scr_mp_cig_plane"},
    {"scr_mp_generic_dst", "scr_mp_controller"},
    {"ent_anim_cig_exhale_nse", "scr_mp_controller"},
    {"scr_mp_drug_dst", "scr_mp_controller"},
    {"ent_anim_cig_smoke", "scr_mp_controller"},
    {"scr_mp_elec_dst", "scr_mp_controller"},
    {"ent_anim_cig_exhale_mth", "scr_mp_controller"},
    {"scr_mp_intro_plane_exhaust", "scr_mp_creator"},
    {"scr_mp_splash", "scr_mp_creator"},
    {"scr_mp_plane_landing_tyre_smoke", "scr_mp_creator"},
    {"scr_mp_dust_cloud", "scr_mp_creator"},
    {"scr_sh_cig_exhale_nose", "scr_mp_house"},
    {"scr_sh_cig_smoke", "scr_mp_house"},
    {"ent_amb_shower", "scr_mp_house"},
    {"ent_amb_shower_steam", "scr_mp_house"},
    {"scr_sh_lighter_flame", "scr_mp_house"},
    {"scr_sh_cig_exhale_mouth", "scr_mp_house"},
    {"scr_mp_int_fireplace_sml", "scr_mp_house"},
    {"scr_sh_lighter_sparks", "scr_mp_house"},
    {"scr_sh_bong_smoke", "scr_mp_house"},
    {"exp_grd_tankshell_mp", "scr_mp_tankbattle"},
    {"scr_obfoundry_cauldron_steam", "scr_obfoundrycauldron"},
    {"scr_ojbusass_bus_impact", "scr_oddjobbusassassin"},
    {"scr_ojtaxi_hotbox_window", "scr_oddjobtaxi"},
    {"scr_ojtaxi_hotbox_trail", "scr_oddjobtaxi"},
    {"scr_ojtaxi_hotbox_door", "scr_oddjobtaxi"},
    {"scr_ojtt_train_sparks", "scr_oddjobtowtruck"},
    {"scr_drug_grd_train_exp", "scr_oddjobtraffickingair"},
    {"scr_boat_trails_sp", "scr_oddjobtraffickingair"},
    {"scr_ojdg4_water_exp", "scr_oddjobtraffickingair"},
    {"scr_drug_grd_plane_exp", "scr_oddjobtraffickingair"},
    {"scr_ojdg4_train_fire", "scr_oddjobtraffickingair"},
    {"scr_drug_traffic_flare_L", "scr_oddjobtraffickingair"},
    {"scr_crate_drop_flare", "scr_oddjobtraffickingair"},
    {"scr_ojdg4_boat_wreck_fire", "scr_oddjobtraffickingair"},
    {"scr_mp_intro_plane_exhaust", "scr_oddjobtraffickingair"},
    {"scr_ojdg4_boat_exp", "scr_oddjobtraffickingair"},
    {"scr_boat_exp_sp", "scr_oddjobtraffickingair"},
    {"scr_crate_drop_beacon", "scr_oddjobtraffickingair"},
    {"scr_drug_traffic_flare_L", "scr_oddjobtraffickingground"},
    {"scr_ojdg5_barrels_smoke", "scr_oddjobtraffickingground"},
    {"scr_drug_traffic_flare", "scr_oddjobtraffickingground"},
    {"scr_ojdg5_barrels", "scr_oddjobtraffickingground"},
    {"scr_heist_ornate_metal_drip", "scr_ornate_heist"},
    {"scr_heist_ornate_banknotes", "scr_ornate_heist"},
    {"scr_heist_ornate_metal_drip_sp", "scr_ornate_heist"},
    {"scr_heist_ornate_thermal_burn", "scr_ornate_heist"},
    {"scr_respray_smoke", "scr_paintnspray"},
    {"scr_paleto_roof_impact", "scr_paletoscore"},
    {"scr_trev_puke", "scr_paletoscore"},
    {"scr_paleto_fire_trail", "scr_paletoscore"},
    {"scr_paleto_banknotes", "scr_paletoscore"},
    {"scr_alarm_damage_sparks", "scr_paletoscore"},
    {"scr_paleto_box_spawned", "scr_paletoscore"},
    {"scr_trev_puke_splash_grd", "scr_paletoscore"},
    {"cs_paleto_blowtorch", "scr_paletoscore"},
    {"scr_paleto_heli_plume", "scr_paletoscore"},
    {"ent_amb_peeing", "scr_paletoscore"},
    {"liquid_splash_pee", "scr_paletoscore"},
    {"scr_paleto_doorway_smoke", "scr_paletoscore"},
    {"cs_rbhs_int_delap_dust", "scr_paletoscore"},
    {"scr_paleto_box_sparks", "scr_paletoscore"},
    {"scr_para_kick_blood", "scr_paradise2_trailer"},
    {"scr_prologue_door_blast", "scr_paradise2_trailer"},
    {"scr_veh_plane_gen_damage", "scr_pilot_school_mp"},
    {"scr_lamgraff_paint_spray", "scr_playerlamgraff"},
    {"scr_pts_vomit_water", "scr_player_timetable_scene"},
    {"ent_dst_pineapple", "scr_player_timetable_scene"},
    {"scr_pts_glass_bottle", "scr_player_timetable_scene"},
    {"scr_pts_headsplash", "scr_player_timetable_scene"},
    {"scr_pts_guitar_break", "scr_player_timetable_scene"},
    {"scr_pts_digging", "scr_player_timetable_scene"},
    {"scr_stuntplane_trail", "scr_pm_plane_promotion"},
    {"scr_property_leaflet_drop", "scr_pm_plane_promotion"},
    {"scr_bio_flare", "scr_portoflsheist"},
    {"scr_pls_sub_water_drips", "scr_portoflsheist"},
    {"scr_bigscore_rpg_trail", "scr_portoflsheist"},
    {"scr_powerplay_beast_vanish", "scr_powerplay"},
    {"scr_powerplay_beast_appear", "scr_powerplay"},
    {"sp_powerplay_beast_appear_trails", "scr_powerplay"},
    {"scr_brk_metal_lock", "scr_prison_break_heist_station"},
    {"sp_prologue_debris", "scr_prologue"},
    {"scr_prologue_vault_haze", "scr_prologue"},
    {"scr_prologue_vault_fog", "scr_prologue"},
    {"scr_pro_door_snow", "scr_prologue"},
    {"ent_ray_pro_door_embers", "scr_prologue"},
    {"ent_ray_pro1_vault_exp_lit", "scr_prologue"},
    {"scr_prologue_door_blast", "scr_prologue"},
    {"scr_pro_car_steam", "scr_prologue"},
    {"scr_pro_door_splinters", "scr_prologue"},
    {"scr_prologue_ceiling_debris", "scr_prologue"},
    {"scr_alien_teleport", "scr_rcbarry1"},
    {"scr_alien_beam", "scr_rcbarry1"},
    {"scr_alien_charging", "scr_rcbarry1"},
    {"scr_alien_disintegrate", "scr_rcbarry1"},
    {"scr_alien_impact", "scr_rcbarry1"},
    {"scr_alien_impact_bul", "scr_rcbarry1"},
    {"scr_clown_death", "scr_rcbarry2"},
    {"eject_clown", "scr_rcbarry2"},
    {"scr_exp_clown", "scr_rcbarry2"},
    {"scr_clown_appears", "scr_rcbarry2"},
    {"sp_clown_appear_trails", "scr_rcbarry2"},
    {"scr_exp_clown_trails", "scr_rcbarry2"},
    {"scr_clown_bul", "scr_rcbarry2"},
    {"muz_clown", "scr_rcbarry2"},
    {"scr_rcext2_cargo_smoke", "scr_rcextreme2"},
    {"scr_extrm4_water_blood", "scr_rcextreme2"},
    {"scr_rcext2_ramp_scrape", "scr_rcextreme2"},
    {"scr_extrm2_moving_cloud", "scr_rcextreme2"},
    {"scr_extrm4_water_splash", "scr_rcextreme2"},
    {"scr_rcn2_debris_trail", "scr_rcnigel2"},
    {"scr_rcn2_ceiling_debris", "scr_rcnigel2"},
    {"scr_mich4_firework_burst_spawn", "scr_rcpaparazzo1"},
    {"scr_rcpap1_smoke_vent", "scr_rcpaparazzo1"},
    {"scr_mich4_firework_trailburst", "scr_rcpaparazzo1"},
    {"scr_rcpap1_champ_slosh", "scr_rcpaparazzo1"},
    {"scr_mich4_firework_starburst", "scr_rcpaparazzo1"},
    {"scr_rcpap1_camera", "scr_rcpaparazzo1"},
    {"scr_rcpap1_champ_burst", "scr_rcpaparazzo1"},
    {"scr_mich4_firework_trail_spawn", "scr_rcpaparazzo1"},
    {"scr_mich4_firework_trailburst_spawn", "scr_rcpaparazzo1"},
    {"scr_mich4_firework_sparkle_spawn", "scr_rcpaparazzo1"},
    {"scr_burial_dirt", "scr_reburials"},
    {"scr_wheel_burnout", "scr_recartheft"},
    {"scr_reconstruct_pipe_impact", "scr_reconstructionaccident"},
    {"scr_sparking_generator", "scr_reconstructionaccident"},
    {"scr_reconstruct_pipefall_debris", "scr_reconstructionaccident"},
    {"sp_sparking_generator", "scr_reconstructionaccident"},
    {"scr_recrash_rescue_fire", "scr_recrash_rescue"},
    {"scr_sh_cig_exhale_nose", "scr_safehouse"},
    {"scr_sh_cig_smoke", "scr_safehouse"},
    {"scr_sh_lighter_flame", "scr_safehouse"},
    {"scr_sh_cig_exhale_mouth", "scr_safehouse"},
    {"scr_sh_lighter_sparks", "scr_safehouse"},
    {"scr_sh_bong_smoke", "scr_safehouse"},
    {"scr_salvage_flare", "scr_salvage"},
    {"scr_vehicle_damage_smoke", "scr_sell"},
    {"scr_sm_hl_package_flare", "scr_sm"},
    {"scr_sm_hl_flare", "scr_sm"},
    {"scr_dst_inflatable", "scr_sm"},
    {"scr_sm_con_ped_light", "scr_sm"},
    {"scr_sm_counter_chaff", "scr_sm_counter"},
    {"scr_sm_con_trans", "scr_sm_trans"},
    {"scr_sm_con_trans_fp", "scr_sm_trans"},
    {"scr_sm_trans_smoke", "scr_sm_trans"},
    {"scr_trev4_747_engine_heathaze", "scr_solomon3"},
    {"scr_trev4_747_blood_impact", "scr_solomon3"},
    {"scr_trev4_trailer_fire", "scr_solomon3"},
    {"scr_trev4_747_engine_debris", "scr_solomon3"},
    {"scr_trev4_747_engine_damage", "scr_solomon3"},
    {"scr_trev4_747_exhaust_plane_misfire", "scr_solomon3"},
    {"scr_trev4_747_blood_splash", "scr_solomon3"},
    {"scr_sr_lg_take_zone", "scr_sr_adversary"},
    {"scr_sr_lg_weapon_highlight", "scr_sr_adversary"},
    {"scr_sr_dst_cardboard", "scr_sr_adversary"},
    {"scr_sr_tr_car_change", "scr_sr_tr"},
    {"scr_sr_tr_player_glow", "scr_sr_tr"},
    {"scr_stunts_fire_ring", "scr_stunts"},
    {"scr_stunts_shotburst", "scr_stunts"},
    {"scr_stunts_bomb_fuse", "scr_stunts"},
    {"scr_stunts_shotburst_spawn", "scr_stunts"},
    {"scr_stunts_bomb_fuse_sp", "scr_stunts"},
    {"scr_tplaces_team_swap", "scr_tplaces"},
    {"scr_tplaces_team_swap_nocash", "scr_tplaces"},
    {"ent_ray_meth_dust_settle", "scr_trevor1"},
    {"scr_trev1_trailer_wires", "scr_trevor1"},
    {"scr_trev1_trailer_boosh", "scr_trevor1"},
    {"scr_trev1_crash_dust", "scr_trevor1"},
    {"sp_ent_sparking_wires", "scr_trevor1"},
    {"scr_trev1_trailer_splash", "scr_trevor1"},
    {"scr_trev1_wheelspin_dirt", "scr_trevor1"},
    {"scr_trev2_heli_wreck", "scr_trevor2"},
    {"scr_trev2_heli_exp", "scr_trevor2"},
    {"scr_trev2_flare_L", "scr_trevor2"},
    {"scr_rotor_blade_blood", "scr_trevor2"},
    {"scr_trev3_trailer_expolsion", "scr_trevor3"},
    {"exp_grd_vehicle_spawn", "scr_trevor3"},
    {"scr_trev3_c4_explosion", "scr_trevor3"},
    {"scr_trev3_trailer_plume", "scr_trevor3"},
    {"ent_ray_trev3_trailer_light", "scr_trevor3"},
    {"scr_bomb_cluster", "scr_weap_bombs"},
    {"scr_bomb_standard", "scr_weap_bombs"},
    {"scr_bomb_gas", "scr_weap_bombs"},
    {"scr_xm_aq_final_kill_plane_delta", "scr_xm_aq"},
    {"scr_xm_aq_final_kill_thruster", "scr_xm_aq"},
    {"scr_xm_aq_final_kill_plane_sweep", "scr_xm_aq"},
    {"scr_xm_aq_final_kill_plane", "scr_xm_aq"},
    {"scr_xm_dst_elec_crackle", "scr_xm_farm"},
    {"scr_xm_dst_elec_crackle_sp", "scr_xm_farm"},
    {"scr_xm_heat_camo", "scr_xm_heat"},
    {"scr_xm_ht_flare", "scr_xm_ht"},
    {"scr_xm_ht_package_flare", "scr_xm_ht"},
    {"scr_xm_orbital_blast", "scr_xm_orbital"},
    {"scr_xm_para_car_smoke", "scr_xm_orbital"},
    {"scr_xm_riotvan_fire_back", "scr_xm_riotvan"},
    {"scr_xm_riotvan_extinguish", "scr_xm_riotvan"},
    {"scr_xm_riotvan_fire_front", "scr_xm_riotvan"},
    {"scr_xm_spybomb_plane_smoke_trail", "scr_xm_spybomb"},
    {"scr_xm_stealcar_cargo_exhaust", "scr_xm_stealcar"},
    {"scr_xm_submarine_surface_explosion", "scr_xm_submarine"},
    {"exp_underwater_mine", "scr_xm_submarine"},
    {"scr_xm_submarine_explosion", "scr_xm_submarine"},
    {"scr_xm_submarine_surface_splashes", "scr_xm_submarine"},
    {"scr_xm_stromberg_scanner", "scr_xm_submarine"},
    {"scr_xs_money_rain", "scr_xs_celebration"},
    {"scr_xs_money_rain_celeb", "scr_xs_celebration"},
    {"scr_xs_confetti_burst", "scr_xs_celebration"},
    {"scr_xs_champagne_spray", "scr_xs_celebration"},
    {"scr_xs_beer_chug", "scr_xs_celebration"},
    {"scr_xs_dr_emp", "scr_xs_dr"},
    {"scr_xs_sf_pit", "scr_xs_pits"},
    {"scr_xs_fire_pit", "scr_xs_pits"},
    {"scr_xs_sf_pit_long", "scr_xs_pits"},
    {"scr_xs_fire_pit_long", "scr_xs_pits"},
    {"scr_xs_exp_mine_sf", "scr_xs_props"},
    {"scr_xs_ball_explosion", "scr_xs_props"},
    {"scr_xs_oil_jack_fire", "scr_xs_props"},
    {"scr_xs_guided_missile_trail", "scr_xs_props"},
    {"muz_xm_akula_mg_turret", "veh_akula"},
    {"eject_xm_akula_mg_turret", "veh_akula"},
    {"bullet_tracer_xm_akula_mg_turret", "veh_akula"},
    {"veh_xm_avenger_downwash_default", "veh_avenger"},
    {"veh_xm_avenger_downwash_sand", "veh_avenger"},
    {"veh_xm_avenger_downwash_vegetation", "veh_avenger"},
    {"veh_xm_avenger_downwash_dirt", "veh_avenger"},
    {"veh_xm_vent_plane_avenger", "veh_avenger"},
    {"veh_xm_avenger_downwash_water", "veh_avenger"},
    {"exp_blimp3_11", "veh_ba_blimp3"},
    {"exp_blimp3_1", "veh_ba_blimp3"},
    {"exp_blimp3_10", "veh_ba_blimp3"},
    {"exp_blimp3_2", "veh_ba_blimp3"},
    {"exp_blimp3_17", "veh_ba_blimp3"},
    {"exp_blimp3_15", "veh_ba_blimp3"},
    {"exp_blimp3_16", "veh_ba_blimp3"},
    {"exp_blimp3_7", "veh_ba_blimp3"},
    {"exp_blimp3_14", "veh_ba_blimp3"},
    {"exp_blimp3_13", "veh_ba_blimp3"},
    {"exp_blimp3_8", "veh_ba_blimp3"},
    {"exp_blimp3_9", "veh_ba_blimp3"},
    {"exp_blimp3_19", "veh_ba_blimp3"},
    {"exp_blimp3_3", "veh_ba_blimp3"},
    {"exp_blimp3_18", "veh_ba_blimp3"},
    {"exp_blimp3_4", "veh_ba_blimp3"},
    {"exp_blimp3_5", "veh_ba_blimp3"},
    {"exp_blimp3_6", "veh_ba_blimp3"},
    {"exp_blimp3_12", "veh_ba_blimp3"},
    {"exp_blimp3_0", "veh_ba_blimp3"},
    {"veh_ba_oppressor_turbulance_default", "veh_ba_oppressor2"},
    {"veh_ba_oppressor_turbulance_foliage", "veh_ba_oppressor2"},
    {"veh_ba_oppressor_turbulance_water", "veh_ba_oppressor2"},
    {"veh_ba_oppressor_turbulance_sand", "veh_ba_oppressor2"},
    {"veh_ba_oppressor_engine_glow", "veh_ba_oppressor2"},
    {"exp_grd_ba_opp2_cannon", "veh_ba_oppressor2"},
    {"veh_ba_oppressor_turbulance_dirt", "veh_ba_oppressor2"},
    {"veh_exhaust_strikeforce", "veh_ba_strikeforce"},
    {"eject_xm_barrage_mg_turret_rear", "veh_barrage"},
    {"eject_xm_barrage_mg_turret", "veh_barrage"},
    {"eject_xm_barrage_minigun_turret", "veh_barrage"},
    {"muz_xm_barrage_minigun_turret", "veh_barrage"},
    {"bullet_tracer_xm_barrage_turret", "veh_barrage"},
    {"muz_xm_barrage_mg_turret", "veh_barrage"},
    {"muz_xm_cherno", "veh_chernobog"},
    {"veh_xm_deluxo_turbulance_water", "veh_deluxo"},
    {"veh_xm_deluxo_turbulance_default", "veh_deluxo"},
    {"veh_xm_deluxo_glide_haze", "veh_deluxo"},
    {"veh_xm_deluxo_engine_glow", "veh_deluxo"},
    {"veh_xm_deluxo_turbulance_dirt", "veh_deluxo"},
    {"veh_xm_deluxo_turbulance_foliage", "veh_deluxo"},
    {"veh_xm_deluxo_turbulance_sand", "veh_deluxo"},
    {"veh_rocket_boost", "veh_impexp_rocket"},
    {"veh_ruiner_hop", "veh_impexp_ruiner"},
    {"proj_xm_khanjali_grenade_trail", "veh_khanjali"},
    {"bullet_tracer_xm_khanjali_mg", "veh_khanjali"},
    {"muz_xm_khanjali_mg", "veh_khanjali"},
    {"muz_xm_khanjali_railgun", "veh_khanjali"},
    {"proj_xm_khanjali_railgun_trail", "veh_khanjali"},
    {"muz_xm_khanjali_railgun_charge", "veh_khanjali"},
    {"eject_xm_khanjali_mg", "veh_khanjali"},
    {"bullet_tracer_turret", "veh_mounted_turrets_car"},
    {"eject_mounted_turret_technical", "veh_mounted_turrets_car"},
    {"muz_mounted_turret", "veh_mounted_turrets_car"},
    {"eject_mounted_turret", "veh_mounted_turrets_car"},
    {"bullet_tracer_valkyrie", "veh_mounted_turrets_heli"},
    {"muz_valkyrie", "veh_mounted_turrets_heli"},
    {"muz_valkyrie_turret", "veh_mounted_turrets_heli"},
    {"eject_mounted_turret", "veh_mounted_turrets_heli"},
    {"eject_valkyrie", "veh_mounted_turrets_heli"},
    {"eject_mounted_turret_limo", "veh_mounted_turret_limo"},
    {"veh_sanctus_exhaust", "veh_sanctus"},
    {"veh_sanctus_backfire", "veh_sanctus"},
    {"veh_sanctus_exhaust_start", "veh_sanctus"},
    {"veh_sm_car_small_backfire", "veh_sm_car_small"},
    {"veh_exhaust_afterburner_molotok", "veh_sm_pyro"},
    {"veh_exhaust_afterburner_pyro", "veh_sm_pyro"},
    {"veh_exhaust_starling", "veh_sm_starling"},
    {"veh_vent_plane_starling", "veh_sm_starling"},
    {"veh_afterburner_starling", "veh_sm_starling"},
    {"muz_sm_vehicle_mg", "veh_sm_vig"},
    {"veh_rocket_boost_vig", "veh_sm_vig"},
    {"bullet_tracer_sm_vehicle_mg", "veh_sm_vig"},
    {"muz_xm_strom_mg", "veh_stromberg"},
    {"veh_xm_strom_underwater_trail", "veh_stromberg"},
    {"proj_torpedo_trail", "veh_stromberg"},
    {"exp_underwater_torpedo", "veh_stromberg"},
    {"muz_torpedo", "veh_stromberg"},
    {"veh_prop_stromberg", "veh_stromberg"},
    {"bullet_tracer_xm_thruster_mg", "veh_thruster"},
    {"muz_xm_thruster_mg", "veh_thruster"},
    {"veh_xm_thruster_wreck_fire", "veh_thruster"},
    {"veh_xm_thruster_downwash_foliage", "veh_thruster"},
    {"veh_xm_thruster_downwash_sand", "veh_thruster"},
    {"veh_thruster_jet", "veh_thruster"},
    {"veh_xm_thruster_downwash", "veh_thruster"},
    {"veh_xm_thruster_engine_damage", "veh_thruster"},
    {"muz_xm_thruster_rpg", "veh_thruster"},
    {"veh_xm_thruster_afterburner", "veh_thruster"},
    {"veh_xm_thruster_downwash_dirt", "veh_thruster"},
    {"veh_xm_thruster_downwash_water", "veh_thruster"},
    {"proj_xm_thruster_rpg_trail", "veh_thruster"},
    {"veh_vent_plane_volatol", "veh_volatol"},
    {"muz_xm_volatol_twinmg", "veh_volatol"},
    {"scr_xm_volatol_turret_camera", "veh_volatol"},
    {"exp_xs_mine_spike", "veh_xs_vehicle_mods"},
    {"exp_xs_mine_kinetic", "veh_xs_vehicle_mods"},
    {"exp_xs_mine_tar", "veh_xs_vehicle_mods"},
    {"veh_nitrous", "veh_xs_vehicle_mods"},
    {"exp_xs_mine_emp", "veh_xs_vehicle_mods"},
    {"veh_xs_electrified_rambar", "veh_xs_vehicle_mods"},
    {"exp_xs_mine_slick", "veh_xs_vehicle_mods"},
    {"eject_ba_vehicle_remote_minigun", "weap_ba_vehicle_weapons"},
    {"eject_ba_vehicle_remote_mg", "weap_ba_vehicle_weapons"},
    {"muz_ba_vehicle_front_mg", "weap_ba_vehicle_weapons"},
    {"muz_ba_vehicle_remote_missile", "weap_ba_vehicle_weapons"},
    {"muz_ba_vehicle_remote_minigun", "weap_ba_vehicle_weapons"},
    {"muz_ba_vehicle_remote_mg", "weap_ba_vehicle_weapons"},
    {"proj_ba_remote_gl_trail", "weap_ba_vehicle_weapons"},
    {"bullet_tracer_ba_vehicle_remote_mg", "weap_ba_vehicle_weapons"},
    {"eject_dbshotgun_fp", "weap_dbshotgun"},
    {"eject_dbshotgun", "weap_dbshotgun"},
    {"proj_gr_moc_cannon_trail", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_tampa_minigun", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_dune_minigun_fp", "weap_gr_vehicle_weapons"},
    {"bullet_tracer_opp_fp", "weap_gr_vehicle_weapons"},
    {"proj_mounted_turret_mortar", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_dune_minigun", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_twinmg", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_dune_mg", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_insurgent3_minigun", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_dune_minigun", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_apc_mg", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_tampa_minigun", "weap_gr_vehicle_weapons"},
    {"eject_mounted_turret_quadmg", "weap_gr_vehicle_weapons"},
    {"muz_gr_vehicle_mg", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_dune_mg", "weap_gr_vehicle_weapons"},
    {"muz_gr_vehicle_opp", "weap_gr_vehicle_weapons"},
    {"bullet_tracer_turret_gr", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_twinmg_trailer", "weap_gr_vehicle_weapons"},
    {"bullet_tracer_turret_gr_tampa", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_apc", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_twinmg", "weap_gr_vehicle_weapons"},
    {"muz_mounted_turret_apc_missile", "weap_gr_vehicle_weapons"},
    {"bullet_tracer_gr_tintable", "weap_gr_weapons"},
    {"muz_ie_vehicle_mg", "weap_ie_vehicle_mg"},
    {"bullet_tracer_ie_vehicle_mg", "weap_ie_vehicle_mg"},
    {"eject_minismg", "weap_minismg"},
    {"eject_minismg_fp", "weap_minismg"},
    {"proj_pipebomb_smoke", "weap_pipebomb"},
    {"eject_revolver", "weap_revolver"},
    {"proj_rpg_barrage_trail", "weap_sm_barrage"},
    {"veh_vent_plane_bom", "weap_sm_bom"},
    {"eject_sm_bom_twinmg", "weap_sm_bom"},
    {"muz_sm_bom_cannon", "weap_sm_bom"},
    {"bullet_tracer_turret_sm", "weap_sm_bom"},
    {"muz_sm_bom_twinmg", "weap_sm_bom"},
    {"proj_rpg_barrage_trail", "weap_sm_bom"},
    {"muz_sm_mogul_turret_mg", "weap_sm_mogul"},
    {"bullet_tracer_turret_mogul", "weap_sm_mogul"},
    {"veh_seabreeze_turbulance_water", "weap_sm_tula"},
    {"muz_sm_tula_mg", "weap_sm_tula"},
    {"muz_sm_tula_turret_mg", "weap_sm_tula"},
    {"veh_vent_plane_tula", "weap_sm_tula"},
    {"bullet_tracer_turret_tula", "weap_sm_tula"},
    {"eject_sm_tula_turret_minigun", "weap_sm_tula"},
    {"veh_tula_turbulance_water", "weap_sm_tula"},
    {"eject_sm_tula_turret_mg", "weap_sm_tula"},
    {"muz_xm_revolver", "weap_xm_revolver"},
    {"eject_xm_revolver", "weap_xm_revolver"},
    {"tracer_xm_shotgun_inc", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_exp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_exp_fp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_hp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_hp_fp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_ap_fp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_ap", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_inc_fp", "weap_xm_shotgun_rounds"},
    {"eject_shotgun_inc", "weap_xm_shotgun_rounds"},
    {"bullet_tracer_xs_vehicle_remote_mg_sf", "weap_xs_vehicle_weapons"},
    {"muz_xs_turret_flamethrower_looping", "weap_xs_vehicle_weapons"},
    {"muz_xs_vehicle_remote_mg_sf", "weap_xs_vehicle_weapons"},
    {"muz_xs_turret_flamethrower_looping_sf", "weap_xs_vehicle_weapons"},
    {"bullet_tracer_xs_sr", "weap_xs_weapons"},
    {"proj_xs_sr_raygun_trail", "weap_xs_weapons"},
    {"muz_xs_sr_carbine", "weap_xs_weapons"},
    {"exp_xs_ray", "weap_xs_weapons"},
    {"muz_xs_sr_raygun", "weap_xs_weapons"},
    {"muz_xs_sr_minigun", "weap_xs_weapons"},
    {"eject_sniper_amrifle", "wpn_amrifle"},
    {"proj_heist_flare_trail", "wpn_flare"},
    {"muz_indep_firework", "wpn_indep_firework"},
    {"muz_musket_ng", "wpn_musket"}
}
logg("[Initialization] Successfully Loaded " .. #ptfxlist .. " Particle Models")
--Vehicle List
vehiclelist = {
    {"Z190", "190z"},
    {"NINEF", "9F"},
    {"NINEF2", "9F Cabrio"},
    {"APC", "APC"},
    {"ADDER", "Adder"},
    {"AIRBUS", "Airport Bus"},
    {"AIRTUG", "Airtug"},
    {"ALKONOST", "Alkonost"},
    {"AKULA", "Akula"},
    {"AKUMA", "Akuma"},
    {"ALPHA", "Alpha"},
    {"ALPHAZ1", "Alpha-Z1"},
    {"AMBULANCE", "Ambulance"},
    {"ANNIHILATOR", "Annihilator"},
    {"ANNIHILATOR2", "Annihilator Stealth"},
    {"TRAILERSMALL2", "Anti-Aircraft"},
    {"BRUISER", "Apocalypse Bruiser"},
    {"BRUTUS", "Apocalypse Brutus"},
    {"CERBERUS", "Apocalypse Cerberus"},
    {"DEATHBIKE", "Apocalypse Deathbike"},
    {"DOMINATOR4", "Apocalypse Dominator"},
    {"IMPALER2", "Apocalypse Impaler"},
    {"IMPERATOR", "Apocalypse Imperator"},
    {"ISSI4", "Apocalypse Issi"},
    {"MONSTER3", "Apocalypse Sasquatch"},
    {"SCARAB", "Apocalypse Scarab"},
    {"SLAMVAN4", "Apocalypse Slamvan"},
    {"ZR380", "Apocalypse ZR380"},
    {"ARDENT", "Ardent"},
    {"BOXVILLE5", "Armored Boxville"},
    {"ARMYTRAILER", "Army Flatbed Trailer (Empty)"},
    {"ARMYTRAILER2", "Army Flatbed Trailer (With Drill)"},
    {"ARMYTANKER", "Army Fuel Tanker"},
    {"ASBO", "Asbo"},
    {"ASEA", "Asea"},
    {"ASEA2", "Asea (Snow)"},
    {"ASTEROPE", "Asterope"},
    {"BLIMP", "Atomic Blimp"},
    {"AUTARCH", "Autarch"},
    {"AVARUS", "Avarus"},
    {"AVENGER", "Avenger"},
    {"AVENGER2", "Avenger 2"},
    {"AVISA", "Avisa"},
    {"BF400", "BF400"},
    {"BMX", "BMX"},
    {"BAGGER", "Bagger"},
    {"BALLER2", "Baller"},
    {"BALLER", "Baller (Old)"},
    {"BALLER3", "Baller LE"},
    {"BALLER5", "Baller LE (Armored)"},
    {"BALLER4", "Baller LE LWB"},
    {"BALLER6", "Baller LE LWB (Armored)"},
    {"BANSHEE", "Banshee"},
    {"BANSHEE2", "Banshee 900R"},
    {"BARRACKS", "Barracks"},
    {"BARRACKS3", "Barracks (Dark Camo)"},
    {"BARRACKS2", "Barracks Semi"},
    {"BARRAGE", "Barrage"},
    {"BATI", "Bati 801"},
    {"BATI2", "Bati 801RR"},
    {"DUKES3", "Beater Dukes"},
    {"BJXL", "BeeJay XL"},
    {"BENSON", "Benson"},
    {"BESRA", "Besra"},
    {"BESTIAGTS", "Bestia GTS"},
    {"BIFF", "Biff"},
    {"BIFTA", "Bifta"},
    {"BISON", "Bison"},
    {"BISON3", "Bison (Backrack)"},
    {"BISON2", "Bison (Construction)"},
    {"BLADE", "Blade"},
    {"BLAZER", "Blazer"},
    {"BLAZER5", "Blazer Aqua"},
    {"BLAZER2", "Blazer Lifeguard"},
    {"BLIMP3", "Blimp 3"},
    {"BLISTA", "Blista"},
    {"BLISTA2", "Blista Compact"},
    {"KANJO", "Blista Kanjo"},
    {"BOATTRAILER", "Boat Trailer"},
    {"TR3", "Boat Trailer (With Boat)"},
    {"BOBCATXL", "Bobcat"},
    {"BODHI2", "Bodhi"},
    {"BOMBUSHKA", "Bombushka"},
    {"BOXVILLE2", "Boxville (Go Postal)"},
    {"BOXVILLE3", "Boxville (Humane Labs)"},
    {"BOXVILLE4", "Boxville (Post OP)"},
    {"BOXVILLE", "Boxville (Water & Power)"},
    {"OPENWHEEL1", "BR8"},
    {"BRAWLER", "Brawler"},
    {"BRICKADE", "Brickade"},
    {"BRIOSO2", "Brioso 300"},
    {"BRIOSO", "Brioso R/A"},
    {"BUCCANEER", "Buccaneer"},
    {"BUCCANEER2", "Buccaneer Custom"},
    {"BUFFALO", "Buffalo"},
    {"BUFFALO2", "Buffalo S"},
    {"BULLET", "Bullet"},
    {"STALION2", "Burger Shot Stallion"},
    {"BURRITO3", "Burrito"},
    {"BURRITO2", "Burrito (Bug Stars)"},
    {"BURRITO4", "Burrito (Construction)"},
    {"GBURRITO2", "Burrito (Gang)"},
    {"BURRITO", "Burrito (Graphics)"},
    {"BURRITO5", "Burrito (Snow)"},
    {"GBURRITO", "Burrito (The Lost)"},
    {"BUS", "Bus"},
    {"BUZZARD", "Buzzard"},
    {"BUZZARD2", "Buzzard (Unarmed)"},
    {"CABLECAR", "Cablecar"},
    {"CADDY", "Caddy"},
    {"CADDY2", "Caddy 2"},
    {"CADDY3", "Caddy 3"},
    {"calico", "Calico GTF"},
    {"CAMPER", "Camper"},
    {"TR4", "Car Transport Trailer"},
    {"TR2", "Car Transport Trailer (Empty)"},
    {"CARACARA", "Caracara"},
    {"CARACARA2", "Caracara 4x4"},
    {"CARBONRS", "Carbon RS"},
    {"CARBONIZZARE", "Carbonizzare"},
    {"CARGOBOB", "Cargobob"},
    {"CARGOBOB2", "Cargobob (Jetsam)"},
    {"CARGOBOB3", "Cargobob (TPI)"},
    {"CARGOBOB4", "Cargobob 4"},
    {"CARGOPLANE", "Cargoplane"},
    {"CASCO", "Casco"},
    {"CAVALCADE", "Cavalcade"},
    {"CAVALCADE2", "Cavalcade 2"},
    {"CHEBUREK", "Cheburek"},
    {"CHEETAH", "Cheetah"},
    {"CHEETAH2", "Cheetah Classic"},
    {"CHERNOBOG", "Chernobog"},
    {"CHIMERA", "Chimera"},
    {"CHINO", "Chino"},
    {"CHINO2", "Chino Custom"},
    {"CLIFFHANGER", "Cliffhanger"},
    {"CLIQUE", "Clique"},
    {"SPEEDO2", "Clown"},
    {"CLUB", "Club"},
    {"COGNOSCENTI", "Cognoscenti"},
    {"COGNOSCENTI2", "Cognoscenti (Armored)"},
    {"COG55", "Cognoscenti 55"},
    {"COG552", "Cognoscenti 55 (Armored)"},
    {"COMET2", "Comet"},
    {"COMET3", "Comet Retro Custom"},
    {"COMET4", "Comet Safari"},
    {"COMET5", "Comet SR"},
    {"comet6", "Comet S2"},
    {"TRAILERS2", "Commercial Trailer (Graphics 1)"},
    {"TRAILERS3", "Commercial Trailer (Graphics 2)"},
    {"COGCABRIO", "Connoscenti Cabrio"},
    {"DOCKTRAILER", "Container Trailer"},
    {"CONTENDER", "Contender"},
    {"COQUETTE", "Coquette"},
    {"COQUETTE3", "Coquette BlackFin"},
    {"COQUETTE2", "Coquette Classic"},
    {"COQUETTE4", "Coquette D10"},
    {"CRUISER", "Cruiser"},
    {"CRUSADER", "Crusader"},
    {"CUBAN800", "Cuban 800"},
    {"CUTTER", "Cutter"},
    {"CYCLONE", "Cyclone"},
    {"cypher", "Cypher"},
    {"DAEMON", "Daemon"},
    {"DAEMON2", "Daemon 2"},
    {"COACH", "Dashound"},
    {"DEFILER", "Defiler"},
    {"DELUXO", "Deluxo"},
    {"TROPHYTRUCK2", "Desert Raid"},
    {"DEVESTE", "Deveste Eight"},
    {"DEVIANT", "Deviant"},
    {"DIABLOUS", "Diabolus"},
    {"DIABLOUS2", "Diabolus Custom"},
    {"DILETTANTE", "Dilettante"},
    {"DILETTANTE2", "Dilettante (Merryweather)"},
    {"DINGHY", "Dinghy"},
    {"DINGHY2", "Dinghy (2 Seater)"},
    {"DINGHY3", "Dinghy (Heist)"},
    {"DINGHY5", "Dinghy (Weaponized)"},
    {"DINGHY4", "Dinghy (Yacht)"},
    {"HANDLER", "Dock Handler"},
    {"DOCKTUG", "Docktug"},
    {"DODO", "Dodo"},
    {"DOMINATOR", "Dominator"},
    {"dominator7", "Dominator ASP"},
    {"dominator8", "Dominator GTT"},
    {"DOMINATOR3", "Dominator GTX"},
    {"DOUBLE", "Double T"},
    {"BULLDOZER", "Dozer"},
    {"OPENWHEEL2", "DR1"},
    {"DRAFTER", "Drafter"},
    {"TAMPA2", "Drift Tampa"},
    {"YOSEMITE2", "Drift Yosemite"},
    {"DUBSTA", "Dubsta"},
    {"DUBSTA2", "Dubsta 2"},
    {"DUBSTA3", "Dubsta 6x6"},
    {"DUKES2", "Duke O' Death"},
    {"DUKES", "Dukes"},
    {"DUMP", "Dump"},
    {"RALLYTRUCK", "Dune"},
    {"DUNE", "Dune Buggy"},
    {"DUNE3", "Dune FAV"},
    {"DLOADER", "Duneloader"},
    {"DUSTER", "Duster"},
    {"DYNASTY", "Dynasty"},
    {"SHEAVA", "ETR1"},
    {"ELEGY2", "Elegy RH8"},
    {"ELEGY", "Elegy Retro Custom"},
    {"ELLIE", "Ellie"},
    {"EMERUS", "Emerus"},
    {"EMPEROR", "Emperor"},
    {"EMPEROR2", "Emperor (Rusty)"},
    {"EMPEROR3", "Emperor (Snow)"},
    {"TRIBIKE2", "Endurex Race Bike"},
    {"ENDURO", "Enduro"},
    {"ENTITYXF", "Entity XF"},
    {"ENTITY2", "Entity XXR"},
    {"ESSKEY", "Esskey"},
    {"euros", "Euros"},
    {"EVERON", "Everon"},
    {"EXEMPLAR", "Exemplar"},
    {"F620", "F620"},
    {"FCR", "FCR 1000"},
    {"FCR2", "FCR 1000 Custom"},
    {"FBI", "FIB Buffalo"},
    {"FBI2", "FIB Granger"},
    {"FMJ", "FMJ"},
    {"FQ2", "FQ 2"},
    {"FACTION", "Faction"},
    {"FACTION2", "Faction Custom"},
    {"FACTION3", "Faction Custom Donk"},
    {"FAGALOA", "Fagaloa"},
    {"FAGGIO2", "Faggio"},
    {"FAGGIO3", "Faggio Mod"},
    {"FAGGIO", "Faggio Sport"},
    {"TVTRAILER", "Fame or Shame Trailer"},
    {"FELON", "Felon"},
    {"FELON2", "Felon GT"},
    {"FELTZER2", "Feltzer"},
    {"PBUS2", "Festival Bus"},
    {"TRACTOR2", "Fieldmaster"},
    {"TRACTOR3", "Fieldmaster (Snow)"},
    {"FIRETRUK", "Firetruck"},
    {"FIXTER", "Fixter"},
    {"FLASHGT", "Flash GT"},
    {"FLATBED", "Flatbed"},
    {"FREIGHTTRAILER", "Flatbed Trailer 1"},
    {"TRFLAT", "Flatbed Trailer 2"},
    {"FORKLIFT", "Forklift"},
    {"BTYPE2", "Franken"},
    {"FREECRAWLER", "Freecrawler"},
    {"FREIGHTCAR", "Freight Car"},
    {"freightcar2", "Freight Trailer"},
    {"FREIGHT", "Freight Train 1"},
    {"FREIGHTCONT1", "Freight Train 2"},
    {"FREIGHTCONT2", "Freight Train 3"},
    {"FREIGHTGRAIN", "Freight Train 4"},
    {"TANKERCAR", "Freight Train 5"},
    {"FROGGER", "Frogger"},
    {"FROGGER2", "Frogger (FIB)"},
    {"FUGITIVE", "Fugitive"},
    {"FURIA", "Furia"},
    {"FUROREGT", "Furore GT"},
    {"FUSILADE", "Fusilade"},
    {"FUTO", "Futo"},
    {"futo2", "Futo GTX"},
    {"BRUISER2", "Future Shock Bruiser"},
    {"BRUTUS2", "Future Shock Brutus"},
    {"CERBERUS2", "Future Shock Cerberus"},
    {"DEATHBIKE2", "Future Shock Deathbike"},
    {"DOMINATOR5", "Future Shock Dominator"},
    {"IMPALER3", "Future Shock Impaler"},
    {"IMPERATOR2", "Future Shock Imperator"},
    {"ISSI5", "Future Shock Issi"},
    {"MONSTER4", "Future Shock Sasquatch"},
    {"SCARAB2", "Future Shock Scarab"},
    {"SLAMVAN5", "Future Shock Slamvan"},
    {"ZR3802", "Future Shock ZR380"},
    {"GB200", "GB200"},
    {"GP1", "GP1"},
    {"GT500", "GT500"},
    {"GARGOYLE", "Gargoyle"},
    {"GAUNTLET", "Gauntlet"},
    {"GAUNTLET2", "Gauntlet (Redwood)"},
    {"GAUNTLET3", "Gauntlet Classic"},
    {"GAUNTLET5", "Gauntlet Classic Custom"},
    {"GAUNTLET4", "Gauntlet Hellfire"},
    {"GLENDALE", "Glendale"},
    {"GLENDALE2", "Glendale Custom"},
    {"BLISTA3", "Go Go Monkey Blista"},
    {"GRAINTRAILER", "Grain Trailer"},
    {"GRANGER", "Granger"},
    {"GRESLEY", "Gresley"},
    {"growler", "Growler"},
    {"GUARDIAN", "Guardian"},
    {"HABANERO", "Habanero"},
    {"HAKUCHOU", "Hakuchou"},
    {"HAKUCHOU2", "Hakuchou Drag"},
    {"HALFTRACK", "Half-Track"},
    {"HAULER", "Hauler"},
    {"HAULER2", "Hauler Custom"},
    {"HAVOK", "Havok"},
    {"BALETRAILER", "Hay Bale Trailer"},
    {"HELLION", "Hellion"},
    {"HERMES", "Hermes"},
    {"HEXER", "Hexer"},
    {"BLAZER3", "Hot Rod Blazer"},
    {"HOTKNIFE", "Hotknife"},
    {"HOTRING", "Hotring Sabre"},
    {"HOWARD", "Howard NX-25"},
    {"HUNTER", "Hunter"},
    {"HUNTLEY", "Huntley S"},
    {"HUSTLER", "Hustler"},
    {"HYDRA", "Hydra"},
    {"IMORGON", "Imorgon"},
    {"IMPALER", "Impaler"},
    {"INFERNUS", "Infernus"},
    {"INFERNUS2", "Infernus Classic"},
    {"INGOT", "Ingot"},
    {"BFINJECTION", "Injection"},
    {"INNOVATION", "Innovation"},
    {"INSURGENT2", "Insurgent"},
    {"INSURGENT3", "Insurgent Custom"},
    {"INSURGENT", "Insurgent Pick-Up"},
    {"INTRUDER", "Intruder"},
    {"MINITANK", "Invade and Persuade Tank"},
    {"ISSI2", "Issi"},
    {"ISSI3", "Issi Classic"},
    {"ISSI7", "Issi Sport"},
    {"ITALIGTB", "Itali GTB"},
    {"ITALIGTB2", "Itali GTB Custom"},
    {"ITALIGTO", "Itali GTO"},
    {"ITALIRSX", "Itali RSX"},
    {"JB700", "JB 700"},
    {"JB7002", "JB 700W"},
    {"JACKAL", "Jackal"},
    {"JESTER", "Jester"},
    {"JESTER3", "Jester Classic"},
    {"JESTER2", "Jester Racecar"},
    {"jester4", "Jester RR"},
    {"JET", "Jet"},
    {"JETMAX", "Jetmax"},
    {"JOURNEY", "Journey"},
    {"JUGULAR", "Jugular"},
    {"KALAHARI", "Kalahari"},
    {"KAMACHO", "Kamacho"},
    {"KHAMELION", "Khamelion"},
    {"KHANJALI", "Khanjali"},
    {"KOMODA", "Komoda"},
    {"SUBMERSIBLE2", "Kranken"},
    {"KRIEGER", "Krieger"},
    {"KURUMA", "Kuruma"},
    {"KURUMA2", "Kuruma (Armored)"},
    {"LANDSTALKER", "Landstalker"},
    {"LANDSTALKER2", "Landstalker XL"},
    {"MOWER", "Lawn Mower"},
    {"LAZER", "Lazer"},
    {"LECTRO", "Lectro"},
    {"LGUARD", "Lifeguard"},
    {"STRETCH", "Limo"},
    {"LIMO2", "Limo (Turreted)"},
    {"LOCUST", "Locust"},
    {"TRAILERLOGS", "Logging Trailer"},
    {"LONGFIN", "Longfin"},
    {"SLAMVAN2", "Lost Slamvan"},
    {"LURCHER", "Lurcher"},
    {"LUXOR", "Luxor"},
    {"LUXOR2", "Luxor Deluxe"},
    {"LYNX", "Lynx"},
    {"STUNT", "Mallard"},
    {"MAMBA", "Mamba"},
    {"MAMMATUS", "Mammatus"},
    {"MANANA", "Manana"},
    {"MANANA2", "Manana Custom"},
    {"MANCHEZ", "Manchez"},
    {"MANCHEZ2", "Manchez Scout"},
    {"MARQUIS", "Marquis"},
    {"MARSHALL", "Marshall"},
    {"MASSACRO", "Massacro"},
    {"MASSACRO2", "Massacro Racecar"},
    {"MAVERICK", "Maverick"},
    {"POLMAV", "Maverick (Emergency)"},
    {"menacer", "Menacer"},
    {"MESA", "Mesa"},
    {"MESA3", "Mesa (Merryweather)"},
    {"MESA2", "Mesa (Snow)"},
    {"PROPTRAILER", "Meth Lab Trailer"},
    {"METROTRAIN", "Metro Train"},
    {"MICHELLI", "Michelli GT"},
    {"MILJET", "Miljet"},
    {"MINIVAN", "Minivan"},
    {"MINIVAN2", "Minivan Custom"},
    {"MIXER", "Mixer"},
    {"MIXER2", "Mixer (Support Wheel)"},
    {"TRAILERLARGE", "Mobile Operations Center"},
    {"MOGUL", "Mogul"},
    {"MOLOTOK", "Molotok"},
    {"MONROE", "Monroe"},
    {"MONSTER", "Monster Truck"},
    {"MOONBEAM", "Moonbeam"},
    {"MOONBEAM2", "Moonbeam Custom"},
    {"MULE", "Mule (Graphics 1)"},
    {"MULE2", "Mule (Graphics 2)"},
    {"MULE3", "Mule (Plain)"},
    {"MULE4", "Mule Custom"},
    {"NEBULA", "Nebula Turbo"},
    {"NEMESIS", "Nemesis"},
    {"NEO", "Neo"},
    {"NEON", "Neon"},
    {"NERO", "Nero"},
    {"NERO2", "Nero Custom"},
    {"NIGHTBLADE", "Nightblade"},
    {"BRUISER3", "Nightmare Bruiser"},
    {"BRUTUS3", "Nightmare Brutus"},
    {"CERBERUS3", "Nightmare Cerberus"},
    {"DEATHBIKE3", "Nightmare Deathbike"},
    {"DOMINATOR6", "Nightmare Dominator"},
    {"IMPALER4", "Nightmare Impaler"},
    {"IMPERATOR3", "Nightmare Imperator"},
    {"ISSI6", "Nightmare Issi"},
    {"MONSTER5", "Nightmare Sasquatch"},
    {"SCARAB3", "Nightmare Scarab"},
    {"SLAMVAN6", "Nightmare Slamvan"},
    {"ZR3803", "Nightmare ZR380"},
    {"NIGHTSHADE", "Nightshade"},
    {"NIGHTSHARK", "Nightshark"},
    {"NIMBUS", "Nimbus"},
    {"NOKOTA", "Nokota"},
    {"NOVAK", "Novak"},
    {"OMNIS", "Omnis"},
    {"OPPRESSOR", "Oppressor"},
    {"OPPRESSOR2", "Oppressor 2"},
    {"ORACLE2", "Oracle"},
    {"ORACLE", "Oracle XS"},
    {"OSIRIS", "Osiris"},
    {"OUTLAW", "Outlaw"},
    {"PCJ", "PCJ 600"},
    {"FORMULA", "PR4"},
    {"PACKER", "Packer"},
    {"PANTO", "Panto"},
    {"PARADISE", "Paradise"},
    {"PARAGON", "Paragon R"},
    {"PARAGON2", "Paragon R (Armored)"},
    {"PARIAH", "Pariah"},
    {"PRANGER", "Park Ranger"},
    {"PATRIOT", "Patriot"},
    {"PATRIOT2", "Patriot Stretch"},
    {"PATROLBOAT", "Patrol Boat"},
    {"PENETRATOR", "Penetrator"},
    {"PENUMBRA", "Penumbra"},
    {"PENUMBRA2", "Penumbra FF"},
    {"TANKER2", "Petrol Tanker Trailer (Plain)"},
    {"TANKER", "Petrol Tanker Trailer (RON)"},
    {"PEYOTE", "Peyote"},
    {"PEYOTE3", "Peyote Custom"},
    {"PEYOTE2", "Peyote Gasser"},
    {"PFISTER811", "Pfister 811"},
    {"PHANTOM", "Phantom"},
    {"PHANTOM3", "Phantom Custom"},
    {"PHANTOM2", "Phantom Wedge"},
    {"PHOENIX", "Phoenix"},
    {"PICADOR", "Picador"},
    {"PIGALLE", "Pigalle"},
    {"DOMINATOR2", "Pisswasser Dominator"},
    {"TRAILERS", "Plain Trailer"},
    {"POLICE", "Police"},
    {"POLICEB", "Police Bike"},
    {"POLICE2", "Police Buffalo"},
    {"POLICE3", "Police Interceptor"},
    {"PBUS", "Police Prison Bus"},
    {"POLICEOLD1", "Police Rancher (Snow)"},
    {"RIOT", "Police Riot"},
    {"POLICEOLD2", "Police Roadcruiser (Snow)"},
    {"POLICET", "Police Transporter"},
    {"PONY", "Pony (Business)"},
    {"PONY2", "Pony (Cannabis)"},
    {"POUNDER", "Pounder"},
    {"POUNDER2", "Pounder Custom"},
    {"PRAIRIE", "Prairie"},
    {"PREDATOR", "Predator"},
    {"PREMIER", "Premier"},
    {"previon", "Previon"},
    {"PRIMO", "Primo"},
    {"PRIMO2", "Primo Custom"},
    {"PYRO", "Pyro"},
    {"FORMULA2", "R88"},
    {"RCBANDITO", "RC Bandito"},
    {"RIOT2", "RCV"},
    {"LE7B", "RE-7B"},
    {"RADI", "Radius"},
    {"RAIDEN", "Raiden"},
    {"RAKETRAILER", "Rake Trailer"},
    {"DUNE4", "Ramp Buggy"},
    {"DUNE5", "Ramp Buggy Custom"},
    {"RROCKET", "Rampant Rocket"},
    {"RANCHERXL", "Rancher XL"},
    {"RANCHERXL2", "Rancher XL (Snow)"},
    {"RAPIDGT", "Rapid GT"},
    {"RAPIDGT3", "Rapid GT Classic"},
    {"RAPIDGT2", "Rapid GT Convertible"},
    {"RAPTOR", "Raptor"},
    {"RATBIKE", "Rat Bike"},
    {"RATLOADER", "Rat Loader"},
    {"RATLOADER2", "Rat Truck"},
    {"REAPER", "Reaper"},
    {"REBEL2", "Rebel"},
    {"REBLA", "Rebla GTS"},
    {"REGINA", "Regina"},
    {"remus", "Remus"},
    {"RENTALBUS", "Rental Shuttle Bus"},
    {"RETINUE", "Retinue"},
    {"RETINUE2", "Retinue MK2"},
    {"REVOLTER", "Revolter"},
    {"RHAPSODY", "Rhapsody"},
    {"RHINO", "Rhino Tank"},
    {"RIATA", "Riata"},
    {"RIPLEY", "Ripley"},
    {"VOLTIC2", "Rocket Voltic"},
    {"ROCOTO", "Rocoto"},
    {"ROGUE", "Rogue"},
    {"ROMERO", "Romero Hearse"},
    {"BTYPE", "Roosevelt"},
    {"BTYPE3", "Roosevelt Valor"},
    {"rt3000", "RT3000"},
    {"RUBBLE", "Rubble"},
    {"RUFFIAN", "Ruffian"},
    {"RUINER", "Ruiner"},
    {"RUINER2", "Ruiner 2000"},
    {"RUINER3", "Ruiner 3"},
    {"RUMPO2", "Rumpo (Deludamol)"},
    {"RUMPO", "Rumpo (Plain/Weazel)"},
    {"RUMPO3", "Rumpo Custom"},
    {"RUSTON", "Ruston"},
    {"REBEL", "Rusty Rebel"},
    {"S80", "S80RR"},
    {"SC1", "SC1"},
    {"SABREGT", "Sabre Turbo"},
    {"SABREGT2", "Sabre Turbo Custom"},
    {"SADLER", "Sadler"},
    {"SADLER2", "Sadler (Snow)"},
    {"SANCHEZ", "Sanchez"},
    {"SANCHEZ2", "Sanchez (No Livery)"},
    {"SANCTUS", "Sanctus"},
    {"SANDKING2", "Sandking"},
    {"SANDKING", "Sandking XL"},
    {"SAVAGE", "Savage"},
    {"SAVESTRA", "Savestra"},
    {"SCHAFTER2", "Schafter"},
    {"SCHAFTER4", "Schafter LWB"},
    {"SCHAFTER6", "Schafter LWB (Armored)"},
    {"SCHAFTER3", "Schafter V12"},
    {"SCHAFTER5", "Schafter V12 (Armored)"},
    {"SCHLAGEN", "Schlagen GT"},
    {"SCHWARZER", "Schwartzer"},
    {"SCORCHER", "Scorcher"},
    {"SCRAMJET", "Scramjet"},
    {"SCRAP", "Scrap Truck"},
    {"SEASPARROW", "Sea Sparrow"},
    {"SEABREEZE", "Seabreeze"},
    {"SEASHARK", "Seashark"},
    {"SEASHARK2", "Seashark (Lifeguard)"},
    {"SEASHARK3", "Seashark (Yacht)"},
    {"SEMINOLE", "Seminole"},
    {"SEMINOLE2", "Seminole Frontier"},
    {"SENTINEL2", "Sentinel"},
    {"SENTINEL3", "Sentinel Classic"},
    {"SENTINEL", "Sentinel XS"},
    {"SERRANO", "Serrano"},
    {"SEVEN70", "Seven-70"},
    {"SHAMAL", "Shamal"},
    {"SHERIFF", "Sheriff Cruiser"},
    {"SHERIFF2", "Sheriff SUV"},
    {"SHOTARO", "Shotaro"},
    {"SKYLIFT", "Skylift"},
    {"SLAMTRUCK", "Slamtruck"},
    {"SLAMVAN", "Slamvan"},
    {"SLAMVAN3", "Slamvan Custom"},
    {"TRAILERSMALL", "Small Trailer"},
    {"SOVEREIGN", "Sovereign"},
    {"DUNE2", "Space Docker"},
    {"SEASPARROW3", "Sparrow"},
    {"SPECTER", "Specter"},
    {"SPECTER2", "Specter Custom"},
    {"SPEEDER", "Speeder"},
    {"SPEEDER2", "Speeder (Yacht)"},
    {"SPEEDO", "Speedo"},
    {"SPEEDO4", "Speedo Custom"},
    {"BUFFALO3", "Sprunk Buffalo"},
    {"SQUADDIE", "Squaddie"},
    {"SQUALO", "Squalo"},
    {"STAFFORD", "Stafford"},
    {"STALION", "Stallion"},
    {"STANIER", "Stanier"},
    {"STARLING", "Starling"},
    {"STINGER", "Stinger"},
    {"STINGERGT", "Stinger GT"},
    {"FELTZER3", "Stirling GT"},
    {"STOCKADE", "Stockade"},
    {"STOCKADE3", "Stockade (Snow)"},
    {"STRATUM", "Stratum"},
    {"BLAZER4", "Street Blazer"},
    {"STREITER", "Streiter"},
    {"STRIKEFORCE", "Strikeforce"},
    {"STROMBERG", "Stromberg"},
    {"STRYDER", "Stryder"},
    {"SUBMERSIBLE", "Submersible"},
    {"SUGOI", "Sugoi"},
    {"SULTAN", "Sultan"},
    {"SULTAN2", "Sultan Classic"},
    {"SULTANRS", "Sultan RS"},
    {"sultan3", "Sultan RS Classic"},
    {"SUNTRAP", "Suntrap"},
    {"SUPERD", "Super Diamond"},
    {"SUPERVOLITO", "Supervolito"},
    {"SUPERVOLITO2", "Supervolito Carbon"},
    {"SURANO", "Surano"},
    {"SURFER", "Surfer"},
    {"SURFER2", "Surfer (Rusty)"},
    {"SURGE", "Surge"},
    {"SWIFT", "Swift"},
    {"SWIFT2", "Swift Deluxe"},
    {"SWINGER", "Swinger"},
    {"T20", "T20"},
    {"TACO", "Taco"},
    {"TAILGATER", "Tailgater"},
    {"tailgater2", "Tailgater S"},
    {"TAIPAN", "Taipan"},
    {"TAMPA", "Tampa"},
    {"TAMPA3", "Tampa (Weaponized)"},
    {"TAXI", "Taxi"},
    {"TECHNICAL", "Technical"},
    {"TECHNICAL2", "Technical Aqua"},
    {"TECHNICAL3", "Technical Custom"},
    {"TEMPESTA", "Tempesta"},
    {"TERBYTE", "Terrorbyte"},
    {"TEZERACT", "Tezeract"},
    {"THRAX", "Thrax"},
    {"THRUST", "Thrust"},
    {"THRUSTER", "Thruster"},
    {"TIGON", "Tigon"},
    {"TIPTRUCK", "Tipper (2 Axle)"},
    {"TIPTRUCK2", "Tipper (3 Axle)"},
    {"TITAN", "Titan"},
    {"TOREADOR", "Toreador"},
    {"TORERO", "Torero"},
    {"TORNADO", "Tornado"},
    {"TORNADO3", "Tornado (Rusty)"},
    {"TORNADO2", "Tornado Cabrio"},
    {"TORNADO4", "Tornado Cabrio (Rusty)"},
    {"TORNADO5", "Tornado Custom"},
    {"TORNADO6", "Tornado Rat Rod"},
    {"TORO", "Toro"},
    {"TORO2", "Toro (Yacht)"},
    {"TOROS", "Toros"},
    {"TOURBUS", "Tourbus"},
    {"TOWTRUCK", "Tow Truck"},
    {"TOWTRUCK2", "Tow Truck (Old)"},
    {"TRACTOR", "Tractor (Rusty)"},
    {"TRAILERS4", "Trailer 4"},
    {"TRASH", "Trashmaster"},
    {"TRASH2", "Trashmaster (Heist)"},
    {"TRIBIKE3", "Tri-Cycles Race Bike"},
    {"TROPHYTRUCK", "Trophy Truck"},
    {"TROPIC", "Tropic"},
    {"TROPIC2", "Tropic (Yacht)"},
    {"TROPOS", "Tropos Rallye"},
    {"TUG", "Tug"},
    {"TULA", "Tula"},
    {"TULIP", "Tulip"},
    {"TURISMO2", "Turismo Classic"},
    {"TURISMOR", "Turismo R"},
    {"TYRANT", "Tyrant"},
    {"TYRUS", "Tyrus"},
    {"MICROLIGHT", "Ultralight"},
    {"POLICE4", "Unmarked Cruiser"},
    {"UTILLITRUCK", "Utility Truck (Cherry Picker)"},
    {"UTILLITRUCK2", "Utility Truck (Flatbed)"},
    {"UTILLITRUCK3", "Utility Truck (Pick-Up)"},
    {"VSTR", "V-STR"},
    {"VACCA", "Vacca"},
    {"VADER", "Vader"},
    {"VAGNER", "Vagner"},
    {"VAGRANT", "Vagrant"},
    {"VALKYRIE", "Valkyrie"},
    {"VALKYRIE2", "Valkyrie MOD.O."},
    {"VAMOS", "Vamos"},
    {"vectre", "Vectre"},
    {"VELUM", "Velum"},
    {"VELUM2", "Velum (5 Seater)"},
    {"VERLIERER2", "Verlierer"},
    {"VERUS", "Verus"},
    {"VESTRA", "Vestra"},
    {"VETIR", "Vetir"},
    {"VETO", "Veto Classic"},
    {"VETO2", "Veto Modern"},
    {"VIGERO", "Vigero"},
    {"VIGILANTE", "Vigilante"},
    {"VINDICATOR", "Vindicator"},
    {"VIRGO", "Virgo"},
    {"VIRGO3", "Virgo Classic"},
    {"VIRGO2", "Virgo Classic Custom"},
    {"VISERIS", "Viseris"},
    {"VISIONE", "Visione"},
    {"VOLATOL", "Volatol"},
    {"VOLATUS", "Volatus"},
    {"VOLTIC", "Voltic"},
    {"VOODOO2", "Voodoo"},
    {"VOODOO", "Voodoo Custom"},
    {"VORTEX", "Vortex"},
    {"WARRENER", "Warrener"},
    {"warrener2", "Warrener HKR"},
    {"WASHINGTON", "Washington"},
    {"WASTELANDER", "Wastelander"},
    {"WEEVIL", "Weevil"},
    {"TRIBIKE", "Whippet Race Bike"},
    {"WINDSOR", "Windsor"},
    {"WINDSOR2", "Windsor Drop"},
    {"WINKY", "Winky"},
    {"WOLFSBANE", "Wolfsbane"},
    {"PROTOTIPO", "X80 Proto"},
    {"XA21", "XA-21"},
    {"XLS", "XLS"},
    {"XLS2", "XLS (Armored)"},
    {"BLIMP2", "Xero Blimp"},
    {"YOSEMITE", "Yosemite"},
    {"YOSEMITE3", "Yosemite Rancher"},
    {"YOUGA", "Youga"},
    {"YOUGA2", "Youga Classic"},
    {"YOUGA3", "Youga Classic 4x4"},
    {"ZTYPE", "Z Type"},
    {"ZENTORNO", "Zentorno"},
    {"ZHABA", "Zhaba"},
    {"ZION", "Zion"},
    {"ZION2", "Zion Cabrio"},
    {"ZION3", "Zion Classic"},
    {"ZOMBIEA", "Zombie Bobber"},
    {"ZOMBIEB", "Zombie Chopper"},
    {"ZORRUSSO", "Zorrusso"},
    {"zr350", "ZR350"}
}
logg("[Initialization] Successfully Loaded " .. #vehiclelist .. " Vehicle Models")
--Ped List
mcname = {
    "麦可",
    "富兰克林",
    "崔佛",
    "在线模式默认女性",
    "在线模式默认男性"
}
mccode = {
    "player_zero",
    "player_one",
    "player_two",
    "mp_f_freemode_01",
    "mp_m_freemode_01"
}

Animalname = {
    "Australian Shepherd",
    "Boar",
    "Cat",
    "Chimp",
    "Chop",
    "Cormorant",
    "Cow",
    "Coyote",
    "Crow",
    "Deer",
    "Dolphin",
    "Fish",
    "Hammerhead Shark",
    "Hawk",
    "Hen",
    "Husky",
    "Mountain Lion",
    "Panther",
    "Pig",
    "Pigeon",
    "Poodle",
    "Pug",
    "Rat",
    "Retriever",
    "Rhesus",
    "Rottweiler",
    "Seagull",
    "Tiger Shark",
    "Westie"
}
Animalcode = {
    "a_c_shepherd",
    "a_c_boar",
    "a_c_cat_01",
    "a_c_chimp",
    "a_c_chop",
    "a_c_cormorant",
    "a_c_cow",
    "a_c_coyote",
    "a_c_crow",
    "a_c_deer",
    "a_c_dolphin",
    "a_c_fish",
    "a_c_sharkhammer",
    "a_c_chickenhawk",
    "a_c_hen",
    "a_c_humpback",
    "a_c_husky",
    "a_c_killerwhale",
    "a_c_mtlion",
    "a_c_panther",
    "a_c_pig",
    "a_c_pigeon",
    "a_c_poodle",
    "a_c_pug",
    "a_c_rabbit_01",
    "a_c_rat",
    "a_c_retriever",
    "a_c_rhesus",
    "a_c_rottweiler",
    "a_c_seagull",
    "a_c_stingray",
    "a_c_sharktiger",
    "a_c_westy"
}

Ambientfemalename = {
    "Beach Female",
    "Beach Tramp Female",
    "Beach Young Female",
    "Beach Young Female 2",
    "Beverly Hills Female",
    "Beverly Hills Female 2",
    "Beverly Hills Young Female",
    "Beverly Hills Young Female 2",
    "Beverly Hills Young Female 3",
    "Beverly Hills Young Female 4",
    "Bodybuilder Female",
    "Business Female 2",
    "Business Young Female",
    "Business Young Female 2",
    "Business Young Female 3",
    "Business Young Female 4",
    "Downtown Female",
    "Dressy Female",
    "East SA Female",
    "East SA Female 2",
    "East SA Young Female",
    "East SA Young Female 2",
    "East SA Young Female 3",
    "Epsilon Female",
    "Fat Black Female",
    "Fat Cult Female",
    "Fat White Female",
    "Female Agent",
    "Fitness Female",
    "Fitness Female 2",
    "General Hot Young Female",
    "General Street Old Female",
    "Casual Casino Guest",
    "Formel Casino Guest",
    "Golfer Young Female",
    "Hiker Female",
    "Hippie Female",
    "Hipster Female",
    "Hipster Female 2",
    "Hipster Female 3",
    "Hipster Female 4",
    "Indian Old Female",
    "Indian Young Female",
    "Jogger Female",
    "Juggalo Female",
    "Korean Female",
    "Korean Female 2",
    "Korean Old Female",
    "Prologue Host Female",
    "Rural Meth Addict Female",
    "Salton Female",
    "Salton Old Female",
    "Skater Female",
    "Skid Row Female",
    "South Central Female",
    "South Central Female 2",
    "South Central MC Female",
    "South Central Old Female",
    "South Central Old Female 2",
    "South Central Young Female",
    "South Central Young Female 2",
    "South Central Young Female 3",
    "Tennis Player Female",
    "Topless",
    "Tourist Female",
    "Tourist Young Female",
    "Tourist Young Female 2",
    "Tramp Female",
    "Vinewood Female",
    "Vinewood Female 2",
    "Vinewood Female 3",
    "Vinewood Female 4",
    "Yoga Female",
    "Club Customer Female 1",
    "Club Customer Female 2",
    "Club Customer Female 3",
    "Club Customer Female 4",
    "Beverly Hills Young Female 5"
}
Ambientfemalecode = {
    "a_f_m_beach_01",
    "a_f_m_trampbeac_01",
    "a_f_y_beach_01",
    "a_f_y_beach_02",
    "a_f_m_bevhills_01",
    "a_f_m_bevhills_02",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_bevhills_03",
    "a_f_y_bevhills_04",
    "a_f_m_bodybuild_01",
    "a_f_m_business_02",
    "a_f_y_business_01",
    "a_f_y_business_02",
    "a_f_y_business_03",
    "a_f_y_business_04",
    "a_f_m_downtown_01",
    "a_f_y_scdressy_01",
    "a_f_m_eastsa_01",
    "a_f_m_eastsa_02",
    "a_f_y_eastsa_01",
    "a_f_y_eastsa_02",
    "a_f_y_eastsa_03",
    "a_f_y_epsilon_01",
    "a_f_m_fatbla_01",
    "a_f_m_fatcult_01",
    "a_f_m_fatwhite_01",
    "a_f_y_femaleagent",
    "a_f_y_fitness_01",
    "a_f_y_fitness_02",
    "a_f_y_genhot_01",
    "a_f_o_genstreet_01",
    "a_f_y_gencaspat_01",
    "a_f_y_smartcaspat_01",
    "a_f_y_golfer_01",
    "a_f_y_hiker_01",
    "a_f_y_hippie_01",
    "a_f_y_hipster_01",
    "a_f_y_hipster_02",
    "a_f_y_hipster_03",
    "a_f_y_hipster_04",
    "a_f_o_indian_01",
    "a_f_y_indian_01",
    "a_f_y_runner_01",
    "a_f_y_juggalo_01",
    "a_f_m_ktown_01",
    "a_f_m_ktown_02",
    "a_f_o_ktown_01",
    "a_f_m_prolhost_01",
    "a_f_y_rurmeth_01",
    "a_f_m_salton_01",
    "a_f_o_salton_01",
    "a_f_y_skater_01",
    "a_f_m_skidrow_01",
    "a_f_m_soucent_01",
    "a_f_m_soucent_02",
    "a_f_m_soucentmc_01",
    "a_f_o_soucent_01",
    "a_f_o_soucent_02",
    "a_f_y_soucent_01",
    "a_f_y_soucent_02",
    "a_f_y_soucent_03",
    "a_f_y_tennis_01",
    "a_f_y_topless_01",
    "a_f_m_tourist_01",
    "a_f_y_tourist_01",
    "a_f_y_tourist_02",
    "a_f_m_tramp_01",
    "a_f_y_vinewood_01",
    "a_f_y_vinewood_02",
    "a_f_y_vinewood_03",
    "a_f_y_vinewood_04",
    "a_f_y_yoga_01",
    "a_f_y_clubcust_01",
    "a_f_y_clubcust_02",
    "a_f_y_clubcust_03",
    "a_f_y_clubcust_04",
    "a_f_y_bevhills_05"
}

Ambientmalename = {
    "African American Male",
    "Altruist Cult Mid-Age Male",
    "Altruist Cult Old Male",
    "Altruist Cult Old Male 2",
    "Altruist Cult Young Male",
    "Altruist Cult Young Male 2",
    "Beach Male",
    "Beach Male 2",
    "Beach Muscle Male",
    "Beach Muscle Male 2",
    "Midlife Crisis Casino Bikers",
    "Casual Casino Guests",
    "Formel Casino Guests",
    "Beach Old Male",
    "Beach Old Male 2",
    "Beach Tramp Male",
    "Beach Young Male",
    "Beach Young Male 2",
    "Beach Young Male 3",
    "Beach Young Male 4",
    "Beverly Hills Male",
    "Beverly Hills Male 2",
    "Beverly Hills Young Male",
    "Beverly Hills Young Male 2",
    "Black Street Male",
    "Black Street Male 2",
    "Breakdancer Male",
    "Business Casual",
    "Business Male",
    "Business Young Male",
    "Business Young Male 2",
    "Business Young Male 3",
    "Cyclist Male",
    "Downhill Cyclist",
    "Downtown Male",
    "East SA Male",
    "East SA Male 2",
    "East SA Young Male",
    "East SA Young Male 2",
    "Epsilon Male",
    "Epsilon Male 2",
    "Farmer",
    "Fat Latino Male",
    "Gay Male",
    "Gay Male 2",
    "General Fat Male",
    "General Fat Male 2",
    "General Street Old Male",
    "General Street Young Male",
    "General Street Young Male 2",
    "Golfer Male",
    "Golfer Young Male",
    "Hasidic Jew Male",
    "Hasidic Jew Young Male",
    "Hiker Male",
    "Hillbilly Male",
    "Hillbilly Male 2",
    "Hippie Male",
    "Hipster Male",
    "Hipster Male 2",
    "Hipster Male 3",
    "Indian Male",
    "Indian Young Male",
    "Jetskier",
    "Jogger Male",
    "Jogger Male 2",
    "Juggalo Male",
    "Korean Male",
    "Korean Old Male",
    "Korean Young Male",
    "Korean Young Male 2",
    "Latino Street Male 2",
    "Latino Street Young Male",
    "Latino Young Male",
    "Malibu Male",
    "Meth Addict",
    "Mexican Labourer",
    "Mexican Rural",
    "Mexican Thug",
    "Motocross Biker",
    "Motocross Biker 2",
    "OG Boss",
    "Paparazzi Male",
    "Polynesian",
    "Polynesian Young",
    "Prologue Host Male",
    "Road Cyclist",
    "Rural Meth Addict Male",
    "Salton Male",
    "Salton Male 2",
    "Salton Male 3",
    "Salton Male 4",
    "Salton Old Male",
    "Salton Young Male",
    "Skater Male",
    "Skater Young Male",
    "Skater Young Male 2",
    "Skid Row Male",
    "South Central Latino Male",
    "South Central Male",
    "South Central Male 2",
    "South Central Male 3",
    "South Central Male 4",
    "South Central Old Male",
    "South Central Old Male 2",
    "South Central Old Male 3",
    "South Central Young Male",
    "South Central Young Male 2",
    "South Central Young Male 3",
    "South Central Young Male 4",
    "Sunbather Male",
    "Surfer",
    "Tennis Player Male",
    "Tourist Male",
    "Tramp Male",
    "Tramp Old Male",
    "Transvestite Male",
    "Transvestite Male 2",
    "Vespucci Beach Male",
    "Vespucci Beach Male 2",
    "Vinewood Douche",
    "Vinewood Male",
    "Vinewood Male 2",
    "Vinewood Male 3",
    "Vinewood Male 4",
    "White Street Male",
    "White Street Male 2",
    "Yoga Male",
    "Club Customer Male 1",
    "Club Customer Male 2",
    "Club Customer Male 3",
    "Club Customer Male 4"
}
Ambientmalecode = {
    "a_m_m_afriamer_01",
    "a_m_m_acult_01",
    "a_m_o_acult_01",
    "a_m_o_acult_02",
    "a_m_y_acult_01",
    "a_m_y_acult_02",
    "a_m_m_beach_01",
    "a_m_m_beach_02",
    "a_m_y_musclbeac_01",
    "a_m_y_musclbeac_02",
    "a_m_m_mlcrisis_01",
    "a_m_y_gencaspat_01",
    "a_m_y_smartcaspat_01",
    "a_m_o_beach_01",
    "a_m_o_beach_02",
    "a_m_m_trampbeac_01",
    "a_m_y_beach_01",
    "a_m_y_beach_02",
    "a_m_y_beach_03",
    "a_m_y_beach_04",
    "a_m_m_bevhills_01",
    "a_m_m_bevhills_02",
    "a_m_y_bevhills_01",
    "a_m_y_bevhills_02",
    "a_m_y_stbla_01",
    "a_m_y_stbla_02",
    "a_m_y_breakdance_01",
    "a_m_y_busicas_01",
    "a_m_m_business_01",
    "a_m_y_business_01",
    "a_m_y_business_02",
    "a_m_y_business_03",
    "a_m_y_cyclist_01",
    "a_m_y_dhill_01",
    "a_m_y_downtown_01",
    "a_m_m_eastsa_01",
    "a_m_m_eastsa_02",
    "a_m_y_eastsa_01",
    "a_m_y_eastsa_02",
    "a_m_y_epsilon_01",
    "a_m_y_epsilon_02",
    "a_m_m_farmer_01",
    "a_m_m_fatlatin_01",
    "a_m_y_gay_01",
    "a_m_y_gay_02",
    "a_m_m_genfat_01",
    "a_m_m_genfat_02",
    "a_m_o_genstreet_01",
    "a_m_y_genstreet_01",
    "a_m_y_genstreet_02",
    "a_m_m_golfer_01",
    "a_m_y_golfer_01",
    "a_m_m_hasjew_01",
    "a_m_y_hasjew_01",
    "a_m_y_hiker_01",
    "a_m_m_hillbilly_01",
    "a_m_m_hillbilly_02",
    "a_m_y_hippy_01",
    "a_m_y_hipster_01",
    "a_m_y_hipster_02",
    "a_m_y_hipster_03",
    "a_m_m_indian_01",
    "a_m_y_indian_01",
    "a_m_y_jetski_01",
    "a_m_y_runner_01",
    "a_m_y_runner_02",
    "a_m_y_juggalo_01",
    "a_m_m_ktown_01",
    "a_m_o_ktown_01",
    "a_m_y_ktown_01",
    "a_m_y_ktown_02",
    "a_m_m_stlat_02",
    "a_m_y_stlat_01",
    "a_m_y_latino_01",
    "a_m_m_malibu_01",
    "a_m_y_methhead_01",
    "a_m_m_mexlabor_01",
    "a_m_m_mexcntry_01",
    "a_m_y_mexthug_01",
    "a_m_y_motox_01",
    "a_m_y_motox_02",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_m_polynesian_01",
    "a_m_y_polynesian_01",
    "a_m_m_prolhost_01",
    "a_m_y_roadcyc_01",
    "a_m_m_rurmeth_01",
    "a_m_m_salton_01",
    "a_m_m_salton_02",
    "a_m_m_salton_03",
    "a_m_m_salton_04",
    "a_m_o_salton_01",
    "a_m_y_salton_01",
    "a_m_m_skater_01",
    "a_m_y_skater_01",
    "a_m_y_skater_02",
    "a_m_m_skidrow_01",
    "a_m_m_socenlat_01",
    "a_m_m_soucent_01",
    "a_m_m_soucent_02",
    "a_m_m_soucent_03",
    "a_m_m_soucent_04",
    "a_m_o_soucent_01",
    "a_m_o_soucent_02",
    "a_m_o_soucent_03",
    "a_m_y_soucent_01",
    "a_m_y_soucent_02",
    "a_m_y_soucent_03",
    "a_m_y_soucent_04",
    "a_m_y_sunbathe_01",
    "a_m_y_surfer_01",
    "a_m_m_tennis_01",
    "a_m_m_tourist_01",
    "a_m_m_tramp_01",
    "a_m_o_tramp_01",
    "a_m_m_tranvest_01",
    "a_m_m_tranvest_02",
    "a_m_y_beachvesp_01",
    "a_m_y_beachvesp_02",
    "a_m_y_vindouche_01",
    "a_m_y_vinewood_01",
    "a_m_y_vinewood_02",
    "a_m_y_vinewood_03",
    "a_m_y_vinewood_04",
    "a_m_y_stwhi_01",
    "a_m_y_stwhi_02",
    "a_m_y_yoga_01",
    "a_m_y_clubcust_01",
    "a_m_y_clubcust_02",
    "a_m_y_clubcust_03",
    "a_m_y_clubcust_04"
}

Cutscenecode = {
    "csb_abigail",
    "csb_agent",
    "csb_agatha",
    "csb_ary",
    "csb_avery",
    "csb_mp_agent14",
    "cs_amandatownley",
    "cs_andreas",
    "csb_anita",
    "csb_anton",
    "cs_ashley",
    "csb_avon",
    "csb_ballasog",
    "cs_bankman",
    "cs_barry",
    "cs_beverly",
    "csb_brucie2",
    "cs_orleans",
    "csb_bogdan",
    "cs_brad",
    "cs_bradcadaver",
    "csb_bride",
    "csb_burgerdrug",
    "csb_car3guy1",
    "csb_car3guy2",
    "cs_carbuyer",
    "cs_casey",
    "csb_chef",
    "csb_chef2",
    "csb_chin_goon",
    "cs_clay",
    "csb_cletus",
    "csb_cop",
    "cs_chrisformage",
    "csb_customer",
    "cs_dale",
    "cs_davenorton",
    "cs_debra",
    "cs_denise",
    "csb_denise_friend",
    "cs_devin",
    "csb_popov",
    "cs_dom",
    "cs_drfriedlander",
    "cs_tomepsilon",
    "cs_fabien",
    "csb_ramp_gang",
    "cs_mrk",
    "cs_fbisuit_01",
    "cs_floyd",
    "csb_fos_rep",
    "csb_gustavo",
    "csb_g",
    "csb_groom",
    "csb_grove_str_dlr",
    "cs_guadalope",
    "cs_gurk",
    "csb_hao",
    "csb_ramp_hic",
    "csb_ramp_hipster",
    "csb_helmsmanpavel",
    "csb_hugh",
    "cs_hunter",
    "csb_isldj_00",
    "csb_isldj_01",
    "csb_isldj_02",
    "csb_isldj_03",
    "csb_isldj_04",
    "csb_imran",
    "csb_jackhowitzer",
    "cs_janet",
    "csb_janitor",
    "cs_jewelass",
    "cs_jimmyboston",
    "cs_jimmydisanto",
    "csb_jio",
    "cs_johnnyklebitz",
    "cs_josef",
    "cs_josh",
    "csb_juanstrickler",
    "cs_karen_daniels",
    "cs_lamardavis",
    "cs_lazlow",
    "cs_lestercrest",
    "cs_lifeinvad_01",
    "cs_magenta",
    "cs_manuel",
    "csb_ramp_marine",
    "cs_marnie",
    "cs_martinmadrazo",
    "cs_maryann",
    "csb_maude",
    "csb_rashcosvki",
    "csb_mweather",
    "csb_ramp_mex",
    "cs_michelle",
    "csb_miguelmadrazo",
    "cs_milton",
    "csb_mjo",
    "cs_joeminuteman",
    "cs_molly",
    "csb_money",
    "cs_movpremf_01",
    "cs_movpremmale",
    "cs_mrsphillips",
    "csb_mrs_r",
    "cs_mrs_thornhill",
    "cs_natalia",
    "cs_nervousron",
    "cs_nigel",
    "cs_old_man1a",
    "cs_old_man2",
    "cs_omega",
    "csb_ortega",
    "csb_oscar",
    "csb_paige",
    "cs_patricia",
    "cs_patricia2",
    "cs_dreyfuss",
    "csb_porndudes",
    "cs_priest",
    "csb_prologuedriver",
    "csb_prolsec",
    "cs_prolsec_02",
    "csb_reporter",
    "csb_roccopelosi",
    "cs_russiandrunk",
    "csb_screen_writer",
    "cs_siemonyetarian",
    "cs_solomon",
    "csb_sss",
    "cs_stevehains",
    "cs_stretch",
    "csb_stripper_01",
    "csb_stripper_02",
    "cs_tanisha",
    "cs_taocheng",
    "cs_taocheng2",
    "cs_taostranslator",
    "cs_taostranslator2",
    "cs_tenniscoach",
    "cs_terry",
    "cs_tom",
    "csb_tomcasino",
    "csb_tonya",
    "csb_thornton",
    "cs_tracydisanto",
    "csb_trafficwarden",
    "csb_undercover",
    "cs_paper",
    "csb_vagspeak",
    "csb_vincent",
    "cs_wade",
    "cs_chengsr",
    "cs_zimbor",
    "csb_djblamadon",
    "csb_dix",
    "csb_englishdave",
    "csb_englishdave2",
    "cs_lazlow_2",
    "csb_sol",
    "csb_talcc",
    "csb_talmm",
    "csb_tonyprince",
    "csb_alan",
    "csb_bryony",
    "csb_celeb_01",
    "csb_georginacheng",
    "csb_huang",
    "csb_vincent_2",
    "csb_wendy",
    "cs_jimmydisanto2",
    "cs_lestercrest_3"
}
Cutscenename = {
    "Abigail Mathers",
    "Agent",
    "Agatha Baker",
    "Ary",
    "Avery Duggan",
    "Agent 14",
    "Amanda De Santa",
    "Andreas Sanchez",
    "Anita Mendoza",
    "Anton Beaudelaire",
    "Ashley Butler",
    "Avon Hertz",
    "Ballas OG",
    "Bank Manager",
    "Barry",
    "Beverly Felton",
    "Brucie Kibbutz",
    "Bigfoot",
    "Bogdan",
    "Brad",
    "Brad's Cadaver",
    "Bride",
    "Burger Drug Worker",
    "Car 3 Guy 1",
    "Car 3 Guy 2",
    "Car Buyer",
    "Casey",
    "Chef",
    "Chef",
    "Chinese Goon",
    "Clay Simons (The Lost)",
    "Cletus",
    "Cop",
    "Cris Formage",
    "Customer",
    "Dale",
    "Dave Norton",
    "Debra",
    "Denise",
    "Denise's Friend",
    "Devin",
    "Dima Popov",
    "Dom Beasley",
    "Dr. Friedlander",
    "Epsilon Tom",
    "Fabien",
    "Families Gang Member?",
    "Ferdinand Kerimov (Mr. K)",
    "FIB Suit",
    "Floyd Hebert",
    "FOS Rep?",
    "Gustavo",
    "Gerald",
    "Groom",
    "Grove Street Dealer",
    "Guadalope",
    "GURK?",
    "Hao",
    "Hick",
    "Hipster",
    "Helmsman Pavel",
    "Hugh Welsh",
    "Hunter",
    "Island Dj",
    "Island Dj 1",
    "Island Dj 2",
    "Island Dj 3",
    "Island Dj 4",
    "Imran Shinowa",
    "Jack Howitzer",
    "Janet",
    "Janitor",
    "Jeweller Assistant",
    "Jimmy Boston",
    "Jimmy De Santa",
    "Jio",
    "Johnny Klebitz",
    "Josef",
    "Josh",
    "Juan Strickler",
    "Karen Daniels",
    "Lamar Davis",
    "Lazlow",
    "Lester Crest",
    "Life Invader",
    "Magenta",
    "Manuel",
    "Marine",
    "Marnie Allen",
    "Martin Madrazo",
    "Mary-Ann Quinn",
    "Maude",
    "Maxim Rashkovsky",
    "Merryweather Merc",
    "Mexican",
    "Michelle",
    "Miguel Madrazo",
    "Milton McIlroy",
    "Mjo",
    "Minuteman Joe",
    "Molly",
    "Money Man",
    "Movie Premiere Female",
    "Movie Premiere Male",
    "Mrs. Phillips",
    "Mrs. Rackman",
    "Mrs. Thornhill",
    "Natalia",
    "Nervous Ron",
    "Nigel",
    "Old Man 1",
    "Old Man 2",
    "Omega",
    "Ortega",
    "Oscar",
    "Paige Harris",
    "Patricia",
    "Patricia 2",
    "Peter Dreyfuss",
    "Porn Dude",
    "Priest",
    "Prologue Driver",
    "Prologue Security",
    "Prologue Security 2",
    "Reporter",
    "Rocco Pelosi",
    "Russian Drunk",
    "Screenwriter",
    "Simeon Yetarian",
    "Solomon Richards",
    "Sss",
    "Steve Haines",
    "Stretch",
    "Stripper",
    "Stripper 2",
    "Tanisha",
    "Tao Cheng",
    "Tao Cheng (Casino)",
    "Tao's Translator",
    "Tao's Translator (Casino)",
    "Tennis Coach",
    "Terry",
    "Tom",
    "Tom Connors",
    "Tonya",
    "Thornton Duggan",
    "Tracey De Santa",
    "Traffic Warden",
    "Undercover Cop",
    "United Paper Man",
    "Vagos Speak",
    "Vincent (Casino)",
    "Wade",
    "Wei Cheng",
    "Zimbor",
    "DJ Black Madonna",
    "Dixon",
    "English Dave",
    "English Dave 2",
    "Lazlow 2",
    "Soloman",
    "Tale of Us 1",
    "Tale of Us 2",
    "Tony Prince",
    "Alan Jerome",
    "Bryony",
    "Celeb 1",
    "Georgina Cheng",
    "Huang",
    "Vincent (Casino) 2",
    "Wendy",
    "Jimmy De Santa 2",
    "Lester Crest 3"
}

Gangfemalename = {
    "Ballas Female",
    "Families Female",
    "Import Export Female",
    "The Lost MC Female",
    "Vagos Female"
}
Gangfemalecode = {
    "g_f_y_ballas_01",
    "g_f_y_families_01",
    "g_f_importexport_01",
    "g_f_y_lost_01",
    "g_f_y_vagos_01"
}

Gangmalename = {
    "Gang Female (Import-Export)",
    "Gang Male (Import-Export)",
    "Armenian Boss",
    "Armenian Goon",
    "Armenian Goon 2",
    "Armenian Lieutenant",
    "Azteca",
    "Ballas East Male",
    "Ballas Original Male",
    "Ballas South Male",
    "Cartel Guard",
    "Cartel Guard 2",
    "Casino Guests?",
    "Chemical Plant Worker",
    "Chinese Boss",
    "Chinese Goon",
    "Chinese Goon 2",
    "Chinese Goon Older",
    "Families CA Male",
    "Families DNF Male",
    "Families FOR Male",
    "Korean Boss",
    "Korean Lieutenant",
    "Korean Young Male",
    "Korean Young Male 2",
    "Mexican Boss",
    "Mexican Boss 2",
    "Mexican Gang Member",
    "Mexican Goon",
    "Mexican Goon 2",
    "Mexican Goon 3",
    "Polynesian Goon",
    "Polynesian Goon 2",
    "Salvadoran Boss",
    "Salvadoran Goon",
    "Salvadoran Goon 2",
    "Salvadoran Goon 3",
    "Street Punk",
    "Street Punk 2",
    "The Lost MC Male",
    "The Lost MC Male 2",
    "The Lost MC Male 3"
}
Gangmalecode = {
    "g_f_importexport_01",
    "g_m_importexport_01",
    "g_m_m_armboss_01",
    "g_m_m_armgoon_01",
    "g_m_y_armgoon_02",
    "g_m_m_armlieut_01",
    "g_m_y_azteca_01",
    "g_m_y_ballaeast_01",
    "g_m_y_ballaorig_01",
    "g_m_y_ballasout_01",
    "g_m_m_cartelguards_01",
    "g_m_m_cartelguards_02",
    "g_m_m_casrn_01",
    "g_m_m_chemwork_01",
    "g_m_m_chiboss_01",
    "g_m_m_chigoon_01",
    "g_m_m_chigoon_02",
    "g_m_m_chicold_01",
    "g_m_y_famca_01",
    "g_m_y_famdnf_01",
    "g_m_y_famfor_01",
    "g_m_m_korboss_01",
    "g_m_y_korlieut_01",
    "g_m_y_korean_01",
    "g_m_y_korean_02",
    "g_m_m_mexboss_01",
    "g_m_m_mexboss_02",
    "g_m_y_mexgang_01",
    "g_m_y_mexgoon_01",
    "g_m_y_mexgoon_02",
    "g_m_y_mexgoon_03",
    "g_m_y_pologoon_01",
    "g_m_y_pologoon_02",
    "g_m_y_salvaboss_01",
    "g_m_y_salvagoon_01",
    "g_m_y_salvagoon_02",
    "g_m_y_salvagoon_03",
    "g_m_y_strpunk_01",
    "g_m_y_strpunk_02",
    "g_m_y_lost_01",
    "g_m_y_lost_02",
    "g_m_y_lost_03"
}

Spname = {
    "Michael",
    "Franklin",
    "Trevor",
    "Abigail Mathers",
    "Agent",
    "Agatha Baker",
    "Ary",
    "Avery Duggan",
    "Agent 14",
    "Amanda De Santa",
    "Andreas Sanchez",
    "Ashley Butler",
    "Avon Hertz",
    "Ballas OG",
    "Benny",
    "Bank Manager",
    "Barry",
    "Best Man",
    "Beverly Felton",
    "Brucie Kibbutz",
    "Bigfoot",
    "Brad",
    "Bride",
    "Car 3 Guy 1",
    "Car 3 Guy 2",
    "Casey",
    "Chef",
    "Chef",
    "Clay Jackson (The Pain Giver)",
    "Clay Simons (The Lost)",
    "Cletus",
    "Cris Formage",
    "Dale",
    "Dave Norton",
    "Denise",
    "Devin",
    "Dima Popov",
    "Dom Beasley",
    "Dr. Friedlander",
    "Epsilon Tom",
    "Fabien",
    "Families Gang Member?",
    "Ferdinand Kerimov (Mr. K)",
    "FIB Suit",
    "Floyd Hebert",
    "Gerald",
    "Groom",
    "Gustavo",
    "Hao",
    "Hick",
    "Hipster",
    "Helmsman Pavel",
    "Hunter",
    "Island Dj",
    "Island Dj 1",
    "Island Dj 2",
    "Island Dj 3",
    "Island Dj 4",
    "Island Dj 4D",
    "Island Dj 4D2",
    "Island Dj 4E",
    "Jackie",
    "Janet",
    "Jay Norris",
    "Jeweller Assistant",
    "Jimmy Boston",
    "Jimmy De Santa",
    "Jio",
    "Johnny Klebitz",
    "Josef",
    "Josh",
    "Juan Strickler",
    "Kaylee",
    "Karen Daniels",
    "Kerry McIntosh",
    "Lamar Davis",
    "Lazlow",
    "Lester Crest",
    "Lester Crest (Doomsday Heist)",
    "Life Invader",
    "Life Invader 2",
    "Magenta",
    "Manuel",
    "Marnie Allen",
    "Mary-Ann Quinn",
    "Maude",
    "Maxim Rashkovsky",
    "Mexican",
    "Michelle",
    "Miguel Madrazo",
    "Milton McIlroy",
    "Minuteman Joe",
    "Malc",
    "Molly",
    "Money Man",
    "Mrs. Phillips",
    "Mrs. Thornhill",
    "Mjo",
    "Natalia",
    "Nervous Ron",
    "Nigel",
    "Old Man 1",
    "Old Man 2",
    "Omega",
    "Old Rich Guy",
    "O'Neil Brothers",
    "Ortega",
    "Paige Harris",
    "Patricia",
    "Patricia 2",
    "Pilot",
    "Peter Dreyfuss",
    "Priest",
    "Prologue Security 2",
    "Rocco Pelosi",
    "Russian Drunk",
    "Screenwriter",
    "Simeon Yetarian",
    "Solomon Richards",
    "Sss",
    "Steve Haines",
    "Stretch",
    "Talina",
    "Tanisha",
    "Tao Cheng",
    "Tao Cheng (Casino)",
    "Tao's Translator",
    "Tao's Translator (Casino)",
    "Tennis Coach",
    "Terry",
    "Tonya",
    "Tracey De Santa",
    "Traffic Warden",
    "Tyler Dixon",
    "United Paper Man",
    "Vagos Funeral Speaker",
    "Wade",
    "Wei Cheng",
    "Zimbor",
    "DJ Black Madonna",
    "DJ Ryan S",
    "DJ Rupert",
    "DJ Dixon Manager",
    "DJ Fotios",
    "DJ Jakob",
    "DJ Mike T",
    "DJ Rob T",
    " DJ Aurelia",
    "DJ Ignazio",
    "Dixon",
    "English Dave",
    "English Dave",
    "Generic DJ",
    "Jimmy Boston 2",
    "Kerry McIntosh 2",
    "Lacy Jones 2",
    "Lazlow 2",
    "Soloman",
    "Soloman Manager",
    "Tale of Us 1",
    "Tale of Us 2",
    "Tyler Dixon 2",
    "Tony Prince",
    "Sacha Yetarian",
    "Thornton Duggan",
    "Tom Connors",
    "Vincent (Casino)",
    "Celeb 1",
    "Georgina Cheng",
    "Huang",
    "Jimmy De Santa 2",
    "Lester Crest 3",
    "Vincent (Casino) 2",
    "Wendy"
}
Spcode = {
    "player_zero",
    "player_one",
    "player_two",
    "ig_abigail",
    "ig_agent",
    "ig_agatha",
    "ig_ary",
    "ig_avery",
    "ig_mp_agent14",
    "ig_amandatownley",
    "ig_andreas",
    "ig_ashley",
    "ig_avon",
    "ig_ballasog",
    "ig_benny",
    "ig_bankman",
    "ig_barry",
    "ig_bestmen",
    "ig_beverly",
    "ig_brucie2",
    "ig_orleans",
    "ig_brad",
    "ig_bride",
    "ig_car3guy1",
    "ig_car3guy2",
    "ig_casey",
    "ig_chef",
    "ig_chef2",
    "ig_claypain",
    "ig_clay",
    "ig_cletus",
    "ig_chrisformage",
    "ig_dale",
    "ig_davenorton",
    "ig_denise",
    "ig_devin",
    "ig_popov",
    "ig_dom",
    "ig_drfriedlander",
    "ig_tomepsilon",
    "ig_fabien",
    "ig_ramp_gang",
    "ig_mrk",
    "ig_fbisuit_01",
    "ig_floyd",
    "ig_g",
    "ig_groom",
    "ig_gustavo",
    "ig_hao",
    "ig_ramp_hic",
    "ig_ramp_hipster",
    "ig_helmsmanpavel",
    "ig_hunter",
    "ig_isldj_00",
    "ig_isldj_01",
    "ig_isldj_02",
    "ig_isldj_03",
    "ig_isldj_04",
    "ig_isldj_04_D_01",
    "ig_isldj_04_D_02",
    "ig_isldj_04_E_01",
    "ig_jackie",
    "ig_janet",
    "ig_jay_norris",
    "ig_jewelass",
    "ig_jimmyboston",
    "ig_jimmydisanto",
    "ig_jio",
    "ig_johnnyklebitz",
    "ig_josef",
    "ig_josh",
    "ig_juanstrickler",
    "ig_kaylee",
    "ig_karen_daniels",
    "ig_kerrymcintosh",
    "ig_lamardavis",
    "ig_lazlow",
    "ig_lestercrest",
    "ig_lestercrest_2",
    "ig_lifeinvad_01",
    "ig_lifeinvad_02",
    "ig_magenta",
    "ig_manuel",
    "ig_marnie",
    "ig_maryann",
    "ig_maude",
    "ig_rashcosvki",
    "ig_ramp_mex",
    "ig_michelle",
    "ig_miguelmadrazo",
    "ig_milton",
    "ig_joeminuteman",
    "ig_malc",
    "ig_molly",
    "ig_money",
    "ig_mrsphillips",
    "ig_mrs_thornhill",
    "ig_mjo",
    "ig_natalia",
    "ig_nervousron",
    "ig_nigel",
    "ig_old_man1a",
    "ig_old_man2",
    "ig_omega",
    "ig_oldrichguy",
    "ig_oneil",
    "ig_ortega",
    "ig_paige",
    "ig_patricia",
    "ig_patricia_02",
    "ig_pilot",
    "ig_dreyfuss",
    "ig_priest",
    "ig_prolsec_02",
    "ig_roccopelosi",
    "ig_russiandrunk",
    "ig_screen_writer",
    "ig_siemonyetarian",
    "ig_solomon",
    "ig_sss",
    "ig_stevehains",
    "ig_stretch",
    "ig_talina",
    "ig_tanisha",
    "ig_taocheng",
    "ig_taocheng2",
    "ig_taostranslator",
    "ig_taostranslator2",
    "ig_tenniscoach",
    "ig_terry",
    "ig_tonya",
    "ig_tracydisanto",
    "ig_trafficwarden",
    "ig_tylerdix",
    "ig_paper",
    "ig_vagspeak",
    "ig_wade",
    "ig_chengsr",
    "ig_zimbor",
    "ig_djblamadon",
    "ig_djblamryans",
    "ig_djblamrupert",
    "ig_djdixmanager",
    "ig_djsolfotios",
    "ig_djsoljakob",
    "ig_djsolmike",
    "ig_djsolrobt",
    "ig_djtalaurelia",
    "ig_djtalignazio",
    "ig_dix",
    "ig_englishdave",
    "ig_englishdave_02",
    "ig_djgeneric_01",
    "ig_jimmyboston_02",
    "ig_kerrymcintosh_02",
    "ig_lacey_jones_02",
    "ig_lazlow_2",
    "ig_sol",
    "ig_djsolmanager",
    "ig_talcc",
    "ig_talmm",
    "ig_tylerdix_02",
    "ig_tonyprince",
    "ig_sacha",
    "ig_thornton",
    "ig_tomcasino",
    "ig_vincent",
    "ig_celeb_01",
    "ig_georginacheng",
    "ig_huang",
    "ig_jimmydisanto2",
    "ig_lestercrest_3",
    "ig_vincent_2",
    "ig_wendy"
}

Mpname = {
    "Armoured Van Security Male",
    "Avon Goon",
    "Biker Cocaine Female",
    "Biker Cocaine Male",
    "Biker Counterfeit Female",
    "Biker Counterfeit Male",
    "Biker Forgery Female",
    "Biker Forgery Male",
    "Biker Meth Female",
    "Biker Meth Male",
    "Biker Weed Female",
    "Biker Weed Male",
    "Boat-Staff Female",
    "Boat-Staff Male",
    "Bogdan Goon",
    "Clubhouse Bar Female",
    "Claude Speed",
    "Dead Hooker",
    "Ex-Army Male",
    "Executive PA Female",
    "Executive PA Female 2",
    "Executive PA Male",
    "Families DD Male",
    "FIB Security",
    "Freemode Female",
    "Freemode Male",
    "Heli-Staff Female",
    "John Marston",
    "Misty",
    "Niko Bellic",
    "Office Garage Mechanic (Female)",
    "Pros",
    "Securoserve Guard (Male)",
    "Shopkeeper (Male)",
    "Stripper Lite (Female)",
    "Vagos Funeral",
    "Warehouse Mechanic (Male)",
    "Weapon Exp (Male)",
    "Weapon Work (Male)",
    "Benny Mechanic (Female)"
}
Mpcode = {
    "mp_s_m_armoured_01",
    "mp_m_avongoon",
    "mp_f_cocaine_01",
    "mp_m_cocaine_01",
    "mp_f_counterfeit_01",
    "mp_m_counterfeit_01",
    "mp_f_forgery_01",
    "mp_m_forgery_01",
    "mp_f_meth_01",
    "mp_m_meth_01",
    "mp_f_weed_01",
    "mp_m_weed_01",
    "mp_f_boatstaff_01",
    "mp_m_boatstaff_01",
    "mp_m_bogdangoon",
    "mp_f_chbar_01",
    "mp_m_claude_01",
    "mp_f_deadhooker",
    "mp_m_exarmy_01",
    "mp_f_execpa_01",
    "mp_f_execpa_02",
    "mp_m_execpa_01",
    "mp_m_famdd_01",
    "mp_m_fibsec_01",
    "mp_f_freemode_01",
    "mp_m_freemode_01",
    "mp_f_helistaff_01",
    "mp_m_marston_01",
    "mp_f_misty_01",
    "mp_m_niko_01",
    "mp_f_cardesign_01",
    "mp_g_m_pros_01",
    "mp_m_securoguard_01",
    "mp_m_shopkeep_01",
    "mp_f_stripperlite",
    "mp_m_g_vagfun_01",
    "mp_m_waremech_01",
    "mp_m_weapexp_01",
    "mp_m_weapwork_01",
    "mp_f_bennymech_01"
}

Scenefemalename = {
    "Air Hostess",
    "Barber Female",
    "Bartender",
    "Baywatch Female",
    "Beach Bar Staff",
    "Casino Staff",
    "Cop Female",
    "Factory Worker Female",
    "Hooker",
    "Hooker 2",
    "Hooker 3",
    "Hospital Scrubs Female",
    "Maid",
    "Migrant Female",
    "Movie Premiere Female",
    "Ranger Female",
    "Sales Assistant (High-End)",
    "Sales Assistant (Low-End)",
    "Sales Assistant (Mid-Price)",
    "Sheriff Female",
    "Stripper",
    "Stripper 2",
    "Stripper Lite",
    "Sweatshop Worker",
    "Sweatshop Worker Young",
    "Club Bartender Female",
    "Club Bartender Female 2"
}
Scenefemalecode = {
    "s_f_y_airhostess_01",
    "s_f_m_fembarber",
    "s_f_y_bartender_01",
    "s_f_y_baywatch_01",
    "s_f_y_beachbarstaff_01",
    "s_f_y_casino_01",
    "s_f_y_cop_01",
    "s_f_y_factory_01",
    "s_f_y_hooker_01",
    "s_f_y_hooker_02",
    "s_f_y_hooker_03",
    "s_f_y_scrubs_01",
    "s_f_m_maid_01",
    "s_f_y_migrant_01",
    "s_f_y_movprem_01",
    "s_f_y_ranger_01",
    "s_f_m_shop_high",
    "s_f_y_shop_low",
    "s_f_y_shop_mid",
    "s_f_y_sheriff_01",
    "s_f_y_stripper_01",
    "s_f_y_stripper_02",
    "s_f_y_stripperlite",
    "s_f_m_sweatshop_01",
    "s_f_y_sweatshop_01",
    "s_f_y_clubbar_01",
    "s_f_y_clubbar_02"
}

Scenemalename = {
    "Air Worker Male",
    "Alien",
    "Ammu-Nation City Clerk",
    "Ammu-Nation Rural Clerk",
    "Armoured Van Security",
    "Armoured Van Security 2",
    "Army Mechanic",
    "Autopsy Tech",
    "Autoshop Worker",
    "Autoshop Worker 2",
    "Barman",
    "Bartender (Rural)",
    "Baywatch Male",
    "Black Ops Soldier",
    "Black Ops Soldier 2",
    "Black Ops Soldier 3",
    "Bouncer",
    "Bouncer 2",
    "Busboy",
    "Busker",
    "Casino Staff",
    "Chef",
    "Chemical Plant Security",
    "Clown",
    "construction Worker",
    "construction Worker 2",
    "Cop Male",
    "Crew Member",
    "Dealer",
    "Devin's Security",
    "Dock Worker",
    "Dock Worker",
    "Doctor",
    "Doorman",
    "Drug Processer",
    "DW Airport Worker",
    "DW Airport Worker 2",
    "Factory Worker Male",
    "FIB Office Worker",
    "FIB Office Worker 2",
    "FIB Security",
    "Field Worker",
    "Fireman Male",
    "Gaffer",
    "Garbage Worker",
    "Gardener",
    "Grip",
    "Hairdresser Male",
    "High Security",
    "High Security 2",
    "High Security 4",
    "Highway Cop",
    "IAA Security",
    "Janitor",
    "Latino Handyman Male",
    "Life Invader Male",
    "Line Cook",
    "LS Metro Worker Male",
    "Mariachi",
    "Marine",
    "Marine 2",
    "Marine Young",
    "Marine Young 2",
    "Marine Young 3",
    "Mechanic",
    "MC Clubhouse Mechanic",
    "Migrant Male",
    "Mime Artist",
    "Movie Astronaut",
    "Movie Premiere Male",
    "Paramedic",
    "Pest Control",
    "Pilot",
    "Pilot",
    "Pilot 2",
    "Postal Worker Male",
    "Postal Worker Male 2",
    "Prison Guard",
    "Prisoner",
    "Prisoner (Muscular)",
    "Ranger Male",
    "Robber",
    "Mask Salesman",
    "Scientist",
    "Security Guard",
    "Sheriff Male",
    "Snow Cop Male",
    "Street Performer",
    "Street Preacher",
    "Street Vendor",
    "Street Vendor Young",
    "SWAT",
    "Transport Worker Male",
    "Trucker Male",
    "UPS Driver",
    "UPS Driver 2",
    "US Coastguard",
    "Valet",
    "Waiter",
    "Duggan Secruity",
    "Window Cleaner",
    "Club Bartender Male",
    "Warehouse Technician",
    "High Security 3",
    "Duggan Security 2"
}
Scenemalecode = {
    "s_m_y_airworker",
    "s_m_m_movalien_01",
    "s_m_y_ammucity_01",
    "s_m_m_ammucountry",
    "s_m_m_armoured_01",
    "s_m_m_armoured_02",
    "s_m_y_armymech_01",
    "s_m_y_autopsy_01",
    "s_m_m_autoshop_01",
    "s_m_m_autoshop_02",
    "s_m_y_barman_01",
    "s_m_m_cntrybar_01",
    "s_m_y_baywatch_01",
    "s_m_y_blackops_01",
    "s_m_y_blackops_02",
    "s_m_y_blackops_03",
    "s_m_m_bouncer_01",
    "s_m_m_bouncer_02",
    "s_m_y_busboy_01",
    "s_m_o_busker_01",
    "s_m_y_casino_01",
    "s_m_y_chef_01",
    "s_m_m_chemsec_01",
    "s_m_y_clown_01",
    "s_m_y_construct_01",
    "s_m_y_construct_02",
    "s_m_y_cop_01",
    "s_m_m_ccrew_01",
    "s_m_y_dealer_01",
    "s_m_y_devinsec_01",
    "s_m_m_dockwork_01",
    "s_m_y_dockwork_01",
    "s_m_m_doctor_01",
    "s_m_y_doorman_01",
    "s_m_m_drugprocess_01",
    "s_m_y_dwservice_01",
    "s_m_y_dwservice_02",
    "s_m_y_factory_01",
    "s_m_m_fiboffice_01",
    "s_m_m_fiboffice_02",
    "s_m_m_fibsec_01",
    "s_m_m_fieldworker_01",
    "s_m_y_fireman_01",
    "s_m_m_gaffer_01",
    "s_m_y_garbage",
    "s_m_m_gardener_01",
    "s_m_y_grip_01",
    "s_m_m_hairdress_01",
    "s_m_m_highsec_01",
    "s_m_m_highsec_02",
    "s_m_m_highsec_04",
    "s_m_y_hwaycop_01",
    "s_m_m_ciasec_01",
    "s_m_m_janitor",
    "s_m_m_lathandy_01",
    "s_m_m_lifeinvad_01",
    "s_m_m_linecook",
    "s_m_m_lsmetro_01",
    "s_m_m_mariachi_01",
    "s_m_m_marine_01",
    "s_m_m_marine_02",
    "s_m_y_marine_01",
    "s_m_y_marine_02",
    "s_m_y_marine_03",
    "s_m_y_xmech_01",
    "s_m_y_xmech_02",
    "s_m_m_migrant_01",
    "s_m_y_mime",
    "s_m_m_movspace_01",
    "s_m_m_movprem_01",
    "s_m_m_paramedic_01",
    "s_m_y_pestcont_01",
    "s_m_m_pilot_01",
    "s_m_y_pilot_01",
    "s_m_m_pilot_02",
    "s_m_m_postal_01",
    "s_m_m_postal_02",
    "s_m_m_prisguard_01",
    "s_m_y_prisoner_01",
    "s_m_y_prismuscl_01",
    "s_m_y_ranger_01",
    "s_m_y_robber_01",
    "s_m_y_shop_mask",
    "s_m_m_scientist_01",
    "s_m_m_security_01",
    "s_m_y_sheriff_01",
    "s_m_m_snowcop_01",
    "s_m_m_strperf_01",
    "s_m_m_strpreach_01",
    "s_m_m_strvend_01",
    "s_m_y_strvend_01",
    "s_m_y_swat_01",
    "s_m_m_gentransport",
    "s_m_m_trucker_01",
    "s_m_m_ups_01",
    "s_m_m_ups_02",
    "s_m_y_uscg_01",
    "s_m_y_valet_01",
    "s_m_y_waiter_01",
    "s_m_y_westsec_01",
    "s_m_y_winclean_01",
    "s_m_y_clubbar_01",
    "s_m_y_waretech_01",
    "s_m_m_highsec_03",
    "s_m_y_westsec_02"
}

spScenefemalename = {
    "Biker Chic Female",
    "Corpse Female",
    "Casino Cashier",
    "Casino shop owner",
    "Debbie (Agatha??s Secretary)",
    "Carol",
    "Eileen",
    "Beth",
    "Lauren",
    "Taylor",
    "Corpse Young Female",
    "Corpse Young Female 2",
    "Hot Posh Female",
    "Jane",
    "Jeweller Assistant",
    "Miranda",
    "Mistress",
    "Movie Star Female",
    "Poppy Mitchell",
    "Princess",
    "Prologue Host Old Female",
    "Prologue Mourner Female",
    "Spy Actress",
    "Miranda 2",
    "Poppy Mitchell 2",
    "Female Club Dancer (Burlesque)",
    "Female Club Dancer (Leather)",
    "Female Club Dancer (Rave)"
}
spScenefemalecode = {
    "u_f_y_bikerchic",
    "u_f_m_corpse_01",
    "u_f_m_casinocash_01",
    "u_f_m_casinoshop_01",
    "u_f_m_debbie_01",
    "u_f_o_carol",
    "u_f_o_eileen",
    "u_f_y_beth",
    "u_f_y_lauren",
    "u_f_y_taylor",
    "u_f_y_corpse_01",
    "u_f_y_corpse_02",
    "u_f_y_hotposh_01",
    "u_f_y_comjane",
    "u_f_y_jewelass_01",
    "u_f_m_miranda",
    "u_f_y_mistress",
    "u_f_o_moviestar",
    "u_f_y_poppymich",
    "u_f_y_princess",
    "u_f_o_prolhost_01",
    "u_f_m_promourn_01",
    "u_f_y_spyactress",
    "u_f_m_miranda_02",
    "u_f_y_poppymich_02",
    "u_f_y_danceburl_01",
    "u_f_y_dancelthr_01",
    "u_f_y_dancerave_01"
}

spScenemalename = {
    "Abner",
    "Al Di Napoli Male",
    "Anton Beaudelaire",
    "Avon Juggernaut",
    "Baby D",
    "Bank Manager Male",
    "Bike Hire Guy",
    "Blane",
    "Curtis",
    "Vince",
    "Dean",
    "Caleb",
    "Casino Thief",
    "Gabriel",
    "Ushi",
    "Burger Drug Worker",
    "Chip",
    "Cyclist Male",
    "Dead Courier",
    "DOA Man",
    "Ed Toh",
    "Ex-Mil Bum",
    "FIB Architect",
    "FIB Mugger",
    "Financial Guru",
    "Glen-Stank Male",
    "Griff",
    "Guido",
    "Gun Vendor",
    "Hangar Mechanic",
    "Hippie Male",
    "Street Art Male",
    "Impotent Rage",
    "Jesco White (Tapdancing Hillbilly)",
    "Jesus",
    "Jewel Thief",
    "Jeweller Security",
    "Justin",
    "Kifflom Guy",
    "Love Fist Willy",
    "Mani",
    "Mark Fostenburg",
    "Movie Director",
    "Movie Corpse (Suited)",
    "Paparazzi Young Male",
    "Party Target",
    "Partygoer",
    "Pogo the Monkey",
    "Prisoner",
    "Prologue Driver",
    "Prologue Mourner Male",
    "Prologue Security",
    "Republican Space Ranger",
    "Rival Paparazzo",
    "Sports Biker",
    "Spy Actor",
    "Stag Party Groom",
    "Tattoo Artist",
    "Tramp Old Male",
    "Zombie",
    "Male Club Dancer (Burlesque)",
    "Male Club Dancer (Leather)",
    "Male Club Dancer (Rave)"
}
spScenemalecode = {
    "u_m_y_abner",
    "u_m_m_aldinapoli",
    "u_m_y_antonb",
    "u_m_y_juggernaut_01",
    "u_m_y_babyd",
    "u_m_m_bankman",
    "u_m_m_bikehire_01",
    "u_m_m_blane",
    "u_m_m_curtis",
    "u_m_m_vince",
    "u_m_o_dean",
    "u_m_y_caleb",
    "u_m_y_croupthief_01",
    "u_m_y_gabriel",
    "u_m_y_ushi",
    "u_m_y_burgerdrug_01",
    "u_m_y_chip",
    "u_m_y_cyclist_01",
    "u_m_y_corpse_01",
    "u_m_m_doa_01",
    "u_m_m_edtoh",
    "u_m_y_militarybum",
    "u_m_m_fibarchitect",
    "u_m_y_fibmugger_01",
    "u_m_o_finguru_01",
    "u_m_m_glenstank_01",
    "u_m_m_griff_01",
    "u_m_y_guido_01",
    "u_m_y_gunvend_01",
    "u_m_y_smugmech_01",
    "u_m_y_hippie_01",
    "u_m_m_streetart_01",
    "u_m_y_imporage",
    "u_m_o_taphillbilly",
    "u_m_m_jesus_01",
    "u_m_m_jewelthief",
    "u_m_m_jewelsec_01",
    "u_m_y_justin",
    "u_m_y_baygor",
    "u_m_m_willyfist",
    "u_m_y_mani",
    "u_m_m_markfost",
    "u_m_m_filmdirector",
    "u_m_o_filmnoir",
    "u_m_y_paparazzi",
    "u_m_m_partytarget",
    "u_m_y_party_01",
    "u_m_y_pogo_01",
    "u_m_y_prisoner_01",
    "u_m_y_proldriver_01",
    "u_m_m_promourn_01",
    "u_m_m_prolsec_01",
    "u_m_y_rsranger_01",
    "u_m_m_rivalpap",
    "u_m_y_sbike",
    "u_m_m_spyactor",
    "u_m_y_staggrm_01",
    "u_m_y_tattoo_01",
    "u_m_o_tramp_01",
    "u_m_y_zombie_01",
    "u_m_y_danceburl_01",
    "u_m_y_dancelthr_01",
    "u_m_y_dancerave_01"
}
qingxinzhou = {
    "       《清心咒》         ",
    "心若冰清，天塌不惊。",
    "万变犹定，神怡气静。",
    "尘垢不沾，俗相不染。",
    "虚空甯宓，混然无物。",
    "无有相生，难易相成。",
    "份与物忘，同乎浑涅。",
    "天地无涯，万物齐一。",
    "飞花落叶，虚怀若谷。",
    "千般烦忧，才下心头。",
    "即展眉头，灵台清悠。",
    "心无罣碍，意无所执。",
    "解心释神，莫然无魂。",
    "水流心不惊，云在意俱迟。",
    "一心不赘物，古今自逍遥。",
    "清心如水，清水即心。",
    "微风无起，波澜不惊。",
    "幽篁独坐，长啸鸣琴。",
    "禅寂入定，毒龙遁形。",
    "我心无窍，天道酬勤。",
    "我义凛然，鬼魅皆惊。",
    "我情豪溢，天地归心。",
    "我志扬迈，水起风生！",
    "天高地阔，流水行云。",
    "清新治本，直道谋身。",
    "至性至善，大道天成！"
}
fojiao = {
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "本刷屏lua由HTHT编写",
    "本刷屏lua由HTHT编写",
    "本刷屏lua由HTHT编写",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "本刷屏lua由HTHT编写",
    "本刷屏lua由HTHT编写",
    "本刷屏lua由HTHT编写",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。",
    "道教八大神咒之净心神咒",
    "太上台星，应变无停。驱邪缚魅，保命护身。智慧明净，心神安宁。三魂永久，魄无丧倾。",
    "道教八大神咒之净口神咒",
    "丹朱口神，吐秽除氛。舌神正伦，通命养神。罗千齿神，却邪卫真。喉神虎贲，",
    "炁神引津。心神丹元，令我通真。思神炼液，道炁常存。",
    "道教八大神咒之净身神咒",
    "灵宝天尊，安慰身形。弟子魂魄，五脏玄冥。青龙白虎，队仗纷纭；朱雀玄武，侍卫我真。",
    "道教八大神咒之安土地神咒",
    "元始安镇，普告万灵。岳渎真官，土地祇灵。左社右稷，不得妄惊。",
    "回向正道，内外澄清。各安方位，备守坛庭。太上有命，搜捕邪精",
    "护法神王，保卫诵经。皈依大道，元亨利贞。",
    "道教八大神咒之净天地神咒",
    "天地自然，秽炁分散。洞中玄虚，晃朗太元。八方威神，使我自然。",
    "灵宝符命，普告九天；乾罗答那，洞罡太玄；斩妖缚邪，杀鬼万千。",
    "中山神咒，元始玉文，持诵一遍，却病延年；按行五岳，八海知闻；",
    "魔王束首，侍卫我轩；凶秽消散，道炁常存。",
    "道教八大神咒之金光神咒",
    "天地玄宗，万炁本根。广修亿劫，证吾神通。三界内外，惟道独尊。",
    "体有金光，覆映吾身。视之不见，听之不闻。包罗天地，养育群生。",
    "诵持万遍，身有光明。三界侍卫，五帝司迎。万神朝礼，役使雷霆。",
    "鬼妖丧胆，精怪忘形。内有霹雳，雷神隐名。",
    "洞慧交彻，五炁腾腾。金光速现，覆护真人。",
    "道教八大神咒之祝香神咒",
    "道由心学，心假香传。香爇玉炉，心存帝前。",
    "真灵下盼，仙旆临轩。令臣关告，迳达九天。",
    "道教八大神咒之玄蕴咒",
    "云篆太虚，浩劫之初。乍遐乍迩，或沉或浮。五方徘徊，一丈之余。",
    "天真皇人，按笔乃书。以演洞章，次书灵符。元始下降，真文诞敷。",
    "昭昭其有，冥冥其无。沉疴能自痊，尘劳溺可扶，幽冥将有赖。由是升仙都。"
}
apologytext = {
    "我开卦了,我承认错误",
    "I use cheat, I admit mistakes",
    "请别和我一样使用外卦",
    " Please don't use the same as me",
    "如果我的队友对您恶意中伤,我会代他向您道歉––年轻人总是口不择言",
    " If my teammates are maliciously guilty of you, I will apologize to you on his behalf – the young people are always vocal",
    "请永远珍惜亲情,友情和爱情",
    "Please cherish family, friendship and love forever",
    "与其和我斗气,不如闭目养神,或者静心品茗",
    "It’s better to keep your eyes shut, or to calm down and taste tea,",
    "RAC不会放过任何一个作弊者,本账号注定会被封禁",
    "RAC will not let go of any cheater,this account is destined to be banned",
    "如果无法忍受官匹外卦太多,各大对战平台则是您的不二之选",
    "If yocan't stand too much cheating, some platforms are your best choice",
    "请不要骂人,文明互联网,骂人不解决问题",
    "Please don't complain, civilized Internet, complaining does not solve the problem",
    "开卦可耻,可卦有罪,希望您能原谅没有忍受外卦诱 惑的我！",
    "Cheating is shameful, cheating is guilty, I hope you",
    "您是否在电脑前坐太久了呢，站立一分钟并深呼吸，放松一下身心。",
    "can forgive me who has not endured the temptation of cheating!",
    "如果您没心情继续游戏,可以使用ALT+F4卦机,并浏览一会网页",
    "If you?are not in the mood to continue the game, you can use the ALT+F4 shortcut to down and browse the web page",
    "一场游戏的输赢无关紧要,没有必要为外卦而心情烦躁。",
    "The win or loss of a game doesn't matter, there is no need to be upset for cheating.",
    "您是否在电脑前坐太久了呢,站立一分钟并呼吸,放松一下身心。",
    "Are you sitting in front of the computer for too long, stand for a minute and take a deep breath to relax your mind and body.",
    "爱与包容是当前社会的主题。",
    "Love and tolerance are the themes of the current society.",
    "您多久没有给您的家人打去一个慰问电话,对母亲说上一句:我爱你",
    "How long have you not given a call to your family and said to your mother: I love you",
    "作为卦逼,我十分羡慕你们家庭美满",
    "As acheater, I am very envious of your family's happiness,",
    "而我这样的孤儿只能开着卦听着歌,忍受其他玩家的谩骂",
    "And an orphan like me can only listen to songs and endure the shackles of other players.",
    "青春由汗水和梦想组成,偶尔也会有一点小挫折来点缀",
    "Youth is made up of sweat and dreams, and occasionally there will be a little setback to embellish.",
    "辛苦了!",
    "Working hard!",
    "放松心情,态平和,没必要为了一个孤儿卦逼生气",
    "Relax, peace of mind, no need to be angry for an orphan.",
    "人类生来平等自由",
    "Human being born with equalfreedom",
    "每一天都是新的开始,一切都不晚",
    "Every day is a new beginning, everything is not too late,",
    "互联网上,你我相逢便是有缘,祝愿您前程似锦,好事连连",
    "On the Internet, you and I will have a relationship, I wish you a bright future, good things again and again"
}
dabeizhou = {
    "南无、喝啰怛那、哆啰夜耶",
    "南无、阿唎耶，婆卢羯帝、烁钵啰耶",
    "菩提萨埵婆耶",
    "摩诃萨埵婆耶",
    "摩诃、迦卢尼迦耶",
    "唵，萨皤啰罚曳",
    "数怛那怛写",
    "南无、悉吉栗埵、伊蒙阿唎耶",
    "婆卢吉帝、室佛啰楞驮婆",
    "南无、那啰谨墀",
    "醯利摩诃、皤哆沙咩",
    "萨婆阿他、豆输朋，阿逝孕，萨婆萨哆、那摩婆萨哆，那摩婆伽，摩罚特豆",
    "怛侄他",
    "唵，阿婆卢醯",
    "卢迦帝",
    "迦罗帝",
    "夷醯唎",
    "摩诃菩提萨埵，萨婆萨婆",
    "摩啰摩啰，摩醯摩醯、唎驮孕",
    "俱卢俱卢、羯蒙",
    "度卢度卢、罚阇耶帝",
    "摩诃罚阇耶帝",
    "陀啰陀啰",
    "地唎尼",
    "室佛啰耶",
    "遮啰遮啰",
    "摩么罚摩啰",
    "穆帝隶",
    "伊醯伊醯",
    "室那室那",
    "阿啰参、佛啰舍利",
    "罚沙罚参",
    "佛啰舍耶",
    "呼嚧呼嚧摩啰",
    "呼嚧呼嚧醯利",
    "娑啰娑啰，悉唎悉唎",
    "苏嚧苏嚧",
    "菩提夜、菩提夜",
    "菩驮夜、菩驮夜",
    "弥帝唎夜",
    "那啰谨墀",
    "地利瑟尼那",
    "波夜摩那",
    "娑婆诃",
    "悉陀夜",
    "娑婆诃",
    "摩诃悉陀夜",
    "娑婆诃",
    "悉陀喻艺",
    "室皤啰耶",
    "娑婆诃",
    "那啰谨墀",
    "娑婆诃",
    "摩啰那啰",
    "娑婆诃",
    "悉啰僧、阿穆佉耶，娑婆诃",
    "娑婆摩诃、阿悉陀夜",
    "娑婆诃",
    "者吉啰、阿悉陀夜",
    "娑婆诃",
    "波陀摩、羯悉陀夜",
    "娑婆诃",
    "那啰谨墀、皤伽啰耶",
    "娑婆诃",
    "摩婆利、胜羯啰夜",
    "娑婆诃",
    "南无、喝啰怛那、哆啰夜耶，南无、阿唎耶",
    "婆嚧吉帝",
    "烁皤啰夜",
    "娑婆诃",
    "唵，悉殿都",
    "漫多啰",
    "跋陀耶，娑婆诃"
}
--Function Modules
--Rainbow Define
local rainbowr = 0
local rainbowg = 0
local rainbowb = 0
function getped(pid)
	return player.get_player_ped(pid)
end
function getveh(pid)
	return player.get_player_vehicle(pid)
end
function getcoords(pid)
	return player.get_player_coords(pid)
end
function requestmodel(hash)
    streaming.request_model(hash)
    while (not streaming.has_model_loaded(hash)) do
        CD(0)
    end
    return streaming.has_model_loaded(hash)
end
function modelchange(hash)
    requestmodel(hash)
    player.set_player_model(hash)
    streaming.set_model_as_no_longer_needed(hash)
end
function lclearobj()
	local me = player.player_id()
	local coord = getcoords(me)
	gameplay.clear_area_of_objects(coord, 10000, 0)
	gameplay.clear_area_of_objects(coord, 10000, 1)
	gameplay.clear_area_of_objects(coord, 10000, 2)
	gameplay.clear_area_of_objects(coord, 10000, 6)
	gameplay.clear_area_of_objects(coord, 10000, 16)
	gameplay.clear_area_of_objects(coord, 10000, 17)
end
function lclearveh()
	local me = player.player_id()
	local coord = getcoords(me)
	gameplay.clear_area_of_vehicles(coord, 10000, false, false, false, false, false)
end
function lclearped()
	local me = player.player_id()
	local coord = getcoords(me)
	gameplay.clear_area_of_peds(coord, 10000, true)
end
function teleport(x, y, z, heading)
    local pos = v3()
    pos.x = x
    pos.y = y
    pos.z = z
    entity.set_entity_coords_no_offset(getped(player.player_id()), pos)
    entity.set_entity_heading(getped(player.player_id()), heading)
end
function createped(type, hash, pos, dir)
	requestmodel(hash)
	while not streaming.has_model_loaded(hash) do
		CD(10)
	end
	local ped = ped.create_ped(type, hash, pos, dir, true, false)
	streaming.set_model_as_no_longer_needed(hash)
	return ped
end
function kickplayer(pid)
	if pid ~= player.player_id() then
		if network.network_is_host() then
			network.network_session_kick_player(pid)
		else
			TSE(2092565704, pid, {pid, script.get_global_i(1630816 + (1 + (pid * 597) + 508))})
			TSE(0x7CBA04C8, pid, {pid, script.get_global_i(1630816 + (1 + (pid * 597) + 508))})
		end
	end
end
function instacrash(pid)
	if pid ~= player.player_id() then
		local spawnedcount = 0
		local pos = getcoords(pid)
		pos.z = pos.z + 0.6
		ped1 = createped(26,0x2D7030F3,pos,0)
		entity.attach_entity_to_entity(ped1,getped(pid), 0, v3(0.30,0,0.0),v3(0.0,0,0.0), true, true, false, 0, true)
		entity.freeze_entity(ped1, true)
		network.request_control_of_entity(ped1)
		  while not network.has_control_of_entity(ped1) do
			CD(2000)
			spawnedcount = spawnedcount + 1
			if spawnedcount > 10 then end
		  end
		   CD(2000)
		entity.delete_entity(ped1)
		ped2 = createped(26,0x856CFB02,pos,0)
		entity.attach_entity_to_entity(ped2,getped(pid), 0, v3(0.30,0,0.0),v3(0.0,0,0.0), true, true, false, 0, true)
		entity.freeze_entity(ped2, true)
		network.request_control_of_entity(ped2)
		  while not network.has_control_of_entity(ped2) do
			CD(2000)
			spawnedcount = spawnedcount + 1
			if spawnedcount > 10 then end
		  end
		   CD(2000)
		entity.delete_entity(ped2)
	end
end
function setstatint(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = joaat(hash1)
    end
    hash0 = joaat(hash0)
    local value0, e = stats.stat_get_int(hash0, -1)
    if value0 ~= value then
        stats.stat_set_int(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_int(hash1, value, save)
        end
    end
end
function setstatbool(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = joaat(hash1)
    end
    hash0 = joaat(hash0)
    local value0, e = stats.stat_get_bool(hash0, -1)
    if value0 ~= value then
        stats.stat_set_bool(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_bool(hash1, -1)
        if value1 ~= value then
            stats.stat_set_bool(hash1, value, save)
        end
    end
end
function setstatfloat(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_float(hash0, -1)
    if value0 ~= value then
        stats.stat_set_float(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_float(hash1, -1)
        if value1 ~= value then
            stats.stat_set_float(hash1, value, save)
        end
    end
end
function getglobaloffset(pid, offset)
    return 1590908 + (1 + (pid * 874)) + 266 + offset
end
function getglobalinfoi(pid, offset)
    return script.get_global_i(getglobaloffset(pid, offset))
end
function getglobalinfof(pid, offset)
    return script.get_global_f(getglobaloffset(pid, offset))
end
NOTG("LEGIT SCRIPT已加载", "Welcome")
NOTG("交流群:706026439", "Welcome")

--Main Submenus
main = newfunc("LEGIT SCRIPT", "parent", 0)
self = newfunc("自身选项", "parent", main.id).id
online = newfunc("在线选项", "parent", main.id).id
genweapons = newfunc("武器选项", "parent", main.id).id
genvehicle = newfunc("载具选项", "parent", main.id).id
recovery = newfunc("恢复&统计", "parent", main.id).id
troll = newfunc("娱乐选项", "parent", main.id).id
protex = newfunc("防护选项", "parent", main.id).id
world = newfunc("世界选项", "parent", main.id).id
misc = newfunc("其它选项", "parent", main.id).id
settings = newfunc("脚本设置", "parent", main.id).id
plmain = newplfunc("LEGIT SCRIPT", "parent", 0)
--Script Settings
newfunc(
    "脚本通知偏好",
    "action_value_str",
    settings,
    function(feat)
        if feat.value == 0 then
            notifyset = 0
            NOTG("已切换为传统通知", "LEGIT SCRIPT")
        elseif feat.value == 1 then
            notifyset = 1
            NOTG("已切换为列表通知", "LEGIT SCRIPT")
        elseif feat.value == 2 then
            notifyset = 2
            NOTG("已选择二者", "LEGIT SCRIPT")
        end
    end
):set_str_data(
    {
        "传统",
        "列表",
        "我全都要"
    }
)
newfunc(
    "脚本输入偏好",
    "action_value_str",
    settings,
    function(feat)
        if feat.value == 0 then
            inputstyle = 0
            NOTG("已切换为2Take1风格", "LEGIT SCRIPT")
        elseif feat.value == 1 then
            inputstyle = 1
            NOTG("已切换为游戏自带风格", "LEGIT SCRIPT")
        end
    end
):set_str_data(
    {
        "2Take1风格",
        "游戏自带风格"
    }
)
local fontlist = {
	"Chalet Comprime",
	"Chalet London",
	"House",
	"Mono Space",
	"Pricedown"
}
newfunc(
    "脚本渲染字体",
    "action_value_str",
    settings,
    function(feat)
		renderfont = feat.value
		NOTG("已切换为字体为"..fontlist[feat.value+1], "LEGIT SCRIPT")
    end
):set_str_data(
	fontlist
)
renderfontset = 
    newfunc(
    "渲染字体大小",
    "action_slider",
    settings,
    function(feat)
	renderfontsize = feat.value
    end
)
renderfontset.max = 0.4
renderfontset.min = 0.2
renderfontset.mod = 0.05
renderfontset.value = 0.35
rainbowall =
    newfunc(
    "RGB脚本渲染",
    "toggle",
    settings,
    function(feat)
        if feat.on then
            notifycolor = math.random(0, 225)
            rainbowr = rainbowr + math.random(0, 5)
            rainbowg = rainbowg + math.random(0, 5)
            rainbowb = rainbowb + math.random(0, 5)
            if rainbowr > 255 then
                rainbowr = rainbowr - 255
            end
            if rainbowg > 255 then
                rainbowg = rainbowg - 255
            end
            if rainbowb > 255 then
                rainbowb = rainbowb - 255
            end
            return HANDLER_CONTINUE
        else
            notifycolor = 175
            return HANDLER_POP
        end
    end
)
newfunc(
    "脚本版本: " .. scriptver,
    "action",
    settings,
    function(feat)
    end
)

--Selfsub

--Model Changer
modelchanger = newfunc("模型切换", "parent", self).id
commonmodel = newfunc("常用模型切换", "parent", modelchanger).id
commonmodelchangerlist = {
    {"莱斯特", "2013139108"},
    {"贝克女士", "1506159504"},
    {"陈涛", "2905870170"},
    {"埃万重甲", "2431602996"},
    {"太空人", "3887273010"},
    {"外星人", "1684083350"},
    {"大脚猴(本地)", "2905870170"}
}
for i = 1, #commonmodelchangerlist do
    newfunc(
        commonmodelchangerlist[i][1],
        "action",
        commonmodel,
        function()
            modelchange(commonmodelchangerlist[i][2])
        end
    )
end
full = newfunc("所有模型", "parent", modelchanger).id
maincharacter =
    newfunc(
    "主角",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(mccode[feat.value + 1]))
    end
):set_str_data(mcname)
maincharacter =
    newfunc(
    "动物",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Animalcode[feat.value + 1]))
    end
):set_str_data(Animalname)
maincharacter =
    newfunc(
    "周围女性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Ambientfemalecode[feat.value + 1]))
    end
):set_str_data(Ambientfemalename)
maincharacter =
    newfunc(
    "周围男性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Ambientmalecode[feat.value + 1]))
    end
):set_str_data(Ambientmalename)
maincharacter =
    newfunc(
    "周围男性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Ambientmalecode[feat.value + 1]))
    end
):set_str_data(Ambientmalename)
maincharacter =
    newfunc(
    "过场动画",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Cutscenecode[feat.value + 1]))
    end
):set_str_data(Cutscenename)
maincharacter =
    newfunc(
    "帮派女性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Gangfemalecode[feat.value + 1]))
    end
):set_str_data(Gangfemalename)
maincharacter =
    newfunc(
    "帮派男性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Gangmalecode[feat.value + 1]))
    end
):set_str_data(Gangmalename)
maincharacter =
    newfunc(
    "故事模式",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Spcode[feat.value + 1]))
    end
):set_str_data(Spname)
maincharacter =
    newfunc(
    "在线模式",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Mpcode[feat.value + 1]))
    end
):set_str_data(Mpname)
maincharacter =
    newfunc(
    "情景动画女性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Scenefemalecode[feat.value + 1]))
    end
):set_str_data(Scenefemalename)
maincharacter =
    newfunc(
    "情景动画男性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(Scenemalecode[feat.value + 1]))
    end
):set_str_data(Scenemalename)
maincharacter =
    newfunc(
    "故事情景女性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(spScenefemalecode[feat.value + 1]))
    end
):set_str_data(spScenefemalename)
maincharacter =
    newfunc(
    "故事情景男性",
    "action_value_str",
    full,
    function(feat)
        modelchange(joaat(spScenemalecode[feat.value + 1]))
    end
):set_str_data(spScenemalename)
newfunc(
    "修复无限加载屏幕",
    "action",
    modelchanger,
    function()
        modelchange(joaat("player_one"))
    end
)
newfunc(
    "输入自定义模型",
    "action",
    modelchanger,
    function()
        local modelname = getinput("输入NPC代码", "player_one", 32, 0)
        if streaming.is_model_a_ped(joaat(modelname)) then
            modelchange(joaat(modelname))
        else
            logg("[ERROR] Model Invalid!")
            NOTG("无效人物模型", "错误")
        end
    end
)

--Scenario
scenerioanim = newfunc("情景动作", "parent", self).id
newfunc(
    "立即停止情景动作",
    "action",
    scenerioanim,
    function()
        cleartask(getped(player.player_id()))
    end
)
for i = 1, #sceneriolist do
    newfunc(
        sceneriolist[i][2],
        "action",
        scenerioanim,
        function()
            ai.task_start_scenario_at_position(getped(player.player_id()), sceneriolist[i][1], getcoords(player.player_id()), 1, 1000000, false, false)
        end
    )
end

--Closet
closet = newfunc("衣柜选项", "parent", self).id
--Preset
newfunc(
    "随机服饰",
    "action",
    closet,
    function()
		ped.set_ped_random_component_variation(getped(player.player_id()))
		for i = 0,9 do
			local index = math.random(0,ped.get_ped_prop_index(getped(player.player_id()),i))
			local texture = math.random(0,ped.get_ped_prop_texture_index(getped(player.player_id()),index))
			ped.set_ped_prop_index(getped(player.player_id()), i, index, texture, 0)
		end
    end
)
newfunc(
    "恢复默认套装",
    "action",
    closet,
    function()
		ped.set_ped_default_component_variation(getped(player.player_id()))
		ped.clear_all_ped_props(getped(player.player_id()))
    end
)
newfunc(
    "乳贴",
    "action",
    closet,
    function()
        if player.get_player_model(player.player_id()) ~= 2627665880 then
            modelchange(joaat("mp_f_freemode_01"))
        end
        ped.set_ped_component_variation(getped(player.player_id()), 0, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 1, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 11, 260, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 2, 42, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 3, 15, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 4, 15, 10, 10)
        ped.set_ped_component_variation(getped(player.player_id()), 6, 81, 1, 1)
        ped.set_ped_component_variation(getped(player.player_id()), 7, 29, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 8, 3, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 5, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 10, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 9, 0, 0, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 0, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 1, 24, 9, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 2, 6, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 3, -1, 0, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 4, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 5, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 6, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 7, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 8, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 9, -1, -1, 0)
    end
)
newfunc(
    "犀牛套",
    "action",
    closet,
    function()
        if player.get_player_model(player.player_id()) ~= 2627665880 then
            modelchange(joaat("mp_f_freemode_01"))
        end
        ped.set_ped_component_variation(getped(player.player_id()), 0, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 1, 91, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 11, 300, 4, 4)
        ped.set_ped_component_variation(getped(player.player_id()), 2, 42, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 3, 8, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 4, 86, 4, 4)
        ped.set_ped_component_variation(getped(player.player_id()), 6, 58, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 7, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 8, 105, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 5, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 10, 0, 0, 0)
        ped.set_ped_component_variation(getped(player.player_id()), 9, 0, 0, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 0, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 1, 24, 9, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 2, 6, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 3, -1, 0, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 4, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 5, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 6, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 7, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 8, -1, -1, 0)
        ped.set_ped_prop_index(getped(player.player_id()), 9, -1, -1, 0)
    end
)
newfunc(
    "警服",
    "action",
    closet,
    function()
        local component = {
            {0, 0},
            {0, 6},
            {0, 14},
            {0, 34},
            {0, 0},
            {0, 25},
            {0, 0},
            {0, 35},
            {0, 0},
            {0, 0},
            {0, 48}
        }
        local prop = {
            {0, 45, 0},
            {1, 11, 0},
            {2, 4294967295, 0},
            {6, 4294967295, -1},
            {7, 4294967295, -1}
        }
        if player.get_player_model(player.player_id()) ~= 2627665880 then
            modelchange(joaat("mp_f_freemode_01"))
        end
        for i = 1, #component do
            ped.set_ped_component_variation(getped(player.player_id()), i, component[i][2], component[i][1], 2)
        end
        for i = 1, #prop do
            ped.set_ped_prop_index(getped(player.player_id()), prop[i][1], prop[i][2], prop[i][3], 0)
        end
    end
)

--Health
health = newfunc("生命选项", "parent", self).id
fakegod =
    newfunc(
    "伪无敌(自动回血+延迟)",
    "value_i",
    health,
    function(feat)
        if feat.on then
            ped.set_ped_max_health(getped(player.player_id()), player.get_player_max_health(player.player_id()))
            if ped.get_ped_health(getped(player.player_id())) < player.get_player_max_health(player.player_id()) then
                CD(feat.value)
                ped.set_ped_health(getped(player.player_id()), player.get_player_max_health(player.player_id()))
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
fakegod.min = 0
fakegod.mod = 50
fakegod.max = 5000
selfsemigod = newfunc(
    "半无敌(防子弹)",
    "toggle",
    health,
    function(feat)
        if feat.on then
            local pos = getcoords(player.player_id())
            pos.x = pos.x + 5
            requestmodel(0x8DA1C0E)
            ball = object.create_object(0x8DA1C0E, pos, true, false)
            entity.set_entity_god_mode(ball, true)
            entity.attach_entity_to_entity(
                ball,
                getped(player.player_id()),
                ped.get_ped_bone_index(getped(player.player_id()), 11816),
                v3(),
                v3(),
                true,
                true,
                false,
                0,
                false
            )
            entity.set_entity_visible(ball, false)
        else
            network.request_control_of_entity(ball)
            entity.detach_entity(ball)
            entity.set_entity_as_no_longer_needed(ball)
            entity.delete_entity(ball)
        end
    end
)
newfunc(
    "一键满血",
    "action",
    health,
    function(feat)
        ped.set_ped_max_health(getped(player.player_id()), player.get_player_max_health(player.player_id()))
        ped.set_ped_health(getped(player.player_id()), player.get_player_max_health(player.player_id()))
    end
)
fakeotr =
    newfunc(
    "伪死亡雷达匿踪",
    "action",
    health,
    function(feat)
        local chp0 = ped.get_ped_max_health(getped(player.player_id()))
        ped.set_ped_max_health(getped(player.player_id()), 0)
        local chp1 = ped.get_ped_max_health(getped(player.player_id()))
        if chp1 ~= 0 then
            ped.set_ped_health(getped(player.player_id()), 0)
        else
        end
    end
)
illegalhealth =
    newfunc(
    "设置自定义血量",
    "action_value_i",
    health,
    function(feat)
        if feat.on then
            ped.set_ped_max_health(getped(player.player_id()), feat.value)
            ped.set_ped_health(getped(player.player_id()), feat.value)
        end
    end
)
illegalhealth.min = 0
illegalhealth.mod = 50
illegalhealth.max = 10000000
function suicide()
    ped.set_ped_max_health(getped(player.player_id()), 0)
    ped.set_ped_health(getped(player.player_id()), 0)
end
comsui =
    newfunc(
    "自杀",
    "action",
    health,
    function(feat)
        suicide()
    end
)

--PTFX
selfptfx = newfunc("粒子特效", "parent", self).id
selfallptfx = newfunc("所有粒子特效", "parent", selfptfx).id
for i = 1, #ptfxlist do
    newfunc(
        ptfxlist[i][1],
        "toggle",
        selfallptfx,
        function(feat)
            if feat.on then
                while not graphics.has_named_ptfx_asset_loaded(ptfxlist[i][1]) do
                    graphics.request_named_ptfx_asset(ptfxlist[i][2])
                    CD(0)
                end
                graphics.start_ptfx_non_looped_on_entity(ptfxlist[i][2], getped(player.player_id()), v3(), v3(), 1)
                CD(5)
                return HANDLER_CONTINUE
            else
                return HANDLER_POP
            end
        end
    )
end
--Ass On Fire
newfunc(
    "喷射战士",
    "toggle",
    selfptfx,
    function(feat)
        if feat.on then
            local dict = "weap_xs_vehicle_weapons"
            graphics.set_next_ptfx_asset(dict)
            while not graphics.has_named_ptfx_asset_loaded(dict) do
                graphics.request_named_ptfx_asset(dict)
                CD(0)
            end
            firearse =
                graphics.start_ptfx_looped_on_entity(
                "muz_xs_turret_flamethrower_looping",
                getped(player.player_id()),
                v3(),
                v3(180, 0, 0),
                0.333
            )
        else
            graphics.remove_ptfx(firearse, true)
        end
    end
)
--Dragon Breath
newfunc(
    "龙息",
    "toggle",
    selfptfx,
    function(feat)
        if feat.on then
            local dict = "weap_xs_vehicle_weapons"
            graphics.set_next_ptfx_asset(dict)
            while not graphics.has_named_ptfx_asset_loaded(dict) do
                graphics.request_named_ptfx_asset(dict)
                CD(0)
            end
            dragonbreath =
                graphics.start_ptfx_looped_on_entity(
                "muz_xs_turret_flamethrower_looping",
                getped(player.player_id()),
                v3(0, 0.025, 0.65),
                v3(0, 0, 0),
                0.333
            )
        else
            graphics.remove_ptfx(dragonbreath, true)
        end
    end
)
--Smoke Fill
newfunc(
    "烟雾笼罩",
    "toggle",
    selfptfx,
    function(feat)
        if feat.on then
            for i = 1, 16 do
                local pos = getcoords(player.player_id())
                local rad = 2 * math.pi
                rad = rad / 16
                rad = rad * i
                pos.x = pos.x + (18 * math.cos(rad))
                pos.y = pos.y + (18 * math.sin(rad))
                pos.z = pos.z - 2.5
                graphics.set_next_ptfx_asset("scr_recartheft")
                while not graphics.has_named_ptfx_asset_loaded("scr_recartheft") do
                    graphics.request_named_ptfx_asset("scr_recartheft")
                    CD(0)
                end
                graphics.start_networked_ptfx_non_looped_at_coord("scr_wheel_burnout", pos, v3(), 2.5, true, true, true)
                CD(40)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "清除身上所有的粒子特效",
    "action",
    selfptfx,
    function(feat)
        graphics.remove_ptfx_from_entity(getped(player.player_id()))
    end
)
--Ragdoll Self
newfunc(
    "摔倒",
    "toggle",
    self,
    function(feat)
        if feat.on then
            ped.set_ped_to_ragdoll(getped(player.player_id()), 2500, 0, 0)
            CD(50)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)

--Online Option
--Session Option
allplayers = newfunc("所有玩家", "parent", online).id
--Friendly
allplayerfriendly = newfunc("友好选项", "parent", allplayers).id
--Add 10k CEO Cash
newfunc(
    "给予10K CEO金钱",
    "toggle",
    allplayerfriendly,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    TSE(
                        1152266822,
                        pid,
                        {
                            player.player_id(),
                            10000,
                            -1292453789,
                            1,
                            script.get_global_i(1630816 + (1 + (pid * 597) + 508)),
                            script.get_global_i(1658176 + 9),
                            script.get_global_i(1658176 + 10)
                        }
                    )
                    CD(1200)
                    TSE(
                        1152266822,
                        pid,
                        {
                            player.player_id(),
                            10000,
                            -1292453789,
                            0,
                            script.get_global_i(1630816 + (1 + (pid * 597) + 508)),
                            script.get_global_i(1658176 + 9),
                            script.get_global_i(1658176 + 10)
                        }
                    )
                    CD(1200)
                    CD(31000)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Remove Wanted Level
newfunc(
    "清除通缉等级",
    "toggle",
    allplayerfriendly,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                TSE(1187364773, pid, {pid, script.get_global_i(1628955 + (1 + (pid * 614)) + 532)})
            end
        end
    end
)
--Give OTR
newfunc(
    "给予雷达匿踪",
    "toggle",
    allplayerfriendly,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                TSE(
                    -397188359,
                    pid,
                    {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630816 + (1 + (pid * 597) + 508))}
                )
            end
        end
    end
)
--Give Semi-God
newfunc(
    "给予半无敌",
    "action",
    allplayerfriendly,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                local pos = getcoords(pid)
                pos.x = pos.x + 5
                requestmodel(0x8DA1C0E)
                ball = object.create_object(0x8DA1C0E, pos, true, false)
                entity.set_entity_god_mode(ball, true)
                entity.attach_entity_to_entity(
                    ball,
                    getped(pid),
                    ped.get_ped_bone_index(getped(pid), 11816),
                    v3(),
                    v3(),
                    true,
                    true,
                    false,
                    0,
                    false
                )
                entity.set_entity_visible(ball, false)
            end
        end
    end
)
--Give All Weapons
newfunc(
    "给予全部武器",
    "action",
    allplayerfriendly,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                local allweaponhashes = weapon.get_all_weapon_hashes()
                for i = 1, #allweaponhashes do
                    requestmodel(allweaponhashes[i])
                    weapon.give_delayed_weapon_to_ped(getped(pid), allweaponhashes[i], 0, 0)
                    streaming.set_model_as_no_longer_needed(allweaponhashes[i])
                end
            end
        end
    end
)
--Trolling
allplayertroll = newfunc("恶搞选项", "parent", allplayers).id
--Teleport
newfunc(
    "传送至",
    "action_value_str",
    allplayertroll,
    function(feat)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if feat.value == 0 then
                    TSE(-1479371259, pid, {1300962917})
                elseif feat.value == 1 then
                    TSE(545396442, pid, {0})
                elseif feat.value == 2 then
                    network.request_control_of_entity(getped(pid))
                    local pos = ui.get_waypoint_coord()
                    local pos = v3(pos.x, pos.y, 10000)
                    if ped.is_ped_in_any_vehicle(getped(pid)) then
                        network.request_control_of_entity(getveh(pid))
                        entity.set_entity_coords_no_offset(getveh(pid), pos)
                    else
                        entity.set_entity_coords_no_offset(getped(pid), pos)
                    end
                elseif feat.value == 3 then
                    network.request_control_of_entity(getped(pid))
                    local pos = getcoords(player.player_id())
                    pos.z = 10000
                    if ped.is_ped_in_any_vehicle(getped(pid)) then
                        network.request_control_of_entity(getveh(pid))
                        entity.set_entity_coords_no_offset(getveh(pid), pos)
						vehicle.set_vehicle_on_ground_properly(getveh(pid))
                    else
                        entity.set_entity_coords_no_offset(getped(pid), pos)
                    end
                end
            end
        end
    end
):set_str_data(
    {
        "佩里科岛",
        "任务",
        "标记点",
        "身边"
    }
)
--CEO
newfunc(
    "CEO",
    "action_value_str",
    allplayertroll,
    function(feat)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if feat.value == 0 then
                    TSE(0x50c72ec2, pid, {0, 1, 5, 0})
                elseif feat.value == 1 then
                    TSE(0xed1bc159, pid, {0, 1, 5})
                elseif feat.value == 2 then
                    TSE(0xed1bc159, pid, {1, 1, 6})
                    TSE(0xed1bc159, pid, {0, 1, 6, 0})
                end
            end
        end
    end
):set_str_data(
    {
        "禁用",
        "解散",
        "终结"
    }
)
--Set Bounty
allplayerbounty = newfunc("悬赏选项", "parent", allplayertroll).id
--Anon Bounty
anonbountyall =
    newfunc(
    "匿名悬赏",
    "toggle",
    allplayerbounty,
    function(feat)
    end
)
--Normal Bounty
custombountyall =
    newfunc(
    "自定义悬赏",
    "action_value_i",
    allplayerbounty,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if anonbountyall.on then
                    TSE(
                        0xf90cc891,
                        pid,
                        {
                            -1,
                            pid,
                            1,
                            feat_value,
                            0,
                            1,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            script.get_global_i(1658176 + 9),
                            script.get_global_i(1658176 + 10)
                        }
                    )
                else
                    TSE(
                        0xf90cc891,
                        pid,
                        {
                            -1,
                            pid,
                            1,
                            feat_value,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            script.get_global_i(1658176 + 9),
                            script.get_global_i(1658176 + 10)
                        }
                    )
                end
            end
        end
    end
)
custombountyall.min = 0
custombountyall.mod = 500
custombountyall.max = 10000
--Cage
allplayercage = newfunc("囚禁选项", "parent", allplayertroll).id
--Stunt Tube
newfunc(
    "竞速管",
    "action",
    allplayercage,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                local pos = getcoords(pid)
                pos.z = pos.z - 5
                requestmodel(1125864094)
                tube = object.create_object(1125864094, pos, true, false)
                entity.set_entity_rotation(tube, v3(0, 90, 0))
                streaming.set_model_as_no_longer_needed(1125864094)
            end
        end
    end
)
--Traditional
newfunc(
    "笼子",
    "action",
    allplayercage,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                local pos = getcoords(pid)
                pos.z = pos.z - 5
                requestmodel(joaat("prop_test_elevator"))
                cage = object.create_object(joaat("prop_test_elevator"), pos, true, false)
                entity.set_entity_rotation(cage, v3(0, 90, 0))
                streaming.set_model_as_no_longer_needed(joaat("prop_test_elevator"))
            end
        end
    end
)
--Attachments
allplayerattach = newfunc("附加选项", "parent", allplayertroll).id
--Customize
customattachall =
    newfunc(
    "附加自定义实体",
    "action",
    allplayerattach,
    function(feat)
        local entname = getinput("INPUT CUSTUM ENTITY NAME", "", 32, 0)
        if streaming.is_model_valid(joaat(entname)) then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    requestmodel(gameplay.get_hash_key(entname))
                    obj = object.create_object(joaat(entname), v3(), true, false)
                    entity.attach_entity_to_entity(
                        obj,
                        getped(pid),
                        ped.get_ped_bone_index(getped(pid), 11816),
                        v3(),
                        v3(0.0, 0.0, 10.0),
                        true,
                        true,
                        false,
                        0,
                        false
                    )
                    streaming.set_model_as_no_longer_needed(joaat(entname))
                end
            end
        else
            logg("[ERROR] Model Invalid!")
            NOTG("无效模型", "错误")
        end
    end
)

--Traditional
newfunc(
    "附加篝火",
    "action",
    allplayerattach,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                requestmodel(3229200997)
                bf = object.create_object(3229200997, v3(), true, false)
                entity.attach_entity_to_entity(
                    bf,
                    getped(pid),
                    ped.get_ped_bone_index(getped(pid), 11816),
                    v3(),
                    v3(0.0, 0.0, 10.0),
                    true,
                    true,
                    false,
                    0,
                    false
                )
                streaming.set_model_as_no_longer_needed(3229200997)
            end
        end
    end
)
newfunc(
    "附加UFO",
    "action",
    allplayerattach,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                requestmodel(joaat("p_spinning_anus_s"))
                ufo = object.create_object(joaat("p_spinning_anus_s"), v3(), true, false)
                entity.attach_entity_to_entity(
                    ufo,
                    getped(pid),
                    ped.get_ped_bone_index(getped(pid), 11816),
                    v3(),
                    v3(0.0, 0.0, 0),
                    true,
                    true,
                    false,
                    0,
                    false
                )
                streaming.set_model_as_no_longer_needed(joaat("p_spinning_anus_s"))
            end
        end
    end
)
newfunc(
    "附加JB",
    "action",
    allplayerattach,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                requestmodel(joaat("prop_cs_dildo_01"))
                DICK = object.create_object(joaat("prop_cs_dildo_01"), v3(), true, false)
                entity.attach_entity_to_entity(
                    DICK,
                    getped(pid),
                    ped.get_ped_bone_index(getped(pid), 11816),
                    v3(),
                    v3(0.0, 0.0, 0),
                    true,
                    true,
                    false,
                    0,
                    false
                )
                streaming.set_model_as_no_longer_needed(joaat("prop_cs_dildo_01"))
            end
        end
    end
)
newfunc(
    "附加火柱",
    "toggle",
    allplayerattach,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    fire.add_explosion(getcoords(pid), 12, true, false, 0, getped(pid))
                end
            end
            CD(10)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "附加水柱",
    "toggle",
    allplayerattach,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    fire.add_explosion(getcoords(pid), 13, true, false, 0, getped(pid))
                end
            end
            CD(10)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Moneybag
newfunc(
    "掉落假钱袋",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    object.create_object(joaat("p_poly_bag_01_s"), getcoords(pid), true, true)
                    CD(50)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Remove Weapon
newfunc(
    "移除全部武器",
    "action",
    allplayertroll,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                local allweaponhashes = weapon.get_all_weapon_hashes()
                for i = 1, #allweaponhashes do
                    weapon.remove_weapon_from_ped(getped(pid), allweaponhashes[i])
                    CD(5)
                end
            end
        end
    end
)
--Other Remote
newfunc(
    "消息轰炸",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    TSE(891272013, pid, {pid, math.random(-2147483647, 2147483647)}, true)
                    system.yield(0)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
newfunc(
    "发送交易错误",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    TSE(
                        -2041535807,
                        pid,
                        {
                            pid,
                            2147483647,
                            1,
                            1,
                            script.get_global_i(1630317 + (1 + (pid * 595) + 506)),
                            script.get_global_i(1658176 + 9),
                            script.get_global_i(1658176 + 10),
                            1
                        },
                        true
                    )
                    system.yield(1000)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
newfunc(
    "禁用被动模式",
    "action",
    allplayertroll,
    function()
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                TSE(1472357458, pid, {pid, 1})
            end
        end
    end
)
newfunc(
    "发送无限黑屏",
    "action",
    allplayertroll,
    function()
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                TSE(0x4a72a08d, pid, {-1, 1, -1})
            end
        end
    end
)
--Ragdoll
newfunc(
    "全体摔倒",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    ped.set_ped_to_ragdoll(getped(pid), 2500, 0, 0)
                    CD(50)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Camera Shake
newfunc(
    "摇晃镜头",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    fire.add_explosion(
                        getcoords(pid),
                        4,
                        false,
                        false,
                        100.0,
                        getped(pid)
                    )
                end
            end
        end
    end
)
--Freeze
newfunc(
    "全体冻结",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    ped.clear_ped_tasks_immediately(getped(pid))
                end
            end
        end
    end
)
--Explosion
newfunc(
    "全体爆炸",
    "toggle",
    allplayertroll,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    fire.add_explosion(getcoords(pid), 0, true, false, 0, getped(pid))
                    CD(15)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Abusive
allplayerabusive = newfunc("攻击选项", "parent", allplayers).id
--Script Event Crash
local crashscriptevent = {
    -988842806,
    -2043109205,
    1926582096,
    153488394,
    1249026189,
    0x4a72a08d,
    0x0F478794,
    315658550,
	-1881357102,
	1033875141,
	-877212109,
	-720040631,
	-435067392,
	-1729804184,
	1428412924,
	823645419,
	1070934291,
	-171207973,
	1317868303,
	-1252906024,
	-1890951223,
	-1212832151,
	-1559754940,
	-1054826273,
	1620254541,
	1401831542,
	-1491386500,
	-977515445,
	767605081,
	-1730227041,
	-1949011582,
	-2122716210,
	-1882923979,
	0x7cba04c8,
	0x09260c0a,
	0x445b050e,
	2092565704
}
function getcrasharg(pid)
	local parameters = {
		pid
	}
	for i = 2, 10 do
		parameters[i] = math.random(-2147483647, 2147483647)
	end
	return parameters
end
secrashall =
    newfunc(
    "脚本事件崩溃",
    "value_i",
    allplayerabusive,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                    TSE(
                        crashscriptevent[math.random(1, #crashscriptevent)],
                        pid,
						getcrasharg(pid)
                    )
                    CD(feat.value)
            end
        end
    end
)
secrashall.min = 1
secrashall.max = 20
secrashall.mod = 1
secrashall.value = 5
--Death Model Sync
mscrashall =
    newfunc(
    "死亡模型交换崩溃",
    "action",
    allplayerabusive,
    function(feat, pid)
        if network.is_session_started() then
            local ori = {
                pos = getcoords(player.player_id()),
                heading = player.get_player_heading(player.player_id())
            }
            teleport(0, 0, 0, 0)
            logg("Player Model Sync Crash Triggered")
            for i = 1, 20 do
                modelchange(joaat("mp_m_freemode_01"))
                CD(200)
                suicide()
                teleport(math.random(0, 10000), math.random(0, 10000), math.random(0, 10000), math.random(0, 360))
                CD(200)
                modelchange(joaat("mp_f_freemode_01"))
                CD(200)
                suicide()
                teleport(math.random(0, 10000), math.random(0, 10000), math.random(0, 10000), math.random(0, 360))
                CD(200)
            end
            teleport(ori.pos.x, ori.pos.y, ori.pos.z, ori.heading)
            CD(300)
        else
            logg("Crash could not be triggered due to invalid online status")
            NOTG("请进入GTA在线模式以使用死亡同步崩溃", "ERROR")
        end
    end
)
--Kick All
newfunc(
    "踢出所有玩家",
    "toggle",
    allplayerabusive,
    function(feat, pid)
        if feat.on then
            if network.network_is_host() then
                for pid = 0, 32 do
                    if pid ~= player.player_id() then
                        logg("Session Host Detected, Triggering Host Kick")
                        network.network_session_kick_player(pid)
                    end
                end
            else
                if pid ~= player.player_id() then
                    kickplayer(pid)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
--Vehicle Option
allplayerveh = newfunc("载具选项", "parent", allplayers).id
--Vehicle Spawner
allplayerspawner = newfunc("刷出载具", "parent", allplayerveh).id
allsetgod =
    newfunc(
    "设置刷出无敌",
    "toggle",
    allplayerspawner,
    function(feat)
    end
)
allspawncustom =
    newfunc(
    "刷出自定义载具",
    "action",
    allplayerspawner,
    function(feat, pid)
        local vehname = getinput("INPUT CUSTUM VEHICLE NAME", "", 32, 0)
        if streaming.is_model_a_vehicle(joaat(vehname)) then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    requestmodel(joaat(vehname))
                    local pos = getcoords(pid)
                    pos.x = pos.x + 3
                    spawnedveh = vehicle.create_vehicle(joaat(vehname), pos, 0.0, true, true)
                    if allsetgod.on then
                        entity.set_entity_god_mode(spawnedveh, true)
                    end
                    streaming.set_model_as_no_longer_needed(joaat(vehname))
                end
            end
        else
            logg("[ERROR] Model Invalid!")
            NOTG("无效载具模型", "错误")
        end
    end
)
allvehlist = newfunc("载具列表", "parent", allplayerspawner).id
for i = 1, #vehiclelist do
    newfunc(
        vehiclelist[i][2],
        "action",
        allvehlist,
        function(feat, pid)
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    requestmodel(joaat(vehiclelist[i][1]))
                    local pos = getcoords(pid)
                    pos.x = pos.x + 3
                    spawnedveh = vehicle.create_vehicle(joaat(vehiclelist[i][1]), pos, 0.0, true, true)
                    if allsetgod.on then
                        entity.set_entity_god_mode(spawnedveh, true)
                    end
                    streaming.set_model_as_no_longer_needed(joaat(vehiclelist[i][1]))
                end
            end
        end
    )
end
newfunc(
    "载具无敌",
    "toggle",
    allplayerveh,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    if player.is_ped_in_any_vehicle == true then
                        entity.set_entity_god_mode(getveh(pid), true)
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "儿童锁",
    "toggle",
    allplayerveh,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    if player.is_ped_in_any_vehicle == true then
                        vehicle.set_vehicle_doors_locked(getveh(pid),4)
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "修复载具",
    "action",
    allplayerveh,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if player.is_ped_in_any_vehicle == true then
                    vehicle.set_vehicle_fixed(getveh(pid))
                    vehicle.set_vehicle_deformation_fixed(getveh(pid))
                end
            end
        end
    end
)
newfunc(
    "载具不可被导弹锁定",
    "toggle",
    allplayerveh,
    function(feat)
        if feat.on then
			for pid = 0, 32 do
				if pid ~= player.player_id() and player.is_player_valid(pid) then
					if ped.is_ped_in_any_vehicle(getped(pid)) == true then
						vehicle.set_vehicle_can_be_locked_on(getveh(pid), false, false)
					end
				end
			end
			return HANDLER_CONTINUE
		else
			for pid = 0, 32 do
				if pid ~= player.player_id() and player.is_player_valid(pid) then
					if ped.is_ped_in_any_vehicle(getped(pid)) == true then
						vehicle.set_vehicle_can_be_locked_on(getveh(pid), true, false)
					end
				end
			end
			return HANDLER_POP
		end
    end
)
newfunc(
    "关闭引擎",
    "toggle",
    allplayerveh,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    if player.is_ped_in_any_vehicle == true then
                        vehicle.set_vehicle_engine_on(getveh(pid), false, true, true)
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "加装电话炸弹",
    "toggle",
    allplayerveh,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    if player.is_ped_in_any_vehicle == true then
                        if vehicle.has_vehicle_phone_explosive_device() == false then
                            vehicle.add_vehicle_phone_explosive_device(getveh(pid))
                        end
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "引爆电话炸弹",
    "action",
    allplayerveh,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if player.is_ped_in_any_vehicle == true then
                    if vehicle.has_vehicle_phone_explosive_device() == true then
                        vehicle.detonate_vehicle_phone_explosive_device()
                    end
                end
            end
        end
    end
)
newfunc(
    "引爆电话炸弹",
    "action",
    allplayerveh,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                if player.is_ped_in_any_vehicle == true then
					if vehicle.does_vehicle_have_parachute(getveh(pid)) == true then
						vehicle.set_vehicle_parachute_active(getveh(pid), true)
					end
                end
            end
        end
    end
)
--Host Option
hostoption = newfunc("主机选项", "parent", online).id
kickhost =
    newfunc(
    "循环踢出当前战局主机",
    "toggle",
    hostoption,
    function(feat)
        if feat.on then
            if not network.network_is_host() then
                kickplayer(network.network_is_host())
                CD(50)
            end
            if network.network_is_host() then
                kickhost.on = false
                NOTG("你现在是战局主机。 ~r~主机踢已启用", "Host Migration")
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
kicksh =
    newfunc(
    "循环踢出当前脚本主机",
    "toggle",
    hostoption,
    function(feat)
        if feat.on then
            if script.get_host_of_this_script() then
                kicksh.on = false
                NOTG("你现在是脚本主机", "Host Migration")
            else
                kickplayer(script.get_host_of_this_script())
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
--Host Queue List
renderfontsize = 0.35
hostlist =
    newfunc(
    "主机排序列表",
    "toggle",
    hostoption,
    function(feat)
        if feat.on then
            if rainbowall.on then
                ui.draw_rect(0.9, 0.5, 0.15, 0.45, rainbowr, rainbowg, rainbowb, 150)
            else
                ui.draw_rect(0.9, 0.5, 0.15, 0.45, 40, 40, 40, 150)
            end
            local pos = v2()
            pos.x = 0.83
            pos.y = 0.32
            local txtpos = v2()
            txtpos.x = 0.87
            txtpos.y = 0.28
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(renderfontsize)
            ui.set_text_font(renderfont)
            ui.set_text_centre(false)
            ui.set_text_outline(false)
            ui.draw_text("Host Queue List", txtpos)
            local host_queue = {}
            for pid = 0, 32 do
                if getped(pid) ~= 0 then
                    if not player.is_player_host(pid) then
                        local name = player.get_player_name(pid)
                        local queue = player.get_player_host_priority(pid)
                        host_queue[queue] = name
                    end
                end
            end
            local i = 1
            local host_queues = {}
            for k, v in pairs(host_queue) do
                host_queues[i] = v
                i = i + 1
            end
            for lineup = 1, #host_queues do
                if lineup > 16 then
                    break
                end
                ui.set_text_color(255, 255, 255, 255)
                ui.set_text_scale(renderfontsize)
                ui.set_text_font(renderfont)
                ui.set_text_centre(false)
                ui.set_text_outline(false)
                ui.draw_text(tostring(lineup) .. ". " .. host_queues[lineup], pos)
                pos.y = pos.y + 0.025
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Modder Detection
local seshackdetkt = newfunc("作弊者检测", "parent", online).id
newfunc(
    "检测&通知战局中可能存在的的作弊者",
    "toggle",
    seshackdetkt,
    function(feat, pid)
        if feat.on then
            local me = player.player_id()
            for pid = 0, 32 do
                if pid ~= me then
                    local rid = player.get_player_scid(pid)
                    local name = player.get_player_name(pid)
                    local hostkey = player.get_player_host_token(pid)
                    local plcount = player.player_count()
                    if rid == "0" then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:可疑的RID", "Modder Detection")
                        logg(
                            "[Modder Detection] Player:" ..
                                name .. " might be a potential modder. Reason: Suspcious RID"
                        )
                    end
                    if hostkey == "0" then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:启用强制主机", "Modder Detection")
                        logg("[Modder Detection] Player:" .. name .. " might be a potential modder. Reason: Force Host")
                    end
                    if player.is_player_god(pid) and plcount >= 5 and player.get_player_host_priority(pid) <= 3 then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:无敌+强制主机", "Modder Detection")
                        logg(
                            "[Modder Detection] Player:" ..
                                name .. " might be a potential modder. Reason: Player Invincible+Force Host"
                        )
                    end
                    if pid ~= script.get_host_of_this_script() then
                        CD(500)
                        if pid == script.get_host_of_this_script() and player.player_count() == plcount then
                            NOTG("玩家:" .. name .. "可能是作弊者\n原因:脚本主机抢夺", "Modder Detection")
                            logg(
                                "[Modder Detection] Player:" ..
                                    name .. " might be a potential modder. Reason: Illegal Script Host Migration"
                            )
                        end
                    end
                    if getglobalinfoi(pid, 56) > 200000000 then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:不正常的金钱数量", "Modder Detection")
                        logg(
                            "[Modder Detection] Player:" ..
                                name .. " might be a potential modder. Reason: Suspcious Total Money"
                        )
                    end
                    if getglobalinfoi(pid, 6) > 500 and getglobalinfoi(pid, 56) > 100000000 then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:不正常的等级", "Modder Detection")
                        logg(
                            "[Modder Detection] Player:" ..
                                name .. " might be a potential modder. Reason: Suspcious Total Money"
                        )
                    end
                    if player.is_player_spectating(pid) then
                        NOTG("玩家:" .. name .. "可能是作弊者\n原因:观看玩家", "Modder Detection")
                        logg(
                            "[Modder Detection] Player:" ..
                                name .. " might be a potential modder. Reason: Player Spectating"
                        )
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "启用所有玩家的作弊者标记",
    "toggle",
    seshackdetkt,
    function(feat, pid)
        NOTG("请将防护中阻止标记为作弊玩家传入的事件中所有选项启用以生效")
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    player.set_player_as_modder(pid, -1)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
newfunc(
    "撤销所有玩家的作弊者标记",
    "action",
    seshackdetkt,
    function(feat, pid)
        for pid = 0, 32 do
            if pid ~= player.player_id() and player.is_player_valid(pid) then
                player.set_player_as_modder(pid, -1)
            end
        end
        return HANDLER_POP
    end
)
--Spammer
spammer = newfunc("轰炸机", "parent", online).id
spammerpreset = newfunc("预设", "parent", spammer).id
newfunc(
    "大悲咒",
    "toggle",
    spammerpreset,
    function(feat, pid)
        if feat.on then
            for i = 1, #dabeizhou do
                network.send_chat_message(dabeizhou[i], false)
                CD(500)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "清心咒",
    "toggle",
    spammerpreset,
    function(feat, pid)
        if feat.on then
            for i = 1, #qingxinzhou do
                network.send_chat_message(qingxinzhou[i], false)
                CD(500)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "超度",
    "toggle",
    spammerpreset,
    function(feat, pid)
        if feat.on then
            for i = 1, #fojiao do
                network.send_chat_message(fojiao[i], false)
                CD(500)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "中英文道歉",
    "toggle",
    spammerpreset,
    function(feat, pid)
        if feat.on then
            for i = 1, #apologytext do
                network.send_chat_message(apologytext[i], false)
                CD(500)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
local sms_text
newfunc(
    "短信轰炸机(提前复制不超过128字的信息)",
    "toggle",
    spammer,
    function(feat, pid)
        if feat.on then
            sms_text = utils.from_clipboard()
            for pid = 0, 32 do
                if pid ~= player.player_id() and player.is_player_valid(pid) then
                    player.send_player_sms(pid, sms_text)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "聊天轰炸机(提前复制不超过128字的信息)",
    "toggle",
    spammer,
    function(feat)
        if feat.on then
            text = utils.from_clipboard()
            network.send_chat_message(text, false)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Ad-Bot
adbotsub = newfunc("广告机检测", "parent", online).id
adbottype = newfunc("检测类别", "parent", adbotsub).id
adbotreaction = newfunc("检测反应", "parent", adbotsub).id
--Ad Type Sub
menupromotion =
    newfunc(
    "卖挂/代练",
    "toggle",
    adbottype,
    function(feat)
    end
)
sex =
    newfunc(
    "色情",
    "toggle",
    adbottype,
    function(feat)
    end
)
--Ad Reaction Sub
autokick =
    newfunc(
    "踢出",
    "toggle",
    adbotreaction,
    function(feat)
    end
)
autocrash =
    newfunc(
    "崩溃",
    "toggle",
    adbotreaction,
    function(feat)
    end
)
crap =
    newfunc(
    "语言嘲讽: 拉跨",
    "toggle",
    adbotreaction,
    function(feat)
    end
)
fraud =
    newfunc(
    "语言嘲讽: 别信",
    "toggle",
    adbotreaction,
    function(feat)
    end
)
blankreplace =
    newfunc(
    "空白信息覆盖",
    "toggle",
    adbotreaction,
    function(feat)
    end
)
--Autokick
admain =
    newfunc(
    "主开关",
    "toggle",
    adbotsub,
    function(feat)
        if feat.on then
            adbotdetect =
                event.add_event_listener(
                "player_join",
                function(ad)
                    local rid = player.get_player_scid(ad.player)
                    local name = player.get_player_name(ad.player)
                    if string.match(name, "_Qun") or string.match(name, "Darkcoin") or string.match(name, "Blackcoin") then
                        if autokick.on then
                            kickplayer(ad.player)
                            logg("[AD-BOT AUTO-KICK] Automatically Kicked " .. name .. ". Reason: Common Name Prefix")
                        end
                        if autocrash.on then
                            instacrash(ad.player)
                            logg("[AD-BOT AUTO-CRASH] Automatically Crashed " .. name .. ". Reason: Common Name Prefix")
                        end
                    end
                end
            )
            adbot =
                event.add_event_listener(
                "chat",
                function(c)
                    local cplayer = player.get_player_name(c.player)
					if c.player ~= player.player_id() then
						if menupromotion.on then
							if
								string.match(c.body, "刷金") or string.match(c.body, "代练") or string.match(c.body, "金币") or
									string.match(c.body, "元一亿") or
									string.match(c.body, "毛一亿") or
									string.match(c.body, "块一亿") or
									string.match(c.body, "分一亿") or
									string.match(c.body, "有妹子") or
									string.match(c.body, "手工打金") or
									string.match(c.body, "解封") or
									string.match(c.body, "科技") or
									string.match(c.body, "不要挂") or
									string.match(c.body, "全网最低") or
									string.match(c.body, "辅助")
							 then
								if autokick.on then
									logg(
										"[AD-BOT AUTO-KICK] Automatically Kicked " ..
											cplayer .. ". Reason: Menu/Recovery Promotion"
									)
									kickplayer(c.player)
								end
								if autocrash.on then
										instacrash(c.player)
										logg(
											"[AD-BOT AUTO-CRASH] Automatically Crashed " ..
												name .. ". Reason: Menu/Recovery Promotion"
										)
								end
								if crap.on then
									for i = 1, 5 do
										network.send_chat_message("LJ广告机，给自己买一个2Take1 VIP吧", false)
									end
								end
								if fraud.on then
									for i = 1, 5 do
										network.send_chat_message("其他玩家别信，谁买谁SB", false)
									end
								end
								if blankreplace.on then
									for i = 1, 5 do
										network.send_chat_message(" ", false)
									end
								end
							end
						end
						if sex.on then
							if
								string.match(c.body, "AV") or string.match(c.body, "欧美大片") or string.match(c.body, "美女荷官") or
									string.match(c.body, "在线观看") or
									string.match(c.body, "处男") or
									string.match(c.body, "处女")
							 then
								if autokick.on then
									logg(
										"[AD-BOT AUTO-KICK] Automatically Kicked " ..
											cplayer .. ". Reason: Sexual Advertisement"
									)
									kickplayer(c.player)
								end
								if autocrash.on then
									instacrash(c.player)
									logg(
										"[AD-BOT AUTO-CRASH] Automatically Crashed " ..
											name .. ". Reason: Sexual Advertisement"
									)
								end
								if crap.on then
									for i = 1, 5 do
										network.send_chat_message("就这还敢拿出来卖？", false)
									end
								end
								if fraud.on then
									for i = 1, 5 do
										network.send_chat_message("其他玩家别信，要看自己找", false)
									end
								end
								if blankreplace.on then
									for i = 1, 5 do
										network.send_chat_message(" ", false)
									end
								end
							end
						end
					end
                end
            )
        else
            event.remove_event_listener("player_join", adbotdetect)
            event.remove_event_listener("chat", adbot)
        end
    end
)
admain.on = true
--Chat Command
stringsplit = function(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end
chatcommand = newfunc("聊天指令", "parent", online).id

chatcommandswitch = newfunc(
    "主开关",
    "toggle",
    chatcommand,
    function(feat, pid)
	if feat.on then
		chatcommandfilter =
		event.add_event_listener(
		"chat",
		function(c)
			if string.match(c.body, "!kick") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						kickplayer(pid)
					end
				end
			end
			if string.match(c.body, "!crash") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						instacrash(pid)
					end
				end
			end
			if string.match(c.body, "!explode") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						fire.add_explosion(getcoords(pid), 0, true, false, 0, getped(pid))
					end
				end
			end
			if string.match(c.body, "!otr") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						TSE(
							-397188359,
							pid,
							{pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630816 + (1 + (pid * 597) + 508))}
						)
					end
				end
			end
			if string.match(c.body, "!summongod") then
				local pos = getcoords(c.player)
				teleport(pos.x,pos.y,pos.z,0)
			end
			if string.match(c.body, "!teleportnext2me") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						network.request_control_of_entity(getped(pid))
						local pos = getcoords(c.player)
						pos.z = 10000
						if ped.is_ped_in_any_vehicle(getped(pid)) then
							network.request_control_of_entity(getveh(pid))
							entity.set_entity_coords_no_offset(getveh(pid), pos)
							vehicle.set_vehicle_on_ground_properly(getveh(pid))
						else
							entity.set_entity_coords_no_offset(getped(pid), pos)
						end
					end
				end
			end
			if string.match(c.body, "!ufo") then
				local target = stringsplit(c.body, " ")[2]
				for pid = 0,32 do
					if target == player.get_player_name(pid) or target == player.get_player_scid(pid) then
						requestmodel(gameplay.get_hash_key("p_spinning_anus_s"))
						ufo = object.create_object(gameplay.get_hash_key("p_spinning_anus_s"), v3(), true, false)
						entity.attach_entity_to_entity(
							ufo,
							getped(pid),
							ped.get_ped_bone_index(getped(pid), 11816),
							v3(),
							v3(0.0, 0.0, 0),
							true,
							true,
							false,
							0,
							false
						)
						streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("p_spinning_anus_s"))
					end
				end
			end
		end
		)
	else
		event.remove_event_listener("chat", chatcommandfilter)
    end
end
)
newfunc(
    "发送指令列表",
    "action",
    chatcommand,
    function(feat, pid)
		if network.is_session_started() then
			network.send_chat_message("--欢迎使用LEGIT SCRIPT聊天指令--\n一般指令(用法为指令名+空格+玩家(RID或昵称均可)):\n!ban\n!crash\n!explode\n!ufo\n!otr\n!teleportnext2me\n特殊指令(直接输入):\n!summongod", false)
		end
    end
)
--Session Searcher
sessionsearcher = newfunc("战局查找器", "parent", online).id
minplayer = 10
sessionswitchtime = 1
sessionswitched = false
newfunc(
    "主开关",
    "toggle",
    sessionsearcher,
    function(feat)
        if feat.on then
			if network.is_session_started() then
				sessionswitched = false
			end
			if sessionswitched == false then
				if player.player_count() < minplayer then
					script.set_global_i(1312860,0)
					script.set_global_i(1312443,1)
					CD(200)
					script.set_global_i(1312443,0)
					CD(1000)
					sessionswitchtime = sessionswitchtime + 1
					logg("人数不满足要求.正在进行第"..sessionswitchtime.."次尝试")
					sessionswitched = true
				else
					logg("战局查找器已关闭")
					sessionswitched = false
					sessionswitchtime = 1
					feat.on = false
				end
			end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
sessionsearchermin = newfunc("设置最小人数","action_value_i",sessionsearcher, function(feat)
	minplayer = feat.value
end)
sessionsearchermin.min = 1
sessionsearchermin.max = 32
sessionsearchermin.mod = 1
--Fake Impulse User
newfunc(
    "伪装成为IMP用户",
    "toggle",
    online,
    function(feat, pid)
        if feat.on then
            if network.is_session_started() then
                for pid = 0, 32 do
                    if player.is_player_valid() then
                        TSE(1120313136, pid, 1289518925, 8373, math.random(0, 10000), 177)
                    end
                end
                CD(5)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Oribital Cooldown
newfunc(
    "移除天基炮冷却",
    "toggle",
    online,
    function(feat)
        if feat.on then
            if network.is_session_started() then
                setstatint("ORBITAL_CANNON_COOLDOWN", 0, 0)
                CD(5)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "移除筹码购买冷却",
    "toggle",
    online,
    function(feat)
        if feat.on then
            if network.is_session_started() then
                setstatint("MPPLY_CASINO_CHIPS_PUR_GD", 0, 0)
                CD(5)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Join/Leave
pljoin =
    newfunc(
    "玩家加入通知",
    "toggle",
    online,
    function(feat)
        if feat.on then
            pljoinevent =
                event.add_event_listener(
                "player_join",
                function(p)
                    local jrid = player.get_player_scid(p.player)
                    local jname = player.get_player_name(p.player)
                    logg("[Player Joining] Name: " .. jname .. " |RID: " .. jrid .. " |Slot: " .. p.player)
                    ui.notify_above_map(jname .. "\nRID: " .. jrid, "玩家正在加入", notifycolor)
                end
            )
        else
            event.remove_event_listener("player_join", pljoinevent)
        end
        return HANDLER_POP
    end
)
pljoin.on = true

--Weapon Option
--Airstrike Gun
newfunc(
    "空袭枪",
    "toggle",
    genweapons,
    function(feat)
        if feat.on then
            if ped.is_ped_shooting(getped(player.player_id())) then
                gameplay.shoot_single_bullet_between_coords(
                    entity.get_entity_coords(player.get_entity_player_is_aiming_at(getped(player.player_id()))) + v3(0, 0, 15),
                    entity.get_entity_coords(player.get_entity_player_is_aiming_at(getped(player.player_id()))),
                    1000,
                    joaat("weapon_airstrike_rocket"),
                    getped(player.player_id()),
                    true,
                    false,
                    250
                )
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Burn Gun
newfunc(
    "燃烧枪",
    "toggle",
    genweapons,
    function(feat)
        if feat.on then
            if ped.is_ped_shooting(getped(player.player_id())) then
                if entity.is_entity_a_ped(player.get_entity_player_is_aiming_at(getped(player.player_id()))) then
                    fire.start_entity_fire(player.get_entity_player_is_aiming_at(getped(player.player_id())))
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Vehicle Option
platespeedo = newfunc(
    "车牌时速表",
    "toggle",
    genvehicle,
    function(feat)
        if feat.on then
			if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
				vehicle.set_vehicle_number_plate_text(getveh(player.player_id()), math.ceil(entity.get_entity_speed(getveh(player.player_id())) * 3.6) .. "KM/H")
            end
			return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
unlockable = newfunc(
    "载具不可被导弹锁定",
    "toggle",
    genvehicle,
    function(feat)
        if feat.on then
			if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
				vehicle.set_vehicle_can_be_locked_on(getveh(player.player_id()), false, false)
            end
			return HANDLER_CONTINUE
		else
			if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
				vehicle.set_vehicle_can_be_locked_on(getveh(player.player_id()), true, false)
            end
			return HANDLER_POP
		end
    end
)
newfunc(
    "隐形车",
    "toggle",
    genvehicle,
    function(feat)
        if feat.on then
			if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
				entity.set_entity_alpha(getveh(player.player_id()), 0, false)
            end
			return HANDLER_CONTINUE
		else
			if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
				entity.set_entity_alpha(getveh(player.player_id()), 255, true)
            end
			return HANDLER_POP
		end
    end
)
--MKII
MKII = newfunc("充能/车载武器专区", "parent", genvehicle).id
mk2instacharge = newfunc(
    "MKII瞬间充能",
    "toggle",
    MKII,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                vehicle.set_vehicle_rocket_boost_refill_time(getveh(player.player_id()), 0.000001)
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
automissile = newfunc(
    "载具导弹连发",
    "toggle",
    MKII,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                vehicle.set_vehicle_fixed(getveh(player.player_id()))
                vehicle.set_vehicle_deformation_fixed(getveh(player.player_id()))
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
--RGB
rainbow = newfunc("彩虹色设置", "parent", genvehicle).id
rainbowlight =
    newfunc(
    "彩虹车灯颜色",
    "toggle",
    rainbow,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                vehicle.set_vehicle_headlight_color(getveh(player.player_id()), math.random(1, 200))
                CD(50)
            else
                rainbowlight.on = false
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
rainbowtire =
    newfunc(
    "彩虹烧胎烟雾",
    "toggle",
    rainbow,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                vehicle.set_vehicle_tire_smoke_color(
                    getveh(player.player_id()),
                    math.random(0, 255),
                    math.random(0, 255),
                    math.random(0, 255)
                )
                CD(50)
            else
                rainbowtire.on = false
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
rainbowneon =
    newfunc(
    "彩虹霓虹灯",
    "toggle",
    rainbow,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                for i = 1, 4 do
                    vehicle.set_vehicle_neon_light_enabled(getveh(player.player_id()), i, true)
                    vehicle.set_vehicle_neon_lights_color(getveh(player.player_id()), math.random(1, 200))
                    CD(50)
                end
            else
                rainbowneon.on = false
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
rainbowcolor =
    newfunc(
    "彩虹车漆",
    "toggle",
    rainbow,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
                vehicle.set_vehicle_color(
                    getveh(player.player_id()),
                    math.random(1, 78),
                    math.random(1, 78),
                    math.random(1, 78),
                    math.random(1, 78)
                )
                CD(50)
            else
                rainbowcolor.on = false
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Autopilot
autopilot = newfunc("自动驾驶", "parent", genvehicle).id
drive2waypoint =
    newfunc(
    "自动驾驶至标记点",
    "value_str",
    autopilot,
    function(feat)
        if feat.on then
            if ped.is_ped_in_any_vehicle(getped(player.player_id())) then
				local v2dest = ui.get_waypoint_coord()
				local v3dest = v3()
				v3dest.x, v3dest.y, v3dest.z = v2dest.x, v2dest.y, 10000
				local mepos = getcoords(player.player_id())
				local veh = getveh(player.player_id())
				local distance = math.sqrt((mepos.x - v3dest.x) ^ 2 + (mepos.y - v3dest.y) ^ 2 + (mepos.z - v3dest.z) ^ 2)
				if feat.value == 0 then
					ai.task_vehicle_drive_to_coord_longrange(getped(player.player_id()), getveh(player.player_id()),v3dest, autospd.value, 1 << 9 + 1 << 18 + 1 << 19, 0)
				elseif feat.value == 1 then
					ai.task_vehicle_drive_to_coord_longrange(getped(player.player_id()), getveh(player.player_id()),v3dest, autospd.value, 1 << 1 + 1 << 8 + 1 << 0, 0)
				end
			else
				feat.on = false
            end
			CD(250)
            return HANDLER_CONTINUE
        else
			local seat = 1
			for i = -1, vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(getveh(player.player_id()))) - 2 do
				if vehicle.get_ped_in_vehicle_seat(getveh(player.player_id()), i) == Ped then
					seat = i
				end
			end
			ped.clear_ped_tasks_immediately(getped(player.player_id()))
			ped.set_ped_into_vehicle(getped(player.player_id()), getveh(player.player_id()), seat)
            return HANDLER_POP
		end
    end
):set_str_data({
  "暴躁",
  "平缓"
})
autospd = newfunc("驾驶速度", "action_slider", autopilot, function(feat) end)
autospd.max = 200
autospd.min = 5
autospd.mod = 5
autospd.value = 50
--Transmission
transmission = newfunc("变速箱设置", "parent", genvehicle).id
setgearcount =
    newfunc(
    "设置载具档位数",
    "action_value_i",
    transmission,
    function(feat)
        if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
            vehicle.set_vehicle_max_gear(getveh(player.player_id()), feat.value)
        end
    end
)
setgearcount.min = 1
setgearcount.mod = 1
setgearcount.max = 8
setgearratio =
    newfunc(
    "设置载具变速箱齿比",
    "action_value_i",
    transmission,
    function(feat)
        if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
			local gearratio = getinput("输入"..feat.value.."挡齿比", vehicle.get_vehicle_gear_ratio(getveh(player.player_id()), feat.value), 32, 0)
            vehicle.set_vehicle_gear_ratio(getveh(player.player_id()), gearratio)
        end
    end
)
setgearratio.min = 1
setgearratio.mod = 1
setgearratio.max = 8
newfunc(
"升档",
"action",
transmission,
function(feat)
	if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
		if vehicle.get_vehicle_current_gear(getveh(player.player_id())) ~= vehicle.get_vehicle_max_gear(getveh(player.player_id())) then
			vehicle.set_vehicle_current_gear(getveh(player.player_id()), vehicle.get_vehicle_current_gear(getveh(player.player_id())) + 1)
		end
	end
end
)
newfunc(
"降档",
"action",
transmission,
function(feat)
	if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
		if vehicle.get_vehicle_current_gear(getveh(player.player_id())) ~= -1 then
			vehicle.set_vehicle_current_gear(getveh(player.player_id()), vehicle.get_vehicle_current_gear(getveh(player.player_id())) - 1)
		end
	end
end
)
--Car Meta
carmeta =
    newfunc(
    "车辆属性修改",
    "parent",
    genvehicle,
    function(feat)
    end
)
setmaxspd =
    newfunc(
    "设置载具最高时速",
    "action_value_i",
    carmeta.id,
    function(feat)
        if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
            entity.set_entity_max_speed(getveh(player.player_id()), feat.value)
            vehicle.modify_vehicle_top_speed(getveh(player.player_id()), feat.value)
        end
    end
)
setmaxspd.min = 0
setmaxspd.mod = 25
setmaxspd.max = 100000
setmaxtorque =
    newfunc(
    "设置发动机扭矩倍率",
    "action_value_f",
    carmeta.id,
    function(feat)
        if ped.is_ped_in_any_vehicle(getped(player.player_id())) == true then
            vehicle.set_vehicle_engine_torque_multiplier_this_frame(getveh(player.player_id()), feat.value)
        end
    end
)
setmaxtorque.min = 0
setmaxtorque.mod = 0.1
setmaxtorque.max = 100000

--Stat
--Unlock
arena = newfunc("竞技场选项", "parent", recovery).id
newfunc(
    "解锁冲冲猴旅行家",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 19)
        setstatint("ARENAWARS_AP", true, 209)
    end
)
newfunc(
    "解锁出租车",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 24)
        setstatint("ARENAWARS_AP", true, 280)
    end
)
newfunc(
    "解锁推土机",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 49)
        setstatint("ARENAWARS_AP", true, 530)
    end
)
newfunc(
    "解锁小丑花车",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 74)
        setstatint("ARENAWARS_AP", true, 780)
    end
)
newfunc(
    "解锁垃圾大王",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 99)
        setstatint("ARENAWARS_AP", true, 1030)
    end
)
newfunc(
    "解锁地霸王拖车",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 199)
        setstatint("ARENAWARS_AP", true, 2030)
    end
)
newfunc(
    "解锁混凝土搅拌车",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 299)
        setstatint("ARENAWARS_AP", true, 3030)
    end
)
newfunc(
    "解锁星际码头",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 499)
        setstatint("ARENAWARS_AP", true, 5030)
    end
)
newfunc(
    "解锁老实拖拉机",
    "action",
    arena,
    function()
        ui.notify_above_map("请开一把比赛以生效", "Arena War", 187)
        setstatint("ARENAWARS_AP_TIER", true, 999)
        setstatint("ARENAWARS_AP", true, 10030)
    end
)
unlockmisc = newfunc("其它解锁", "parent", recovery).id
newfunc(
    "解锁外星人纹身",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已解锁外星人纹身", "MISC UNLOCK", 187)
        setstatint("TATTOO_FM_CURRENT_32", true, 32768)
        setstatint("TATTOO_FM_CURRENT_32", true, 67108864)
    end
)
newfunc(
    "解锁全部游艇任务",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已解锁全部游艇任务", "MISC UNLOCK", 187)
        setstatint("YACHT_MISSION_PROG", true, 0)
        setstatint("YACHT_MISSION_FLOW", true, 21845)
        setstatint("CASINO_DECORATION_GIFT_1", true, -1)
    end
)
newfunc(
    "解锁老虎机限制",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已解锁老虎机限制", "MISC UNLOCK", 187)
        setstatint("MPPLY_CASINO_CHIPS_WON_GD", true, 0)
    end
)
newfunc(
    "办公室满地钱",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("请切换战局并进出货一次", "MISC UNLOCK", 187)
        setstatint("LIFETIME_CONTRA_EARNINGS", true, 20000000)
        setstatint("LIFETIME_BUY_UNDERTAKEN", true, 1000)
        setstatint("LIFETIME_BUY_COMPLETE", true, 1000)
        setstatint("LIFETIME_SELL_UNDERTAKEN", true, 1000)
        setstatint("LIFETIME_SELL_COMPLETE", true, 1000)
    end
)
newfunc(
    "完成全部改车铺任务",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已完成全部改车铺任务", "MISC UNLOCK", 187)
		for i = 1,7 do
			setstatint("TUNER_GEN_BS", true, 12543)
			setstatint("TUNER_CURRENT", true, i)
		end
    end
)
newfunc(
    "重置地堡收入",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已重置地堡收入", "MISC UNLOCK", 187)
        setstatint("LIFETIME_BKR_SELL_EARNINGS5", true, 0)
    end
)
newfunc(
    "重置载具销售计时",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已重置载具销售计时", "MISC UNLOCK", 187)
        setstatint("MPPLY_VEHICLE_SELL_TIME", true, 0)
        setstatint("MPPLY_NUM_CARS_SOLD_TODAY", true, 0)
    end
)
newfunc(
    "重置精神状态",
    "action",
    unlockmisc,
    function()
        ui.notify_above_map("已重置玩家精神状态", "MISC UNLOCK", 187)
        setstatfloat("PLAYER_MENTAL_STATE", true, 0.0)
    end
)
newfunc(
    "夜总会满人气",
    "toggle",
    unlockmisc,
    function(feat)
        if feat.on then
            if network.is_session_started() then
                setstatint("CLUB_POPULARITY", 0, 1000)
                CD(5)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)

--Troll Option
newfunc(
    "猴王",
    "action",
    troll,
    function()
        requestmodel(0xA8683715)
        requestmodel(0xC2D06F53)
        ped.create_ped(28, 0xA8683715, getcoords(player.player_id()), 72, true, false)
        ped.create_ped(28, 0xA8683715, getcoords(player.player_id()), 144, true, false)
        ped.create_ped(28, 0xA8683715, getcoords(player.player_id()), 216, true, false)
        ped.create_ped(28, 0xA8683715, getcoords(player.player_id()), 284, true, false)
        ped.create_ped(28, 0xA8683715, getcoords(player.player_id()), 0, true, false)
        modelchange(0xC2D06F53)
        streaming.set_model_as_no_longer_needed(0xA8683715)
        streaming.set_model_as_no_longer_needed(0xC2D06F53)
        gameplay.set_override_weather(14)
    end
)
newfunc(
    "一键瞎眼",
    "toggle",
    troll,
    function(feat)
		if feat.on then
			gameplay.set_override_weather(15)
			CD(1000)
			gameplay.set_override_weather(0)
			CD(1000)
			return HANDLER_CONTINUE
		else
			return HANDLER_POP
		end
    end
)
basemod = newfunc("2Take1Sense", "parent", troll).id
aamaster = newfunc(
    "Anti-Aim",
    "toggle",
    basemod,
    function(feat)
		if feat.on then
			ui.draw_rect(0.85, 0.025, 0.2, 0.025, 0, 0, 0, 120)
			ui.set_text_color(255, 255, 255, 255)
			ui.set_text_scale(0.25)
			ui.set_text_font(renderfont)
			ui.set_text_centre(true)
			ui.set_text_outline(true)
			local ostime = os.date("%H:%M:%S")
			ui.draw_text("Gamesense|"..player.get_player_name(player.player_id()).."|64tick|"..ostime, v2(0.85, 0.015))
			return HANDLER_CONTINUE
		else
			return HANDLER_POP
		end
    end
)
local peekdown = false
local peekpos = v3()
local peekheading = 0
autopeek = newfunc(
    "Auto-Peek",
    "toggle",
    basemod,
    function(feat)
		if feat.on then
			local key = MenuKey()
			key:push_str("LCONTROL")
			if key:is_down() then
				if peekdown == false then
					peekdown = true
					peekpos = getcoords(player.player_id())
					peekheading = entity.get_entity_heading(getped(player.player_id()))
				end
			end
			if key:is_down() == false then
				if peekdown == true then
					teleport(peekpos.x,peekpos.y,peekpos.z,peekheading)
					peekdown = false
				end
			end
			return HANDLER_CONTINUE
		else
			return HANDLER_POP
		end
    end
)
local currentheading = 0
local aaleftlimit = 15
local aarightlimit = 15
function updatespinheading()
	if currentheading < 360 then
		currentheading = currentheading + 20
	else
		currentheading = 0
	end
end
		
basedir = newfunc(
    "Base Direction",
    "value_str",
    basemod,
    function(feat)
		if feat.on then
			if aamaster.on then
				if feat.value == 0 then
					updatespinheading()
					entity.set_entity_heading(getped(player.player_id()),currentheading)
				elseif feat.value == 1 then
					entity.set_entity_heading(getped(player.player_id()),entity.get_entity_heading(getped(player.player_id())) + aaleftlimit)
					CD(10)
					entity.set_entity_heading(getped(player.player_id()),entity.get_entity_heading(getped(player.player_id())) - aarightlimit)
				end
				CD(0)
			end
			return HANDLER_CONTINUE
		else
			return HANDLER_POP
		end
    end
):set_str_data(
    {
        "Spin",
		"Jitter"
    }
)
aaleft = newfunc(
    "Left Limit",
    "slider",
    basemod,
    function(feat)
        if feat.on then
			aaleftlimit = feat.value
			return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
aaleft.max = 60
aaleft.min = 0
aaleft.mod = 1
aaleft.value = 15
aaright = newfunc(
    "Right Limit",
    "slider",
    basemod,
    function(feat)
        if feat.on then
			aarightlimit = feat.value
			return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
aaright.max = 60
aaright.min = 0
aaright.mod = 1
aaright.value = 15
fl = newfunc(
    "Fake-Lag",
    "slider",
    basemod,
    function(feat)
        if feat.on then
            local me = getped(player.player_id())
            local chp0
            chp0 = ped.get_ped_max_health(me)
            ped.set_ped_max_health(me, 0)
            local chp1
            chp1 = ped.get_ped_max_health(me)
            if chp1 ~= 0 then
                ped.set_ped_health(me, 0)
            else
            end
            CD(feat.value * 25)
            ped.set_ped_max_health(getped(player.player_id()), 328)
            ped.set_ped_health(getped(player.player_id()), 328)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
fl.max = 16
fl.min = 0
fl.mod = 1
fl.value = 5
dt = newfunc(
    "Double-Tap",
    "slider",
    basemod,
    function(feat)
        if feat.on then
            if ped.is_ped_shooting(getped(player.player_id())) then
				local success, v3_start = ped.get_ped_bone_coords(getped(player.player_id()), 0x67f2, v3())
				while not success do
					success, v3_start = ped.get_ped_bone_coords(getped(player.player_id()), 0x67f2, v3())
					CD(0)
				end
				local dir = cam.get_gameplay_cam_rot()
				dir:transformRotToDir()
				dir = dir * 1.5
				v3_start = v3_start + dir
				dir = nil
				local v3_end = getcoords(player.player_id())
				dir = cam.get_gameplay_cam_rot()
				dir:transformRotToDir()
				dir = dir * 1500
				v3_end = v3_end + dir
				gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, ped.get_current_ped_weapon(getped(player.player_id())), getped(player.player_id()), true, false, 1000)
				CD(100/feat.value)	
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
dt.max = 16
dt.min = 0
dt.mod = 1
dt.value = 8
dt = newfunc(
    "AA-Debugger",
    "toggle",
    basemod,
    function(feat)
        if feat.on then
			print(entity.get_entity_heading(getped(player.player_id())))
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Protex
local entiti = newfunc("实体防护", "parent", protex).id
mdlchgdetkt =
    newfunc(
    "模型切换检测",
    "toggle",
    protex,
    function(feat, pid)
        if feat.on then
            logg("[Protection] Model Change Detection Enabled")
            if network.is_session_started() then
                for pid = 0, 32 do
                    if pid ~= player.player_id() then
                        plped = player.get_player_model(pid)
                        local name = player.get_player_name(pid)
                        if player.is_player_female(pid) and plped ~= 2627665880 then
                            player.set_player_as_modder(pid, 1 << 0x01)
                            logg("[Protection] Player:" .. name .. " has been marked as modder. Reason: Model Change")
                        end
                        if not player.is_player_female(pid) and plped ~= 1885233650 then
                            player.set_player_as_modder(pid, 1 << 0x01)
                            logg("[Protection] Player:" .. name .. " has been marked as modder. Reason: Model Change")
                        end
                    end
                    return HANDLER_CONTINUE
                end
            end
        else
            logg("[Protection] Model Change Detection Disabled")
            return HANDLER_POP
        end
    end
)
spectatedetkt =
    newfunc(
    "观看玩家检测",
    "toggle",
    protex,
    function(feat, pid)
        if feat.on then
            for pid = 0, 32 do
                if pid ~= player.player_id() then
                    if player.is_player_spectating(pid) then
                        local spectatedplayer = player.get_player_player_is_spectating(pid)
                        local pname = player.get_player_name(pid)
                        local prid = player.get_player_scid(pid)
                        local spectatedplayername = player.get_player_name(spectatedplayer)
                        if spectatedplayer == player.player_id() then
                            logg("[Protection] Player " .. pname .. " is spectating you. RID:" .. prid)
                            NOTG("玩家" .. pname .. "正在观看你")
                        else
                            logg("[Protection] Player " .. pname .. " is spectating player" .. spectatedplayername)
                            NOTG("玩家" .. pname .. "正在观看玩家" .. spectatedplayername)
                        end
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
karmavotekick =
    newfunc(
    "反弹投票踢",
    "toggle",
    protex,
    function(feat, pid)
        if feat.on then
			vk = hook.register_net_event_hook(function(source, target, eventid)
				if eventid == 64 and player.is_player_valid(pid) and target == player.player_id() then
					kickplayer(source)
				end
			end)
        else
            hook.remove_net_event_hook(vk)
        end
    end
)
karmafreeze =
    newfunc(
    "反弹冻结",
    "toggle",
    protex,
    function(feat, pid)
        if feat.on then
			ct = hook.register_net_event_hook(function(source, target, eventid)
				if eventid == 43 and player.is_player_valid(pid) and target == player.player_id() then
					cleartask(getped(source))
				end
			end)
        else
            hook.remove_net_event_hook(ct)
        end
    end
)
removeallptfx =
    newfunc(
    "移除全部粒子特效",
    "toggle",
    protex,
    function(feat, pid)
        if feat.on then
			graphics.remove_ptfx_in_range(getcoords(player.player_id()),10000)
        end
    end
)
customentityblocker =
    newfunc(
    "自定义实体防护",
    "action_value_str",
    entiti,
    function(feat)
        local entname = getinput("输入实体代码", "", 32, 0)
		local enthash = joaat(entname)
        if streaming.is_model_valid(enthash) then
			if feat.value == 0 then
				if streaming.is_model_a_ped(enthash) then
					newfunc(
						entname,
						"toggle",
						entiti,
						function(feat)
							if feat.on then
								for i = 1,#ped.get_all_peds() do
									if entity.get_entity_model_hash(ped.get_all_peds()[i]) == enthash then
										network.request_control_of_entity(ped.get_all_peds()[i])
										entity.delete_entity(ped.get_all_peds()[i])
									end
									CD(5)
								end
								return HANDLER_CONTINUE
							else
								return HANDLER_POP
							end
						end
					)
				else
					NOTG("此哈希值不是NPC", "Entity Blocker")
				end
			elseif feat.value == 1 then
				if streaming.is_model_a_vehicle(enthash) then
					newfunc(
						entname,
						"toggle",
						entiti,
						function(feat)
							if feat.on then
								for i = 1,#vehicle.get_all_vehicles() do
									if entity.get_entity_model_hash(vehicle.get_all_vehicles()[i]) == enthash then
										network.request_control_of_entity(vehicle.get_all_vehicles()[i])
										entity.delete_entity(vehicle.get_all_vehicles()[i])
									end
									CD(5)
								end
								return HANDLER_CONTINUE
							else
								return HANDLER_POP
							end
						end
					)
				else
					NOTG("此哈希值不是载具", "Entity Blocker")
				end
			elseif feat.value == 2 then
				if streaming.is_model_an_object(enthash) then
					newfunc(
						entname,
						"toggle",
						entiti,
						function(feat)
							if feat.on then
								for i = 1,#object.get_all_objects() do
									if entity.get_entity_model_hash(object.get_all_objects()[i]) == enthash then
										network.request_control_of_entity(object.get_all_objects()[i])
										entity.delete_entity(object.get_all_objects()[i])
									end
									CD(5)
								end
								return HANDLER_CONTINUE
							else
								return HANDLER_POP
							end
						end
					)
				else
					NOTG("此哈希值不是物体", "Entity Blocker")
				end
			elseif feat.value == 3 then
				if streaming.is_model_an_object(enthash) then
					newfunc(
						entname,
						"toggle",
						entiti,
						function(feat)
							if feat.on then
								for i = 1,#object.get_all_pickups() do
									if entity.get_entity_model_hash(object.get_all_pickups()[i]) == enthash then
										network.request_control_of_entity(object.get_all_pickups()[i])
										entity.delete_entity(object.get_all_pickups()[i])
									end
									CD(5)
								end
								return HANDLER_CONTINUE
							else
								return HANDLER_POP
							end
						end
					)
				else
					NOTG("此哈希值不是可拾取物", "Entity Blocker")
				end
			end
		else
			NOTG("哈希不正确", "Entity Blocker")
		end
		
    end
):set_str_data(
    {
        "NPC",
        "载具",
		"物体",
		"可拾取物"
    }
)
newfunc(
    "防崩溃镜头",
    "toggle",
    entiti,
    function(feat)
        if feat.on then
            NOTG("现在已拦截一切实体崩溃", "Anti-Crash Cam")
            logg("[Protection] ANTI-CRASH CAM TRIGGERED")
            teleport(-2180, -5197, 10000, 0)
			while feat.on do
				entity.freeze_entity(getped(player.player_id()), true)
				CD(500)
				teleport(2180, -5197, 10800, 0)
			end
        else
            teleport(130.130, -1300.266, 29.228, 0)
            entity.freeze_entity(getped(player.player_id()), false)
            NOTG("防崩溃镜头已关闭", "Anti-Crash Cam")
            logg("[Protection] ANTI-CRASH CAM DISARMED")
        end
    end
)
blknpc =
    newfunc(
    "设置区域内NPC数量上限",
    "value_i",
    entiti,
    function(feat)
        if feat.on then
            NOTG("当区域内NPC数量到达" .. feat.value .. "时，将自动屏蔽附近NPC")
            logg("[Protection] AUTO_BLOCK_NPC ENABLED")
            while #ped.get_all_peds() >= feat.value do
                logg("[Protection] NPC AMOUNT REACHED TARGETTED LIMIT, ENABLING NPC BLOCK")
                lclearped()
                return HANDLER_CONTINUE
            end
            while #ped.get_all_peds() < feat.value do
                return HANDLER_POP
            end
        else
            NOTG("NPC数量上限已关闭")
            logg("[Protection] AUTO_BLOCK_NPC DISABLED")
        end
    end
)
blknpc.min = 0
blkveh =
    newfunc(
    "设置区域内载具数量上限",
    "value_i",
    entiti,
    function(feat)
        if feat.on then
            NOTG("当区域内载具数量到达" .. feat.value .. "时，将自动屏蔽附近载具")
            logg("[Protection] AUTO_BLOCK_VEHICLE ENABLED")
            while #vehicle.get_all_vehicles() >= feat.value do
                logg("[Protection] VEHICLE AMOUNT REACHED TARGETTED LIMIT, ENABLING VEHICLE BLOCK")
                lclearveh()
                return HANDLER_CONTINUE
            end
            while #vehicle.get_all_vehicles() < feat.value do
                return HANDLER_POP
            end
        else
            NOTG("载具数量上限已关闭")
            logg("[Protection] AUTO_BLOCK_VEHICLE DISABLED")
        end
    end
)
blkveh.min = 0
blkobj =
    newfunc(
    "设置区域内物体数量上限",
    "value_i",
    entiti,
    function(feat)
        if feat.on then
            NOTG("当区域内物体数量到达" .. feat.value .. "时，将自动屏蔽附近物体")
            logg("[Protection] AUTO_BLOCK_OBJECT ENABLED")
            while #object.get_all_objects() >= feat.value do
                logg("[Protection] VEHICLE AMOUNT REACHED TARGETTED LIMIT, ENABLING OBJECT BLOCK")
                lclearobj()
                return HANDLER_CONTINUE
            end
            while #vehicle.get_all_objects() < feat.value do
                return HANDLER_POP
            end
        else
            NOTG("物体数量上限已关闭")
            logg("[Protection] AUTO_BLOCK_OBJECT DISABLED")
        end
    end
)
blkobj.min = 0
newfunc(
    "防护钱袋拾取",
    "toggle",
    entiti,
    function(feat)
        if feat.on then
            local hash = joaat("p_poly_bag_01_s")
            local pickups = object.get_all_pickups()
            for i = 1, #object.get_all_pickups() do
                if entity.get_entity_model_hash(pickups[i]) == hash then
                    logg("[Protection] Money bag model detected, now deleting automatically.")
                    NOTG("检测到钱袋掉落,自动删除中")
                    network.request_control_of_entity(pickups[i])
                    entity.set_entity_coords_no_offset(pickups[i], 0, 0, 0)
                    entity.set_entity_as_no_longer_needed(pickups[i])
                    entity.delete_entity(pickups[i])
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--World Option
--Weather/Time
wt = newfunc("天气/时间", "parent", world).id
newfunc(
    "同步系统时间",
    "toggle",
    wt,
    function(feat)
        if feat.on then
            local osh, osm, oss = os.date("%H"), os.date("%M"), os.date("%S")
            time.set_clock_time(osh, osm, oss)
            CD(0)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "随机时间",
    "toggle",
    wt,
    function(feat)
        if feat.on then
            time.set_clock_time(math.random(0, 24), math.random(0, 60), math.random(0, 60))
            CD(5)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "随机天气",
    "toggle",
    wt,
    function(feat)
        if feat.on then
            gameplay.set_override_weather(math.random(1, 13))
            CD(5)
            return HANDLER_CONTINUE
        else
            gameplay.clear_override_weather()
            return HANDLER_POP
        end
    end
)
--Traffic
traffic = newfunc("周围载具", "parent", world).id
newfunc(
    "周围载具无敌",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #vehicle.get_all_vehicles() do
                entity.set_entity_god_mode(vehicle.get_all_vehicles()[i], true)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "修复周围载具",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #vehicle.get_all_vehicles() do
                vehicle.set_vehicle_fixed(vehicle.get_all_vehicles()[i])
                vehicle.set_vehicle_deformation_fixed(vehicle.get_all_vehicles()[i])
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "周围载具彩虹色",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #vehicle.get_all_vehicles() do
                vehicle.set_vehicle_color(
                    vehicle.get_all_vehicles()[i],
                    math.random(1, 78),
                    math.random(1, 78),
                    math.random(1, 78),
                    math.random(1, 78)
                )
            end
            CD(50)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "周围载具无重力",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #vehicle.get_all_vehicles() do
                entity.set_entity_gravity(vehicle.get_all_vehicles()[i], 0.00)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "周围载具对你有敌意",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #ped.get_all_peds() do
                if ped.is_ped_in_any_vehicle(ped.get_all_peds()[i]) then
                    ai.task_combat_ped(ped.get_all_peds()[i], getped(player.player_id()), 0, 16)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "关闭载具引擎",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            for i = 1, #vehicle.get_all_vehicles() do
                if player.is_player_in_any_vehicle(player.player_id()) then
                    vehicle.set_vehicle_engine_on(vehicle.get_all_vehicles()[i], false, false, true)
                    vehicle.set_vehicle_engine_on(getveh(player.player_id()), true, true, false)
                else
                    vehicle.set_vehicle_engine_on(vehicle.get_all_vehicles()[i], false, false, true)
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "删除周围载具",
    "toggle",
    traffic,
    function(feat)
        if feat.on then
            gameplay.clear_area_of_vehicles(getcoords(player.player_id()), 10000, false, false, false, false, false)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
vehdensity = newfunc(
    "车流量",
    "slider",
    traffic,
    function(feat, pid)
        if feat.on then
            vehicle.set_ambient_vehicle_range_multiplier_this_frame(feat.value)
        end
    end
)
vehdensity.max = 1.49
vehdensity.min = 0.00
vehdensity.mod = 0.05
vehdensity.value = 1.00
vehparkeddensity = newfunc(
    "停车场中车辆",
    "slider",
    traffic,
    function(feat, pid)
        if feat.on then
            vehicle.set_parked_vehicle_density_multiplier_this_frame(feat.value)
        end
    end
)
vehparkeddensity.max = 1.49
vehparkeddensity.min = 0.00
vehparkeddensity.mod = 0.05
vehparkeddensity.value = 1.00
--Pedestrian
pedestrian = newfunc("周围NPC", "parent", world).id
newfunc(
    "周围NPC无敌",
    "toggle",
    pedestrian,
    function(feat)
        if feat.on then
            for i = 1, #ped.get_all_peds() do
                ped.set_ped_health(ped.get_all_peds()[i], ped.get_ped_max_health(ped.get_all_peds()[i]))
                if ped.get_ped_health(ped.get_all_peds()[i]) == 0 then
                    ped.resurrect_ped(ped.get_all_peds()[i])
                    ped.set_ped_health(ped.get_all_peds()[i], ped.get_ped_max_health(ped.get_all_peds()[i]))
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "冻结周围NPC",
    "toggle",
    pedestrian,
    function(feat, pid)
        if feat.on then
            for i = 1, #ped.get_all_peds() do
                for pid = 0, 32 do
                    if ped.get_all_peds()[i] == getped(pid) then
                        break
                    else
                        entity.freeze_entity(ped.get_all_peds()[i], true)
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            for i = 1, #ped.get_all_peds() do
                entity.freeze_entity(ped.get_all_peds()[i], false)
            end
            return HANDLER_POP
        end
    end
)
newfunc(
    "杀死周围NPC",
    "toggle",
    pedestrian,
    function(feat, pid)
        if feat.on then
            for i = 1, #ped.get_all_peds() do
                for pid = 0, 32 do
                    if ped.get_all_peds()[i] == getped(pid) then
                        break
                    else
                        ped.set_ped_health(ped.get_all_peds()[i], 0)
                    end
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "NPC对你有敌意",
    "toggle",
    pedestrian,
    function(feat, pid)
        if feat.on then
            for i = 1, #ped.get_all_peds() do
                ai.task_combat_ped(ped.get_all_peds()[i], getped(player.player_id()), 0, 16)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "复活周围NPC",
    "action",
    pedestrian,
    function(feat, pid)
        for i = 1, #ped.get_all_peds() do
            if ped.get_ped_health(ped.get_all_peds()[i]) == 0 then
                ped.resurrect_ped(ped.get_all_peds()[i])
                ped.set_ped_health(ped.get_all_peds()[i], ped.get_ped_max_health(ped.get_all_peds()[i]))
            end
        end
    end
)
newfunc(
    "克隆周围NPC",
    "action",
    pedestrian,
    function(feat, pid)
        for i = 1, #ped.get_all_peds() do
            ped.clone_ped(ped.get_all_peds()[i])
        end
    end
)
newfunc(
    "删除周围NPC",
    "toggle",
    pedestrian,
    function(feat, pid)
        if feat.on then
            gameplay.clear_area_of_peds(mepos, 10000, true)
        end
    end
)
npcdensity = newfunc(
    "NPC密度",
    "slider",
    pedestrian,
    function(feat, pid)
        if feat.on then
            ped.set_ped_density_multiplier_this_frame(feat.value)
        end
    end
)
npcdensity.max = 1.49
npcdensity.min = 0.00
npcdensity.mod = 0.05
npcdensity.value = 1.00
--Entity
nearbyentity = newfunc("周围实体", "parent", world).id
newfunc(
    "删除周围物体",
    "toggle",
    nearbyentity,
    function(feat, pid)
        if feat.on then
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 0)
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 1)
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 2)
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 6)
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 16)
            gameplay.clear_area_of_objects(getcoords(player.player_id()), 10000, 17)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)

--Misc Option
lobbyinfo = newfunc(
    "战局简略信息框",
    "toggle",
    misc,
    function(feat)
        resolutionratio = string.format("%.1f", graphics.get_screen_width() / graphics.get_screen_height())
        if resolutionratio == "1.8" then
            resolutionratio = "16:9"
        end
        if feat.on then
            if rainbowall.on then
                ui.draw_rect(0.95, 0.2, 0.18, 0.15, rainbowr, rainbowg, rainbowb, 135)
            else
                ui.draw_rect(0.95, 0.2, 0.18, 0.15, 30, 144, 255, 135)
            end
            if resolutionratio == "16:9" then
                local pos = v2()
                pos.x = 0.83
                pos.y = 0.32
                local txtpos = v2()
                local host = player.get_host()
                local pname = player.get_player_name(host)
                txtpos.x = 0.875
                txtpos.y = 0.135
                ui.set_text_color(255, 255, 255, 255)
                ui.set_text_scale(renderfontsize + 0.15)
                ui.set_text_font(renderfont)
                ui.set_text_centre(false)
                ui.set_text_outline(false)
                ui.draw_text("LEGIT SCRIPT", txtpos)
                txtpos.x = txtpos.x - 0.01
                txtpos.y = txtpos.y + 0.04
                ui.set_text_scale(renderfontsize)
                ui.draw_text("当前脚本版本 V1.0.9 Public", txtpos)
                txtpos.y = txtpos.y + 0.03
                ui.set_text_scale(renderfontsize)
                if network.is_session_started() then
                    ui.draw_text("当前战局主机: " .. pname, txtpos)
                    txtpos.y = txtpos.y + 0.03
                    ui.set_text_scale(renderfontsize)
                    ui.draw_text("战局玩家人数 " .. player.player_count() .. "/32", txtpos)
                end
                if not network.is_session_started() then
                    ui.draw_text("你现在不在GTA在线模式", txtpos)
                end
                return HANDLER_CONTINUE
            else
                local pos = v2()
                pos.x = 0.83
                pos.y = 0.32
                local txtpos = v2()
                local host = player.get_host()
                local pname = player.get_player_name(host)
                txtpos.x = 0.89
                txtpos.y = 0.135
                ui.set_text_color(255, 255, 255, 255)
                ui.set_text_scale(renderfontsize + 0.15)
                ui.set_text_font(renderfont)
                ui.set_text_centre(false)
                ui.set_text_outline(false)
                ui.draw_text("LEGIT SCRIPT", txtpos)
                txtpos.x = txtpos.x - 0.01
                txtpos.y = txtpos.y + 0.04
                ui.set_text_scale(renderfontsize)
                ui.draw_text("当前脚本版本 V1.0.9 Public", txtpos)
                txtpos.y = txtpos.y + 0.03
                ui.set_text_scale(renderfontsize)
                if network.is_session_started() then
                    ui.draw_text("当前战局主机: " .. pname, txtpos)
                    txtpos.y = txtpos.y + 0.03
                    ui.set_text_scale(renderfontsize)
                    ui.draw_text("战局玩家人数 " .. player.player_count() .. "/32", txtpos)
                end
                if not network.is_session_started() then
                    ui.draw_text("你现在不在GTA在线模式", txtpos)
                end
                return HANDLER_CONTINUE
            end
        else
            return HANDLER_POP
        end
    end
)
MDF_MANUAL                  = 1 << 0x00
MDF_PLAYER_MODEL            = 1 << 0x01
MDF_SCID_SPOOF              = 1 << 0x02
MDF_INVALID_OBJECT_CRASH    = 1 << 0x03
MDF_INVALID_PED_CRASH       = 1 << 0x04
MDF_MODEL_CHANGE_CRASH      = 1 << 0x05
MDF_PLAYER_MODEL_CHANGE     = 1 << 0x06
MDF_RAC                     = 1 << 0x07
MDF_MONEY_DROP              = 1 << 0x08
MDF_SEP                     = 1 << 0x09
MDF_ATTACH_OBJECT           = 1 << 0x0A
MDF_ATTACH_PED              = 1 << 0x0B
MDF_NET_ARRAY_CRASH         = 1 << 0x0C
MDF_SYNC_CRASH              = 1 << 0x0D
MDF_NET_EVENT_CRASH         = 1 << 0x0E
MDF_HOST_TOKEN              = 1 << 0x0F
MDF_SE_SPAM                 = 1 << 0x10
MDF_INVALID_VEHICLE         = 1 << 0x11
MDF_FRAME_FLAGS             = 1 << 0x12
MDF_ENDS                    = 1 << 0x13
playerinfo = newfunc(
    "战局玩家信息",
    "value_str",
    misc,
    function(feat)
        if feat.on then
			if feat.value == 0 then
				if rainbowall.on then
					ui.draw_rect(0.001, 0.02, 2.5, 0.065, rainbowr, rainbowg, rainbowb, 150)
				else
					ui.draw_rect(0.001, 0.02, 2.5, 0.065, 40, 40, 40, 150)
				end
				local pos = v2()
				pos.x = 0.0001
				pos.y = 0.000001
				for i = 0, 32 do
					if getped(i) ~= 0 then
						local name = player.get_player_name(i)
						ui.set_text_color(255, 255, 255, 255)
						if player.is_player_host(i) then
							ui.set_text_color(220, 185, 75, 255)
						end
						if i == script.get_host_of_this_script() then
							ui.set_text_color(220, 185, 75, 255)
						end
						if player.is_player_modder(i, -1) then
							ui.set_text_color(202, 51, 51, 255)
						end
						if player.is_player_friend(i) then
							ui.set_text_color(112, 198, 112, 255)
						end
						if pos.x > 0.95 then
							pos.y = 0.025
							pos.x = 0.0001
						else
						end
						ui.set_text_scale(renderfontsize)
						ui.set_text_font(renderfont)
						ui.set_text_centre(false)
						ui.set_text_outline(false)
						ui.draw_text(" " .. name .. " ", pos)
						pos.x = pos.x + 0.075
					end
				end
			else
				local pos = v2()
				pos.x = 0.01
				pos.y = 0.1
				for i = 0, 32 do
					if getped(i) ~= 0 then
						local name = player.get_player_name(i)
						ui.set_text_color(255, 255, 255, 255)
						if player.is_player_host(i) then
							ui.set_text_color(220, 185, 75, 255)
							name = name .. "[主机]"
						end
						if i == script.get_host_of_this_script() then
							ui.set_text_color(220, 185, 75, 255)
							name = name .. "[脚本主机]"
						end
						if player.is_player_modder(i, MDF_PLAYER_MODEL) or player.is_player_modder(i, MDF_PLAYER_MODEL_CHANGE) then
							ui.set_text_color(202, 51, 51, 255)
							name = name .. "[模型切换]"
						end
						if player.is_player_modder(i, MDF_SCID_SPOOF) then
							ui.set_text_color(202, 51, 51, 255)
							name = name .. "[虚假RID]"
						end
						if player.is_player_modder(i, MDF_INVALID_OBJECT_CRASH) or player.is_player_modder(i, MDF_INVALID_PED_CRASH) or player.is_player_modder(i, MDF_MODEL_CHANGE_CRASH) or player.is_player_modder(i, MDF_NET_ARRAY_CRASH) or player.is_player_modder(i, MDF_SYNC_CRASH) or player.is_player_modder(i, MDF_NET_EVENT_CRASH) then
							ui.set_text_color(202, 51, 51, 255)
							name = name .. "[崩溃尝试]"
						end
						if player.is_player_friend(i) then
							ui.set_text_color(112, 198, 112, 255)
							name = name .. "[好友]"
						end
						if pos.x > 0.95 then
							pos.y = 0.025
							pos.x = 0.0001
						else
						end
						ui.set_text_scale(renderfontsize)
						ui.set_text_font(renderfont)
						ui.set_text_centre(false)
						ui.set_text_outline(false)
						ui.draw_text(" " .. name .. " ", pos)
						pos.y = pos.y + 0.025
					end
				end
			end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
):set_str_data(
    {
        "顶部",
        "屏幕中央"
    }
)
--Speedo
speedo = newfunc(
    "玩家时速表",
    "toggle",
    misc,
    function(feat)
        if feat.on then
            local pos = v2()
            pos.x = 0.9
            pos.y = 0.02
			local ent
			local ent1 = getped(player.player_id())	
			local ent2 = getveh(player.player_id())	
            if ped.is_ped_in_any_vehicle(ent1) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = entity.get_entity_speed(ent)
            local speedcalc = speed * 3.6
            myspeed1 = math.ceil(speedcalc)
            ui.set_text_scale(0.5)
            ui.set_text_font(renderfont)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_centre(false)
            ui.set_text_outline(false)
            ui.draw_text(myspeed1 .. " 千米/时\n", pos)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newfunc(
    "卡单人战局",
    "action",
    misc,
    function(feat)
        local time = utils.time_ms() + 10000
        while time > utils.time_ms() do
        end
    end
)
newfunc(
    "自崩",
    "action",
    misc,
    function(feat)
        player.set_player_model(0)
    end
)

--Player Option
--Friendly
selectedplayerfriendly = newplfunc("友好选项", "parent", plmain.id).id
--Add 10k CEO Cash
newplfunc(
    "给予10K CEO金钱",
    "toggle",
    selectedplayerfriendly,
    function(feat, pid)
        if feat.on then
            TSE(
                1152266822,
                pid,
                {
                    player.player_id(),
                    10000,
                    -1292453789,
                    1,
                    script.get_global_i(1630816 + (1 + (pid * 597) + 508)),
                    script.get_global_i(1658176 + 9),
                    script.get_global_i(1658176 + 10)
                }
            )
            CD(1200)
            TSE(
                1152266822,
                pid,
                {
                    player.player_id(),
                    10000,
                    -1292453789,
                    0,
                    script.get_global_i(1630816 + (1 + (pid * 597) + 508)),
                    script.get_global_i(1658176 + 9),
                    script.get_global_i(1658176 + 10)
                }
            )
            CD(1200)
            CD(31000)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Remove Wanted Level
newplfunc(
    "清除通缉等级",
    "toggle",
    selectedplayerfriendly,
    function(feat, pid)
        TSE(1187364773, pid, {pid, script.get_global_i(1628955 + (1 + (pid * 614)) + 532)})
    end
)
--Give OTR
newplfunc(
    "给予雷达匿踪",
    "toggle",
    selectedplayerfriendly,
    function(feat, pid)
        TSE(
            -397188359,
            pid,
            {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630816 + (1 + (pid * 597) + 508))}
        )
    end
)
--Give Semi-God
newplfunc(
    "给予半无敌",
    "action",
    selectedplayerfriendly,
    function(feat, pid)
        local pos = getcoords(pid)
        pos.x = pos.x + 5
        requestmodel(0x8DA1C0E)
        ball = object.create_object(0x8DA1C0E, pos, true, false)
        entity.set_entity_god_mode(ball, true)
        entity.attach_entity_to_entity(
            ball,
            getped(pid),
            ped.get_ped_bone_index(getped(pid), 11816),
            v3(),
            v3(),
            true,
            true,
            false,
            0,
            false
        )
        entity.set_entity_visible(ball, false)
    end
)
--Give All Weapons
newplfunc(
    "给予全部武器",
    "action",
    selectedplayerfriendly,
    function(feat, pid)
        local allweaponhashes = weapon.get_all_weapon_hashes()
        for i = 1, #allweaponhashes do
            requestmodel(allweaponhashes[i])
            weapon.give_delayed_weapon_to_ped(getped(pid), allweaponhashes[i], 0, 0)
            streaming.set_model_as_no_longer_needed(allweaponhashes[i])
        end
    end
)

--Trolling
selectedplayertroll = newplfunc("恶搞选项", "parent", plmain.id).id
--Teleport
newplfunc(
    "传送至",
    "action_value_str",
    selectedplayertroll,
    function(feat)
        if feat.value == 0 then
            TSE(-1479371259, pid, {1300962917})
        elseif feat.value == 1 then
            TSE(545396442, pid, {0})
        elseif feat.value == 2 then
            network.request_control_of_entity(getped(pid))
            local pos = ui.get_waypoint_coord()
            local pos = v3(pos.x, pos.y, 10000)
            if ped.is_ped_in_any_vehicle(getped(pid)) then
                network.request_control_of_entity(getveh(pid))
                entity.set_entity_coords_no_offset(getveh(pid), pos)
				vehicle.set_vehicle_on_ground_properly(getveh(pid))
            else
                entity.set_entity_coords_no_offset(getped(pid), pos)
            end
        elseif feat.value == 3 then
            network.request_control_of_entity(getped(pid))
            local pos = getcoords(player.player_id())
            pos.z = 10000
            if ped.is_ped_in_any_vehicle(getped(pid)) then
                network.request_control_of_entity(getveh(pid))
                entity.set_entity_coords_no_offset(getveh(pid), pos)
				vehicle.set_vehicle_on_ground_properly(getveh(pid))
            else
                entity.set_entity_coords_no_offset(getped(pid), pos)
            end
        end
    end
):set_str_data(
    {
        "佩里科岛",
        "任务",
        "标记点",
        "身边"
    }
)
--CEO
newplfunc(
    "CEO",
    "action_value_str",
    selectedplayertroll,
    function(feat)
        if feat.value == 0 then
            TSE(0x50c72ec2, pid, {0, 1, 5, 0})
        elseif feat.value == 1 then
            TSE(0xed1bc159, pid, {0, 1, 5})
        elseif feat.value == 2 then
            TSE(0xed1bc159, pid, {1, 1, 6})
            TSE(0xed1bc159, pid, {0, 1, 6, 0})
        end
    end
):set_str_data(
    {
        "禁用",
        "解散",
        "终结"
    }
)
--Set Bounty
selectedplayerbounty = newplfunc("悬赏选项", "parent", selectedplayertroll).id
--Anon Bounty
anonbountyselected =
    newplfunc(
    "匿名悬赏",
    "toggle",
    selectedplayerbounty,
    function(feat)
    end
)
--Normal Bounty
custombountyselected =
    newplfunc(
    "自定义悬赏",
    "action_value_i",
    selectedplayerbounty,
    function(feat, pid)
		if anonbountyselected.on then
			TSE(
				0xf90cc891,
				pid,
				{
					-1,
					pid,
					1,
					feat_value,
					0,
					1,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					script.get_global_i(1658176 + 9),
					script.get_global_i(1658176 + 10)
				}
			)
		else
			TSE(
				0xf90cc891,
				pid,
				{
					-1,
					pid,
					1,
					feat_value,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					script.get_global_i(1658176 + 9),
					script.get_global_i(1658176 + 10)
				}
			)
		end
	end
)
custombountyselected.min = 0
custombountyselected.mod = 500
custombountyselected.max = 10000
--Cage
selectedplayercage = newplfunc("囚禁选项", "parent", selectedplayertroll).id
--Stunt Tube
newplfunc(
    "竞速管",
    "action",
    selectedplayercage,
    function(feat, pid)
        local pos = getcoords(pid)
        pos.z = pos.z - 5
        requestmodel(1125864094)
        tube = object.create_object(1125864094, pos, true, false)
        entity.set_entity_rotation(tube, v3(0, 90, 0))
        streaming.set_model_as_no_longer_needed(1125864094)
    end
)
--Traditional
newplfunc(
    "笼子",
    "action",
    selectedplayercage,
    function(feat, pid)
        local pos = getcoords(pid)
        pos.z = pos.z - 5
        requestmodel(gameplay.get_hash_key("prop_test_elevator"))
        cage = object.create_object(gameplay.get_hash_key("prop_test_elevator"), pos, true, false)
        entity.set_entity_rotation(cage, v3(0, 90, 0))
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("prop_test_elevator"))
    end
)
--Attachments
selectedplayerattach = newplfunc("附加选项", "parent", selectedplayertroll).id
--Customize
customattachselected =
    newplfunc(
    "附加自定义实体",
    "action",
    selectedplayertroll,
    function(feat)
        local entname = getinput("输入实体代码", "", 32, 0)
        if streaming.is_model_valid(joaat(entname)) then
            requestmodel(gameplay.get_hash_key(entname))
            obj = object.create_object(joaat(entname), v3(), true, false)
            entity.attach_entity_to_entity(
                obj,
                getped(pid),
                ped.get_ped_bone_index(getped(pid), 11816),
                v3(),
                v3(0.0, 0.0, 10.0),
                true,
                true,
                false,
                0,
                false
            )
            streaming.set_model_as_no_longer_needed(joaat(entname))
        else
            logg("[ERROR] Model Invalid!")
            NOTG("无效模型", "错误")
        end
    end
)
--Traditional
newplfunc(
    "附加篝火",
    "action",
    selectedplayerattach,
    function(feat, pid)
        requestmodel(3229200997)
        bf = object.create_object(3229200997, v3(), true, false)
        entity.attach_entity_to_entity(
            bf,
            getped(pid),
            ped.get_ped_bone_index(getped(pid), 11816),
            v3(),
            v3(0.0, 0.0, 10.0),
            true,
            true,
            false,
            0,
            false
        )
        streaming.set_model_as_no_longer_needed(3229200997)
    end
)
newplfunc(
    "附加UFO",
    "action",
    selectedplayerattach,
    function(feat, pid)
        requestmodel(gameplay.get_hash_key("p_spinning_anus_s"))
        ufo = object.create_object(gameplay.get_hash_key("p_spinning_anus_s"), v3(), true, false)
        entity.attach_entity_to_entity(
            ufo,
            getped(pid),
            ped.get_ped_bone_index(getped(pid), 11816),
            v3(),
            v3(0.0, 0.0, 0),
            true,
            true,
            false,
            0,
            false
        )
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("p_spinning_anus_s"))
    end
)
newplfunc(
    "附加JB",
    "action",
    selectedplayerattach,
    function(feat, pid)
        requestmodel(gameplay.get_hash_key("prop_cs_dildo_01"))
        DICK = object.create_object(gameplay.get_hash_key("prop_cs_dildo_01"), v3(), true, false)
        entity.attach_entity_to_entity(
            DICK,
            getped(pid),
            ped.get_ped_bone_index(getped(pid), 11816),
            v3(),
            v3(0.0, 0.0, 0),
            true,
            true,
            false,
            0,
            false
        )
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("prop_cs_dildo_01"))
    end
)
newplfunc(
    "附加火柱",
    "toggle",
    selectedplayerattach,
    function(feat, pid)
        if feat.on then
            fire.add_explosion(getcoords(pid), 12, true, false, 0, getped(pid))
            CD(10)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newplfunc(
    "附加水柱",
    "toggle",
    selectedplayerattach,
    function(feat, pid)
        if feat.on then
            fire.add_explosion(getcoords(pid), 13, true, false, 0, getped(pid))
            CD(10)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Moneybag
newplfunc(
    "掉落假钱袋",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if feat.on then
            object.create_object(gameplay.get_hash_key("p_poly_bag_01_s"), getcoords(pid), true, true)
            CD(50)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Remove Weapon
newplfunc(
    "移除全部武器",
    "action",
    selectedplayertroll,
    function(feat, pid)
        local allweaponhashes = weapon.get_all_weapon_hashes()
        for i = 1, #allweaponhashes do
            weapon.remove_weapon_from_ped(getped(pid), allweaponhashes[i])
            CD(5)
        end
    end
)
--Other Remote
newplfunc(
    "消息轰炸",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if feat.on then
            TSE(891272013, pid, {pid, math.random(-2147483647, 2147483647)}, true)
            CD(0)
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
newplfunc(
    "发送交易错误",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if pid ~= player.player_id() and player.is_player_valid(pid) then
            TSE(
                -2041535807,
                pid,
                {
                    pid,
                    2147483647,
                    1,
                    1,
                    script.get_global_i(1630317 + (1 + (pid * 595) + 506)),
                    script.get_global_i(1658176 + 9),
                    script.get_global_i(1658176 + 10),
                    1
                },
                true
            )
            CD(1000)
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
newplfunc(
    "禁用被动模式",
    "action",
    selectedplayertroll,
    function()
        TSE(1472357458, pid, {pid, 1})
    end
)
newplfunc(
    "发送无限黑屏",
    "action",
    selectedplayertroll,
    function()
        TSE(0x4a72a08d, pid, {-1, 1, -1})
    end
)
--Ragdoll
newplfunc(
    "玩家摔倒",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if feat.on then
            ped.set_ped_to_ragdoll(getped(pid), 2500, 0, 0)
            CD(50)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Camera Shake
newplfunc(
    "摇晃镜头",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if feat.on then
            fire.add_explosion(getcoords(pid), 4, false, false, 100.0, getped(pid))
        end
    end
)
--Freeze
newplfunc(
    "冻结玩家",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if pid ~= player.player_id() and player.is_player_valid(pid) then
            ped.clear_ped_tasks_immediately(getped(pid))
        end
    end
)
--Explosion
newplfunc(
    "爆炸玩家",
    "toggle",
    selectedplayertroll,
    function(feat, pid)
        if feat.on then
            fire.add_explosion(getcoords(pid), 0, true, false, 0, getped(pid))
            CD(15)
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
--Abusive
selectedplayerabusive = newplfunc("攻击选项", "parent", plmain.id).id
--Script Event Crash
secrash =
    newplfunc(
    "脚本事件崩溃",
    "value_i",
    selectedplayerabusive,
    function(feat, pid)
        if feat.on then
            TSE(
                crashscriptevent[math.random(1, #crashscriptevent)],
                pid,
                getcrasharg(pid)
            )
            CD(feat.value)
        end
    end
)
secrash.min = 1
secrash.max = 10
secrash.mod = 1
secrash.value = 5
--Invalid Entity
invalidentitycrash =
    newplfunc(
    "无效实体崩溃",
    "action",
    selectedplayerabusive,
    function(feat, pid)
        logg("[Abusive] Invalid Model Crash Triggered")
        requestmodel(gameplay.get_hash_key("slod_human"))
        requestmodel(gameplay.get_hash_key(("slod_large_quadped")))
        requestmodel(gameplay.get_hash_key(("slod_small_quadped")))
        ped1 = ped.create_ped(26, gameplay.get_hash_key("slod_human"), getcoords(pid), 0.0, true, false)
        ped2 =
            ped.create_ped(
            26,
            gameplay.get_hash_key("slod_large_quadped"),
            getcoords(pid),
            0.0,
            true,
            false
        )
        ped3 =
            ped.create_ped(
            26,
            gameplay.get_hash_key("slod_large_quadped"),
            getcoords(pid),
            0.0,
            true,
            false
        )
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("slod_human"))
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("slod_large_quadped"))
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("slod_large_quadped"))
        CD(100)
        entity.set_entity_as_no_longer_needed(ped1)
        entity.set_entity_as_no_longer_needed(ped2)
        entity.set_entity_as_no_longer_needed(ped3)
    end
)
--Vehicle Option
selectedplayerveh = newplfunc("载具选项", "parent", plmain.id).id
--Vehicle Spawner
selectedplayerspawner = newplfunc("刷出载具", "parent", selectedplayerveh).id
selectedsetgod =
    newplfunc(
    "设置刷出无敌",
    "toggle",
    selectedplayerspawner,
    function(feat)
    end
)
allspawncustom =
    newplfunc(
    "刷出自定义载具",
    "action",
    selectedplayerspawner,
    function(feat, pid)
        local vehname = getinput("输入载具代码", "", 32, 0)
        if streaming.is_model_a_vehicle(gameplay.get_hash_key(vehname)) then
            requestmodel(gameplay.get_hash_key(vehname))
            local pos = getcoords(pid)
            pos.x = pos.x + 3
            spawnedveh = vehicle.create_vehicle(gameplay.get_hash_key(vehname), pos, 0.0, true, true)
            if selectedsetgod.on then
                entity.set_entity_god_mode(spawnedveh, true)
            end
            streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(vehname))
        else
            logg("[ERROR] Model Invalid!")
            NOTG("无效载具模型", "错误")
        end
    end
)
selectedvehlist = newplfunc("载具列表", "parent", selectedplayerspawner).id
for i = 1, #vehiclelist do
    newplfunc(
        vehiclelist[i][2],
        "action",
        selectedvehlist,
        function(feat, pid)
            requestmodel(gameplay.get_hash_key(vehiclelist[i][1]))
            local pos = getcoords(pid)
            pos.x = pos.x + 3
            spawnedveh = vehicle.create_vehicle(gameplay.get_hash_key(vehiclelist[i][1]), pos, 0.0, true, true)
            if selectedsetgod.on then
                entity.set_entity_god_mode(spawnedveh, true)
            end
            streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(vehiclelist[i][1]))
        end
    )
end
newplfunc(
    "载具无敌",
    "toggle",
    selectedplayerveh,
    function(feat, pid)
        if feat.on then
            if player.is_ped_in_any_vehicle == true then
                entity.set_entity_god_mode(getveh(pid), true)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newplfunc(
    "儿童锁",
    "toggle",
    selectedplayerveh,
    function(feat, pid)
        if feat.on then
            if player.is_ped_in_any_vehicle == true then
                vehicle.set_vehicle_doors_locked(getveh(pid),4)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newplfunc(
    "修复载具",
    "action",
    selectedplayerveh,
    function(feat, pid)
        if player.is_ped_in_any_vehicle == true then
            vehicle.set_vehicle_fixed(getveh(pid))
            vehicle.set_vehicle_deformation_fixed(getveh(pid))
        end
    end
)
newplfunc(
    "载具不可被导弹锁定",
    "toggle",
    selectedplayerveh,
    function(feat)
        if feat.on then
			if ped.is_ped_in_any_vehicle(getped(pid)) == true then
				vehicle.set_vehicle_can_be_locked_on(getveh(pid), false, false)
            end
			return HANDLER_CONTINUE
		else
			if ped.is_ped_in_any_vehicle(getped(pid)) == true then
				vehicle.set_vehicle_can_be_locked_on(getveh(pid), true, false)
            end
			return HANDLER_POP
		end
    end
)
newplfunc(
    "关闭引擎",
    "toggle",
    selectedplayerveh,
    function(feat, pid)
        if feat.on then
            if player.is_ped_in_any_vehicle == true then
                vehicle.set_vehicle_engine_on(getveh(pid), false, true, true)
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newplfunc(
    "加装电话炸弹",
    "toggle",
    selectedplayerveh,
    function(feat, pid)
        if feat.on then
            if player.is_ped_in_any_vehicle == true then
                if vehicle.has_vehicle_phone_explosive_device() == false then
                    vehicle.add_vehicle_phone_explosive_device(getveh(pid))
                end
            end
            return HANDLER_CONTINUE
        else
            return HANDLER_POP
        end
    end
)
newplfunc(
    "引爆电话炸弹",
    "action",
    selectedplayerveh,
    function(feat, pid)
        if player.is_ped_in_any_vehicle == true then
            if vehicle.has_vehicle_phone_explosive_device() == true then
                vehicle.detonate_vehicle_phone_explosive_device()
            end
        end
    end
)
newplfunc(
    "让他的灭世暴徒2000强制开伞",
    "action",
    selectedplayerveh,
    function(feat, pid)
        if player.is_ped_in_any_vehicle == true then
            if vehicle.does_vehicle_have_parachute(getveh(pid)) == true then
                vehicle.set_vehicle_parachute_active(getveh(pid), true)
            end
        end
    end
)
--Toolbox
selectedplayertoolbox = newplfunc("工具箱", "parent", plmain.id).id
newplfunc(
    "复制玩家信息",
    "action",
    selectedplayertoolbox,
    function(feat, pid)
        utils.to_clipboard(
            player.get_player_name(pid) ..
                "'s Player Info Was Successfully Generated By LEGIT SCRIPT\n" ..
                    "RID: " ..
                        player.get_player_scid(pid) ..
                            "\nPlayer Host Token: " ..
                                player.get_player_host_token(pid) ..
								"\nPlayer Rank: " ..
									getglobalinfoi(pid, 6) ..
										"\nTotal Money: " ..
											getglobalinfoi(pid, 56) ..
												"\nK/D: " .. string.format("%.01f", getglobalinfof(pid, 26))
        )
    end
)
--General
newplfunc(
    "持续设置到玩家的路径点",
    "toggle",
    selectedplayertoolbox,
    function(feat, pid)
        coord = getcoords(pid)
        if coord.x and coord.y then
            local pos = v2()
            pos.x = coord.x
            pos.y = coord.y
            ui.set_new_waypoint(pos)
        end
    end
)
--Load Config
function loadconfig()
	local cfg = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini", "a+")
	local cfgstr = cfg:read("*a")
	for i = 1,#funclist do
		if (funclist[i][2] == "bool") then
			if (string.match(cfgstr,funclist[i][1].."=".."true")) then
				funclistbackend[i][1] = true
			end
		end
	end
	cfg:close()
end
loadconfig()
function saveconfig()
	local cfg = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini", "a+")
	local cfgstr = cfg:read("*a")
	cfg:close()
	for i = 1,#funclist do
		if (funclist[i][2] == "bool") then
			if (string.match(cfgstr,funclist[i][1].."=".."false")) then
				if (funclistbackend[i] == true) then
					cfgstr, num = string.gsub(cfgstr, funclist[i][1].."=".."false", funclist[i][1].."=".."true")
				end
			end
		end
	end
	local cfg = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\LEGIT CFG.ini", "w+")
	cfg:write(cfgstr)
	cfg:close()
end
--Unload
event.add_event_listener(
    "exit",
    function()
		saveconfig()
        NOTG("脚本退出中")
        logg("[Unload] Script Unloading")
        logg("[Unload] Removing Event Listeners")
        if pljoin.on then
            event.remove_event_listener("player_join", pljoinevent)
        end
        if admain.on then
            event.remove_event_listener("player_join", adbotdetect)
            event.remove_event_listener("chat", adbot)
        end
		if chatcommandswitch.on then
			event.remove_event_listener("chat", chatcommandfilter)
		end
		logg("[Unload] Removing Network Event Hooks")
		if karmavotekick.on then
			hook.remove_net_event_hook(vk)
		end
		if karmafreeze.on then
			hook.remove_net_event_hook(ct)
		end
        logg("[Unload] Script Has Been Successfully Unloaded XD")
    end
)
