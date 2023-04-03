local shop = game:GetService("Workspace").Ignored.Shop
local players = game:GetService("Players")
local localpalyer = players.LocalPlayer

local module = {
    _target = nil
}

function module:_isBag(object)
    if object.Name:match("BrownBag") ~= nil then
        print(object.Name)
        return true
    else
        return false
    end
end

function module:_getBag()
    local savedCFrame = localpalyer.Character.HumanoidRootPart.CFrame
    local backpackCheck = localpalyer.Backpack:FindFirstChild('[BrownBag]')
    local characterCheck = localpalyer.Character:FindFirstChild('[BrownBag]')
    if backpackCheck then return backpackCheck end
    if characterCheck then return characterCheck end
    if not backpackCheck and not characterCheck then
        for _, object in pairs(shop:GetChildren()) do
            if self:_isBag(object) then
                localpalyer.Character.HumanoidRootPart.CFrame = object.Head.CFrame
                wait(.25)
                fireclickdetector(object.ClickDetector)
                wait(.25)
                localpalyer.Character.HumanoidRootPart.CFrame = savedCFrame
                repeat 
                    wait()
                until (localpalyer.Backpack:FindFirstChild('[BrownBag]') or localpalyer.Character:FindFirstChild('[BrownBag]'))
            end
        end
    end
    return (localpalyer.Backpack:FindFirstChild('[BrownBag]') or localpalyer.Character:FindFirstChild('[BrownBag]'))
end

function module:bag(player)
    local bag = self:_getBag()
    localpalyer.Character.Humanoid:EquipTool(bag)
    local savedCFrame = localpalyer.Character.HumanoidRootPart.CFrame
    bag:Activate()
    wait()
    localpalyer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    wait(1.5)
    localpalyer.Character.HumanoidRootPart.CFrame = savedCFrame
end

function module:_getPlayerByName(name)
    for _, player in pairs(players:GetPlayers()) do
        local playerName = player.Name:lower()
        if name:lower() == player.DisplayName:lower() or string.sub(playerName,0,#name) == name:lower() then
            return player
        end
    end
    return false
end

function new(window)
    local target = window.new({ text = "Target" })
    local playerDropdown = target.new("dropdown", { text = "Players", color = Color3.fromRGB(25, 25, 25) })
    playerDropdown.event:Connect(function(player)
        module._target = player
        print(player)
    end)
    for i,v in pairs(players:GetPlayers()) do playerDropdown.new(v.Name, { color = Color3.fromRGB(45, 45, 45) }) end
    players.ChildAdded:Connect(function(child)
        local new = playerDropdown.new(child.Name)
        local connection = nil
        connection = players.ChildRemoved:Connect(function(child)
            if new.name == child.Name then
                new:Destroy()
                connection:Disconnect()
            end
        end)
    end)
    target.new("button", { text = "Goto", color = Color3.fromRGB(25, 25, 25) }).event:Connect(function()
        local player = players:FindFirstChild(module._target)
        if player and player.Character then
            local humanoidrootpart = player.Character:FindFirstChild('HumanoidRootPart')
            if humanoidrootpart then
                localpalyer.Character.HumanoidRootPart.CFrame = humanoidrootpart.CFrame
            end
        end
    end)
    target.new("button", { text = "Bag", color = Color3.fromRGB(25, 25, 25) }).event:Connect(function()
        local player = players:FindFirstChild(module._target)
        if player and player.Character then
            local humanoidrootpart = player.Character:FindFirstChild('HumanoidRootPart')
            if humanoidrootpart and module._target ~= localpalyer then
                module:bag(player)
            end
        end
    end)
end

return new