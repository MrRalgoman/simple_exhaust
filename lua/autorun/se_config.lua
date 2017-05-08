-- Simple exhaust addon config
se_config = se_config or {}

--[[-------------------------------------------------------------------------
All changes require a server restart or map reload to take effect.
---------------------------------------------------------------------------]]

----- Run/walk speeds -----
-- Set the sprint/walk speed.
se_config.runSpeed = 500
se_config.walkSpeed = 100

----- Sprint Limit -----
-- In seconds.
-- Player can sprint for 10 seconds before running out of stamina.
se_config.stamina = 10

----- Length Multiplier -----
-- Determines the length of the sprint bar.
-- The length is also based on what you set the stamina to.
se_config.lengthMultipler = 2

----- Exhaust intervals -----
-- Set the three intervals for when the client should slow down.
-- By default, the client slows at 7.5 secs, 5 secs, and then 2.5 secs.
se_config.exhaustInts = {
    [1]     = 7.5,
    [2]     = 5,
    [3]     = 2.5
}

----- Jump stamina consumption ----- 
-- Set to false to disable.
-- This number will take a given amount of stamina. For example, if stamina is 10
-- and jumpConsume is 1 A player jumping will take 1/10 of his stamina. (decimals are okay).
se_config.jumpConsume = 0.5