local bypasses = { 'teleport', 'bodyvelocity_bodyposition' }
local tabs = { 'silentaim', 'buyables' }
local files = { 'whitelisted_players.json', 'profiles.json' }
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()
local window = engine.new({
    text = "Project Joy",
    size = Vector2.new(500, 400),
    color = Color3.fromRGB(25, 25, 25)
})

local function import(file)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/not-A88/project-joy/main/'..file..'.lua'))()
end

-- folder / file setup.
local files = { 'whitelisted_players.json', 'profiles.json' }
for _, filePath in pairs(files) do
    local file, info = pcall(function()
        return readfile('ProjectC/'..filePath)
    end)
    if not file then
        makefolder('ProjectC')
        writefile('ProjectC/'..filePath,'[]')
    end
end

-- bypasses loader.
for _,bypassPath in pairs(bypasses) do
    import('bypasses/'..bypassPath)
end

-- tabs loader.
for _,tabPath in pairs(tabs) do
    local tab = import('tabs/'..tabPath)
    tab(window)
end

window.open()

-- Notes:
--  Add file loader to the int part.
--  Add profiles to buyables later.