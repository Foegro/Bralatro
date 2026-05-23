--- STEAMODDED HEADER
--- MOD_NAME: Bralatro
--- MOD_ID: bralatro
--- PREFIX: bra
--- MOD_AUTHOR: [Foegro and KevinE.S.The Lost Knight]
--- MOD_DESCRIPTION: Adds Bringle themed cards to the game
--- BADGE_COLOUR: 891B8A
--- DISPLAY_NAME:  Bralatro
--- VERSION: 0.2.0
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
	key = "jokers",
	px = 71,
	py = 95,
	path = "Jokers.png",
}

G.C.BREPIC = {100/255,0/255,100/255,1}
SMODS.Rarity{
	key = "brepic",
	default_weight = 0.01,
	disable_if_empty = true,
	badge_colour = G.C.BREPIC,
}

SMODS.Joker{
	key = "kevines",
	atlas = "jokers",
	pos = {
		x = 3,
		y = 1,
	},
	soul_pos = {
		x = 3,
		y = 2,
	},
	config = {
		x_mult = 1,
		extra = 1,
	},
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra,
				card.ability.x_mult,
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

SMODS.Joker{
	key = "foegro",
	atlas = "jokers",
	pos = {
		x = 4,
		y = 1,
	},
	soul_pos = {
		x = 4,
		y = 2,
	},
	rarity = 4,
	cost = 20,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.discard then
			local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
			tarot:set_edition({negative = true})
			tarot:add_to_deck()
			tarot.sell_cost = 0
			tarot.sell_cost_label = tarot.facing == 'back' and '?' or tarot.sell_cost
			G.consumeables:emplace(tarot)
		end
	end,
}

SMODS.Sound{
	key = "wiicrash",
	path = "wii_crash.ogg",
}

SMODS.Joker{
	key = "wiimote",
	atlas = "jokers",
	pos = {
		x = 3,
		y = 0,
	},
	rarity = 2,
	cost = 3,
	config = {
		chips = 0,
		chips_mod = 33,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.chips_mod,
				card.ability.chips,
			}
		}
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands["Three of a Kind"]) and not context.blueprint then
			card.ability.chips = card.ability.chips+card.ability.chips_mod
			return {
				message = localize("k_bra_eee"),
				message_card = card,
				colour = G.C.CHIPS,
				sound = "bra_wiicrash"
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.chips,
			}
		end
	end,
}

SMODS.Joker{
	key = "wii",
	atlas = "jokers",
	pos = {
		x = 4,
		y = 0,
	},
	rarity = "bra_brepic",
	cost = 9,
	config = {
		mult = 0,
		mult_mod = 33,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.mult_mod,
				card.ability.mult,
			}
		}
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands["Three of a Kind"]) and not context.blueprint then
			card.ability.mult = card.ability.mult+card.ability.mult_mod
			return {
				message = localize("k_bra_big_eee"),
				message_card = card,
				colour = G.C.MULT,
				sound = "bra_wiicrash"
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.mult,
			}
		end
	end,
}

SMODS.Joker{
	key = "cosmic_bringle",
	atlas = "jokers",
	pos = {
		x = 5,
		y = 1,
	},
	soul_pos = {
		x = 5,
		y = 2,
	},
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			money = 0,
			money_mod = 1,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.money,
				card.ability.extra.money_mod,
			}
		}
	end,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind then
			local pos = nil
			for k, v in ipairs(G.jokers.cards) do
				if v == card then 
					pos = k
					break
				end
			end
			if pos 
			and G.jokers.cards[pos+1]
			and not card.getting_sliced
			and not G.jokers.cards[pos+1].ability.eternal
			and not G.jokers.cards[pos+1].getting_sliced then
				local sliced_card = G.jokers.cards[pos+1]
				sliced_card.getting_sliced = true
				G.E_MANAGER:add_event(Event({func = function()
					card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
					play_sound('slice1', 0.96+math.random()*0.08)
					return true
				end}))
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
}