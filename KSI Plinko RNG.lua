local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "▶ Ksi Plinko RNG ◀",
	LoadingTitle = "Loading...",
	LoadingSubtitle = "by Agreed 🥵",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "KsiPlinkoRng",
		FileName = "byAgreed"
	},
})

local Main = Window:CreateTab("Main", 4483362458)
local PvP = Window:CreateTab("PvP", 4483362458)

--> [< Variables >] <--

local wrk = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local pets = plr:FindFirstChild("Pets")
local char = plr.Character
local hrp = char.HumanoidRootPart

local money = 0
local title = nil
local swordAmount = 0
local droppedswordAmount

local clip = false
local noclipping = nil

local validTitles = {
    "NEWBIE", "MEMBER", "LESS NOOB", "LUCKY", "BETTER", "GAMBLER",
    "ADDICTED", "HIGH ROLLER", "MEGA", "RICH", "GODLY", "HIM",
    "MILLIONAIRE", "BILLIONAIRE", "TRILLIONAIRE", "QUADRILLIONAIRE"
}

--> [< Variables >] <--

local Button = Main:CreateButton({
	Name = "Inf Money",
	Callback = function()
        if money ~= 0 then
            rs.Add:FireServer({["Funny"] = "durpiei1",["Cash"] = money}) -- Don't touch or you might be banned cuz the dev made some checks
            Rayfield:Notify({Title = "Inf Money ✅", Content = "Gave you: $" .. money, Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Inf Money ❌", Content = "You forgot to put the amount of money you want!!!", Duration = 1.5, Image = 0})
        end
	end,
})

local Input = Main:CreateInput({
	Name = "Money Amount",
	PlaceholderText = "How much money you want",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
        local amount = tonumber(Text)
        if amount then
            money = amount
            Rayfield:Notify({Title = "Money Amount ✅", Content = "Click Inf Money to get the money.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Money Amount ❌", Content = "Please enter a valid number!!!", Duration = 1, Image = 0})
        end
	end,
})

local autoprestige = Main:CreateToggle({
	Name = "Auto Prestige",
	CurrentValue = false,
	Flag = "AutoPrestige",
	Callback = function(Value)
        _G.prestige = Value
        if Value then
            Rayfield:Notify({Title = "Auto Prestige ✅", Content = "Enabled Auto Prestige.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Auto Prestige ❌", Content = "Disabled Auto Prestige.", Duration = 1, Image = 0})
        end
        while _G.prestige do
            rs.Prestige:FireServer(1)
            wait()
        end
	end,
})

local multispammer = Main:CreateToggle({
	Name = "Multi Spammer",
	CurrentValue = false,
	Flag = "MultiSpammer",
	Callback = function(Value)
        _G.multi = Value
        if Value then
            if #pets:GetChildren() ~= 0 then
                Rayfield:Notify({Title = "Multi Spammer ✅", Content = "Enabled Multi Spammer.", Duration = 1, Image = 0})
                while _G.multi do
                    for _, randompet in ipairs(pets:GetChildren()) do
                        game:GetService("ReplicatedStorage").EquipPet:FireServer(randompet.Name, true)
                        RunService.RenderStepped:Wait()
                    end
                end
            else
                Rayfield:Notify({Title = "Multi Spammer ❌", Content = "The Pets folder is empty!!! Try hatching a pet.", Duration = 1.5, Image = 0})
            end
        else
            Rayfield:Notify({Title = "Multi Spammer ❌", Content = "Disabled Multi Spammer.", Duration = 1, Image = 0})
        end
	end,
})

local Button = Main:CreateButton({
	Name = "Inf Pet Equips",
	Callback = function()
        plr.MaxPets.Value = 9999999
        Rayfield:Notify({Title = "Inf Pet Equips ✅", Content = "Gave you a lot of pet equips.", Duration = 1, Image = 0})
	end,
})

local Button = Main:CreateButton({
	Name = "Equip Title",
	Callback = function()
        if title ~= nil then
            rs.Title:FireServer(title)
            Rayfield:Notify({Title = "Equip Title ✅", Content = "Trying to equip: " .. title, Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Equip Title ❌", Content = "You forgot to put the title you want!!!", Duration = 1.5, Image = 0})
        end
	end,
})

local Input = Main:CreateInput({
	Name = "Title Name",
	PlaceholderText = "Any title from the shop",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
        if table.find(validTitles, Text) then
            title = Text
            Rayfield:Notify({Title = "Money Amount ✅", Content = "Click Equip Title for the title.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Money Amount ❌", Content = "Enter a valid title (Case sensitive)", Duration = 1, Image = 0})
        end
	end,
})

local swordspawner = Main:CreateToggle({
	Name = "Sword Spawner [FE]",
	CurrentValue = false,
	Flag = "SwordSpawner",
	Callback = function(Value)
        _G.spawner = Value
        if Value then
            droppedswordAmount = 0
            local oldCFrame = hrp.CFrame
            local clip = true
            local function noclipping()
                if clip == true and char ~= nil then
                    for _, child in pairs(char:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true then
                            child.CanCollide = false
                        end
                    end
                end
            end
            noclipping = RunService.Stepped:Connect(noclipping)
            while _G.spawner do
                hrp.CFrame = CFrame.new(Vector3.new(-92, 206, 91)) + Vector3.new(0,0,0)
                wait(0.15)
                hrp.CFrame = CFrame.new(Vector3.new(-38, 206, 92)) + Vector3.new(0,0,0)
                wait(0.5)
                local t = char:FindFirstChild("ClassicSword")
                if t then
                    t.Parent = wrk
                    droppedswordAmount = droppedswordAmount + 1
                    Rayfield:Notify({Title = "Sword Spawner", Content = "Dropped sword: " ..  droppedswordAmount, Duration = 1, Image = 0})
                end
                wait(0.2)
            end
            hrp.CFrame = oldCFrame
            noclipping:Disconnect()
            clip = false
            Rayfield:Notify({Title = "Sword Spawner ✅", Content = "Done! Make sure to use collect swords button to get them.", Duration = 1, Image = 0})
        end
	end,
})

local Button = Main:CreateButton({
	Name = "Collect Swords",
	Callback = function()
        swordAmount = 0
        for _, v in ipairs(wrk:GetChildren()) do
            if v:IsA("Tool") then
                v.Handle.CFrame = hrp.CFrame
                swordAmount = swordAmount + 1
            end
        end
        if swordAmount ~= 0 then
            Rayfield:Notify({Title = "Collected Swords ✅", Content = "Collected " .. swordAmount .. " swords.", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "No Swords ❌", Content = "Spawn some using sword spawner!!!", Duration = 1, Image = 0})
        end
	end,
})

local Button = Main:CreateButton({
	Name = "Drop All Swords",
	Callback = function()
        for i,v in pairs(plr.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = char
            end
        end
        wait()
        for i,v in pairs(char:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = workspace
            end
        end
        Rayfield:Notify({Title = "Dropped All Swords ✅", Content = "Dropped all swords.", Duration = 1, Image = 0})
	end,
})

local Button = Main:CreateButton({
	Name = "Remove Walls/Blockers",
	Callback = function()
        for _, v in ipairs(wrk:GetChildren()) do
            if v.Name == "PartyDoor" then
                v:Destroy()
            elseif v.Name == "Walls" then
                v:Destroy()
            elseif v.Name == "VIPObby" then
                v:Destroy()
            elseif v.Name == "HardObby" then
                v:Destroy()
            elseif v.Name == "ObbyKillPart" then
                v:FindFirstChildWhichIsA("TouchTransmitter"):Destroy()
            elseif v.Name == "InvisPart" then
                v:Destroy()
            end
        end
        Rayfield:Notify({Title = "Removed Walls/Blockers ✅", Content = "Finished destroying everything!", Duration = 1, Image = 0})
	end,
})

-- aaaaaaaaaaaaaaaaaaaaa

local Label = PvP:CreateLabel("PvP with other gui users!")
local Label = PvP:CreateLabel("Turning the toggle on makes sword deal damage")
local Label = PvP:CreateLabel("You must also get a sword with my script")

local pvptoggle = PvP:CreateToggle({
	Name = "PvP",
	CurrentValue = false,
	Flag = "PvPToggle",
	Callback = function(Value)
        if Value then
            plr.SwordFighting.Value = true
            Rayfield:Notify({Title = "PvP ✅", Content = "Enabled, now find someone else using the script and fight them.", Duration = 1, Image = 0})
        else
            plr.SwordFighting.Value = false
            Rayfield:Notify({Title = "PvP ❌", Content = "Disabled.", Duration = 1, Image = 0})
        end
	end,
})

local Label = PvP:CreateLabel("Btw this doesn't kill non-exploiters or exploiters with the toggle off")
