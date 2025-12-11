-- LocalScript (colocar em StarterPlayerScripts)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DarkaureusLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Root frame (fundo preto)
local root = Instance.new("Frame")
root.Name = "Root"
root.Size = UDim2.new(1,0,1,0)
root.Position = UDim2.fromScale(0,0)
root.BackgroundColor3 = Color3.fromRGB(0,0,0)
root.BorderSizePixel = 0
root.Parent = gui

-- Nebula glow (imagem-like with UIGradient blur effect imitation)
local neb = Instance.new("Frame")
neb.Name = "Nebula"
neb.Size = UDim2.new(1.6,0,1.2,0)
neb.Position = UDim2.new(-0.3,0,-0.2,0)
neb.BackgroundTransparency = 0
neb.BackgroundColor3 = Color3.fromRGB(20,0,0)
neb.BorderSizePixel = 0
neb.Parent = root
neb.ZIndex = 1
local nebGrad = Instance.new("UIGradient", neb)
nebGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,30,30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180,10,10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,0,0))
}
nebGrad.Rotation = 20
neb.ClipsDescendants = false
neb.BackgroundTransparency = 0.9 -- mostly subtle

-- Twinkling stars (many tiny circles)
local starsFolder = Instance.new("Folder", root)
starsFolder.Name = "Stars"
local starCount = 60
for i = 1, starCount do
    local s = Instance.new("Frame")
    s.Name = "Star"..i
    s.Size = UDim2.new(0, math.random(1,3), 0, math.random(1,3))
    s.BackgroundColor3 = Color3.fromRGB(255, 100 + math.random(0,155), math.random(0,80))
    s.BorderSizePixel = 0
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.AnchorPoint = Vector2.new(0.5,0.5)
    s.BackgroundTransparency = 0.2 + math.random() * 0.7
    local corner = Instance.new("UICorner", s)
    corner.CornerRadius = UDim.new(1,0)
    s.ZIndex = 2
    s.Parent = starsFolder

    -- twinkle animation (looping)
    local function twinkle()
        while s.Parent do
            local targetTransparency = 0.05 + math.random() * 0.7
            local tinfo = TweenInfo.new(1 + math.random()*2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local tween = TweenService:Create(s, tinfo, {BackgroundTransparency = targetTransparency})
            tween:Play()
            tween.Completed:Wait()
            wait(0.2 + math.random()*1.2)
        end
    end
    spawn(twinkle)
end

-- Red streaks (moving horizontal streaks)
local streaks = Instance.new("Folder", root)
streaks.Name = "Streaks"
for i = 1, 4 do
    local st = Instance.new("Frame")
    st.Size = UDim2.new(1.6,0,0, 6 + math.random()*8)
    st.Position = UDim2.new(-0.8, 0, math.random()*0.9, 0)
    st.BackgroundTransparency = 0.9
    st.BorderSizePixel = 0
    st.AnchorPoint = Vector2.new(0,0)
    st.ZIndex = 3
    st.Parent = streaks
    local grad = Instance.new("UIGradient", st)
    grad.Rotation = 0
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200,20,20)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255,40,40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
    }
    grad.Transparency = NumberSequence.new(0.9, 0.0, 0.9)
    -- animate left->right
    spawn(function()
        while st.Parent do
            st.Position = UDim2.new(-1.2,0, st.Position.Y.Scale, 0)
            local t = TweenInfo.new(5 + math.random()*4, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(st, t, {Position = UDim2.new(1.2,0,st.Position.Y.Scale,0)})
            tween:Play()
            tween.Completed:Wait()
            wait(0.1 + math.random()*0.6)
        end
    end)
end

-- Center container
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0.66,0,0.28,0)
container.Position = UDim2.new(0.17,0,0.36,0)
container.AnchorPoint = Vector2.new(0,0)
container.BackgroundTransparency = 1
container.Parent = root
container.ZIndex = 4

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1,0,0,48)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Welcome to Darkaureus Hub!"
title.TextScaled = false
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255,80,80)
title.TextStrokeTransparency = 0.6
title.TextXAlignment = Enum.TextXAlignment.Center
title.ZIndex = 5
title.Parent = container

-- Subtitle / small text
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Sub"
subtitle.Size = UDim2.new(1,0,0,18)
subtitle.Position = UDim2.new(0,0,0,52)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Loading Darkaureus Hub..."
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(255,160,160)
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.ZIndex = 5
subtitle.Parent = container

