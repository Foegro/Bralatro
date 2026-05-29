--- STEAMODDED HEADER
--- MOD_NAME: Bralatro
--- MOD_ID: bralatro
--- PREFIX: bra
--- MOD_AUTHOR: [Foegro, KevinE.S.The Lost Knight, FloofDumbus, WaluigiTheLagger, Bringle Discord]
--- MOD_DESCRIPTION: Adds Bringle themed cards to the game
--- BADGE_COLOUR: 891B8A
--- DISPLAY_NAME:  Bralatro
--- VERSION: 0.14.0
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

if not Bralatro then
	Bralatro = {}
end

local mod_path = "" .. SMODS.current_mod.path
Bralatro.path = mod_path

local success, dpAPI = pcall(require, "debugplus-api")
local logger = { -- Placeholder logger, for when DebugPlus isn't available
    log = print,
    debug = print,
    info = print,
    warn = print,
    error = print
}
if success and dpAPI.isVersionCompatible(1) then
	local debugplus = dpAPI.registerID("Bralatro")
    logger = debugplus.logger -- Provides the logger object
	debugplus.addCommand{
		name = "suitless_mode",
        shortDesc = "Sets or gets suitless mode",
        desc = "Use the command to set the suitless mode in arg1 or get it by leaving out the argument",
		exec = function(args, rawArgs, dp)
			if args[1] then G.GAME.bra_suitless_mode = args[1] end
			return G.GAME.bra_suitless_mode
		end
	}
	debugplus.addCommand{
		name = "rich",
		shortDesc = "Doubles your money",
		desc = "Dobules your money",
		exec = function(args, rawArgs, dp)
			G.GAME.dollars = G.GAME.dollars*2
		end
	}
	debugplus.addCommand{
		name = "weights",
		shortDesc = "Doubles your money",
		desc = "Dobules your money",
		exec = function(args, rawArgs, dp)
			return inspect(G.GAME.probabilities)
		end
	}
end

SMODS.current_mod.menu_cards = function()
	return {
		{key = "j_bra_bringle"}
	}
end

local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err)
	end
	f()
end