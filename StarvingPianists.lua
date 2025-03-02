local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "▶ Starving Pianists ◀",
    Icon = 0,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Agreed 🥵",
    Theme = "DarkBlue",
})

local Main = Window:CreateTab("Main")
Main:CreateSection("Main")

local slotName, slotNumber = "Sybau 💔", 1
local spacing = string.rep("\n", 50) .. string.rep("\u{00A0}", 5000)

local function doShit(notes)
    game:GetService("ReplicatedStorage"):WaitForChild("PianoEvents"):WaitForChild("SaveRecording"):FireServer(
        slotNumber,
        spacing .. slotName .. spacing,
        notes or {}
    )
end

Main:CreateButton({
    Name = "Change Name",
    Callback = function()
        doShit()
    end,
})

Main:CreateButton({
    Name = "Particle Accelerator",
    Callback = function()
        local notes = {}
        for s = 1, 1000 do
            notes[#notes + 1] = -1
            notes[#notes + 1] = {1, s}
            notes[#notes + 1] = -1
            notes[#notes + 1] = {1, -s}
        end
        doShit(notes)
    end,
})

Main:CreateSection("Names last basically forever and don't get tagged.")
Main:CreateInput({
    Name = "Slot Name",
    CurrentValue = slotName,
    PlaceholderText = "Say ANYTHING",
    RemoveTextAfterFocusLost = false,
    Flag = "SlotName",
    Callback = function(Text)
        slotName = Text
    end,
})

Main:CreateDropdown({
    Name = "Slot Number",
    Options = {"1","2","3","4","5 [Paid]","6 [Paid]","7 [Paid]","8 [Paid]"},
    CurrentOption = {"1"},
    MultipleOptions = false,
    Callback = function(Option)
        slotNumber = tonumber(Option[1]) or slotNumber
    end,
})
