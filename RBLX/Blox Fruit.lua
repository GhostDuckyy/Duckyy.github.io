--// Rewrite
while true do
    if game:IsLoaded() then break; end
    wait(.005)
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/FluxLib/FluxLib.lua", true))()
local esp_library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
local w = library:Window("Bread","Blox Fruit")
local sea = 1;

-- Notify library
local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;

-- service
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local VU = game:GetService('VirtualUser')
local TS = game:GetService('TweenService')
local camera = game:GetService('Workspace').CurrentCamera

-- check sea
if game.PlaceId == 2753915549 then -- First Sea
    sea = 1
elseif game.PlaceId == 4442272183 then -- Second Sea
    sea = 2
elseif game.PlaceId == 4442272183 then -- Third Sea
    sea = 3
else -- For stupid/retard user
    setclipboard("https://www.roblox.com/games/2753915549/")
    wait(.5)
    lp:Kick("Copy'ed bloxfruit game link")
end

local screengui = game:GetService("CoreGui"):WaitForChild("FluxLib");
local Icons = {
    Folder = "rbxassetid://8668393244",
    Portal = "rbxassetid://8671667006",
    Vision = "rbxassetid://8671664613",
    Automatic = "rbxassetid://10463883625",
    Shield = "rbxassetid://10463868703",
    User_Shield = "rbxassetid://10463878735",
    User_Folder = "rbxassetid://10463880932",
}

-- getgenv
getgenv().noclip = false;
getgenv().Infinite_jump = false;
getgenv().Jesus = false; -- walk on the sea
getgenv().Auto_Buso = false;
getgenv().Auto_equipTool = false;

getgenv().Chests_Type = nil;getgenv().Chests_Farm = false;getgenv().Chests_Range = 50000;

getgenv().Players_Charms = false;getgenv().Players_Charms_TeamColor = false;getgenv().Players_Charms_Colors = Color3.fromRGB(255,255,255);getgenv().Players_Charms_Outline = Color3.fromRGB(255,255,255);
getgenv().Fruits_Charms = false;getgenv().Fruits_Charms_Colors = Color3.fromRGB(255,255,255);getgenv().Fruits_Charms_Outline = Color3.fromRGB(255,255,255);

getgenv().cancel_Tween = false;

pcall(function() -- setup of esp
    esp_library:Toggle(false)
    esp_library.AutoRemove = true;
    esp_library.TeamColor = true;
    esp_library.FaceCamera = true;
    esp_library.Players = true;

    esp_library.Names = true;
    esp_library.Boxs = true;
    esp_library.Tracers = true;

    do -- Chest
        esp_library:AddObjectListener(workspace, {
            Name = "Chest1",
            Type = "Part",
            CustomName = "Sliver Chest",
            Color = Color3.fromRGB(192,192,192),
            IsEnabled = "Chest1",
        })
        esp_library:AddObjectListener(workspace, {
            Name = "Chest2",
            Type = "Part",
            CustomName = "Gold Chest",
            Color = Color3.fromRGB(218,165,32),
            IsEnabled = "Chest2",
        })
        esp_library:AddObjectListener(workspace, {
            Name = "Chest3",
            Type = "Part",
            CustomName = "Diamond Chest",
            Color = Color3.fromRGB(185,242,255),
            IsEnabled = "Chest3",
        })
    end

    do -- Flower
        esp_library:AddObjectListener(workspace, {
            Name = "Flower1",
            Type = "Part",
            CustomName = "Blue Flower",
            Color = Color3.fromRGB(33, 84, 185),
            IsEnabled = "F1"
        })
        esp_library:AddObjectListener(workspace, {
            Name = "Flower2",
            Type = "Part",
            CustomName = "Red Flower",
            Color = Color3.fromRGB(163, 75, 75),
            IsEnabled = "F2"
        })
    end

    do -- Fruit
        esp_library:AddObjectListener(workspace, {
            Type = "Tool",
            PrimaryPart = function(v)
                if v:FindFirstChild("Handle") then
                    return v.Handle
                end
            end,
            CustomName = function(obj)
                return tostring(obj.Name)
            end,
            Color = Color3.new(1,1,1),
            IsEnabled = "Fruit1"
        })
        esp_library:AddObjectListener(workspace, {
            Name = function(v)
                if tostring(v):lower() == "fruits" or tostring(v):lower() == "fruit" then
                    return v
                end
            end,
            Type = "Model",
            PrimaryPart = function(v)
                if v:FindFirstChild("Handle") then
                    return v.Handle
                end
            end,
            CustomName = "Fruit",
            Color = Color3.new(1,1,1),
            IsEnabled = "Fruit2"
        })
    end
end)

-- Remote
local CommF_ = game:GetService("ReplicatedStorage")["Remotes"]:WaitForChild("CommF_")


-- script
local auto = w:Tab("Automation",Icons.Automatic)
local plr_Tabs = w:Tab("Players",Icons.User_Folder)
local visual = w:Tab("Visual",Icons.Vision)
local Fruit_or_Teleport = w:Tab("Fruits / Teleport",Icons.Folder)
local misc = w:Tab("Misc",Icons.Folder)
local credit = w:Tab("Credit",Icons.Folder)

auto:Line()
auto:Label("Tools")

