
local function scale(width, height)
    local scrH, scrW = ScrH(), ScrW()
    local multW, multH = 0, 0
    if (height == nil) then
        multW = width / 1920
        return scrW * multW
    elseif (width == 0) then
        multH = height / 1080
        return scrH * multH
    else 
        multW = width / 1920
        multH = height / 1080
        return {(scrW * multW), (scrH * multH)}
    end // end if
end // end func

local bar = bar or {}

bar.width = scale(200)
bar.sprint = 200
bar.height = scale(0, 25)
bar.x = 10
bar.y = ScrH() - 160

local color = color or {}

color.green            = Color(0, 255, 0)
color.lightGreen       = Color(120, 255, 120)

for k, v in pairs(se_config.exhaustInts) do
    se_config.exhaustInts[k] = v * 10
    print(v)
end // end for loop

local stamina = se_config.stamina * 10
local jump = se_config.jumpConsume * 10
local stam = stamina
local up = false
local int = se_config.exhaustInts

net.Receive("onSpawn", function()
    print("GOT IT!!!!\n\n\n\n\n\n")
    stam = se_config.stamina * 10
end) // end onSpawn net/func

timer.Create("isSprinting", 0.1, 0, function()
    if (!LocalPlayer():IsValid()) then return end

    if (LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():KeyDown(IN_FORWARD)) then
        if (stam <= stamina and stam > 0) then
            stam = stam - 1
        end // end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():KeyDown(IN_BACK)) then
        if (stam <= stamina and stam > 0) then
            stam = stam - 1
        end // end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():KeyDown(IN_MOVELEFT)) then
        if (stam <= stamina and stam > 0) then
            stam = stam - 1
        end // end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():KeyDown(IN_MOVERIGHT)) then
        if (stam <= stamina and stam > 0) then
            stam = stam - 1
        end // end if
        up = false 
    else
        if (stam < stamina and stam >= 0) then
            stam = stam + 1
        end // end if
        up = true
    end // end if
    chat.AddText(tostring(LocalPlayer():GetRunSpeed()).." || "..tostring(stam))
    bar.sprint = stam * 2
end) // end isSprinting hook/func

hook.Add("KeyPress", "onJump", function(ply, key)
    timer.Simple(0.5, function() pressed = false end)
    if (key == IN_JUMP and stam > 0 + jump and !pressed) then
        print("GOT IT!!\n\n\n\n\n\n")
        stam = stam - jump
        pressed = true
    elseif (key== IN_JUMP and stam < 0 + jump and !pressed) then
        stam = 0
        pressed = true
    end // end if   
end) // end onJump func/hook

hook.Add("Think", "speedCheck" function()
    if (stam == int[1] or stam == int[2] or stam == int[3]) then
        net.Start("interval")
            net.WriteBool(up)
        net.SendToServer()
    end // end if
end) // end speedCheck hook/func

local sprinting = false

hook.Add("HUDPaint", "sprintBar", function()
    surface.SetDrawColor(color.lightGreen)
    surface.DrawRect(bar.x, bar.y, bar.sprint, bar.height)

    surface.SetDrawColor(color.green)
    surface.DrawOutlinedRect(bar.x, bar.y, bar.width, bar.height)
end) // end of sprint/paint hook/func