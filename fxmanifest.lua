fx_version 'cerulean'
game 'gta5'
author 'Codesign#2715'
description 'Staff Suppport'
version '1.0.2'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua'
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua'
}

server_scripts {
    --'@vrp/lib/utils.lua', --⚠️PLEASE READ⚠️; Unhash this line if you use 'vRP'.⚠️
    'configs/server_customise_me.lua',
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/script.js',
    'html/sound/*.ogg'
}