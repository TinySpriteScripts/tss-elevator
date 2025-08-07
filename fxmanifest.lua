fx_version "cerulean"
game "gta5"
lua54 "yes"

name "TSS-Elevator"
author "TinySprite-Scripts"
description "Elevator System for FiveM"
version "2.1.0"
discord "https://discord.gg/ZMFfC54FdJ"
tebex "https://tinysprite-scripts.tebex.io/"

dependency "jim_bridge" -- https://github.com/jimathy/jim_bridge

shared_scripts {
    "config.lua",
    -- Required scripts
    "@jim_bridge/starter.lua",
}

client_scripts { 
    "client/*.lua",
}
server_scripts {
    "server/*.lua",
}

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.js',
    'html/*.css'
}

escrow_ignore {
    "client/*.lua",
    "config.lua",
}

dependency "/assetpacks"
