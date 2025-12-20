-- Nytherune Hub - Loading integrado com música + loadstring

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NytheruneLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Fundo
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(5,5,15)
bg.BorderSizePixel = 0
bg.Parent = gui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,80)
title.Position = UDim2.new(0,0,0.25,0)
title.BackgroundTransparency = 1
title.Text = "Nytherune Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = bg

-- Barra fundo
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.4,0,0,18)
barBg.Position = UDim2.new(0.3,0,0.55,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,60)
barBg.BorderSizePixel = 0
barBg.Parent = bg
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,10)

-- Barra progresso
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(188,57,179)
bar.BorderSizePixel = 0
bar.Parent = barBg
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,10)

-- Estrelas
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

RunService.RenderStepped:Connect(function(dt)
    for _, star in ipairs(stars) do
        star.Position = star.Position + UDim2.new(0,0,dt * 0.6,0)
        if star.Position.Y.Scale > 1.1 then
            star.Position = UDim2.new(math.random(),0,-0.05,0)
        end
    end
end)

-- Música
local music = Instance.new("Sound")
music.SoundId = "rbxassetid://1848354536"
music.Volume = 1
music.Looped = false
music.Parent = SoundService

music:Play()

-- Sincronização loading + música
task.spawn(function()
    while music.IsPlaying and music.TimeLength == 0 do
        task.wait()
    end

    local duration = music.TimeLength

    while music.IsPlaying do
        local progress = math.clamp(music.TimePosition / duration, 0, 1)
        bar.Size = UDim2.new(progress,0,1,0)
        task.wait()
    end

    -- Final
    music:Stop()
    gui:Destroy()

    -- Loadstring final
    loadstring(game:HttpGet(
        "https://scriptsneonauth.vercel.app/api/scripts/aead227c-b8f3-4ccf-a1dd-d5212c00a129/raw"
    ))()
end)
