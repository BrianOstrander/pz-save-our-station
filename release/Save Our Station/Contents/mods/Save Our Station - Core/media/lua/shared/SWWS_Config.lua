SWWS_Config = SWWS_Config or {}

-------------------------------------------------------
-- DEBUG OPTIONS -- 
-- DO NOT MESS WITH UNLESS YOU KNOW WHAT YOU ARE DOING!
-------------------------------------------------------

SWWS_Config.debug = {}

-- Forces mod to reinitialize game state every time a game is loaded.
SWWS_Config.debug.forceInitialize = true
-- Ignores if the power is on or off, and forces breakdown checks every hour.
SWWS_Config.debug.ignoreRequirePowerShutoff = true
-- Force stage time to a single hour.
SWWS_Config.debug.forceMinimumTime = true
-- Forces the fatal pool to be chosen every time.
SWWS_Config.debug.forceFatal = true
-- Enables logging of various events
SWWS_Config.debug.logging = true

-------------------------------------------------------
-- GAMEPLAY OPTIONS --
-------------------------------------------------------

SWWS_Config.gameplay = {}

-- Does power need to be off before faults start occuring?
SWWS_Config.gameplay.requirePowerShutoff = true
-- Fault stages are defined in hours, this controls how fast they occur.
SWWS_Config.gameplay.timeMultiplier = 24
-- These values should add up to 100, and represent how often pools are chosen.
-- Nominal: EBS operates normally.
-- NonFatal: EBS has a non-fatal fault that resolves itself.
-- Fatal: EBS has a fatal fault that requires the player to fix it.
SWWS_Config.gameplay.poolChanceNominal  = 67;
SWWS_Config.gameplay.poolChanceFatal    = 33;