local Tool_Table = {"none"}
getgenv().Selected_Tool = nil;
for i,v in ipairs(lp.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        table.insert(Tool_Table, tostring(v.Name))
    end
end
lp.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        if not table.find(Tool_Table,tostring(child.Name)) then
            table.insert(Tool_Table,tostring(child.Name))
        end
    end
end)
lp.Backpack.ChildRemoved:Connect(function(child)
    if child:IsA("Tool") then
        if table.find(Tool_Table,tostring(child.Name)) then
            table.remove(Tool_Table,table.find(Tool_Table,tostring(child.Name)))
        end
    end
end)
function Check_Character_Tools(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            if not table.find(Tool_Table,tostring(child.Name)) then
                table.insert(Tool_Table,tostring(child.Name))
            end
        end
    end)
    char.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") then
            if table.find(Tool_Table,tostring(child.Name)) then
                table.remove(Tool_Table,table.find(Tool_Table,tostring(child.Name)))
            end
        end
    end)
end
lp.CharacterAdded:Connect(function(char)
    Check_Character_Tools(char)
end)
Check_Character_Tools(lp.Character)

getgenv().Tool_Dropdown = auto:Dropdown("Select a tool",Tool_Table,function(options)
    getgenv().Selected_Tool = options;
end)
auto:Button("Refresh","Refresh tool list",function()
    getgenv().Tool_Dropdown:Add({Tool_Table})
end)
auto:Toggle("Auto equip tool","Auto equip selected tool",false,function(x)
    getgenv().Auto_equipTool = x
    if x then
        Auto_equip_tool()
    else
        if lp.Character then
            lp.Character.Humanoid:UnequipTools()
        end
    end
end)
function Auto_equip_tool()
    spawn(function()
        while getgenv().Auto_equipTool == true do
            if lp.Character then
                if getgenv().Selected_Tool == nil or getgenv().Selected_Tool == "none" then
                    make_Notification(nil,"Please select a tool to auto equip it")
                else
                    local tool = lp.Backpack:FindFirstChild(getgenv().Selected_Tool)
                    if tool then
                        lp.Character.Humanoid:EquipTool(tool)
                    end
                end
            end
            wait(.1)
        end
    end)
end

auto:Line()
auto:Toggle("Auto activate Enchant/Buso","Auto active enchant/buso haki",false,function(x)
    getgenv().Auto_Buso = x
    if x then
        Activate_buso()
    end
end)
function Activate_buso()
    spawn(function()
        while getgenv().Auto_Buso do
            if lp.Character then
                if not CollectionService:HasTag(lp.Character,"Buso") then CollectionService:AddTag(lp.Character,"Buso") end
                if not lp.Character:FindFirstChild("HasBuso") then
                    CommF_:InvokeServer("Buso")
                end
            end
            wait(.1)
        end
    end)
end
auto:Toggle("Auto set spawn point","Auto set your spawn point",function(x)
    if x then
        spawn(function()
            while x == true do
                CommF_:InvokeServer("SetSpawnPoint")
                wait(.1)
            end
        end)
    else
    end
end)

auto:Label("Chests")
auto:Dropdown("Select chests type",{"Sliver Chests","Gold Chests","Diamond Chests"},function(options)
    if options == "Sliver Chests" then
        getgenv().Chests_Type = 1;
    elseif options == "Gold Chests" then
        getgenv().Chests_Type = 2;
    else
        getgenv().Chests_Type = 3;
    end
end)
auto:Toggle("Chests farm","Auto collect chests in range",false,function(x)
    getgenv().Chests_Farm = x;
    if x then
        make_Notification("Notification","Noclip is activate while chest farm working")
        getgenv().noclip = true;
        CollectChests()
    else
        make_Notification("Notification","Noclip is deactivate")
        getgenv().noclip = false;
    end
end)
function CollectChests()
    spawn(function()
        while getgenv().Chests_Farm == true do
            if lp.Character then
                if getgenv().noclip ~= true then
                    getgenv().noclip = true;
                end
                if getgenv().Chests_Type ~= nil then
                    local getChests;
                    for i,v in ipairs(workspace:GetChildren()) do
                        if v:IsA("Part") and v:FindFirstChildOfClass("TouchTransmitter") then
                            local mag;
                            if getgenv().Chests_Type == 1 then
                                if tostring(v):lower() == "chest1" then
                                    mag = (lp.Character.HumanoidRootPart.CFrame.Position - v.CFrame.Position).Magnitude
                                    if mag < getgenv().Chests_Range then
                                        getChests = v;
                                    end
                                end
                            elseif getgenv().Chests_Type == 2 then
                                if tostring(v):lower() == "chest2" then
                                    mag = (lp.Character.HumanoidRootPart.CFrame.Position - v.CFrame.Position).Magnitude
                                    if mag < getgenv().Chests_Range then
                                        getChests = v;
                                    end
                                end
                            elseif getgenv().Chests_Type == 3 then
                                if tostring(v):lower() == "chest3" then
                                    mag = (lp.Character.HumanoidRootPart.CFrame.Position - v.CFrame.Position).Magnitude
                                    if mag < getgenv().Chests_Range then
                                        getChests = v;
                                    end
                                end
                            end
                        end
                    end
                    if getChests ~= nil then
                        local mag;
                        mag = (lp.Character.HumanoidRootPart.CFrame.Position - getChests.CFrame.Position).Magnitude
                        if mag < 1000 or mag <= 1000 then
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{10.5})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        elseif mag < 3000 or mag < 3000  then
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{25})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        elseif mag < 5000 or mag <= 5000 then
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{40})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        elseif mag < 8000 or mag <= 8000 then
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{45})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        elseif mag < 10000 or mag <= 10000 then
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{50})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        else
                            local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = getChests.CFrame},{60})
                            while true do
                                if tween.PlaybackState == Enum.PlaybackState.Completed then
                                    make_Notification("Completed to collect a chests")
                                    break;
                                elseif tween == Enum.PlaybackState.Cancelled then
                                    make_Notification("Cancelled to collect a chests")
                                    break;
                                end
                                if getgenv().Chests_Farm ~= true then tween:Cancel() break; end
                                wait(.1)
                            end
                        end
                    end
                else
                    make_Notification("Chest Farm","Select a chests type",5)
                    while true do
                        if getgenv().Chests_Type ~= nil then break; end
                        if getgenv().Chests_Farm ~= true then break; end
                        wait(.1)
                    end
                end
            end
            wait(1.5)
        end
    end)
