fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Dannyfjsf'
description 'Armour script with lots of features'
lua54 'yes'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

server_scripts{
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua',
    
}

shared_script{
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua'
}


dependencies{
    'es_extended',
    'oxmysql',
    'ox_lib'
}