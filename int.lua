local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()

local window = engine.new({
    text = "Project Joy",
    size = Vector3.new(300, 200),
    color = Color3.fromRGB(25, 25, 25)
})

local function import(file)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/not-A88/project-joy/main/'..file..'.lua'))()
end

-- bypasses loader.
import('bypasses/teleport')

-- tabs loader.
local test = import('tabs/buyables')
test(window)

window.open()

return window
