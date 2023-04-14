local lighting = game:GetService("Lighting")

function new(window)
    local misc = window.new({ text = "Misc", })

    misc.new("switch", { text = "Disable Fog?"; }).event:Connect(function(bool)
        lighting.FogEnd = (bool and math.huge) or (not bool and 500) -- default 500
        lighting.FogStart = (bool and math.huge) or (not bool and 0) -- default 0
    end)

end

return new

