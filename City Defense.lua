-- Made for https://scriptblox.com/u/coyx

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--> [< Variables >] <--
local players = game:GetService("Players")
local plr = players.LocalPlayer
local hrp = plr.Character.HumanoidRootPart
local wrk = game:GetService("Workspace")
local inputService = game:GetService("UserInputService")
local rstorage = game:GetService("ReplicatedStorage")
local e = rstorage.Knit.Services

local target = nil
local moneyValue = 0
local raidMoneyValue = 0
local autoButtonDelay = 0.1

local surrender = true

local infiniteJump = false
--> [< Variables >] <--

--> [< Remotes >] <--
local moneyR = e.RaidService.RF.GiveReward
local payR = e.TycoonService.RF.PayIncome
local raidR = e.RaidService.RF.StartRaid
local spawnmobR = e.RaidService.RF.SpawnMob
local surrenderR = e.RaidService.RF.RaiderSurrendered
local buyR = e.TycoonService.RF.BuyObject
local rebirthR = e.TycoonService.RF.Rebirth
--> [< Remotes >] <--

local function getClosest(input)
    input = input:lower()
    local closestMatch = nil
    local shortestDistance = math.huge

    for _, player in pairs(players:GetPlayers()) do
        local playerName = player.Name:lower()
        local distance = #playerName - #input

        if playerName:sub(1, #input) == input and distance < shortestDistance then
            closestMatch = player.Name
            shortestDistance = distance
        end
    end

    return closestMatch
end

local Window = Rayfield:CreateWindow({
	Name = "▶ City Defense ◀",
	LoadingTitle = "Loading...",
	LoadingSubtitle = "by Agreed 🥵",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "CityDefense",
		FileName = "byAgreed"
	},
})

local main = Window:CreateTab("Main 🤑", 4483362458)
local raid = Window:CreateTab("Raid 💣", 4483362458)
local misc = Window:CreateTab("Misc 👀", 4483362458)

local infinitemoneysection = main:CreateSection("Infinite Money")

