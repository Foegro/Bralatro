--- STEAMODDED HEADER
--- MOD_NAME: Bralatro
--- MOD_ID: bralatro
--- PREFIX: bra
--- MOD_AUTHOR: [Foegro, KevinE.S.The Lost Knight, FloofDumbus, WaluigiTheLagger, Bringle Discord]
--- MOD_DESCRIPTION: Adds Bringle themed cards to the game
--- BADGE_COLOUR: 891B8A
--- DISPLAY_NAME:  Bralatro
--- VERSION: 0.14.1
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

if not Bralatro then
	Bralatro = {}
end

local mod_path = "" .. SMODS.current_mod.path
Bralatro.path = mod_path

local success, dpAPI = pcall(require, "debugplus-api")
Bralatro.logger = { -- Placeholder logger, for when DebugPlus isn't available
    log = print,
    debug = print,
    info = print,
    warn = print,
    error = print
}
if success and dpAPI.isVersionCompatible(1) then
	local debugplus = dpAPI.registerID("Bralatro")
    Bralatro.logger = debugplus.logger -- Provides the logger object
	debugplus.addCommand{
		name = "suitless_mode",
		desc = "",
		shortDesc = "",
		exec = function(args, rawArgs, dp)
			if args[1] then G.GAME.bra_suitless_mode = args[1] end
			return G.GAME.bra_suitless_mode
		end
	}
	debugplus.addCommand{
		name = "diamond",
		desc = "",
		shortDesc = "",
		exec = function(args, rawArgs, dp)
			SMODS.change_base(dp.hovered,"Diamond")
		end
	}
	debugplus.addCommand{
		name = "stats",
		desc = "",
		shortDesc = "",
		exec = function(args, rawArgs, dp)
			return inspect(dp.hovered.config.center)
		end
	}
end

Bralatro.add_suitless_info_queue = function(info_queue)
	if G.GAME.bra_suitless_mode and G.GAME.bra_suitless_mode == "Wild" then info_queue[#info_queue+1] = {key = "bra_suitless_wild", set = "Other"}
	elseif not G.GAME.bra_suitless_mode or G.GAME.bra_suitless_mode ~= "Suit" then info_queue[#info_queue+1] = {key = "bra_suitless_no_suit", set = "Other"} end
end

SMODS.current_mod.menu_cards = function()
	return {
		{key = "j_bra_bringle"}
	}
end

SMODS.Atlas{
	key = "consumables",
	path = "Consumables.png",
	px = 71,
	py = 95,
}

local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err)
	end
	f()
end