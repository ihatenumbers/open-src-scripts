local RunService = game:GetService("RunService")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local wrk = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local sg = game:GetService("StarterGui")

local gameStuff = wrk:FindFirstChild("GameStuff")

local Window = Rayfield:CreateWindow({
    Name = "▶ SwordBacks ◀",
    Icon = 0,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Agreed 🥵",
    Theme = "DarkBlue",
})

local Tab = Window:CreateTab("Main")

local Section = Tab:CreateSection("Main")

local AGrabCrates = Tab:CreateToggle({
    Name = "Auto Crates",
    CurrentValue = false,
    Callback = function(Value)
        _G.autocrates = Value
        while _G.autocrates and plr.Character:FindFirstChild("HumanoidRootPart") do
            for _, child in ipairs(gameStuff:GetChildren()) do
                if child.Name == "Crate" then
                    for _, part in ipairs(child:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                            part.CFrame = plr.Character:FindFirstChild("HumanoidRootPart").CFrame
                        end
                    end
                end
            end
            wait(1)
        end
    end,
})

local AGrabCrates = Tab:CreateToggle({
    Name = "Anti Ability",
    CurrentValue = false,
    Callback = function(Value)
        _G.antiability = Value
        while _G.antiability do
            for _, other in ipairs(gameStuff:GetChildren()) do
                local touchinterest = other:FindFirstChildWhichIsA("TouchInterest")
                if touchinterest then touchinterest:Destroy() end
            end
            wait(0.1)
        end
    end,
})

local jumpConnection
_G.jumpCooldown = false

local NoJumpCooldown = Tab:CreateButton({
    Name = "No Jump Cooldown",
    Callback = function()
        _G.jumpCooldown = not _G.jumpCooldown
        jumpConnection = RunService.RenderStepped:Connect(function()
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            end

            if not _G.jumpCooldown then
                jumpConnection:Disconnect()
                jumpConnection = nil
            end
        end)
    end,
})

local Section = Tab:CreateSection("Bypasses")

local BypassAC = Tab:CreateButton({
    Name = "Anticheat Bypasser",
    Callback = function()
        -- This is a really dumb disabler but since the anticheat is localscript we can just delete the remote it uses to kick the player
        local kickRemote = rs.Stuff.Events:FindFirstChild("KickRemote")
        if kickRemote then kickRemote:Destroy() end
    end,
})

local BypassResetTax = Tab:CreateButton({
    Name = "Reset Tax Bypasser",
    Callback = function()
        -- Again just delete the remote
        local resetRemote = rs.Stuff.Events:FindFirstChild("Reset")
        if resetRemote then resetRemote:Destroy() end
    end,
})

local Section = Tab:CreateSection("Misc")

local Excalibur = Tab:CreateButton({
    Name = "Get Excalibur",
    Callback = function()
        local excalibur = gameStuff:FindFirstChild("ExcaliburIsland")
        if excalibur then
            excalibur.Rock.Hitbox.CFrame = plr.CFrame
            excalibur.Rock.hitbox.Prompt.HoldDuration = 0
            fireproximityprompt(excalibur.Rock.Hitbox.Prompt)
        end
    end,
})

local Unskydive = Tab:CreateButton({
    Name = "Unskydive",
    Callback = function()
        wrk.Lobby.EnterArena.Script.Unskydive:FireServer()
    end,
})

local Fun = Window:CreateTab("Fun")
local emoteAnim = sg.Main.Taunt.Anim1
local danceSpeed = 1
local currentTrack

local Section = Fun:CreateSection("I highly recommend activating anticheat disabler before using any of these features!")

local Section = Fun:CreateSection("Fun Stuff")

local Invis = Fun:CreateToggle({
    Name = "Invis [FE]",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            local savedpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-25.95, 84, 3537.55))
            wait(.15)
            local Seat = Instance.new('Seat', game.Workspace)
            Seat.Anchored = false
            Seat.CanCollide = false
            Seat.Name = 'invischair'
            Seat.Transparency = 1
            Seat.Position = Vector3.new(-25.95, 84, 3537.55)
            local Weld = Instance.new("Weld", Seat)
            Weld.Part0 = Seat
            Weld.Part1 = game.Players.LocalPlayer.Character:FindFirstChild("Torso") or game.Players.LocalPlayer.Character.UpperTorso
            wait()
            Seat.CFrame = savedpos
        else
            workspace:FindFirstChild('invischair'):Remove()
        end
    end,
})

local spinSpeed = 1

