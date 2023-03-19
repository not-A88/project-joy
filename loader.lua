--[[
    Project.
             ██╗ ██████╗ ██╗   ██╗
             ██║██╔═══██╗╚██╗ ██╔╝
             ██║██║   ██║ ╚████╔╝
        ██   ██║██║   ██║  ╚██╔╝
        ╚█████╔╝╚██████╔╝   ██║
         ╚════╝  ╚═════╝    ╚═╝
]]--

local function import(file)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/not-A88/project-joy/main/'..file..'.lua'))()
end

import('int')