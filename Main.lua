local MemoryStoreService = game:GetService("MemoryStoreService")
local module = {} 
local memory = {}

local rp = false

local function callback(part, trackingpos)
    while true do
        if not part then break end
        if not trackingpos then part:Destroy(); break end

        part.CFrame = trackingpos.CFrame

        task.wait()
    end
end

local function createhitbox(model)

    local newPart = Instance.new("Part", model)
    newPart.Anchored = true
    newPart.CanCollide = false
    if model:FindFirstChild("HumanoidRootPart") then
        newPart.CFrame = model:FindFirstChild("HumanoidRootPart").CFrame
        newPart.Size = model:FindFirstChild("HumanoidRootPart").Size
        newPart.Name = "ReplicatedHitbox"
        table.insert(memory, newPart)
        coroutine.wrap(callback)(newPart, model:FindFirstChild("HumanoidRootPart"))
    else
        newPart:Destroy()
    end

end

function module:StartReplicating()
    rp = true

    for _,v in pairs(game.Players:GetPlayers()) do

        if v.Character then

            createhitbox(v.Character)

        end

    end
    return
end

function module:RemoveReplication()
    for _,v in pairs(memory) do
        v:Destroy()
    end
    memory = {}
    return
end

game.Players.PlayerAdded:Connect(function(player)
    
    if rp then
        repeat
            wait()
        until player.Character
        createhitbox(player.Character)
    end

end)

return module