end


plr_Tabs:Label("Self Mods")
plr_Tabs:Toggle("Jesus Mode","You can walk on walk like jesus",false,function(x)
    getgenv().Jesus = x;
end)
RunService.RenderStepped:Connect(function()
    if getgenv().Jesus == true then
        if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("WaterBase-Plane") then
            if not workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part") then
                local jesus_part = Instance.new("Part")
                jesus_part.Parent = workspace.Map["WaterBase-Plane"]
                jesus_part.Name = HttpService:GenerateGUID(false)
                jesus_part.Anchored = true
                jesus_part.Transparency = 1
                jesus_part.Size = workspace.Map["WaterBase-Plane"].Size
                jesus_part.CFrame = workspace.Map["WaterBase-Plane"].CFrame
            else
                local cf = workspace.Map["WaterBase-Plane"].CFrame * CFrame.new(0,16.11,0)
                workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part").CFrame = cf
                workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part").Name = HttpService:GenerateGUID(false)
            end
        end
    else
        if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("WaterBase-Plane") then
            if workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part") then
                local cf = workspace.Map["WaterBase-Plane"].CFrame
                workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part").CFrame = cf
                workspace.Map["WaterBase-Plane"]:FindFirstChildOfClass("Part").Name = HttpService:GenerateGUID(false)
            end
        end
    end
end)
plr_Tabs:Button("Invisible | R15 Only","He/She abcwe332 made Invisible script",function()
    invisible()
end)
function invisible()
    if lp.Character then
        if lp.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 and lp.Character:FindFirstChild("LowerTorso") then
            if lp.Character.PrimaryPart ~= lp.Character:FindFirstChild("HumanoidRootPart") then
            else
                make_Notification(nil,"Thanks abcwe332 made the Invisible script.He/She is awesome",8)
                local hrp = lp.Character.HumanoidRootPart
                local old = hrp.CFrame

                local core = Instance.new("Part", workspace)
                core.Name = HttpService:GenerateGUID(false)
                core.Anchored = true
                core.CanCollide = false
                core.Material = Enum.Material.ForceField
                core.Shape = Enum.PartType.Ball
                core.Size = Vector3.new(1.5,1.5,1.5)
                core.Color = Color3.fromRGB(66,135,245)
                core.CFrame = old

                for i,v in ipairs(hrp:GetDescendants()) do
                    if v:IsA("BillboardGui") then
                        v:Destroy()
                    end
                end

                local died = lp.Character.Humanoid.Died:Connect(function()
                    make_Notification("Notification","You are visible now")
                    if core then
                        core:Destroy()
                    end
                end)

                core.Destroying:Connect(function()
                    died:Disconnect()
                end)

                local newroot = lp.Character.LowerTorso.Root:Clone()
                hrp.Parent = workspace
                lp.Character.PrimaryPart = hrp
                lp.Character:MoveTo(Vector3.new(old.X,9e9,old.Z))
                hrp.Parent = lp.Character
                task.wait(0.5)

                for i,v in ipairs(hrp:GetDescendants()) do
                    if v:IsA("BillboardGui") then
                        v:Destroy()
                    end
                end

                newroot.Parent = lp.Character.LowerTorso
                hrp.CFrame = old

                make_Notification(nil,"You are invisible now | Blue core is your body position",10)
            end
        else
            make_Notification("Error ","Your character is not R15")
        end
    else
        make_Notification("Error","Your character missing")
    end
end
plr_Tabs:Toggle("Infinite jump","Make you can infinity jump",false,function(x)
    getgenv().Infinite_jump = x;
end)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().Infinite_jump then
        if lp.Character then
            lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
plr_Tabs:Bind("Noclip",Enum.KeyCode.H,function()
    getgenv().noclip = not getgenv().noclip
    if getgenv().noclip then
        make_Notification(nil,"Noclip is activate",6)
    else
        make_Notification(nil,"Noclip is deactivate",6)
    end
end)
RunService.Stepped:Connect(function()
    if getgenv().noclip then
        if lp.Character then
            if lp.Character:FindFirstChild("HumanoidRootPart") then
                lp.Character:FindFirstChild("HumanoidRootPart").CanCollide = false;
            end
            if lp.Character:FindFirstChild("LowerTorso") then
                lp.Character:FindFirstChild("LowerTorso").CanCollide = false;
            end
            if lp.Character:FindFirstChild("UpperTorso") then
                lp.Character:FindFirstChild("UpperTorso").CanCollide = false;
            end
        end
    end
end)
plr_Tabs:Button("Check spawnpoint","Check your spawnpoint at where",function()
    if lp:FindFirstChild("Data") and lp:FindFirstChild("Data"):IsA("Folder") then
        for i,v in next, lp.Data:GetChildren() do
            if v:IsA("StringValue") and tostring(v.Name):lower() == "spawnpoint" then
                make_Notification("Notification",string.format("Your spawnpoint at %s",v.Value),5)
            end
        end
    end
end)

plr_Tabs:Line()
plr_Tabs:Label("Others")
getgenv().plr_selected = nil;
local plr_table = {"None"}
for i,v in ipairs(Players:GetPlayers()) do
    if v then
        if v.DisplayName then
            table.insert(plr_table,v.DisplayName)
        else
            table.insert(plr_table,v.Name)
        end
    end
