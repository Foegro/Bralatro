--- STEAMODDED HEADER
--- MOD_NAME: Bralatro
--- MOD_ID: bralatro
--- PREFIX: bra
--- MOD_AUTHOR: [Foegro, KevinE.S.The Lost Knight, FloofDumbus and Bringle Discord]
--- MOD_DESCRIPTION: Adds Bringle themed cards to the game
--- BADGE_COLOUR: 891B8A
--- DISPLAY_NAME:  Bralatro
--- VERSION: 0.7.1
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

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
end

SMODS.Atlas{
	key = "jokers",
	px = 71,
	py = 95,
	path = "Jokers.png",
}

G.C.BRALATRO = HEX("891B8A")
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
	pools = {
		["Bralatro"] = true
	},
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

SMODS.Sound{
	key = "music_bergentruck",
	path = "bergentruck.ogg",
	pitch = 1,
	sync = false,
	select_music_track = function(self)
		if G.jokers then
			for k, v in ipairs(G.jokers.cards) do
				if v.ability.name == "j_bra_foegro" then
					--logger.log("Check")
					return 999999
				end
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
	pools = {
		["Bralatro"] = true
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.discard then
			--logger.log(inspect(card.children.floating_sprite))
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
	pools = {
		["Bralatro"] = true
	},
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
	pools = {
		["Bralatro"] = true
	},
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
	pools = {
		["Bralatro"] = true
	},
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

SMODS.Joker{
	key = "greentoad",
	atlas = "jokers",
	pos = {
		x = 7,
		y = 2,
	},
	rarity = 2,
	cost = 7,
	config = {
		mult = 5,
	},
	pools = {
		["Bralatro"] = true
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.mult
			}
		}
	end,
	blueprint_compat = true,
	calculate = function(self, card, context) 
		if context.joker_main then
			return {
				mult = card.ability.mult,
				mult_message = {
					message = localize{
						type = "variable",
						key = "a_bra_greentoad_mult",
						vars = {
							card.ability.mult
						},
					},
					colour = G.C.MULT,
				},
			}
		end
	end,
}

SMODS.Joker{
	key = "chat",
	atlas = "jokers",
	pos = {
		x = 0,
		y = 1,
	},
	soul_pos = {
		x = 0,
		y = 2,
	},
	rarity = 4,
	cost = 20,
	pools = {
		["Bralatro"] = true
	},
	config = {
		extra = {
			money_max = 5,
			money_chance = 100,
		}
	},
	blueprint_compat = true,
	calculate = function(self, card, context)
		if pseudorandom('chat') < G.GAME.probabilities.normal/card.ability.extra.money_chance then
			return {
				dollars = math.ceil(pseudorandom('chat_payout')*card.ability.extra.money_max),
				message_card = card
			}
		end
	end,
}

SMODS.Joker{
	key = "trans_flavio",
	atlas = "jokers",
	pos = {
		x = 9,
		y = 2,
	},
	rarity = 1,
	cost = 6,
	pools = {
		["Bralatro"] = true
	},
	config = {
		extra = {
			chance = 2,
			money = 5,
		}
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return {
			vars = {
				''..(G.GAME and G.GAME.probabilities.normal or 1),
				card.ability.extra.chance,
				card.ability.extra.money
			}
		}
	end,
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.individual and context.other_card.ability.name == 'Wild Card'
		and pseudorandom("Trans Flavio") < G.GAME.probabilities.normal/card.ability.extra.chance then
			return {
				dollars = card.ability.extra.money,
				card = card
			}
		end
	end,
}

SMODS.Joker{
	key = "bug_sticker_bucket_origami",
	atlas = "jokers",
	pos = {
		x = 6,
		y = 1,
	},
	soul_pos = {
		x = 6,
		y = 2,
	},
	rarity = "bra_brepic",
	cost = 9,
	pools = {
		["Bralatro"] = true
	},
	config = {
		extra = {
			enhancement_chance = 2,
			edition_chance = 5,
			seal_chance = 20,
		}
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				''..(G.GAME and G.GAME.probabilities.normal or 1),
				card.ability.extra.enhancement_chance,
				card.ability.extra.edition_chance,
				card.ability.extra.seal_chance,
			}
		}
	end,
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.before then
			local enhanced = false
			for k, v in ipairs(context.scoring_hand) do
				local card_enhanced = false
				if v.config.center == G.P_CENTERS.c_base and pseudorandom("bug_sticker_bucket_origami") < G.GAME.probabilities.normal/card.ability.extra.enhancement_chance then
					v:set_ability(SMODS.poll_enhancement{
						guaranteed = true,
						type_key = "bug_sticker_bucket_origami"
					})
					enhanced = true
					card_enhanced = true
				end
				if not v.edition and pseudorandom("bug_sticker_bucket_origami") < G.GAME.probabilities.normal/card.ability.extra.edition_chance then
					v:set_edition(SMODS.poll_edition{
						guaranteed = true,
						type_key = "bug_sticker_bucket_origami",
						no_negative = true,
					})
					enhanced = true
					card_enhanced = true
				end
				if not v.seal and pseudorandom("bug_sticker_bucket_origami") < G.GAME.probabilities.normal/card.ability.extra.seal_chance then
					v:set_seal(SMODS.poll_seal{
						guaranteed = true,
						type_key = "bug_sticker_bucket_origami"
					})
					enhanced = true
					card_enhanced = true
				end
				if card_enhanced then
					G.E_MANAGER:add_event(Event{func = function()
						v:juice_up()
						return true
					end})
				end
			end
			if not enhanced then
				return {
					message = localize('k_nope_ex'),
					message_card = card,
					colour = G.C.SECONDARY_SET.Tarot,
				}
			end
		end
	end,
}

SMODS.Joker{
	key = "bringle",
	atlas = "jokers",
	pos = {
		x = 4,
		y = 3,
	},
	soul_pos = {
		x = 8,
		y = 4,
	},
	rarity = 4,
	cost = 20,
	pools = {
		["Bralatro"] = true,
	},
	config = {
		extra = {
			xchips = 1.5
		},
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				card.ability.extra.xchips,
			},
		}
	end,
	update = function(self, card, dt)
		if card.ability then
			if card.ability.extra.image then card.config.center.pos.x = 4+card.ability.extra.image
			else
				card.ability.extra.image = math.min(4,math.floor(5*pseudorandom("Bringle Image")))
				card.config.center.pos.x = 4+card.ability.extra.image
			end
		end
	end,
	calculate = function(self,card,context)
		if context.other_joker and context.other_joker.ability.name ~= "j_bra_bringle" then
			return {
				xchips = card.ability.extra.xchips,
				xchip_message = {
					message = localize("k_bra_big_hampter"),
					colour = G.C.CHIPS,
				},
				message_card = card,
			}
		end
	end
}