local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local uis = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DarkaureusLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Raiz
local root = Instance.new("Frame")
root.Size = UDim2.new(1,0,1,0)
root.BackgroundColor3 = Color3.fromRGB(0,0,0)
root.BorderSizePixel = 0
root.Parent = gui


---

-- NEBULOSA VERMELHA

local neb = Instance.new("Frame")
neb.Size = UDim2.new(1.6,0,1.3,0)
neb.Position = UDim2.new(-0.3,0,-0.1,0)
neb.BackgroundColor3 = Color3.fromRGB(50,0,0)
neb.BackgroundTransparency = 0.87
neb.ZIndex = 1
neb.Parent = root

local nebGrad = Instance.new("UIGradient", neb)
nebGrad.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255,40,40)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150,0,0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(20,0,0))
}
nebGrad.Rotation = 20


---

-- ESTRELAS PISCANDO

local stars = Instance.new("Folder", root)
stars.Name = "Stars"

for i = 1, 70 do
local s = Instance.new("Frame")
s.Size = UDim2.new(0, math.random(1,3), 0, math.random(1,3))
s.Position = UDim2.new(math.random(), 0, math.random(), 0)
s.BackgroundColor3 = Color3.fromRGB(255, math.random(80,150), math.random(20,60))
s.BackgroundTransparency = math.random()
s.BorderSizePixel = 0
s.ZIndex = 3
s.Parent = stars

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(1,0)
c.Parent = s

task.spawn(function()
while s.Parent do
local t = TweenInfo.new(1 + math.random(), Enum.EasingStyle.Sine)
TweenService:Create(s, t, {
BackgroundTransparency = math.random()
}):Play()
task.wait(0.2 + math.random())
end
end)

end


---

-- TRAÇOS VERMELHOS (efeito Darkaureus)

local streaks = Instance.new("Folder")
streaks.Name = "Streaks"
streaks.Parent = root

for i = 1, 4 do
local st = Instance.new("Frame")
st.Size = UDim2.new(1.5,0,0, 5 + math.random(8))
st.Position = UDim2.new(-1.2,0, math.random(), 0)
st.BackgroundTransparency = 1
st.ZIndex = 2
st.Parent = streaks

local grad = Instance.new("UIGradient", st)
grad.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
ColorSequenceKeypoint.new(0.4, Color3.fromRGB(200,30,30)),
ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255,60,60)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
}
grad.Rotation = 0

task.spawn(function()
while st.Parent do
st.Position = UDim2.new(-1.1,0, st.Position.Y.Scale, 0)
TweenService:Create(st, TweenInfo.new(6 + math.random(3), Enum.EasingStyle.Linear), {
Position = UDim2.new(1.2,0,st.Position.Y.Scale,0)
}):Play()
task.wait(0.3 + math.random())
end
end)

end


---

-- CONTAINER CENTRAL

local container = Instance.new("Frame")
container.Size = UDim2.new(0.6,0,0.28,0)
container.Position = UDim2.new(0.2,0,0.36,0)
container.BackgroundTransparency = 1
container.ZIndex = 4
container.Parent = root

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,48)
title.BackgroundTransparency = 1
title.Text = "Darkaureus Hub"
title.TextColor3 = Color3.fromRGB(255,50,50)
title.TextSize = 34
title.Font = Enum.Font.GothamBold
title.ZIndex = 5
title.Parent = container

-- Subtitulo
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,0,0,20)
sub.Position = UDim2.new(0,0,0,50)
sub.BackgroundTransparency = 1
sub.Text = "Carregando..."
sub.TextColor3 = Color3.fromRGB(255,130,130)
sub.TextSize = 16
sub.Font = Enum.Font.Gotham
sub.ZIndex = 5
sub.Parent = container


---

-- BARRA DE PROGRESSO

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1,0,0,18)
barBg.Position = UDim2.new(0,0,0,80)
barBg.BackgroundColor3 = Color3.fromRGB(25,0,0)
barBg.BorderSizePixel = 0
barBg.ZIndex = 5
barBg.Parent = container

local bgCorner = Instance.new("UICorner", barBg)
bgCorner.CornerRadius = UDim.new(1,0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(230, 20, 20)
barFill.ZIndex = 6
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner", barFill)
fillCorner.CornerRadius = UDim.new(1,0)

-- Porcentagem
local perc = Instance.new("TextLabel")
perc.Size = UDim2.new(0,80,1,0)
perc.Position = UDim2.new(1,6,0,0)
perc.BackgroundTransparency = 1
perc.Text = "0%"
perc.TextColor3 = Color3.fromRGB(255,140,140)
perc.TextSize = 16
perc.Font = Enum.Font.Gotham
perc.ZIndex = 6
perc.Parent = container


---

-- FUNÇÃO DE PROGRESSO

local function setProgress(p)
p = math.clamp(p,0,100)
perc.Text = math.floor(p).."%"

TweenService:Create(
barFill,
TweenInfo.new(0.2, Enum.EasingStyle.Linear),
{Size = UDim2.new(p/100,0,1,0)}
):Play()

end


---

-- ANIMAÇÃO PRINCIPAL DO LOADING

local total = 5
local start = tick()
local skipped = false

task.spawn(function()
while tick() - start < total and not skipped do
local e = tick() - start
local percent = (e / total) * 100
setProgress(percent)
task.wait(0.05)
end

if not skipped then
setProgress(100)
task.wait(0.4)
end

-- Fade-out
TweenService:Create(root, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()

for _,v in ipairs(root:GetDescendants()) do
if v:IsA("TextLabel") or v:IsA("ImageLabel") or v:IsA("Frame") then
pcall(function()
TweenService:Create(v, TweenInfo.new(0.6), {
BackgroundTransparency = 1,
TextTransparency = 1,
ImageTransparency = 1
}):Play()
end)
end
end

task.wait(0.7)
gui:Destroy()


---

-- 🔥 CARREGAR A SUA URL

loadstring(game:HttpGet("https://scriptsneonauth.vercel.app/api/scripts/4a6a7d54-44e0-4044-a88e-1147c9bbafea/raw"))()

end)


---

-- SKIP (tecla R)

uis.InputBegan:Connect(function(input, gp)
if gp then return end
if input.KeyCode == Enum.KeyCode.R and not skipped then
skipped = true
setProgress(100)
task.wait(0.1)
gui:Destroy()

-- roda a URL imediatamente
loadstring(game:HttpGet("https://scriptsneonauth.vercel.app/api/scripts/4a6a7d54-44e0-4044-a88e-1147c9bbafea/raw"))()
end

end)