end
Players.PlayerAdded:Connect(function(player)
    if player.DisplayName then
        table.insert(plr_table,player.DisplayName)
    else
        table.insert(plr_table,player.Name)
    end
end)
Players.PlayerRemoving:Connect(function(removing)
    if removing.DisplayName then
        if table.find(plr_table,removing.DisplayName) then
            table.remove(plr_table,table.find(plr_table,removing.DisplayName))
        end
    else
        if table.find(plr_table,removing.Name) then
            table.remove(plr_table,table.find(plr_table,removing.Name))
        end
    end
end)

function getPlr(str)
    for i,v in ipairs(Players:GetPlayers()) do
        if v and tostring(v.DisplayName):lower() == tostring(str):lower() or tostring(v.Name):lower() == tostring(str):lower() then
            return v
        end
    end
end

getgenv().Otherplr_Dropdown = plr_Tabs:Dropdown("Players List", plr_table,function(options)
    getgenv().plr_selected = options;
end)
plr_Tabs:Button("Refresh","Refresh the players list",function()
    getgenv().Otherplr_Dropdown:Add({plr_table})
end)
plr_Tabs:Toggle("Spectate selected players","Spectate the selected players",false,function(x)
    if x then
        local plr = getPlr(getgenv().plr_selected)
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = plr.Character.Humanoid
        else
            make_Notification("Error","Selected players missing character or humanoid")
        end
    else
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = lp.Character.Humanoid
        else
            make_Notification("Error","Your character or humanoid is missing")
        end
    end
end)
plr_Tabs:Button("Teleport to selected player","Tween/Teleport to selected player",function()
    if lp.Character then
        local plr = getPlr(getgenv().plr_selected)
        local cf;
        local mag;
        if plr.Character then
            make_Notification("Notification","Noclip is activate while Tween/Teleport")
            cf = plr.Character.HumanoidRootPart.CFrame
            mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            if mag < 500 or mag <= 500 or mag < 1000 or mag <= 1000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10})
                while true do
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; make_Notification("Notification","Noclip is deactivate") break; end
                    wait(.5)
                end
            elseif mag < 3000 or mag <= 3000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{20})
                while true do
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; make_Notification("Notification","Noclip is deactivate") break; end
                    wait(.5)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; make_Notification("Notification","Noclip is deactivate") break; end
                    wait(.5)
                end
            else
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{50})
                while true do
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; make_Notification("Notification","Noclip is deactivate") break; end
                    wait(.5)
                end
            end
        else
            make_Notification("Error","Selected players character is missing")
        end
    else
        make_Notification("Error","Your character is missing")
    end
end)
plr_Tabs:Button("Check selected players all Data","Check players spawn point and more",function()
    local plr = getPlr(getgenv().plr_selected)
    if plr and plr:FindFirstChild("Data") and plr.Data:IsA("Folder") then
        for i,v in ipairs(plr.Data:GetChildren()) do
            if v:IsA("IntValue") then
                make_Notification("Data", string.format("%s: %s",tostring(v.Name),v.Value), 8)
                wait(.5)
            end
            if v:IsA("StringValue") then
                make_Notification("Data", string.format("%s: %s",tostring(v.Name),v.Value), 8)
                wait(.5)
            end
        end
    end
end)
plr_Tabs:Button("Check selected players Stats","Check players stats",function()
    local plr = getPlr(getgenv().plr_selected)
    local statsFolder = nil;
    if plr and plr:FindFirstChild("Data") and plr.Data:IsA("Folder") and plr.Data:WaitForChild("Stats") then
        statsFolder = plr.Data:WaitForChild("Stats")
    end
    wait(.1)
    if statsFolder ~= nil then
        for i,v in ipairs(statsFolder:GetChildren()) do
            if v:IsA("Folder") and v:FindFirstChild("Level") then
                make_Notification(tostring(v.Name),string.format("Level: %s",v.Level.Value),8)
                wait(.5)
            end
        end
    end
end)

visual:Label("Esp")
visual:Toggle("Toggle","Enable/Disable Esp", false, function(x)
    esp_library:Toggle(x);
end)
visual:Line()
visual:Label("Options of esp")
visual:Toggle("Show players", "Show/Hide esp of players",true,function(x)
    esp_library.Players = x;
end)
visual:Toggle("Show fruits", "Show/Hide esp of fruits",false,function(x)
    esp_library["Fruit1"] = x
    esp_library["Fruit2"] = x
end)
if sea == 2 then
    visual:Toggle("Show flowers", "Show/Hide esp of Flowers",false,function(x)
        esp_library["F1"] = x
        esp_library["F2"] = x
    end)
end
visual:Toggle("Show chests", "Show/Hide esp of chests",false,function(x)
    esp_library["Chest1"] = x;
    esp_library["Chest2"] = x;
    esp_library["Chest3"] = x;
end)
visual:Line()
visual:Label("Settings of esp")
visual:Toggle("Names","Show/Hide names of target",true,function(x)
    esp_library.Names = x;
end)
visual:Toggle("Boxs","Show/Hide Boxs of target",true,function(x)
    esp_library.Boxes = x;
end)
visual:Toggle("Tracers","Show/Hide Tracers of target",true,function(x)
    esp_library.Tracers = x;
end)

