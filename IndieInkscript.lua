local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "IndieInk",
   LoadingTitle = "ScriptLoading...",
   LoadingSubtitle = "Hacks for Small/Indie Games",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "IndieInkCfg",
      FileName = "IndieInk"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/2CPW6seNNv",  -- Update with real invite
      RememberJoins = true
   },
   KeySystem = false  -- Set true + add key ask later for premium
})

-- Universal Tab (Always Loads)
local UniversalTab = Window:CreateTab("🎨 Universal", 4483362458)

local MovementSection = UniversalTab:CreateSection("Movement")
local UniversalSpeed = 50
Rayfield:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 50,
   Flag = "UniversalSpeed",
   Callback = function(Value)
      UniversalSpeed = Value
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value
      end
   end,
})

local FlyEnabled = false
Rayfield:CreateToggle({
   Name = "Fly (Space=Up, Shift=Down, WASD)",
   CurrentValue = false,
   Flag = "UniversalFly",
   Callback = function(Value)
      FlyEnabled = Value
      local char = game.Players.LocalPlayer.Character
      if char then
         local root = char:FindFirstChild("HumanoidRootPart")
         if root then
            if Value then
               local bv = Instance.new("BodyVelocity")
               bv.MaxForce = Vector3.new(4000, 4000, 4000)
               bv.Velocity = Vector3.new(0, 0, 0)
               bv.Parent = root
               spawn(function()
                  repeat
                     local cam = workspace.CurrentCamera
                     local hum = char:FindFirstChild("Humanoid")
                     bv.Velocity = (hum.MoveDirection * UniversalSpeed) + Vector3.new(0, (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and 50 or 0) - (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) and 50 or 0), 0)
                     game:GetService("RunService").RenderStepped:Wait()
                  until not FlyEnabled or not root.Parent
                  if bv then bv:Destroy() end
               end)
            else
               if root:FindFirstChild("BodyVelocity") then
                  root:FindFirstChild("BodyVelocity"):Destroy()
               end
            end
         end
      end
   end,
})

local NoclipEnabled = false
Rayfield:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Flag = "UniversalNoclip",
   Callback = function(Value)
      NoclipEnabled = Value
   end,
})
game:GetService("RunService").Stepped:Connect(function()
   if NoclipEnabled then
      local char = game.Players.LocalPlayer.Character
      if char then
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = false
            end
         end
      end
   end
end)

local UniversalSection = UniversalTab:CreateSection("Player")
local GodEnabled = false
Rayfield:CreateToggle({
   Name = "God Mode",
   CurrentValue = false,
   Flag = "UniversalGod",
   Callback = function(Value)
      GodEnabled = Value
   end,
})
game:GetService("RunService").Heartbeat:Connect(function()
   if GodEnabled then
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.Health = math.huge
      end
   end
end)

-- Game Detection
local PlaceId = game.PlaceId

