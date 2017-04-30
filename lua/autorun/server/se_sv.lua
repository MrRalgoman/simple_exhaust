util.AddNetworkString("interval")
util.AddNetworkString("onSpawn")

hook.Add("PlayerSetModel", "clientSpawn", function(ply)
    // Have to call setspeed funcs in this hook to override darkRP
    ply:SetRunSpeed(se_config.runSpeed)
    ply:SetWalkSpeed(se_config.walkSpeed)

end) // hook/function end

local stamina = se_config.stamina * 100
local interval = 1
local up = true

local max, min = se_config.runSpeed, se_config.walkSpeed
local difference = (max - min)

net.Receive("interval", function(len, ply)
    local up = net.ReadBool()

    if (up and ply:GetRunSpeed() < se_config.runSpeed) then
        ply:SetRunSpeed(ply:GetRunSpeed() + difference/4)
    elseif (!up and ply:GetRunSpeed() > se_config.walkSpeed) then
        ply:SetRunSpeed(ply:GetRunSpeed() - difference/4)
    end
end) // end net interval func

hook.Add("PlayerSpawn", "onSpawn", function(ply, inflictor, killer)
    net.Start("onSpawn")
    net.Send(ply)
end) // end hook onSpawn func