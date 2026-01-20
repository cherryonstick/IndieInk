-- IndieInk - Noob Exterminators (16395296930)

if game.PlaceId ~= 16395296930 then return end  -- Safety

local NETab = Window:CreateTab(" Noob Exterminators", 4483362458)

-- Movement (game-specific overrides/adds)
local NEMovement = NETab:CreateSection("Movement")
-- e.g. Jump Power slider

-- Combat
local NECombat = NETab:CreateSection("Combat")
-- KillAura toggle + Heartbeat loop
-- Infinite Shells

-- Visuals
local NEVisuals = NETab:CreateSection("Visuals")
-- Noob ESP toggle + RenderStepped update