-- Noob Exterminators (PlaceId: 16395296930)
if PlaceId == 16395296930 then
   local NETab = Window:CreateTab("🪰 Noob Exterminators", 4483362458)

   local NEMovementSection = NETab:CreateSection("Movement")
   local NEJump = 100
   Rayfield:CreateSlider({
      Name = "Jump Power",
      Range = {50, 200},
      Increment = 10,
      CurrentValue = 100,
      Flag = "NEJump",
      Callback = function(Value)
         NEJump = Value
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = Value
         end
      end,
   })

   local NECombatSection = NETab:CreateSection("Combat")
   local AuraEnabled = false
   Rayfield:CreateToggle({
      Name = "KillAura (Equip Bat/Stick/Shotgun)",
      CurrentValue = false,
      Flag = "NEAura",
      Callback = function(Value)
         AuraEnabled = Value
      end,
   })
   game:GetService("RunService").Heartbeat:Connect(function()
      if AuraEnabled then
         local char = game.Players.LocalPlayer.Character
         if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
               for _, obj in pairs(workspace:GetDescendants()) do
                  if obj.Parent:FindFirstChild("Humanoid") and obj.Parent ~= char and (string.lower(obj.Parent.Name):find("noob") or string.lower(obj.Parent.Name):find("robot") or string.lower(obj.Parent.Name):find("lurker")) then
                     local hroot = obj.Parent:FindFirstChild("HumanoidRootPart")
                     if hroot and (hroot.Position - root.Position).Magnitude < 15 then
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then
                           tool:Activate()
                        end
                        obj.Parent.Humanoid.Health = 0
                     end
                  end
               end
            end
         end
      end
   end)

   local InfShellsEnabled = false
   Rayfield:CreateToggle({
      Name = "Infinite Shotgun Shells",
      CurrentValue = false,
      Flag = "NEShells",
      Callback = function(Value)
         InfShellsEnabled = Value
         spawn(function()
            while InfShellsEnabled do
               local char = game.Players.LocalPlayer
               for _, tool in pairs(char.Backpack:GetChildren()) do
                  if tool.Name:find("Shotgun") then
                     for _, val in pairs(tool:GetDescendants()) do
                        if val.Name:lower():find("shell") or val.Name:lower():find("ammo") then
                           val.Value = math.huge
                        end
                     end
                  end
               end
               wait(0.1)
            end
         end)
      end,
   })

   local NEVisualsSection = NETab:CreateSection("Visuals")
   local ESPEnabled = false
   Rayfield:CreateToggle({
      Name = "Noob/Robot ESP",
      CurrentValue = false,
      Flag = "NEEsp",
      Callback = function(Value)
         ESPEnabled = Value
         for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent:FindFirstChild("Humanoid") and (string.lower(obj.Parent.Name):find("noob") or string.lower(obj.Parent.Name):find("robot")) then
               if Value then
                  local highlight = Instance.new("Highlight")
                  highlight.FillColor = Color3.new(1, 0, 0)
                  highlight.OutlineColor = Color3.new(1, 1, 1)
                  highlight.Parent = obj.Parent:FindFirstChild("HumanoidRootPart") or obj
                  
                  local bill = Instance.new("BillboardGui")
                  bill.Size = UDim2.new(0, 100, 0, 50)
                  bill.Adornee = obj.Parent:FindFirstChild("Head") or obj
                  bill.Parent = obj.Parent
                  local text = Instance.new("TextLabel", bill)
                  text.Size = UDim2.new(1, 0, 1, 0)
                  text.BackgroundTransparency = 1
                  text.Text = obj.Parent.Name
                  text.TextColor3 = Color3.new(1, 1, 1)
                  text.TextScaled = true
               else
                  if obj.Parent:FindFirstChild("Highlight") then obj.Parent.Highlight:Destroy() end
                  if obj.Parent:FindFirstChild("BillboardGui") then obj.Parent.BillboardGui:Destroy() end
               end
            end
         end
      end,
   })
   -- ESP Distance Update
   game:GetService("RunService").RenderStepped:Connect(function()
      if ESPEnabled then
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            for _, obj in pairs(workspace:GetDescendants()) do
               if obj.Parent:FindFirstChild("BillboardGui") then
                  local dist = math.floor((obj.Parent.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                  obj.Parent.BillboardGui.TextLabel.Text = obj.Parent.Name .. "\nDist: " .. dist
               end
            end
         end
      end
   end)

   Rayfield:Notify({
      Title = "🪰 Noob Exterminators Loaded!",
      Content = "Farm noobs easy! God + Aura OP.",
      Duration = 6,
      Image = 4483362458
   })
end

-- Add more games here the same way!
-- Example: if PlaceId == NEWID then ... end

print("IndieInk v1.3 Loaded! | Updated: " .. os.date("%Y-%m-%d %H:%M:%S"))
Rayfield:Notify({
   Title = "IndieInk Ready! 🎨",
   Content = "Universal + Auto Game Tabs | Enjoy the indies!",
   Duration = 5,
   Image = 4483362458
})
