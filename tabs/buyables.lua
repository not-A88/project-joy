local players = game:GetService('Players')
local locaplayer = players.LocalPlayer
local shop = game:GetService("Workspace").Ignored.Shop
local food_keys = { "Pizza", "Popcorn", "Cranberry", "Starblox Latte", "Donut", "Chicken", "Lemonade", "Meat", "Da Milk", "Taco", "Hamburger", "HotDog" }
local food_maps = {  }

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

function new(window)
    local buyables = window.new({ text = "Food", })

    local dropdown = buyables.new("dropdown", { text = "Foods", color = Color3.fromRGB(25, 25, 25) })
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

return new