local players = game:GetService('Players')
local locaplayer = players.LocalPlayer
local shop = game:GetService("Workspace").Ignored.Shop
local food_keys = { "Pizza", "Popcorn", "Cranberry", "Starblox Latte", "Donut", "Chicken", "Lemonade", "Meat", "Da Milk", "Taco", "Hamburger", "HotDog" }
local food_maps = {  }
local weapon_maps = {  }
local module = {}

function module:buyWeapon(weapon)
    local savedCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local weapondata = weapon_maps[weapon]
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        local matched = v.Name:match(weapon)
        if matched == weapon then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = weapondata.ammo.Head.CFrame
            wait(.25)
            fireclickdetector(weapondata.ammo.ClickDetector)
            wait(.25)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
            return
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        local matched = v.Name:match(weapon)
        if matched == weapon then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = weapondata.ammo.Head.CFrame
            wait(.25)
            fireclickdetector(weapondata.ammo.ClickDetector)
            wait(.25)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
            return
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = weapondata.gun.Head.CFrame
    wait(.25)
    fireclickdetector(weapondata.gun.ClickDetector)
    wait(.25)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
end

for _, foodbuy in pairs(shop:GetChildren()) do
    for _,food_key in pairs(food_keys) do
        local unfilteredName = string.match(foodbuy.Name, food_key)
        if unfilteredName ~= nil then
            if food_maps[food_key] and food_maps[food_key].price < foodbuy.Price.Value then
                food_maps[food_key] = { food = foodbuy, price = foodbuy.Price.Value }
            else
                food_maps[food_key] = { food = foodbuy, price = foodbuy.Price.Value }
            end
        end
    end
end

for _, ammoBuy in pairs(shop:GetChildren()) do
    local unfilteredName = string.match(ammoBuy.Name, "%[(.-)%]")
    if unfilteredName and unfilteredName:match('Ammo') == 'Ammo' then
        local filteredName = unfilteredName:gsub("Ammo","")
        filteredName = filteredName:sub(0,#filteredName-1)
        for _, gunBuy in pairs(shop:GetChildren()) do
            if string.match(gunBuy.Name,filteredName) == filteredName and string.match(gunBuy.Name,'Ammo') == nil then
                if weapon_maps[filteredName] and weapon_maps[filteredName].price < gunBuy.Price.Value then
                    weapon_maps[filteredName] = { gun = gunBuy, ammo = ammoBuy, price = gunBuy.Price.Value }
                else
                    weapon_maps[filteredName] = { gun = gunBuy, ammo = ammoBuy, price = gunBuy.Price.Value }
                end
            end
        end
    end
end

function new(window)
    local buyables = window.new({ text = "Buyables", })

    local dropdown = buyables.new("dropdown", { text = "Guns", color = Color3.fromRGB(25, 25, 25) })
    for i,_ in pairs(weapon_maps) do dropdown.new(i) end
    dropdown.event:Connect(function(weapon) module:buyWeapon(weapon) end)

    local dropdown = buyables.new("dropdown", { text = "Food", color = Color3.fromRGB(25, 25, 25) })
    for i,_ in pairs(food_maps) do dropdown.new(i) end
    dropdown.event:Connect(function(weapon)
        local savedCFrame = locaplayer.Character.HumanoidRootPart.CFrame
        local weapondata = food_maps[weapon]
        for i,v in pairs(locaplayer.Backpack:GetChildren()) do
            local matched = v.Name:match(weapon)
            if matched == weapon then
                return
            end
        end
        for i,v in pairs(locaplayer.Character:GetChildren()) do
            local matched = v.Name:match(weapon)
            if matched == weapon then
                return
            end
        end
        locaplayer.Character.HumanoidRootPart.CFrame = weapondata.food.Head.CFrame
        wait(.25)
        fireclickdetector(weapondata.food.ClickDetector)
        wait(.25)
        locaplayer.Character.HumanoidRootPart.CFrame = savedCFrame
    end)
end

return {
    new 
}