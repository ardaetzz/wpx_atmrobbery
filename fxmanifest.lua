fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'winprix'
description 'Advanced ATM Robbery Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'locale/init.lua',
    'config.lua',
    'framework/init.lua'
}

client_scripts {
    'locale/*.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'locale/*.lua',
    'server/main.lua'
}

dependency 'qb-core'
dependency 'ps-ui'
dependency 'ox_lib'
dependency 'ox_target'    -- veya qb-target
dependency 'ox_inventory' -- veya qb-inventory

files {
    'framework/qb.lua',
    'framework/notify/qb.lua',
    'framework/inventory/ox.lua',
    'framework/target/ox.lua'
    -- Eğer qb-inventory veya qb-target kullanılıyorsa, yukarıdakiler yerine veya ek olarak:
    -- 'framework/inventory/qb.lua',
    -- 'framework/target/qb.lua',
}