-- Progress bar background
local barBg = Instance.new("Frame")
barBg.Name = "BarBg"
barBg.Size = UDim2.new(1,0,0,18)
barBg.Position = UDim2.new(0,0,0,80)
barBg.BackgroundColor3 = Color3.fromRGB(20,0,0)
barBg.BorderSizePixel = 0
barBg.ZIndex = 5
barBg.Parent = container
local bgCorner = Instance.new("UICorner", barBg)
bgCorner.CornerRadius = UDim.new(1,0)
local bgStroke = Instance.new("UIStroke", barBg)
bgStroke.Color = Color3.fromRGB(90,0,0)
bgStroke.Transparency = 0.4
bgStroke.Thickness = 2

-- Progress fill (starts at 0 width)
local barFill = Instance.new("Frame")
barFill.Name = "BarFill"
barFill.Size = UDim2.new(0,0,1,0)
barFill.Position = UDim2.new(0,0,0,0)
barFill.BackgroundColor3 = Color3.fromRGB(220,30,30)
barFill.BorderSizePixel = 0
barFill.ZIndex = 6
barFill.Parent = barBg
local fillCorner = Instance.new("UICorner", barFill)
fillCorner.CornerRadius = UDim.new(1,0)

-- Percentage label
local perc = Instance.new("TextLabel")
perc.Name = "Percentage"
perc.Size = UDim2.new(0,90,1,0)
perc.Position = UDim2.new(1, 8, 0, -2)
perc.AnchorPoint = Vector2.new(0,0)
perc.BackgroundTransparency = 1
perc.Text = "0%"
perc.Font = Enum.Font.Gotham
perc.TextSize = 16
perc.TextColor3 = Color3.fromRGB(255,170,170)
perc.TextXAlignment = Enum.TextXAlignment.Left
perc.ZIndex = 6
perc.Parent = container

-- optional subtle vignette (edges darker)
local vignette = Instance.new("ImageLabel")
vignette.Size = UDim2.new(1,0,1,0)
vignette.Position = UDim2.new(0,0,0,0)
vignette.BackgroundTransparency = 1
vignette.Image = "rbxassetid://131602993" -- subtle vignette-ish asset (if fails, it's still okay)
vignette.ImageTransparency = 0.9
vignette.ZIndex = 0
vignette.Parent = root

-- Loading logic: duration 5 seconds
local totalTime = 5 -- seconds
local startTime = tick()
local elapsed = 0
local lastPercent = -1

-- use a smooth tween for the bar fill width
local function setProgress(percent)
    percent = math.clamp(percent, 0, 100)
    perc.Text = tostring(math.floor(percent)).."%"
    local target = UDim2.new(percent/100, 0, 1, 0)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(barFill, tweenInfo, {Size = target})
    tween:Play()
end

-- Simulate loading: increase to 100% in totalTime seconds with small random jitters
spawn(function()
    while elapsed < totalTime do
        elapsed = tick() - startTime
        local raw = (elapsed / totalTime) * 100
        -- jitter to feel organic
        local jitter = math.sin(elapsed * 6) * 2
        local percent = math.clamp(raw + jitter, 0, 100)
        if math.floor(percent) ~= lastPercent then
            lastPercent = math.floor(percent)
            setProgress(percent)
        end
        wait(0.05)
    end
    -- ensure 100%
    setProgress(100)
    wait(0.35)
    -- fade out and destroy
    local fadeTween = TweenService:Create(root, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
    fadeTween:Play()
    -- also tween children transparency smoothly
    for _,v in pairs(root:GetDescendants()) do
        if v:IsA("GuiObject") and v ~= root then
            pcall(function()
                local t = TweenService:Create(v, TweenInfo.new(0.65), {BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1})
                t:Play()
            end)
        end
    end
    wait(0.75)
    gui:Destroy()
end)

-- Accessibility: allow manual skip for testing by pressing R
local uis = game:GetService("UserInputService")
local skip = false
uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R and not skip then
        skip = true
        -- quickly jump to end
        setProgress(100)
        wait(0.05)
        gui:Destroy()
    end
end)
game.Players.LocalPlayer:Kick("Script Is Down. Reason: Update. Back in Minutes")
