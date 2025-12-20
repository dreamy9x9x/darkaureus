-- Loading Screen - Nytherune Hub (5 segundos)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "NytheruneLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(5,5,15)
bg.BorderSizePixel = 0
bg.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,80)
title.Position = UDim2.new(0,0,0.25,0)
title.BackgroundTransparency = 1
title.Text = "Nytherune Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = bg

-- Loading Bar Background
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.4,0,0,18)
barBg.Position = UDim2.new(0.3,0,0.55,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,60)
barBg.BorderSizePixel = 0
barBg.Parent = bg

local cornerBg = Instance.new("UICorner", barBg)
cornerBg.CornerRadius = UDim.new(0,10)

-- Loading Bar
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(188,57,179)
bar.BorderSizePixel = 0
bar.Parent = barBg

local corner = Instance.new("UICorner", bar)
corner.CornerRadius = UDim.new(0,10)

-- Stars
local stars = {}

local function createStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0,2,0,2)
    star.Position = UDim2.new(math.random(),0,-0.05,0)
    star.BackgroundColor3 = Color3.fromRGB(255,255,255)
    star.BorderSizePixel = 0
    star.Parent = bg
    table.insert(stars, star)
end

for i = 1,120 do
    createStar()
end

-- Star animation
RunService.RenderStepped:Connect(function(dt)
    for _,star in pairs(stars) do
        star.Position = star.Position + UDim2.new(0,0,dt * 0.6,0)
        if star.Position.Y.Scale > 1.1 then
            star.Position = UDim2.new(math.random(),0,-0.05,0)
        end
    end
end)

-- Música
local music = Instance.new("Sound")
music.SoundId = "rbxassetid://1848354536"
music.Volume = 0.5
music.Parent = SoundService
music:Play()

-- Loading animation (5 segundos)
local duration = 5 -- segundos
local startTime = tick()

task.spawn(function()
    while true do
        local elapsed = tick() - startTime
        local progress = math.clamp(elapsed/duration, 0, 1)
        bar.Size = UDim2.new(progress,0,1,0)
        if progress >= 1 then break end
        task.wait()
    end
    music:Stop()
    gui:Destroy()
end)
