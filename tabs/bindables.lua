local flySpeed = 50
local macroSpeed = 50

-- Fly
local player = game.Players.LocalPlayer
local character, humanoid, camera, flying, gravityValue

gravityValue = workspace.Gravity

local buttons = { W = false, S = false, A = false, D = false, Moving = false }

local function startFly()
    if not player.Character or not player.Character.Head or flying then
        return
    end

    character = player.Character
    humanoid = character:FindFirstChildOfClass("Humanoid")
    humanoid.PlatformStand = true
    camera = workspace.Camera
    flying = true

    -- Set velocity of all parts to zero
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Velocity = Vector3.new(0, 0, 0)
        end
    end

    humanoid.Died:Connect(function()
        flying = false
    end)
end

local function endFly()
    if not player.Character or not flying then
        return
    end

    workspace.Gravity = gravityValue
    humanoid.PlatformStand = false
    flying = false

    task.spawn(function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

game:GetService("UserInputService").InputBegan:Connect(function(input, GPE)
    if GPE then
        return
    end

    local keyCode = input.KeyCode
    if buttons[keyCode.Name] ~= nil then
        buttons[keyCode.Name] = true
        buttons.Moving = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input, GPE)
    if GPE then
        return
    end

    local keyCode = input.KeyCode
    if buttons[keyCode.Name] ~= nil then
        buttons[keyCode.Name] = false
    end

    buttons.Moving = false
    for _, button in pairs(buttons) do
        if button then
            buttons.Moving = true
            break
        end
    end
end)

local function setVec(vec) return vec.Unit * flySpeed end

game:GetService("RunService").Heartbeat:Connect(function(step)
    if not flying or not character.PrimaryPart then
        return
    end

    task.spawn(function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)

    local primaryPart = character.PrimaryPart
    local position = primaryPart.Position
    local cameraCFrame = camera.CFrame
    local newCFrame = CFrame.new(position, position + workspace.CurrentCamera.CFrame.LookVector)
    primaryPart.CFrame = newCFrame

    if buttons.Moving then
        local velocity = Vector3.new()
        if buttons.W then velocity = velocity + setVec(workspace.CurrentCamera.CFrame.LookVector) end
        if buttons.S then velocity = velocity - setVec(workspace.CurrentCamera.CFrame.LookVector) end
        if buttons.A then velocity = velocity - setVec(workspace.CurrentCamera.CFrame.RightVector) end
        if buttons.D then velocity = velocity + setVec(workspace.CurrentCamera.CFrame.RightVector) end
        character:TranslateBy(velocity * step)
        workspace.Gravity = gravityValue
    else
        workspace.Gravity = 0
        character:TranslateBy(Vector3.new(0,0,0))
    end
end)

-- Macro
local macroEnabled = false
local keybind = Enum.KeyCode.W

local down = false

local velocity = player.Character:FindFirstChild('UpperTorso'):FindFirstChild('BodyVelocity') or Instance.new('BodyVelocity')
velocity.maxForce = Vector3.new(100000, 0, 100000)

player.CharacterAdded:Connect(function(character)
	local root = character:WaitForChild('UpperTorso')
	velocity = root:FindFirstChild('BodyVelocity') or Instance.new('BodyVelocity')
	velocity.maxForce = Vector3.new(100000, 0, 100000)
end)

game.RunService.RenderStepped:Connect(function()
    if down and velocity then
	    local root = character:WaitForChild('UpperTorso')
        velocity = root:FindFirstChild('BodyVelocity') or Instance.new('BodyVelocity')
        velocity.maxForce = Vector3.new(100000, 0, 100000)
        velocity.Parent = player.Character.UpperTorso
        velocity.velocity = (player.Character.Humanoid.MoveDirection) * macroSpeed
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input,gameEvent)
    if not gameEvent and input.KeyCode == keybind and macroEnabled then
        down = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input,gameEvent)
    if not gameEvent and input.KeyCode == keybind and macroEnabled then
        down = false
        velocity.Parent = nil
    end
end)

function new(window)
    local bindables = window.new({ text = "Bindables", })

    bindables.new("switch", { text = "Enable Macro?"; }).event:Connect(function(bool)
        macroEnabled = bool
    end)

	bindables.new("slider", {
		text = "Macro speed",
		color = Color3.fromRGB(25, 25, 25),
		min = 0,
		max = 160,
		value = 80,
		rounding = 1,
	}).event:Connect(function(x)
		macroSpeed = x
	end)

    bindables.new("switch", { text = "Enable Fly?"; }).event:Connect(function(bool)
        if bool then
            startFly()
        else
            endFly()
        end
    end)

    bindables.new("slider", { text = "Fly Speed", color = Color3.fromRGB(45, 45, 45), min = 1, max = 200, value = 50, rounding = 0.5, }).event:Connect(function(x)
        flySpeed = x
    end)
end

return new