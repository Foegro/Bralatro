--- STEAMODDED HEADER
--- MOD_NAME: Bralatro
--- MOD_ID: bralatro
--- PREFIX: bra
--- MOD_AUTHOR: [Foegro and KevinE.S.The Lost Knight]
--- MOD_DESCRIPTION: Adds Bringle themed cards to the game
--- BADGE_COLOUR: 891b8a
--- DISPLAY_NAME:  Bralatro
--- VERSION: 1.0.0
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
	key = "jokers",
	px = 71,
	py = 95,
	path = "Jokers.png",
}

SMODS.Joker{
	key = "kevines",
	atlas = "jokers",
	pos = {
		x = 1,
		y = 0,
	},
	soul_pos = {
		x = 1,
		y = 1,
	},
	config = {
		x_mult = 1,
		extra = 1,
	},
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra,
				center.ability.x_mult,
			}
		}
	end,
	calculate = function(self, card, context) 
		if context.joker_main then
			return {
				xmult = card.ability.x_mult
			}
		end
		if context.cardarea == G.play and not context.blueprint then
			local enhanced = {}
			local editioned = {}
			local sealed = {}
			for k, v in ipairs(context.scoring_hand) do
				if (v.config.center ~= G.P_CENTERS.c_base or v.edition or v.seal) and not v.debuff and not v.vampired then
					if v.config.center ~= G.P_CENTERS.c_base then
						enhanced[#enhanced+1] = v
						v:set_ability(G.P_CENTERS.c_base, nil, true)
					end
					if v.edition then
						editioned[#editioned+1] = v
						v:set_edition(nil)
					end
					if v.seal then
						sealed[#sealed+1] = v
						v:set_seal(nil)
					end
					v.vampired = true
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v.vampired = nil
							return true
						end
					})) 
				end
			end
			if #enhanced > 0 or #editioned > 0 or #sealed > 0 then 
				card.ability.x_mult = card.ability.x_mult + card.ability.extra*(#enhanced+#editioned+#sealed)
				return {
					message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
					colour = G.C.MULT,
					message_card = card
				}
			end
		end
	end
}