// Simple exhaust addon config
se_config = se_config or {}

----- Run/walk speeds -----
// Set the sprint/walk speed (leave as default for gamemode default)
// requires server restart or map reload for changes to take effect.
se_config.runSpeed = 500
se_config.walkSpeed = 100

----- Sprint Limit -----
// This setting does not equal seconds!
// Setting at 10 is roughly 15 seconds, play around with it 
// and figure out what you like best.
se_config.stamina = 10

----- Exhaust intervals -----
// At what points would you like the players to slow down?
// These intervals are based off of the stamina. For example,
// the player will slow down more and more at the 75% mark, 50% mark
// and 25% mark.
se_config.exhaustInts = {
    [1]     = 7.5,
    [2]     = 5,
    [3]     = 2.5
}

----- Jump stamina consumption ----- 
// Set to false to disable
// This number will take a given amount of stamina. For example, if stamina is 10 
// and jumpConsume is 1 A player jumping will take 1/10 of his stamina. (decimals are okay)
se_config.jumpConsume = 0.5

--[[-------------------------------------------------------------------------
END OF CONFIG
---------------------------------------------------------------------------]]