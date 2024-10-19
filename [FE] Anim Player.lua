-- Idk I made this shit a while ago probably buggy asf

local plr = game:GetService("Players").LocalPlayer
local humanoid = plr.Character:WaitForChild("Humanoid")
local animSpeed = 1
local presetranimSpeed = 1
local exploreranimSpeed = 1
local weirdsitWeight = 0.1
local weirdsit = false
local animId
local currentTrack

local function playAnim(id, speed)
    if currentTrack then
        currentTrack:Stop()
    end
    local Anim = Instance.new("Animation")
    Anim.AnimationId = "rbxassetid://" .. id
    currentTrack = humanoid:LoadAnimation(Anim)
    currentTrack.Looped = true
    currentTrack:Play(.1, 9999999, speed)
end

local function stopAnim()
    if currentTrack then
        currentTrack:Stop()
    end
end

local function fix(character)
    humanoid = character:WaitForChild("Humanoid")
end

plr.CharacterAdded:Connect(function(character)
    fix(character)
end)

if plr.Character then
    fix(plr.Character)
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "[FE] Animation Player",
    LoadingTitle = "Loading Animation GUI...",
    LoadingSubtitle = "by Agreed69 🥵",
})

local Player = Window:CreateTab("Player", 4483362458)
local Presets = Window:CreateTab("Presets", 4483362458)
local Explorer = Window:CreateTab("Explorer", 4483362458)

local Label = Player:CreateLabel("Some may need R15")

local Input = Player:CreateInput({
    Name = "Animation Id",
    PlaceholderText = "Enter Animation ID",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        animId = Text
    end,
})

local Slider = Player:CreateSlider({
	Name = "Animation Speed",
	Range = {0, 100},
	Increment = 1,
	Suffix = "",
	CurrentValue = 1, 
	Flag = "aeaeaea",
	Callback = function(Value)
        animSpeed = Value
        if currentTrack then
            currentTrack:AdjustSpeed(animSpeed)
        end
	end,
})

local StartButton = Player:CreateButton({
    Name = "Start Animation",
    Callback = function()
        if animId then
            playAnim(animId, animSpeed)
        end
    end,
})

local StopButton = Player:CreateButton({
    Name = "Stop Animation",
    Callback = function()
        stopAnim()
    end,
})

local SuperSpeedButton = Player:CreateButton({
    Name = "Super Speed [ALL]",
    Callback = function()
        animSpeed = 1e7
        presetranimSpeed = 1e7
        exploreranimSpeed = 1e7
        if currentTrack then
            currentTrack:AdjustSpeed(1e7)
        end
        Rayfield:Notify({Title = "Animation Player", Content = "Made animations fast as FUCK", Duration = 1, Image = 4483362458,})
    end,
})

