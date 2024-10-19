local rs = game:GetService("ReplicatedStorage")
local hit = rs.EnemyGetHit

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/agreed69-scripts/scripts/refs/heads/main/pphud%20fix.lua", true))() -- Not made by me but I fixed it and added size option
local Flags = Library.Flags

local Window = Library:Window({
   Text = "❤",
   Size = UDim2.new(0, 250, 0, 150)
})

local Tab = Window:Tab({
   Text = "Too Many Weapons by Agreed69"
})

local Section = Tab:Section({
    Text = "Exploit"
})

Section:Button({
    Text = "Kill All",
    Callback = function()
        for _, enemy in ipairs(game.Workspace.Enemies.dungeon:GetChildren()) do
            hit:FireServer(enemy, 100, true, "item6_rarity1")
        end
    end
})

Section:Check({
    Text = "Loop Kill All",
    Callback = function(bool)
        _G.kill = bool
        while _G.kill do
            for _, enemy in ipairs(game.Workspace.Enemies.dungeon:GetChildren()) do
                hit:FireServer(enemy, 100, true, "item6_rarity1")
            end
            wait(0.1)
        end
    end
})

Tab:Select()