visual:Line()
visual:Label("Charms")
visual:Colorpicker("Players charms colors",Color3.fromRGB(255,255,255),function(colors)
    getgenv().Players_Charms_Colors = colors;
end)
visual:Colorpicker("Players charms outline colors",Color3.fromRGB(255,255,255),function(colors)
    getgenv().Players_Charms_Outline = colors;
end)
visual:Toggle("Team colors","Set charms color same as team",false,function(x)
    getgenv().Players_Charms_TeamColor = x;
end)
visual:Colorpicker("Fruits charms colors",Color3.fromRGB(255,255,255),function(colors)
    getgenv().Fruits_Charms_Colors = colors;
end)
visual:Colorpicker("Fruits charms outline colors",Color3.fromRGB(255,255,255),function(colors)
    getgenv().Fruits_Charms_Outline = colors;
end)
visual:Label("Options of charms")
visual:Toggle("Show players","Show/Hide charms of players",false,function(x)
    getgenv().Players_Charms = x;
    if x then
        for i,v in ipairs(Players:GetPlayers()) do
            if v ~= lp then
                if v.Character then
                    Players_charms(v.Character)
                end
            end
        end
    end
end)

for i,v in ipairs(Players:GetPlayers()) do
    if v ~= lp then
        v.CharacterAdded:Connect(function(char)
            Players_charms(char)
        end)
    end
end
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        Players_charms(char)
    end)
end)

function Players_charms(character)
    if not character:FindFirstChildOfClass("Highlight") then
        local Highlight = Instance.new("Highlight",character)
        Highlight.Name = HttpService:GenerateGUID(false);
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        local Stepped;
        Stepped = RunService.Stepped:Connect(function()
            local getPlrformChr = Players:GetPlayerFromCharacter(character)
            if Highlight then
                Highlight.Enabled = getgenv().Players_Charms;
                Highlight.Name = HttpService:GenerateGUID(false);
                if getgenv().Players_Charms_TeamColor ~= true then
                    Highlight.FillColor = getgenv().Players_Charms_Colors;
                    Highlight.OutlineColor = getgenv().Players_Charms_Outline;
                else
                    pcall(function()
                        local getTeam = getPlrformChr.Team
                        if getTeam then
                            local dickColors = getPlrformChr.TeamColor
                            local TeamColors = dickColors.Color
                            Highlight.FillColor = TeamColors;
                            Highlight.OutlineColor = TeamColors;
                        else
                            Highlight.FillColor = Color3.new(1,1,1)
                            Highlight.OutlineColor = Color3.new(1,1,1)
                        end
                    end)
                end
            end
        end)
        Highlight.Destroying:Connect(function()
            Stepped:Disconnect()
        end)
        return Highlight;
    else
        return character:FindFirstChildOfClass("Highlight");
    end
end

visual:Toggle("Show fruits","Show/Hide charms of fruits",false,function(x)
    getgenv().Fruits_Charms = x;
    if x then
        for i,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Tool") then
                if v:FindFirstChild("Handle") and v:FindFirstChild("Fruit") then
                    Fruits_Charms(v["Fruit"])
                end
            elseif v:IsA("Model") then
                if v:FindFirstChild("Handle") and v:FindFirstChild("Fruit") then
                    Fruits_Charms(v["Fruit"])
                end
            end
        end
    end
end)

workspace.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        if child:FindFirstChild("Handle") and child:FindFirstChild("Fruit") then
            Fruits_Charms(child["Fruit"])
        end
    elseif child:IsA("Model") then
        if child:FindFirstChild("Handle") and child:FindFirstChild("Fruit") then
            Fruits_Charms(child["Fruit"])
        end
    end
end)

function Fruits_Charms(Handle)
    if typeof(Handle) == "Instance" then
        local part = Handle;
        if not part:FindFirstChildOfClass("Highlight") then
            local Highlight = Instance.new("Highlight",Handle)
            Highlight.Name = HttpService:GenerateGUID(false);
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            local Stepped;
            Stepped = RunService.Stepped:Connect(function()
                if Highlight then
                    Highlight.Name = HttpService:GenerateGUID(false);
                    Highlight.Enabled = getgenv().Fruits_Charms;
                    Highlight.FillColor = getgenv().Fruits_Charms_Colors;
                    Highlight.OutlineColor = getgenv().Fruits_Charms_Outline;
                end
            end)
            Highlight.Destroying:Connect(function()
                Stepped:Disconnect()
            end)
            return Highlight;
        else
            return part:FindFirstChildOfClass("Highlight");
        end
    end
end

Fruit_or_Teleport:Label("Fruits")
Fruit_or_Teleport:Button("Check any fruit in game","none desc",function()
    local bool = false;
    local count = 0;
    for i,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v:FindFirstChild("Fruit") and v:FindFirstChild("Handle") then
            make_Notification("Fruit",string.format("Found: %s in game",tostring(v.Name)),8)
            bool = true;
            count = count + 1
        elseif v:IsA("Model") and v:FindFirstChild("Handle") and v:FindFirstChild("Fruit") then
            make_Notification("Fruit","Found a spawned fruit",8)
            bool = true;
            count = count + 1
        end
    end
    wait(2)
    if bool then
        make_Notification("Notification",string.format("Found %s fruit in game",count),8)
    else
        make_Notification("Notification","Empty fruit in game",8)
    end
end)
Fruit_or_Teleport:Button("Bring fruits","Bring the fruit to yourself",function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        if firetouchinterest then
            for i,v in ipairs(workspace:GetDescendants()) do
                if v and v:IsA("Tool") and v:FindFirstChild("Fruit") and v:FindFirstChild("Handle") then
                    make_Notification("Notification",string.format("Bring a %s to you",tostring(v.Name)),8)
                    firetouchinterest(lp.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 0)
                    wait(0.2)
                    firetouchinterest(lp.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 1)
                end
            end
        else
            for i,v in ipairs(workspace:GetDescendants()) do
                if v and v:IsA("Tool") and v:FindFirstChild("Fruit") and v:FindFirstChild("Handle") then
                    make_Notification("Notification",string.format("Bring a %s to you",tostring(v.Name)),8)
                    local cf = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.5,.1)
                    v.Fruit.CFrame = cf
                    v.Handle.CFrame = cf
                end
            end
        end
    end