local spawnmoney = main:CreateButton({
	Name = "[FE] Spawn Money",
	Callback = function()
        if moneyValue ~= 0 then
            moneyR:InvokeServer(moneyValue)
            Rayfield:Notify({Title = "Spawn Money ✅", Content = "Spawned: $" .. moneyValue,Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Spawn Money ❌", Content = "You forgot to choose how much.",Duration = 1, Image = 0,})
        end
	end,
})

local moneyamount = main:CreateInput({
	Name = "Money Amount",
	PlaceholderText = "How much money you want",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
        local amount = tonumber(Text)
        if amount and amount ~= 0 then
            moneyValue = amount
            Rayfield:Notify({Title = "Money Amount ✅", Content = "Click Spawn Money to get the money.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Money Amount ❌", Content = "Please enter a valid number!!!", Duration = 1, Image = 0})
        end
	end,
})

local spawnraidmoney = main:CreateButton({
	Name = "[RAID] Spawn Money",
	Callback = function()
        if raidMoneyValue ~= 0 then
            raidR:InvokeServer(plr.Name)
            spawnmobR:InvokeServer("Giant", -raidMoneyValue)
            surrenderR:InvokeServer()
            Rayfield:Notify({Title = "Spawn Money ✅", Content = "Spawned: $" .. raidMoneyValue,Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Spawn Money ❌", Content = "You forgot to choose how much.",Duration = 1, Image = 0,})
        end
	end,
})

local raidmoneyamount = main:CreateInput({
	Name = "Raid Money Amount",
	PlaceholderText = "How much money you want",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
        local amount = tonumber(Text)
        if amount and amount ~= 0 then
            raidMoneyValue = amount
            Rayfield:Notify({Title = "Raid Money Amount ✅", Content = "Click Spawn Raid Money to get the money.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Raid Money Amount ❌", Content = "Please enter a valid number!!!", Duration = 1, Image = 0})
        end
	end,
})

local automatedsection = main:CreateSection("Automated")

local autobuttons = main:CreateToggle({
    Name = "Auto Buttons [USE PRIVATE SERVER]",
    CurrentValue = false,
    Flag = "AutoButtons",
    Callback = function(Value)
        _G.buttons = Value
        if not Value then
            Rayfield:Notify({Title = "Auto Buttons ❌", Content = "Disabled Auto Buttons.",Duration = 1, Image = 0,})
        else
            moneyR:InvokeServer(100000000)
            local tycoon = wrk.Tycoons:FindFirstChild("Tycoon")
            if tycoon then
                local button = tycoon:FindFirstChild("Buttons")
                if button then
                    Rayfield:Notify({Title = "Auto Buttons ✅", Content = "Enabled Auto Buttons.",Duration = 1, Image = 0,})
                    wait(0.1)
                    Rayfield:Notify({Title = "Auto Buttons", Content = "If it teleports the wrong buttons, go into a free private server!",Duration = 2, Image = 0,})
                    while _G.buttons do
                        for _, v in ipairs(button:GetChildren()) do
                            if v:FindFirstChild("Type") and v:FindFirstChild("Top") then
                                if v.Type.Value ~= "Gamepass" and v.Top.CFrame ~= hrp.CFrame then
                                    local name = v.Name
                                    if name:sub(1, 6) == "Wizard" or name:sub(1, 7) == "Soldier" or name:sub(1, 6) == "Archer" or name:sub(1, 5) == "Ninja" or name:sub(1, 6) == "Bomber" then
                                        buyR:InvokeServer(v.Name, 3)
                                    else
                                        v.Top.CanCollide = false
                                        v.Top.CFrame = hrp.CFrame
                                    end
                                end                                
                            end
                        end
                        wait(autoButtonDelay)
                    end
                else
                    Rayfield:Notify({Title = "Auto Buttons ❌", Content = "Couldn't find buttons folder.",Duration = 1, Image = 0,})
                end
            else
                Rayfield:Notify({Title = "Auto Buttons ❌", Content = "No tycoons found (Wrong game?)",Duration = 1, Image = 0,})
            end
        end
    end
})

local updatedelay = main:CreateSlider({
	Name = "Update Delay",
	Range = {0, 1},
	Increment = .1,
	CurrentValue = 0.1,
	Flag = "UpdateDelay",
	Callback = function(Value)
        autoButtonDelay = Value
	end,
})

local autorebirth = main:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        _G.rebirth = Value
        if Value then
            Rayfield:Notify({Title = "Auto Rebirth ✅", Content = "Enabled Auto Rebirth.",Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Auto Rebirth ❌", Content = "Disabled Auto Rebirth.",Duration = 1, Image = 0,})
        end
        while _G.rebirth do
            rebirthR:InvokeServer()
            wait(1)
        end
    end
})

local uselesssection = main:CreateSection("Useless")

local incomespam = main:CreateToggle({
    Name = "Income Spam",
    CurrentValue = false,
    Flag = "IncomeSpam",
    Callback = function(Value)
        _G.income = Value
        if Value then
            Rayfield:Notify({Title = "Income Spam ✅", Content = "Enabled Income Spam.",Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Income Spam ❌", Content = "Disabled Income Spam.",Duration = 1, Image = 0,})
        end
        while _G.income do
            payR:InvokeServer()
            wait()
        end
    end
})

local opraidsection = raid:CreateSection("OP Raid")

local raidmobspam = raid:CreateToggle({
    Name = "Raid Mob Spam [FREE]",
    CurrentValue = false,
    Flag = "RaidMobSpam",
    Callback = function(Value)
        _G.mobspam = Value
        if Value then
            Rayfield:Notify({Title = "Raid Mob Spam ✅", Content = "Enabled Raid Mob Spam.",Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Raid Mob Spam ❌", Content = "Disabled Raid Mob Spam.",Duration = 1, Image = 0,})
        end
        while _G.mobspam do
            spawnmobR:InvokeServer("Prisoner", 0)
            spawnmobR:InvokeServer("Thief", 0)
            spawnmobR:InvokeServer("Gangster", 0)
            spawnmobR:InvokeServer("Hacker", 0)
            spawnmobR:InvokeServer("Hitman", 0)
            spawnmobR:InvokeServer("Clown", 0)
            spawnmobR:InvokeServer("Giant", 0)
            wait(0.05)
        end
    end
})

local raidspamsection = raid:CreateSection("Raid Spam")

local raidspam = raid:CreateToggle({
    Name = "Raid Spam [ANNOYING]",
    CurrentValue = false,
    Flag = "RaidSpam",
    Callback = function(Value)
        _G.raidspam = Value
        if Value then
            if target then
                Rayfield:Notify({Title = "Raid Spam ✅", Content = "Enabled Raid Spam.",Duration = 1, Image = 0,})
                while _G.raidspam do
                    raidR:InvokeServer(target)
                    if surrender then
                        surrenderR:InvokeServer()
                    end
                    wait()
                end
            else
                Rayfield:Notify({Title = "Raid Spam ❌", Content = "Choose a target first!",Duration = 1, Image = 0,})
            end
        else
            Rayfield:Notify({Title = "Raid Spam ❌", Content = "Disabled Raid Spam.",Duration = 1, Image = 0,})
        end
    end
})

local surrender = raid:CreateToggle({
    Name = "Surrender",
    CurrentValue = true,
    Flag = "Surrender",
    Callback = function(Value)
        surrender = Value
    end
})

local raidtarget = raid:CreateInput({
	Name = "Raid Target",
	PlaceholderText = "Target Name (autofills)",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
        target = getClosest(Text)
        if target then
            Rayfield:Notify({Title = "Raid Target ✅", Content = "Selected target: " .. target,Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Raid Target ❌", Content = "Couldn't find player!!!", Duration = 1, Image = 0,})
        end
	end,
})

local raidsection = raid:CreateSection("Raid")

local surrenderraid = raid:CreateButton({
	Name = "Force Surrender Raid",
	Callback = function()
        surrenderR:InvokeServer()
        Rayfield:Notify({Title = "Force Surrender Raid ✅", Content = "Raid Surrendered.",Duration = 1, Image = 0,})
	end,
})

local startraid = raid:CreateButton({
	Name = "Force Start Raid",
	Callback = function()
        if target then
            raidR:InvokeServer(target)
            Rayfield:Notify({Title = "Force Start Raid ✅", Content = "Started raid with: " .. target,Duration = 1, Image = 0,})
        else
            Rayfield:Notify({Title = "Force Start Raid ❌", Content = "No valid target selected!!!", Duration = 1, Image = 0,})
        end
	end,
})

local playersection = misc:CreateSection("Player")

local walkspeed = misc:CreateSlider({
	Name = "Walk Speed",
	Range = {16, 200},
	Increment = 1,
	CurrentValue = 16,
	Flag = "WalkSpeed",
	Callback = function(Value)
        plr.Character.Humanoid.WalkSpeed = Value
        Rayfield:Notify({Title = "Walk Speed ✅", Content = "New Walkspeed: " .. Value,Duration = 1, Image = 0,})
	end,
})

local jumpheight = misc:CreateSlider({
	Name = "Jump Height",
	Range = {50, 500},
	Increment = 1,
	CurrentValue = 50,
	Flag = "JumpHeight",
	Callback = function(Value)
        plr.Character.Humanoid.JumpHeight = Value
        Rayfield:Notify({Title = "Jump Height ✅", Content = "New Jump Height: " .. Value,Duration = 1, Image = 0,})
	end,
})

local infJump
local jumping = false
local infjump = misc:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        if Value then
            if infJump then
                infJump:Disconnect()
            end
            jumping = false
            infJump = inputService.JumpRequest:Connect(function()
                if not jumping then
                    jumping = true
                    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    wait()
                    jumping = false
                end
            end)
        else
            if infJump then
                infJump:Disconnect()
            end
            jumping = false
        end
    end,
})
