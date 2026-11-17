-- // RUSaken Pro Hub v10 (Core Features & Polished Sub-Settings)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("RUSakenAdvancedHub") then
    CoreGui.RUSakenAdvancedHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUSakenAdvancedHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
MainFrame.Size = UDim2.new(0, 340, 0, 460)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 42)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1.00
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Size = UDim2.new(1, -28, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "RUSaken // Pro Hub v10"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 16.00
Title.TextXAlignment = Enum.TextXAlignment.Left

local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.Active = true
Container.BackgroundTransparency = 1.00
Container.Position = UDim2.new(0, 10, 0, 52)
Container.Size = UDim2.new(1, -20, 1, -62)
Container.CanvasSize = UDim2.new(0, 0, 0, 1100)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Btn"
    Button.Parent = Container
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.AutoButtonColor = false
    Button.Font = Enum.Font.SourceSansSemibold
    Button.Text = name .. " [ВЫКЛ]"
    Button.TextColor3 = Color3.fromRGB(170, 170, 170)
    Button.TextSize = 14.00

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Button.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Text = name .. " [ВКЛ]"
        else
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Button.TextColor3 = Color3.fromRGB(170, 170, 170)
            Button.Text = name .. " [ВЫКЛ]"
        end
        callback(state)
    end)
end

local function CreateSlider(labelName, defaultVal, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = Container
    SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = SliderFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Font = Enum.Font.SourceSansSemibold
    Label.Text = labelName .. ": " .. defaultVal
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = SliderFrame
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextBox.Position = UDim2.new(0, 10, 0, 26)
    TextBox.Size = UDim2.new(1, -20, 0, 20)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.Text = tostring(defaultVal)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 13
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = TextBox
    
    TextBox.FocusLost:Connect(function()
        local num = tonumber(TextBox.Text)
        if num then
            Label.Text = labelName .. ": " .. num
            callback(num)
        else
            TextBox.Text = tostring(defaultVal)
        end
    end)
end

local espHighlightEnabled = false
local espNamesEnabled = false
local hitboxEnabled = false
local hitboxSizeVal = 5
local speedEnabled = false
local speedVal = 26
local flyEnabled = false
local flySpeedVal = 50
local noclipEnabled = false
local infiniteJumpEnabled = false
local fullbrightEnabled = false
local autoGeneratorEnabled = false
local autoGenDelayVal = 0.1
local antiStunEnabled = false
local fieldOfViewEnabled = false
local fovVal = 100

-- 1. Настройка Хитбоксов
CreateSlider("Настройка: Размер Хитбоксов", 5, function(val)
    hitboxSizeVal = val
end)
RunService.Heartbeat:Connect(function()
    if hitboxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                hrp.Size = Vector3.new(hitboxSizeVal, hitboxSizeVal, hitboxSizeVal)
                hrp.Transparency = 0.6
                hrp.CanCollide = false
            end
        end
    end
end)
CreateButton("Увеличение хитбоксов", function(state)
    hitboxEnabled = state
    if not state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
                hrp.CanCollide = true
            end
        end
    end
end)

-- 2. Настройка Скорости
CreateSlider("Настройка: Скорость Бега (WalkSpeed)", 26, function(val)
    speedVal = val
end)
RunService.Heartbeat:Connect(function()
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedVal
    end
end)
CreateButton("Ускорение бега (SpeedHack)", function(state)
    speedEnabled = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- 3. Настройка Полета
CreateSlider("Настройка: Скорость Полета (Fly)", 50, function(val)
    flySpeedVal = val
end)
RunService.RenderStepped:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local cam = Camera.CFrame
        local moveVector = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.RightVector end
        
        hrp.Velocity = moveVector * flySpeedVal
        hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.LookVector)
    end
end)
CreateButton("Полет (Fly Mode)", function(state)
    flyEnabled = state
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end
end)

-- 4. Настройка Автогенератора
CreateSlider("Настройка: Задержка Автогена (сек)", 0.1, function(val)
    autoGenDelayVal = val
end)
task.spawn(function()
    while true do
        if autoGeneratorEnabled then
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name:lower():find("generator") or obj.Name:lower():find("gen") or obj.Name:lower():find("machine") then
                        for _, child in ipairs(obj:GetDescendants()) do
                            if child:IsA("ProximityPrompt") then
                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    if (child.Parent.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= (child.MaxActivationDistance + 5) then
                                        fireproximityprompt(child)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(autoGenDelayVal)
    end
end)
CreateButton("Автогенератор (Ультра)", function(state) autoGeneratorEnabled = state end)

-- 5. Настройка FOV
CreateSlider("Настройка: Угол обзора (FOV)", 100, function(val)
    fovVal = val
end)
RunService.RenderStepped:Connect(function()
    if fieldOfViewEnabled then
        Camera.FieldOfView = fovVal
    else
        Camera.FieldOfView = 70
    end
end)
CreateButton("Широкий обзор (Custom FOV)", function(state) fieldOfViewEnabled = state end)

-- Остальные функции
RunService.RenderStepped:Connect(function()
    if espHighlightEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local char = player.Character
                if not char:FindFirstChild("ProHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ProHighlight"
                    highlight.Adornee = char
                    highlight.FillColor = Color3.fromRGB(255, 30, 30)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.4
                    highlight.Parent = char
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ProHighlight") then
                player.Character.ProHighlight:Destroy()
            end
        end
    end
end)
CreateButton("ESP: Подсветка тел", function(state) espHighlightEnabled = state end)

RunService.RenderStepped:Connect(function()
    if espNamesEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local head = player.Character.Head
                if not head:FindFirstChild("ProNameTag") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ProNameTag"
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 120, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboard
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextSize = 13
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextStrokeTransparency = 0
                    textLabel.Name = "InfoText"
                    
                    billboard.Parent = head
                else
                    local tag = head:FindFirstChild("ProNameTag")
                    if tag and tag:FindFirstChild("InfoText") and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                        local health = "???"
                        if player.Character:FindFirstChildOfClass("Humanoid") then
                            health = math.floor(player.Character.Humanoid.Health)
                        end
                        tag.InfoText.Text = player.Name .. " | " .. health .. "HP
[" .. dist .. "m]"
                    end
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local tag = player.Character.Head:FindFirstChild("ProNameTag")
                if tag then tag:Destroy() end
            end
        end
    end
end)
CreateButton("ESP: Имена, Здоровье и Дистанция", function(state) espNamesEnabled = state end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
CreateButton("Проход сквозь стены (Noclip)", function(state) noclipEnabled = state end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
CreateButton("Бесконечный прыжок (Infinite Jump)", function(state) infiniteJumpEnabled = state end)

RunService.RenderStepped:Connect(function()
    if fullbrightEnabled then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end)
CreateButton("Полное освещение (Fullbright)", function(state) fullbrightEnabled = state end)

RunService.Heartbeat:Connect(function()
    if antiStunEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum.WalkSpeed < 16 and not speedEnabled then
            hum.WalkSpeed = 16
        end
    end
end)
CreateButton("Анти-Стан / Анти-Замедление", function(state) antiStunEnabled = state end)
