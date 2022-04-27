Config = {}
function L(cd, ...) if Locales[Config.Language][cd] then return string.format(Locales[Config.Language][cd], ...) else print('Locale is nil ('..cd..')') end end
--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


Config.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'vrp' / 'identifiers', 'other' ] Choose your framework (by framework we mean choose the permission system you want to use).
Config.Language = 'EN' --[ 'EN' ] You can add your own locales to the Locales.lua. But make sure to add it here.

Config.FrameworkTriggers = { --You can change the esx/qbcore events (IF NEEDED).
    main = 'esx:getSharedObject',   --ESX = 'esx:getSharedObject'   QBCORE = 'QBCore:GetObject'
    load = 'esx:playerLoaded',      --ESX = 'esx:playerLoaded'      QBCORE = 'QBCore:Client:OnPlayerLoaded'
    job = 'esx:setJob',             --ESX = 'esx:setJob'            QBCORE = 'QBCore:Client:OnJobUpdate'
    resource_name = 'es_extended'   --ESX = 'es_extended'           QBCORE = 'qb-core'
}

Config.NotificationType = { --[ 'esx' / 'qbcore' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    server = 'esx',
    client = 'esx' 
}


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.StaffSit = {
    ENABLE = true, --Do you want to enable the staff sit feature?
    commands = {
        start = 'staffsit_start',
        end_ = 'staffsit_end',
        reset = 'staffsit_reset',
        endall = 'staffsit_endall'
    },
    perms = {
        ['esx'] = {'superadmin', 'admin', 'mod'},
        ['qbcore'] = {'god', 'admin'},
        ['vrp'] = {'change_me', 'change_me'},
        ['identifiers'] = {'steam:xxxxx', 'license:xxxxx'},
        ['other'] = {'change_me', 'change_me'}
    },
    locations = {
        [1] = vector3(-438.90, 1076.00, 352.41), --observatory
        [2] = vector3(-75.43, -819.01, 326.17), --maze bank
        [3] = vector3(-326.38, -1965.82, 66.79), --areana
        [4] = vector3(2020.89, -1586.85, 252.36), --east side hill
        [5] = vector3(-1177.95, 3846.73, 487.92), --zancudo hill
    },
}

Config.StaffJail = {
    ENABLE = true, --Do you want to enable the staff jail feature?
    commands = {
        start = 'staffjail_start',
        end_ = 'staffjail_end',
        gotojail = 'staffjail_goto',
        lion = 'staffjail_lion'
    },
    perms = {
        ['esx'] = {'superadmin', 'admin', 'mod'},
        ['qbcore'] = {'god', 'admin'},
        ['vrp'] = {'change_me', 'change_me'},
        ['identifiers'] = {'steam:xxxxx', 'license:xxxxx'},
        ['other'] = {'change_me', 'change_me'}
    },
    locations = {
        [1] = vector3(1651.13,2570.23,45.56), --cell 1
        [2] = vector3(1642.41,2569.66,45.56), --cell 2
        [3] = vector3(1628.57,2570.42,45.56), --cell 3
    },
}

Config.HolyTroll = {
    ENABLE = true, --Do you want to enable the holy troll feature?
    commands = {
        start = 'holytroll'
    },
    perms = {
        ['esx'] = {'superadmin', 'admin', 'mod'},
        ['qbcore'] = {'god', 'admin'},
        ['vrp'] = {'change_me', 'change_me'},
        ['identifiers'] = {'steam:xxxxx', 'license:xxxxx'},
        ['other'] = {'change_me', 'change_me'}
    },
    ped_location = vector4(-2835.83,-467.51,-12.60, 0.0),
    locations = {
        shark = {
            [0] = `a_c_sharktiger`,
            [1] = {spawn_coords = vector4(-2817.96, -458.81, -10.59, 128.08), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [2] = {spawn_coords = vector4(-2832.91, -446.31, -10.44, 162.88), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [3] = {spawn_coords = vector4(-2854.64, -457.67, -12.56, 230.44), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [4] = {spawn_coords = vector4(-2849.16, -452.78, -10.70, 221.08), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [5] = {spawn_coords = vector4(-2824.43, -451.32, -10.63, 221.08), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [6] = {spawn_coords = vector4(-2844.06, -449.86, -8.90, 221.08), goto_coords = vector3(-2835.83, -467.51, -12.60)},
        },
        
        killerwhale = {
            [0] = `a_c_killerwhale`,
            [1] = {spawn_coords = vector4(-2829.43, -436.44, -12.37, 186.12), goto_coords = vector3(-2835.83, -467.51, -12.60)},
            [2] = {spawn_coords = vector4(-2844.03, -438.88, -12.37, 186.12), goto_coords = vector3(-2835.83, -467.51, -12.60)},
        },
    
        whale = {
            [0] = `a_c_humpback`,
            [1] = {spawn_coords = vector4(-2835.14, -479.67, -3.96, 0.82), goto_coords = vector3(-2844.02, -401.16, -6.57)},
        },
    },
}