end)
Fruit_or_Teleport:Button("Teleport to spawned fruit","Tween/Teleport to spawned fruit",function()
    if lp.Character then
        for i,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Handle") and v:FindFirstChild("Fruit") then
                local mag = (lp.Character.HumanoidRootPart.CFrame.Position - v.Handle.CFrame.Position).Magnitude
                if mag < 1500 or mag <= 1500 then
                    local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = v.Handle.CFrame},{10.5})
                    while true do
                        if tween.PlaybackState == Enum.PlaybackState.Completed then
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 0)
                            wait(.5)
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 1)
                            break;
                        elseif tween.PlaybackState == Enum.PlaybackState.Cancelled then
                            break;
                        end
                        wait(.1)
                    end
                elseif mag < 5000 or mag <= 5000 then
                    local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = v.Handle.CFrame},{40})
                    while true do
                        if tween.PlaybackState == Enum.PlaybackState.Completed then
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 0)
                            wait(.5)
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 1)
                            break;
                        elseif tween.PlaybackState == Enum.PlaybackState.Cancelled then
                            break;
                        end
                        wait(.1)
                    end
                elseif mag < 10000 or mag <= 10000 then
                    local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = v.Handle.CFrame},{50})
                    while true do
                        if tween.PlaybackState == Enum.PlaybackState.Completed then
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 0)
                            wait(.5)
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 1)
                            break;
                        elseif tween.PlaybackState == Enum.PlaybackState.Cancelled then
                            break;
                        end
                        wait(.1)
                    end
                else
                    local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = v.Handle.CFrame},{60})
                    while true do
                        if tween.PlaybackState == Enum.PlaybackState.Completed then
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 0)
                            wait(.5)
                            firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 1)
                            break;
                        elseif tween.PlaybackState == Enum.PlaybackState.Cancelled then
                            break;
                        end
                        wait(.1)
                    end
                end
            end
        end
    end
end)
if sea == 2 then
    Fruit_or_Teleport:Button("Bring flower","Bring the flower to yourself",function()
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            if firetouchinterest then
                for _,v in pairs(workspace:GetChildren()) do
                    if v and v:IsA("Part") and v:FindFirstChildOfClass("TouchTransmitter") then
                        if v.Name == "Flower1" or v.Name == "Flower2" then
                            make_Notification("Notification",string.format("Bring a %s to you",v.Name),8)
                            firetouchinterest(lp.Character.HumanoidRootPart, v, 0)
                            wait(.2)
                            firetouchinterest(lp.Character.HumanoidRootPart, v, 1)
                        end
                    end
                end
            else
                for _,v in pairs(workspace:GetChildren()) do
                    if v and v:IsA("Part") and v:FindFirstChildOfClass("TouchTransmitter") then
                        if v.Name == "Flower1" or v.Name == "Flower2" then
                            make_Notification("Notification",string.format("Bring a %s to you",v.Name),8)
                            local cf = lp.Chracter.HumanoidRootPart.CFrame * CFrame.new(0,1.5,.1)
                            v.CFrame = cf
                        end
                    end
                end
            end
        end
    end)
end

local Waypoint = {
    First_Sea = {
        NPC = {
            ["Blox Fruits Dealer Cousin"] = CFrame.new(-1438.8468017578125, 61.977294921875, 6.349756240844727),
        },
        Pirate_Starter_Island = CFrame.new(975.676575, 16.6168118, 1414.43591),
        Marine_Starter_Island = CFrame.new(-2614.32153, 7.23207808, 2043.56238),
        Middle_Town = CFrame.new(-720.284912109375, 7.977573871612549, 1663.4769287109375),
        Jungle = CFrame.new(-1336.11816, 11.9782085, 496.681976),
        Pirate_Village = CFrame.new(-1187.2489013671875, 4.876879692077637, 3814.66162109375),
        Desert = CFrame.new(912.3401489257812, 3.504537343978882, 4112.6474609375),
        Frozen_Village = CFrame.new(1107.083251953125, 7.4288835525512695, -1165.495361328125),
        Marine_Ford = CFrame.new(-4923.53125, 41.37738037109375, 4425.16015625),
        Sky_First_Floor = CFrame.new(-4918.6533203125, 717.796630859375, -2638.172607421875),
        Sky_Second_Floor = CFrame.new(-4602.77978515625, 872.6677856445312, -1658.86474609375),
        Prison = CFrame.new(4850.751953125, 5.777949810028076, 749.29443359375),
        Colosseum = CFrame.new(-1393.3409423828125, 7.414727210998535, -2832.365478515625),
        Magma_Village = CFrame.new(-5227.54931640625, 8.715539932250977, 8469.0830078125),
        Underwater_City = CFrame.new(3855.510009765625, 5.498478889465332, -1922.8553466796875),
        Sky_Third_Floor = CFrame.new(-7873.22265625, 5545.61865234375, -335.565673828125),
        Fountain_City = CFrame.new(5191.16552734375, 38.626468658447266, 4143.75634765625),
    },
    Second_Sea = {
        NPC = {

        }
    },
    Third_Sea = {
        NPC = {

        }
    },
}

Fruit_or_Teleport:Line()
Fruit_or_Teleport:Label("NPC")
if sea == 1 then
    Fruit_or_Teleport:Button("Blox Fruits Dealer Cousin","Tween/Instant Teleport to Blox Fruits Dealer Cousin",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.NPC["Blox Fruits Dealer Cousin"]
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 10000 or mag <= 10000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{50})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{60})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
elseif sea == 2 then

