-- [< VARIABLES >] --

local RunService = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")

local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local things = game.Workspace:FindFirstChild("__THINGS")

local breakables = things:FindFirstChild("Breakables")
local relics = things:FindFirstChild("Relics")

local merchantAmount = 6
local connect

-- [< VARIABLES >] --


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "▶ Pets Go ◀",LoadingTitle = "Loading...",LoadingSubtitle = "by Agreed69 🥵",ConfigurationSaving = {Enabled = false,}})

local main = Window:CreateTab("Main")
local buy = Window:CreateTab("Auto Buy")

-- [< MAIN >] --

local Section = main:CreateSection("Main")
local Section = buy:CreateSection("Auto Buy")

local Toggle = main:CreateToggle({
    Name = "Auto Open Eggs",
    CurrentValue = false,
    Flag = "",
    Callback = function(Value)
        _G.open = Value
        if Value then
            Rayfield:Notify({Title = "Auto Open Eggs ✅", Content = "Enabled!", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Auto Open Eggs ❌", Content = "Disabled!", Duration = 1, Image = 0})
        end
        while _G.open do
            rs.Network.Eggs_Roll:InvokeServer()
            wait()
        end
    end,
})

local Toggle = main:CreateToggle({
    Name = "Breakables Farm",
    CurrentValue = false,
    Flag = "",
    Callback = function(Value)
        if breakables then
            _G.tc = Value
            if Value then
                Rayfield:Notify({Title = "Breakables Farm ✅", Content = "Enabled!", Duration = 1, Image = 0})
            else
                Rayfield:Notify({Title = "Breakables Farm ❌", Content = "Disabled!", Duration = 1, Image = 0})
            end
            if connect then
                connect:Disconnect()
            end
            if Value then
                connect = RunService.Heartbeat:Connect(function()
                    local e = 0
                    for _, breakable in ipairs(breakables:GetChildren()) do
                        if breakable:IsA("Model") then
                            for _, meshPart in ipairs(breakable:GetChildren()) do
                                if meshPart:FindFirstChild("Hitbox") then
                                    meshPart.CFrame = hrp.CFrame
                                    meshPart.Transparency = 1
                                    meshPart.Hitbox.CFrame = hrp.CFrame
                                    meshPart.Hitbox.Size = Vector3.new(6 + e,6 + e,6 + e)
                                    meshPart.Hitbox.Transparency = 0
                                    e = e + 0.05
                                    break
                                end
                            end
                        end
                    end
                end)
            else
                if connect then
                    connect:Disconnect()
                    connect = nil
                end
            end
        else
            Rayfield:Notify({Title = "Breakables Farm ❌", Content = "Breakables folder not found! Did you buy the upgrade for it?", Duration = 1, Image = 0})
        end
    end,
})

local Button = main:CreateButton({
    Name = "Bring Relics",
    Callback = function()
        if relics then
            for _, relic in ipairs(relics:GetDescendants()) do
                if relic:IsA("MeshPart") and relic:FindFirstChild("ClickDetector") then
                    while relic:FindFirstChild("ClickDetector") do
                        relic.Position = hrp.Position + Vector3.new(0, 5, 0)
                        wait(0.1)
                    end
                    relic:Destroy()
                end
            end
            Rayfield:Notify({Title = "Bring Relics ✅", Content = "Finished!", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Bring Relics ❌", Content = "Relics folder not found! Did you buy the upgrade for it?", Duration = 1, Image = 0})
        end
    end,
})

-- [< MAIN >] --



-- [< AUTO BUY >] --

local Toggle = buy:CreateToggle({
    Name = "Potion Vending Machine",
    CurrentValue = false,
    Flag = "",
    Callback = function(Value)
        _G.vending = Value
        if Value then
            Rayfield:Notify({Title = "Potion Vending Machine ✅", Content = "Enabled!", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Potion Vending Machine ❌", Content = "Disabled!", Duration = 1, Image = 0})
        end
        while _G.vending do
            rs.Network.VendingMachines_Purchase:InvokeServer("PotionVendingMachine")
            wait(0.05)
        end
    end,
})

local Toggle = buy:CreateToggle({
    Name = "Merchant",
    CurrentValue = false,
    Flag = "",
    Callback = function(Value)
        _G.merchant = Value
        if Value then
            Rayfield:Notify({Title = "Merchant ✅", Content = "Enabled!", Duration = 1, Image = 0})
        else
            Rayfield:Notify({Title = "Merchant ❌", Content = "Disabled!", Duration = 1, Image = 0})
        end
        while _G.merchant do
            for i = 1, merchantAmount, 1 do
                for sex = 0, 10, 1 do
                    rs.Network.CustomMerchants_Purchase:InvokeServer("StandardMerchant", i)
                    wait()
                end
                wait(0.1)
            end
            wait(5)
        end
    end,
})

local Slider = buy:CreateSlider({
    Name = "Merchant Buy Slots",
    Range = {1, 6},
    Increment = 1,
    Suffix = "Slots",
    CurrentValue = 6,
    Flag = "",
    Callback = function(Value)
        merchantAmount = Value
    end,
 })

-- [< AUTO BUY >] --