local Spinny = Fun:CreateToggle({
    Name = "Spinner",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            for i,v in pairs(plr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
                if v.Name == "Spinning" then
                    v:Destroy()
                end
            end
            plr.Character.Humanoid.AutoRotate = false
            local Spin = Instance.new("BodyAngularVelocity")
            Spin.Name = "Spinning"
            Spin.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
            Spin.MaxTorque = Vector3.new(0, math.huge, 0)
            Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
        else
            for i,v in pairs(plr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
                if v.Name == "Spinning" then
                    v:Destroy()
                end
            end
            plr.Character.Humanoid.AutoRotate = true
        end
    end,
})

local SpinnySpeed = Fun:CreateSlider({
    Name = "Spin Speed",
    Range = {1, 250},
    Increment = 1,
    CurrentValue = 0,
    Flag = "SpinSpeed",
    Callback = function(Value)
        spinSpeed = Value
        for i,v in pairs(plr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
            if v.Name == "Spinning" then
                v.AngularVelocity = Vector3.new(0,spinSpeed,0)
            end
        end
    end,
})

local confuseStrength = 100
local connection

local Confuse = Fun:CreateToggle({
    Name = "Confuse [FE]",
    CurrentValue = false,
    Callback = function(Value)
        _G.confuse = Value
        if Value then
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                local vel = plr.Character:FindFirstChild("HumanoidRootPart").Velocity
                local a = math.random(-confuseStrength,confuseStrength)
                local s = math.random(-confuseStrength,confuseStrength)
                local d = math.random(-confuseStrength,confuseStrength)
                plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(a,s,d)
                RunService.RenderStepped:Wait()
                plr.Character:FindFirstChild("HumanoidRootPart").Velocity = vel

                if not _G.confuse then
                    connection:Disconnect()
                    connection = nil
                end

                -- Basically other people will see you flying around and shit but u are actually in the same place the entire time!!!
            end)
        end
    end,
})

local ConfuseSlider = Fun:CreateSlider({
    Name = "Confuse Strength",
    Range = {0, 1000},
    Increment = 10,
    CurrentValue = 0,
    Callback = function(Value)
        confuseStrength = Value
    end,
})

local FovSlider = Fun:CreateSlider({
    Name = "Fov",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        wrk.CurrentCamera.FieldOfView = Value
    end,
})

local Section = Fun:CreateSection("Other Scripts")

local IY = Fun:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

local Section = Fun:CreateSection("[FE] Dance")

local SpeedSlider = Fun:CreateSlider({
    Name = "Dance Speed",
    Range = {0.5, 3},
    Increment = 0.1,
    CurrentValue = 1,
    Flag = "Speed",
    Callback = function(Value)
        danceSpeed = Value
        if currentTrack then
            currentTrack:AdjustSpeed(danceSpeed)
        end
    end,
})

local DanceButton = Fun:CreateButton({
    Name = "[FE] Dance",
    Callback = function()
        if currentTrack then
            currentTrack:Stop()
            currentTrack = nil
            return
        end

        if emoteAnim then
            local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                local animator = humanoid:FindFirstChild("Animator") or humanoid:FindFirstChildOfClass("Animator")
                if not animator then
                    animator = Instance.new("Animator")
                    animator.Parent = humanoid
                end

                local animation = Instance.new("Animation")
                animation.AnimationId = emoteAnim.AnimationId

                currentTrack = animator:LoadAnimation(animation)
                currentTrack.Looped = true
                currentTrack:Play(1, 9999999, danceSpeed)
                currentTrack:AdjustSpeed(danceSpeed)
            end
        else
            Rayfield:Notify({Title = "Error", Content = "Emote not found!"})
        end
    end,
})

local DanceDropdown = Fun:CreateDropdown({
    Name = "Select Dance",
    Options = {"Anim1", "Anim2", "Anim3", "TakeTheL", "Smug", "Distraction", "Transendence", "Cat Dance"},
    CurrentOption = "Anim1",
    MultipleOptions = false,
    Flag = "Dance",
    Callback = function(Option)
        local emote = typeof(Option) == "table" and Option[1] or Option
        emoteAnim = sg.Main.Taunt:FindFirstChild(emote) or sg.Main.Taunt.GamepassTaunts:FindFirstChild(emote)

        if currentTrack and emoteAnim then
            local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                local animator = humanoid:FindFirstChild("Animator") or humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    local animation = Instance.new("Animation")
                    animation.AnimationId = emoteAnim.AnimationId

                    currentTrack:Stop()
                    currentTrack = animator:LoadAnimation(animation)
                    currentTrack.Looped = true
                    currentTrack:Play(0.1, 9999999, danceSpeed)
                end
            end
        end
    end,
})

local DanceButton = Fun:CreateButton({
    Name = "SUPER Dance Speed",
    Callback = function()
        danceSpeed = 1e7
        if currentTrack then
            currentTrack:AdjustSpeed(1e7)
        end
    end,
})

local Player = Window:CreateTab("Player")

local WalkspeedSlider = Player:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 320},
    Increment = 1,
    CurrentValue = 0,
    Flag = "Walkspeed",
    Callback = function(Value)
        plr.Character.Humanoid.WalkSpeed = Value
    end,
})

local JumppowerSlider = Player:CreateSlider({
    Name = "Jump Power",
    Range = {50, 1000},
    Increment = 1,
    CurrentValue = 0,
    Flag = "Jumppower",
    Callback = function(Value)
        plr.Character.Humanoid.JumpPower = Value
    end,
})

local SitToggle = Player:CreateToggle({
    Name = "Sit",
    CurrentValue = false,
    Callback = function(Value)
        plr.Character.Humanoid.Sit = Value
    end,
})
