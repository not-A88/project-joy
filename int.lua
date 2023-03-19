local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()

local window = engine.new({
    text = "Project Joy",
    size = Vector3.new(300, 200),
    color = Color3.fromRGB(25, 25, 25)
})

window.open()

return window
