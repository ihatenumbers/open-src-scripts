local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer
local hrp = plr.Character:FindFirstChild("HumanoidRootPart")

local sinks = workspace.restaurant.sinks
local selectedItem

local circleHandler = "Players." .. plr.Name .. ".PlayerGui.gameui.skill test.skillTestScript.circleHandler"
local secondCircleHandler = "Players." .. plr.Name .. ".PlayerGui.gameui.skill test.skillTestScript.secondCircleHandler"

local Window = Rayfield:CreateWindow({
    Name = "▶ Disch ◀",
    Icon = 0,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Agreed 🥵",
    Theme = "DarkBlue",
})

local Main = Window:CreateTab("Main")
local Misc = Window:CreateTab("Misc")


local circleHandlerClick = nil
local secondCircleHandlerClick = nil

for _, func in next, getgc(true) do
    if typeof(func) == "function" then
        local funcName = debug.info(func, "n")
        local funcParent = debug.info(func, "s")

        if funcName == "inputBegan" and funcParent == circleHandler then
            circleHandlerClick = func
        elseif funcName == "inputBegan" and funcParent == secondCircleHandler then
            secondCircleHandlerClick = func
            break
        end
    end
end

local Asdaasdadsad = Main:CreateSection("Autofarm")

local AutoClick = Main:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Callback = function(Value)
        _G.autoclick = Value
        local fakeInput = {
            UserInputType = Enum.UserInputType.MouseButton1,
            KeyCode = Enum.KeyCode.Unknown,
        }

        if not circleHandlerClick or not secondCircleHandlerClick then print("Something went very wrong") return end
        while _G.autoclick do
            if plr.PlayerGui.gameui["skill test"].Visible then
                circleHandlerClick(fakeInput, false)
                for i = 1, 3 do
                    secondCircleHandlerClick(fakeInput, false)
                end
            end
            task.wait()
        end
    end,
})

local AutoSink = Main:CreateToggle({
    Name = "Auto Sink",
    CurrentValue = false,
    Callback = function(Value)
        _G.autosink = Value
        
        while _G.autosink do
            for _, sink in ipairs(sinks:GetChildren()) do
                local prompt = sink:FindFirstChild("ProximityPrompt")
                if prompt and prompt.Enabled then
                    fireproximityprompt(prompt)
                end
            end
            task.wait(0.1)
        end
    end,
})

local AutoSell = Main:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(Value)
        _G.autosell = Value
        
        while _G.autosell do
            rs.events.sell:InvokeServer(true)
            task.wait()
        end
    end,
})

local AntiFail = Main:CreateButton({
    Name = "Never Fail",
    Callback = function()
        for _, func in next, getgc(true) do
            if typeof(func) == "function" then
                local funcName = debug.info(func, "n")
                if funcName == "checkValidClick" then
                    hookfunction(func, function()
                        return true
                    end)
                end
            end
        end
    end,
})

local Asdaasdadsad = Main:CreateSection("Other shit")

local AutoClaim = Main:CreateToggle({
    Name = "Auto Claim Playtime",
    CurrentValue = false,
    Callback = function(Value)
        _G.autoclaim = Value

        while _G.autoclaim do
            local rewardsGui = plr.PlayerGui:FindFirstChild("passivegui")
            if rewardsGui then
                local playtimeRewards = rewardsGui:FindFirstChild("playtimeRewards")
                if playtimeRewards then
                    for _, button in ipairs(playtimeRewards.page:GetChildren()) do
                        if button:IsA("GuiButton") and button.time.Text == "CLAIM" then
                            rs.events.playtimeReward:InvokeServer(string.lower(button.reward.Text))
                        end
                    end
                end
            end
            task.wait(1)
        end
    end,
})

local AutoFeedFilly = Main:CreateToggle({
    Name = "Auto Feed Filly",
    CurrentValue = false,
    Callback = function(Value)
        _G.autofeedfilly = Value
        
        while _G.autofeedfilly do
            rs.events.eat:InvokeServer(true)
            task.wait()
        end
    end,
})

local AppraiseItem = Main:CreateButton({
    Name = "Appraise Item",
    Callback = function()
        local heldTool = plr.Character:FindFirstChildOfClass("Tool")
        if not heldTool then print("Hold an item to appraise!") return end
            
        rs.events.appraiseItem:InvokeServer(heldTool)
    end,
})

local Section = Misc:CreateSection("Misc")

local AntiAfk = Misc:CreateButton({
    Name = "Anti Afk",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end,
})

local RemovePopups = Misc:CreateButton({
    Name = "Remove Popups",
    Callback = function()
        plr.PlayerGui.passivegui:FindFirstChild("doubleLuckPopup"):Destroy()
        plr.PlayerGui.passivegui:FindFirstChild("fastDishingPopup"):Destroy()
    end,
})

local BarrierRemove = Misc:CreateButton({
    Name = "Remove Barriers",
    Callback = function()
        local barriers = game.Workspace.restaurant.restaurant:FindFirstChild("barrier")
        if not barriers then return end
        barriers:Destroy()
    end,
})

local Section = Misc:CreateSection("Animations")

local emoteAnim = plr.Character.Humanoid.Animator.digin
local danceSpeed = 1
local currentTrack

local SpeedSlider = Misc:CreateSlider({
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

local AnimButton = Misc:CreateButton({
    Name = "[FE] Play Anim",
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

local AnimDropdown = Misc:CreateDropdown({
    Name = "Select Anim",
    Options = {"digin", "keepdiggin"},
    CurrentOption = "digin",
    MultipleOptions = false,
    Callback = function(Option)
        local emote = typeof(Option) == "table" and Option[1] or Option
        emoteAnim = plr.Character.Humanoid.Animator:FindFirstChild(emote)

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