elseif sea == 3 then
    
end

Fruit_or_Teleport:Label("Waypoint")
if sea == 1 then
    Fruit_or_Teleport:Button("Pirate starter island","Tween/Instant Teleport to pirate starter island",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Pirate_Starter_Island
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Marine starter island","Tween/Instant Teleport to marine starter island",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Marine_Starter_Island
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Middle town","Tween/Instant Teleport to middle town",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Middle_Town
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Pirate village","Tween/Instant Teleport to pirate village",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Pirate_Village
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Desert","Tween/Instant Teleport to desert",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Desert
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Frozen village","Tween/Instant Teleport to frozen village",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Frozen_Village
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Marine ford","Tween/Instant Teleport to marine ford",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Marine_Ford
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Sky lands | First floor","Tween/Instant Teleport to sky lands first floor",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Sky_First_Floor
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Sky lands | Second floor","Tween to sky lands second floor",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Sky_Second_Floor
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Prison","Tween/Instant Teleport to prison",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Prison
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Colosseum","Tween/Instant Teleport to colosseum",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Colosseum
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Magma Village","Tween/Instant Teleport to magma village",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Magma_Village
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Underwater City","Tween/Instant Teleport to underwater city",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Underwater_City
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Sky lands | Third_Floor","Tween/Instant Teleport to sky lands third floor",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Sky_Third_Floor
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
    Fruit_or_Teleport:Button("Fountain city","Tween/Instant Teleport to fountain city",function()
        if lp.Character then
            local cf = Waypoint.First_Sea.Fountain_City
            local mag = (lp.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude
            getgenv().noclip = true
            if mag < 1500 or mag <= 1500 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{10.5})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            elseif mag < 5000 or mag <= 5000 then
                local tween = FastTween(lp.Character.HumanoidRootPart,{CFrame = cf},{40})
                while true do
                    if tween.PlaybackState == Enum.PlaybackState.Completed or tween.PlaybackState == Enum.PlaybackState.Cancelled then getgenv().noclip = false; break; end
                    if getgenv().noclip ~= true then getgenv().noclip = true end
                    wait(.1)
                end
            else
                Instant_Teleport(cf)
            end
        else
            make_Notification("Error","Your character is missing")
        end
    end)
elseif sea == 2 then
    
elseif sea == 3 then
        
end


misc:Label("Misc")
misc:Button("Make Ken/Observation range to inf","Make your Ken/Observation range to infinite",function()
    if lp:FindFirstChild("VisionRadius") then
        lp["VisionRadius"].Value = math.huge
    end
end)
misc:Button("Unlock Ken/Observation & upgrade V2","Unlock your ken/observation and upgrade to V2",function()
    if lp.Character then
        if not CollectionService:HasTag(lp.Character,"Ken") then
            CollectionService:AddTag(lp.Character,"Ken")
        end
        if not CollectionService:HasTag(lp.Character,"KenUpgrade") then
            CollectionService:AddTag(lp.Character,"KenUpgrade")
            make_Notification("Notification","You unlock ken/observation and upgrade to V2 now")
        else
            make_Notification("Notification","You ken/observation already V2")
        end
        lp.CharacterAdded:Connect(function(chrs)
            wait(.5)
            if not CollectionService:HasTag(lp.Character,"Ken") then
                CollectionService:AddTag(lp.Character,"Ken")
            end
            if not CollectionService:HasTag(chrs,"KenUpgrade") then
                CollectionService:AddTag(chrs,"KenUpgrade")
            end
        end)
    else
        make_Notification("Error","Your character missing")
    end
end)
misc:Button("Remove lava","Remove entire lava in world",function()
    for i,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") and tostring(v):lower() == "lava" then
            if v:FindFirstChildOfClass("TouchTransmitter") then
                v:Destroy()
            end
        end
    end
end)

misc:Line()
misc:Label("Team Switcher")
misc:Button("Switch to Priates","Switch yourself to Team pirates",function()
    CommF_:InvokeServer("SetTeam","Pirates")
    CommF_:InvokeServer("ZQuestProgress")
    CommF_:InvokeServer("DressrosaQuestProgress")
    CommF_:InvokeServer("ProQuestProgress")
end)
misc:Button("Switch to Marines","Switch yourself to Team marines",function()
    CommF_:InvokeServer("SetTeam","Marines")
    CommF_:InvokeServer("ZQuestProgress")
    CommF_:InvokeServer("DressrosaQuestProgress")
    CommF_:InvokeServer("ProQuestProgress")
end)

misc:Line()
misc:Label("GUI")
for i,v in ipairs(lp.PlayerGui:WaitForChild("Main"):GetDescendants()) do
    if v:IsA("Frame") and v.Name == "FruitShop" then
        misc:Button("Fruit Shop","Open the "..v.Name:lower(),function()
            if v.Visible == false then v.Visible = true else v.Visible = false end
        end)
    elseif v:IsA("Frame") and v.Name == "FruitInventory" then
        misc:Button("Fruit Inventory","Open the "..v.Name:lower(),function()
            if v.Visible == false then v.Visible = true else v.Visible = false end
        end)
    elseif v:IsA("Frame") and v.Name == "AwakeningToggler" then
        misc:Button("Awakening Toggler","Open the "..v.Name:lower(),function()
            if v.Visible == false then v.Visible = true else v.Visible = false end
        end)
    end
end
misc:Button("Buso/Enchant colors","Open the buso/enchant colors",function()
        for i,ui in ipairs(lp.PlayerGui:WaitForChild("Main"):GetDescendants()) do
            if ui ~= nil and ui:IsA("Frame") and ui.Name:lower() == "colors" and ui.Parent == lp.PlayerGui:WaitForChild("Main") then
                if ui.Visible == false then ui.Visible = true else ui.Visible = false end
            end
        end
end)

misc:Label("Server")
misc:Button("Rejoin server","Rejoin same server",function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId,lp)
    lp.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Started then
            if syn then
                --syn.queue_on_teleport()
            else
                --queue_on_teleport()
            end
        end
    end)
