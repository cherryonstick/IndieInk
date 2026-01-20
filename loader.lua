-- IndieInk Loader v1.0 | indieink.cc
-- Always fresh: ?v=tick() + nocache
local HttpGet = game:HttpGet

local mainUrl = "https://raw.githubusercontent.com/cherryonstick/IndieInk/main/"

-- Load Rayfield once
local Rayfield = loadstring(HttpGet(mainUrl .. "rayfield.lua", true))()  -- Or keep external if you prefer sirius.menu

local Window = Rayfield:CreateWindow({
   Name = "IndieInk 🎨",
   LoadingTitle = "Inking...",
   LoadingSubtitle = "Hidden Gems Hacks",
   ConfigurationSaving = {Enabled = true, FolderName = "IndieInk", FileName = "Config"},
   Discord = {Enabled = true, Invite = "indieink", RememberJoins = true},
   KeySystem = false
})

-- Load Universal first
loadstring(HttpGet(mainUrl .. "universal.lua?v=" .. tostring(tick()), true))()

-- Game detection & load specific
local PlaceId = game.PlaceId
local gameScript = tostring(PlaceId) .. ".lua"  -- e.g. 16395296930.lua

local success, err = pcall(function()
   loadstring(HttpGet(mainUrl .. gameScript .. "?v=" .. tostring(tick()), true))()
end)

if not success then
   Rayfield:Notify({
      Title = "Game Not Supported Yet",
      Content = "PlaceId: " .. PlaceId .. " | Join Discord to request!",
      Duration = 8
   })
end

print("IndieInk Loader Done! Game: " .. PlaceId)
