local tabs = { 'buyables' }
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()
local window = engine.new({
    text = "Project Joy",
    size = Vector3.new(300, 200),
    color = Color3.fromRGB(25, 25, 25)
})

local function import(file)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/not-A88/project-joy/main/'..file..'.lua'))()
end

-- bypasses loader.
import('bypasses/teleport')

-- tabs loader.
for i,v in pairs(tabs) do
    local tab = import('tabs/'..v)
    tab(window)
end

window.open()

-- Notes:
--  Add file loader to the int part.
--  Add profiles to buyables later.