end)
misc:Button("Server hop","Hop to different server",function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
    lp.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Started then
            if syn then
                --syn.queue_on_teleport()
            else
                --queue_on_teleport()
            end
        end
    end)
end)

misc:Line()
misc:Label("Other")
misc:Button("Destroy ui","Remove the ui",function()
    esp_library:Toggle(false)
    wait(.1)
    screengui:Destroy()
end)

-- credit
credit:Label("Infomation | source is not open anymore")
credit:Button("Scripting | Ghost-Ducky#7698","Scripting alone all script",function()end)
credit:Button("UI | dawid#7205","He/She made Flux UI Library. Copy link to v3rm thread",function() setclipboard("https://v3rmillion.net/showthread.php?tid=1101621") end)
credit:Button("Notification UI | twink marie ( v3rmillion )","He/She made Notification UI. Copy link to thread",function() setclipboard("https://v3rmillion.net/showthread.php?tid=1135753") end)
credit:Button("Esp | Kiriot22 / Real Panda ( v3rmillion )","He/She made Kiriot22 esp library. Copy link to v3rm thread",function() setclipboard("https://v3rmillion.net/showthread.php?tid=1088719") end)
credit:Button("Tween Function | netbox ( v3rmillion )","He/She made smooth tween/teleport function. Copy link to v3rm thread",function() setclipboard("https://v3rmillion.net/showthread.php?tid=1171026") end)
credit:Button("Copy discord invite","discord.gg/TFUeFEESVv",function() setclipboard("discord.gg/TFUeFEESVv") end)

--// Tween function
function FastTween(instance, property, tweenInfo, delayTime)
    if lp.Character then
        if type(instance) ~= "table" then
            instance = { instance }
        end
        local TTable = {}
        local Easing_Style;
        local EasingDirection;
        for i, v in ipairs(instance) do
            local carpet = Instance.new("Part",workspace)
            carpet.Anchored = true
            carpet.Size = Vector3.new(15,.5,15)
            carpet.Material = Enum.Material.ForceField

            if tweenInfo == nil then
            tweenInfo = { 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }
            else
                if tweenInfo[2] == nil then
                    tweenInfo[2] = Enum.EasingStyle.Sine
                elseif type(tweenInfo[2]) == "string" then
                    if string.lower(tweenInfo[2]) == "expo" then
                        tweenInfo[2] = Enum.EasingStyle.Exponential
                    else
                        Easing_Style = tweenInfo[2]
                        tweenInfo[2] = Enum.EasingStyle[Easing_Style]
                    end;
                end;
                if tweenInfo[3] == nil then
                    tweenInfo[3] = Enum.EasingDirection.InOut
                elseif type(tweenInfo[3]) == "string" then
                    EasingDirection = tweenInfo[3]
                    tweenInfo[3] = Enum.EasingDirection[EasingDirection]
                end
            end

            local Tween = game:GetService("TweenService"):Create(v, TweenInfo.new(unpack(tweenInfo)), property)
            coroutine.wrap(function()
                lp.Character.Humanoid.Died:Connect(function()
                    Tween:Cancel()
                end)
                local RS = RunService.RenderStepped:Connect(function()
                    carpet.Name = HttpService:GenerateGUID(false)
                    carpet.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0,-4,0)
                    carpet.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    if Tween.PlaybackState == Enum.PlaybackState.Completed or Tween.PlaybackState == Enum.PlaybackState.Cancelled then
                        if carpet then
                            carpet:Destroy()
                        end
                    end
                end)
                carpet.Destroying:Connect(function()
                    RS:Disconnect()
                end)

                if delayTime then
                    wait(delayTime)
                end

                Tween:Play()
            end)()
            table.insert(TTable, Tween)
        end
        return unpack(TTable)
    else
        make_Notification("Error","Your character is missing")
    end
end

--// Instant TP
function Instant_Teleport(arg)
    if lp.Character then
        if typeof(arg) == "CFrame" then
            lp.Character.Humanoid.Health = 0;
            task.wait(.1)
            lp.Character.HumanoidRootPart.CFrame = arg;
            task.wait(.2)
            CommF_:InvokeServer("SetSpawnPoint")
        elseif typeof(arg) == "Instance" then
            lp.Character.Humanoid.Health = 0;
            task.wait(.1)
            lp.Character.HumanoidRootPart.CFrame = arg.CFrame;
            task.wait(.2)
            CommF_:InvokeServer("SetSpawnPoint")
        end
    else
        --make_Notification("Error","Your character is missing")
    end
end

-- Notification function
function make_Notification(title,desc,time)
    if title ~= nil then
        Notify({
            Description = desc;
            Title = title;
            Duration = time or 5;
        });
    else
        Notify({
            Description = desc;
            Duration = time or 5;
        });
    end
end

library:Notification("Toggle Bind is Rightcontrol","ok")
-- secure ui
while true do
    pcall(function()
        local randomz = HttpService:GenerateGUID(false);
        screengui.Name = randomz;
        screengui = game:GetService("CoreGui"):FindFirstChild(randomz);
    end)
    wait(5)
end