local Slider = Presets:CreateSlider({
	Name = "Preset Animation Speed",
	Range = {0, 100},
	Increment = 1,
	Suffix = "",
	CurrentValue = 1,
	Flag = "aeaeaea",
	Callback = function(Value)
        presetranimSpeed = Value
        if currentTrack then
            currentTrack:AdjustSpeed(presetranimSpeed)
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Idle 1",
	CurrentValue = false,
	Flag = "idle1",
	Callback = function(Value)
        if Value then
            playAnim(180435571, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Idle 2",
	CurrentValue = false,
	Flag = "idle2",
	Callback = function(Value)
        if Value then
            playAnim(180435792, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Walk",
	CurrentValue = false,
	Flag = "walk",
	Callback = function(Value)
        if Value then
            playAnim(180426354, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Jump",
	CurrentValue = false,
	Flag = "jump",
	Callback = function(Value)
        if Value then
            playAnim(125750702, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Climb",
	CurrentValue = false,
	Flag = "climb",
	Callback = function(Value)
        if Value then
            playAnim(180436334, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Hold Tool",
	CurrentValue = false,
	Flag = "hold",
	Callback = function(Value)
        if Value then
            playAnim(182393478, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Fall",
	CurrentValue = false,
	Flag = "fall",
	Callback = function(Value)
        if Value then
            playAnim(180436148, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Sit",
	CurrentValue = false,
	Flag = "sit",
	Callback = function(Value)
        if Value then
            playAnim(179224234, presetranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Slider = Presets:CreateSlider({
	Name = "Weird Sit Weight",
	Range = {0.1, 1},
	Increment = 0.1,
	Suffix = "",
	CurrentValue = 0.1,
	Flag = "aeeaeaea",
	Callback = function(Value)
        weirdsitWeight = Value
        if weirdsit and currentTrack then
            currentTrack:AdjustWeight(weirdsitWeight, 0)
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Weird Sit",
	CurrentValue = false,
	Flag = "wsit",
	Callback = function(Value)
        if Value then
            if currentTrack then
                currentTrack:Stop()
            end
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://179224234"
            currentTrack = humanoid:LoadAnimation(Anim)
            currentTrack.Looped = true
            currentTrack:Play(.1, weirdsitWeight, 1)
            weirdsit = true
        elseif not Value then
            stopAnim()
            weirdsit = false
        end
	end,
})

local Toggle = Presets:CreateToggle({
	Name = "Sit Idk",
	CurrentValue = false,
	Flag = "sitidk",
	Callback = function(Value)
        _G.sittroll = Value
        if Value then
            playAnim(179224234, presetranimSpeed)
            while _G.sittroll do
                for i = .1, 1, .1 do
                    currentTrack:AdjustWeight(i, 0)
                    game:GetService("RunService").RenderStepped:Wait()
                end
                for i = 1, .1, -.1 do
                    currentTrack:AdjustWeight(i, 0)
                    game:GetService("RunService").RenderStepped:Wait()
                end
                wait()
            end
            stopAnim()
        end
	end,
})

local Label = Explorer:CreateLabel("R6")

local Slider = Explorer:CreateSlider({
	Name = "Explorer Animation Speed",
	Range = {0, 100},
	Increment = 1,
	Suffix = "",
	CurrentValue = 1,
	Flag = "aeeaeaea",
	Callback = function(Value)
        exploreranimSpeed = Value
        if currentTrack then
            currentTrack:AdjustSpeed(exploreranimSpeed)
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Head Throw",
	CurrentValue = false,
	Flag = "ht",
	Callback = function(Value)
        if Value then
            playAnim(35154961, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Floating Head",
	CurrentValue = false,
	Flag = "fh",
	Callback = function(Value)
        if Value then
            playAnim(121572214, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Crouch",
	CurrentValue = false,
	Flag = "c",
	Callback = function(Value)
        if Value then
            playAnim(182724289, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Floor Crawl",
	CurrentValue = false,
	Flag = "fc",
	Callback = function(Value)
        if Value then
            playAnim(282574440, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Dyno Walk",
	CurrentValue = false,
	Flag = "dw",
	Callback = function(Value)
        if Value then
            playAnim(204328711, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Jumping Jacks",
	CurrentValue = false,
	Flag = "jj",
	Callback = function(Value)
        if Value then
            playAnim(429681631, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Hero Jump",
	CurrentValue = false,
	Flag = "hj",
	Callback = function(Value)
        if Value then
            playAnim(184574340, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Faint",
	CurrentValue = false,
	Flag = "f",
	Callback = function(Value)
        if Value then
            playAnim(181526230, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Floor Faint",
	CurrentValue = false,
	Flag = "ff",
	Callback = function(Value)
        if Value then
            playAnim(181525546, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Levitate",
	CurrentValue = false,
	Flag = "l",
	Callback = function(Value)
        if Value then
            playAnim(313762630, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Spin",
	CurrentValue = false,
	Flag = "s",
	Callback = function(Value)
        if Value then
            playAnim(188632011, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Moving Dance",
	CurrentValue = false,
	Flag = "md",
	Callback = function(Value)
        if Value then
            playAnim(429703734, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Weird Move",
	CurrentValue = false,
	Flag = "wm",
	Callback = function(Value)
        if Value then
            playAnim(215384594, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Spin Dance",
	CurrentValue = false,
	Flag = "sd",
	Callback = function(Value)
        if Value then
            playAnim(429730430, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Spin Dance 2",
	CurrentValue = false,
	Flag = "sd2",
	Callback = function(Value)
        if Value then
            playAnim(186934910, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Moon Dance",
	CurrentValue = false,
	Flag = "md",
	Callback = function(Value)
        if Value then
            playAnim(45834924, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Full Punch",
	CurrentValue = false,
	Flag = "fp",
	Callback = function(Value)
        if Value then
            playAnim(204062532, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Full Swing",
	CurrentValue = false,
	Flag = "fs",
	Callback = function(Value)
        if Value then
            playAnim(218504594, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Super Punch",
	CurrentValue = false,
	Flag = "sp",
	Callback = function(Value)
        if Value then
            playAnim(126753849, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Bow Down",
	CurrentValue = false,
	Flag = "bd",
	Callback = function(Value)
        if Value then
            playAnim(204292303, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Sword Slam",
	CurrentValue = false,
	Flag = "ss",
	Callback = function(Value)
        if Value then
            playAnim(204295235, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Arm Turbine",
	CurrentValue = false,
	Flag = "sp",
	Callback = function(Value)
        if Value then
            playAnim(259438880, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Barrel Roll",
	CurrentValue = false,
	Flag = "br",
	Callback = function(Value)
        if Value then
            playAnim(136801964, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Scared",
	CurrentValue = false,
	Flag = "s",
	Callback = function(Value)
        if Value then
            playAnim(180612465, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Insane",
	CurrentValue = false,
	Flag = "i",
	Callback = function(Value)
        if Value then
            playAnim(33796059, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Arm Detach",
	CurrentValue = false,
	Flag = "ad",
	Callback = function(Value)
        if Value then
            playAnim(33169583, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Sword Slice",
	CurrentValue = false,
	Flag = "ss",
	Callback = function(Value)
        if Value then
            playAnim(35978879, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Insane Arms",
	CurrentValue = false,
	Flag = "ia",
	Callback = function(Value)
        if Value then
            playAnim(27432691, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Label = Explorer:CreateLabel("R15")

local Toggle = Explorer:CreateToggle({
	Name = "Crazy Slash",
	CurrentValue = false,
	Flag = "cs",
	Callback = function(Value)
        if Value then
            playAnim(674871189, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Open",
	CurrentValue = false,
	Flag = "oa",
	Callback = function(Value)
        if Value then
            playAnim(582855105, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "R15 Spinner",
	CurrentValue = false,
	Flag = "rs",
	Callback = function(Value)
        if Value then
            playAnim(754658275, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Arms Out",
	CurrentValue = false,
	Flag = "ao",
	Callback = function(Value)
        if Value then
            playAnim(582384156, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Float Slash",
	CurrentValue = false,
	Flag = "fs",
	Callback = function(Value)
        if Value then
            playAnim(717879555, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Weird Zombie",
	CurrentValue = false,
	Flag = "wz",
	Callback = function(Value)
        if Value then
            playAnim(708553116, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Down Slash",
	CurrentValue = false,
	Flag = "ds",
	Callback = function(Value)
        if Value then
            playAnim(746398327, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Pull",
	CurrentValue = false,
	Flag = "p",
	Callback = function(Value)
        if Value then
            playAnim(675025795, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Circle Arm",
	CurrentValue = false,
	Flag = "ca",
	Callback = function(Value)
        if Value then
            playAnim(698251653, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Bend",
	CurrentValue = false,
	Flag = "b",
	Callback = function(Value)
        if Value then
            playAnim(696096087, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Rotate Slash",
	CurrentValue = false,
	Flag = "rs",
	Callback = function(Value)
        if Value then
            playAnim(675025570, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})

local Toggle = Explorer:CreateToggle({
	Name = "Fling Arms",
	CurrentValue = false,
	Flag = "fa",
	Callback = function(Value)
        if Value then
            playAnim(754656200, exploreranimSpeed)
        elseif not Value then
            stopAnim()
        end
	end,
})
