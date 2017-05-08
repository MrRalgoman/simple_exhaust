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
    end -- end if
end -- end func

local stamina = se_config.stamina * 10
local jump = se_config.jumpConsume * 10
local stam = stamina
local up = false
local int = se_config.exhaustInts

local bar = bar or {}

bar.width = scale(stamina) * se_config.lengthMultipler
bar.sprint = scale(stamina)
bar.height = scale(0, 10)
bar.x = ScrW()/2 - bar.width/2
bar.y = ScrH() - bar.height - 5

local color = color or {}

color.main = Color(75, 75, 75)
color.depleted = Color(50, 50, 50)
color.white = Color(255, 255, 255)

for k, v in pairs(se_config.exhaustInts) do
    se_config.exhaustInts[k] = v * 10
end -- end for loop

net.Receive("onSpawn", function()
    stam = se_config.stamina * 10
end) -- end onSpawn net/func

local g = 200
local r = 0

-- jump stam remove
hook.Add("KeyPress", "onJump", function(ply, key)
    timer.Simple(0.5, function() pressed = false end)
    if (key == IN_JUMP && stam > 0 + jump && !pressed) then
        stam = stam - jump
        pressed = true
        if (g >= 1 && r <= 199) then
            g = g - 5
            r = r + 5
        end -- end if
    elseif (key == IN_JUMP && stam < 0 + jump && !pressed) then
        stam = 0
        pressed = true
    end -- end if   
end) -- end onJump func/hook

-- sprinting stam remove
timer.Create("isSprinting", 0.1, 0, function()
    if (!LocalPlayer():IsValid()) then return end

    if (LocalPlayer():KeyDown(IN_SPEED) && LocalPlayer():KeyDown(IN_FORWARD)) then
        if (stam <= stamina && stam > 0) then
            stam = stam - 1
        end -- end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) && LocalPlayer():KeyDown(IN_BACK)) then
        if (stam <= stamina && stam > 0) then
            stam = stam - 1
        end -- end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) && LocalPlayer():KeyDown(IN_MOVELEFT)) then
        if (stam <= stamina && stam > 0) then
            stam = stam - 1
        end -- end if
        up = false
    elseif (LocalPlayer():KeyDown(IN_SPEED) && LocalPlayer():KeyDown(IN_MOVERIGHT)) then
        if (stam <= stamina && stam > 0) then
            stam = stam - 1
        end -- end if
        up = false 
    else
        if (stam < stamina && stam >= 0) then
            stam = stam + 1
        end -- end if
        up = true
    end -- end if

    if (stam == int[1] || stam == int[2] || stam == int[3]) then
        net.Start("interval")
            net.WriteBool(up)
        net.SendToServer()
    end -- end if

    bar.sprint = stam * se_config.lengthMultipler

end) -- end isSprinting hook/func

local triangle1 = {
    {x = bar.x - 5, y = bar.y - 5},
    {x = bar.x - 5, y = bar.y + bar.height + 10},
    {x = bar.x - 15, y = bar.y + bar.height + 10}
}

local triangle2 = {
    {x = bar.x + bar.width + 5, y = bar.y - 5},
    {x = bar.x + bar.width + 5, y = bar.y + bar.height + 10},
    {x = bar.x + bar.width + 15, y = bar.y + bar.height + 10}
}

hook.Add("HUDPaint", "sprintBar", function()
    surface.SetDrawColor(color.main)
    surface.DrawPoly(triangle1)
    surface.DrawPoly(triangle2)
    surface.DrawRect(bar.x - 5, bar.y - 5, bar.width + 10, bar.height + 10)

    surface.SetDrawColor(color.depleted)
    surface.DrawRect(bar.x, bar.y, bar.width, bar.height)

    surface.SetDrawColor(color.white)
    surface.DrawRect(bar.x, bar.y, bar.sprint, bar.height)
end) -- end of sprint/paint hook/func