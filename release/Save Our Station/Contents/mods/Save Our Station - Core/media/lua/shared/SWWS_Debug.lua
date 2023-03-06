-------------------------------------------------------
-- Save Our Station! - Debug Options -- 
-------------------------------------------------------

SWWS_Debug = SWWS_Debug or {}

SWWS_Debug.version = "v11"
SWWS_Debug.isInitialized = false


-------------------------------------------------------
-- DEBUG OPTIONS -- 
-- DO NOT MESS WITH UNLESS YOU KNOW WHAT YOU ARE DOING!
-------------------------------------------------------

function SWWS_DebugSetup()

	-- Forces mod to reinitialize game state every time a game is loaded (= Clears any currently-ongoing stages)
	SWWS_Debug.forceInitialize = false

	-- Ignores if the power is on or off, and forces breakdown checks every hour.
	SWWS_Debug.ignoreRequirePowerShutoff = false

	-- Force stage time to a single hour.
	SWWS_Debug.forceMinimumTime = false

	-- Forces the fatal pool to be chosen every time.
	SWWS_Debug.forceFatal = false

	-- Forces the NON-fatal (Interruption) pool to be chosen every time.
	-- Important: This IGNORES the "Enable Interruptions?" mod option.
	SWWS_Debug.forceNonFatal = false

	-- Enables logging of various events
	SWWS_Debug.logging = false

	-------------------------------------------------------

	if SWWS_Debug.logging then

		local gameType = "Singleplayer"

		if isServer() then
			gameType = "Server"
		elseif isClient() then
			gameType = "Client / Host"
		end 

		print("SWWS: Game Type [" .. gameType .. "], running [" .. SWWS_Debug.version .. "]")

	end
end

pcall(SWWS_DebugSetup)