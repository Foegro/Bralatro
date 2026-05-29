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
			logger.log(inspect(card.children.floating_sprite))
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
	perishable_compat = false,
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
	perishable_compat = false,
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
	perishable_compat = false,
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
	blueprint_compat = true,
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
					message = localize("k_bra_hampter"),
					colour = G.C.CHIPS,
				},
				message_card = card,
			}
		end
	end
}

SMODS.Joker{
	key = "hampter_wheel",
	atlas = "jokers",
	pos = {
		x = 2,
		y = 0
	},
	rarity = "bra_brepic",
	cost = 10,
	pools = {
		["Bralatro"] = true,
	},
	config = {
		extra = {
			rubee_goal = 1000000,
			rubees = 0,
			rubees_per_round = 200000,
		},
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				tostring(card.ability.extra.rubees_per_round),
				tostring(card.ability.extra.rubee_goal),
				tostring(card.ability.extra.rubees),
			}
		}
	end,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.rubees = card.ability.extra.rubees+card.ability.extra.rubees_per_round
			return {
				message = localize{
					type = "variable",
					key = "a_bra_rubees",
					vars = {
						tostring(card.ability.extra.rubees)
					},
				},
				message_card = card
			}
		end
		if context.selling_self and card.ability.extra.rubees >= card.ability.extra.rubee_goal then
			local joker = SMODS.create_card{
				set = "Joker",
				legendary = true,
				key_append = "Hampter Wheel",
			}
			joker:add_to_deck()
			G.jokers:emplace(joker)
		end
	end,
}

SMODS.Joker{
	key = "broob",
	atlas = "jokers",
	pos = {
		x = 8,
		y = 0,
	},
	rarity = 2,
	cost = 6,
	pools = {
		["Bralatro"] = true,
	},
	config = {
		xmult = 2,
	},
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.joker_main then
			return {xmult = card.ability.xmult}
		end
		if context.end_of_round and context.main_eval then
			local pos = nil
			for k, v in ipairs(G.jokers.cards) do
				if v == card then
					pos = k
					break
				end
			end
			if G.jokers.cards[pos-1] and G.jokers.cards[pos-1].ability.name ~= "j_bra_broob" then
				local old_joker = G.jokers.cards[pos-1]
				old_joker:flip()
				card_eval_status_text(G.jokers.cards[pos-1],"extra",nil,nil,nil,{
					message = localize("k_bra_boobify"),
					colour = HEX("8400c4")
				})
				G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.3,
					func = function()
						local joker = SMODS.create_card{
							set = "Joker",
							key = "j_bra_broob",
						}
						joker.edition = old_joker.edition
						joker.ability.eternal = old_joker.ability.eternal
						joker.ability.perishable = old_joker.ability.perishable
						joker.ability.perish_tally = old_joker.ability.perish_tally
						joker.ability.rental = old_joker.ability.rental
						joker:add_to_deck()
						joker.facing='back'
						joker:set_card_area(G.jokers)
						G.jokers.cards[pos-1] = joker
						joker:flip()
					return true
				end})
			end
			if G.jokers.cards[pos+1] and G.jokers.cards[pos+1].ability.name ~= "j_bra_broob" then
				local old_joker = G.jokers.cards[pos+1]
				old_joker:flip()
				card_eval_status_text(G.jokers.cards[pos+1],"extra",nil,nil,nil,{
					message = localize("k_bra_boobify"),
					colour = HEX("8400c4")
				})
				G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.3,
					func = function()
						local joker = SMODS.create_card{
							set = "Joker",
							key = "j_bra_broob",
						}
						joker.edition = old_joker.edition
						joker.ability.eternal = old_joker.ability.eternal
						joker.ability.perishable = old_joker.ability.perishable
						joker.ability.perish_tally = old_joker.ability.perish_tally
						joker.ability.rental = old_joker.ability.rental
						joker:add_to_deck()
						joker.facing='back'
						joker:set_card_area(G.jokers)
						G.jokers.cards[pos+1] = joker
						joker:flip()
					return true
				end})
			end
		end
	end,
}

SMODS.Joker{
	key = "mods",
	atlas = "jokers",
	pos = {
		x = 3,
		y = 3,
	},
	soul_pos = {
		x = 3,
		y = 4,
	},
	config = {
		extra = {},
	},
	blueprint_compat = true,
	rarity = 4,
	cost = 20,
	pools = {
		["Bralatro"] = true,
	},
	update = function(self, card, dt)
		if card.ability then
			if card.ability.extra.image then
				card.config.center.soul_pos = card.ability.extra.image
			else
				if pseudorandom("Mods Image") < 0.01 then
					card.ability.extra.image = {
						x = 1+math.min(3,math.floor(4*pseudorandom("Mods Image"))),
						y =	2
					}
					card.config.center.soul_pos = card.ability.extra.image
				else
					card.ability.extra.image = {
						x = 2+math.min(5,math.floor(6*pseudorandom("Mods Image"))),
						y =	4
					}
					card.config.center.soul_pos = card.ability.extra.image
				end
			end
		end
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			local unplayed_hand = {}
			for k, v in ipairs(context.full_hand) do
				local played = false
				if not v.debuff then
					for _k, _v in ipairs(context.scoring_hand) do
						if _v == v and not v.debu then played = true end
					end
				end
				if not played then unplayed_hand[#unplayed_hand+1] = v end
			end
			local total_chips = 0
			for k, v in ipairs(unplayed_hand) do
				local was_debuffed = v.debuff
				v.debuff = false
				total_chips = total_chips + v:get_chip_bonus()
				v.debuff = was_debuffed
			end
			if total_chips > 1 then
				return {
					xchips = total_chips
				}
			end
		end
	end
}

SMODS.Joker{
	key = "joker3",
	atlas = "jokers",
	pos = {
		x = 2,
		y = 3,
	},
	config = {
		extra = 3
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				card.ability.extra
			}
		}
	end,
	blueprint_compat = true,
	rarity = 2,
	cost = 6,
	calculate = function(self,card,context)
		if context.joker_main then
			local queens = {}
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() == 12 then queens[#queens+1] = v end
			end
			if #queens >= card.ability.extra then
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local _card = copy_card(pseudorandom_element(queens,"Mother 3"), nil, nil, G.playing_card)
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.hand:emplace(_card)
				_card.states.visible = nil
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:start_materialize()
						return true
					end
				}))
				return {
					message = localize('k_copied_ex'),
					colour = G.C.CHIPS,
					card = card,
					playing_cards_created = {true}
				}
			end
		end
	end
}

SMODS.Joker{
	key = "floof",
	atlas = "jokers",
	pos = {
		x = 2,
		y = 1,
	},
	soul_pos = {
		x = 2,
		y = 2,
	},
	config = {
		extra = 1.5
	},
	loc_vars = function(self,info_queue,card)
		local xmult
		if G.playing_cards then
			local queens = 0
			local kings = 0
			for k, v in ipairs(G.playing_cards) do
				if v:get_id() == 12 then queens = queens+1 end
				if v:get_id() == 13 then kings = kings+1 end
			end
			xmult = math.max(1,card.ability.extra*math.min(queens,kings))
		else
			xmult = 6
		end
		return {
			vars = {
				card.ability.extra,
				xmult
			}
		}
	end,
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.joker_main then
			local queens = 0
			local kings = 0
			for k, v in ipairs(G.playing_cards) do
				if v:get_id() == 12 then queens = queens+1 end
				if v:get_id() == 13 then kings = kings+1 end
			end
			local xmult = card.ability.extra*math.min(queens,kings)
			if xmult > 1 then
				return {
					xmult = xmult
				}
			end
		end
	end
}

SMODS.Joker{
	key = "hampter_mario",
	atlas = "jokers",
	pos = {
		x = 1,
		y = 3,
	},
	config = {
		extra = 5,
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_bra_hampter_wheel
		return {
			vars = {
				card.ability.extra
			}
		}
	end,
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra > 0 then
			card.ability.extra = card.ability.extra-1
			return {
				message = localize{
					type = "variable",
					key = "a_bra_hampter",
					vars = {
						card.ability.extra
					}
				}
			}
		end
		if context.selling_self and card.ability.extra <= 0 then
			local joker = SMODS.create_card{
				key = "j_bra_hampter_wheel"
			}
			joker.add_to_deck()
			G.jokers:emplace(joker)
		end
	end,
}

SMODS.Joker{
	key = "rescue_toads",
	atlas = "jokers",
	pos = {
		x = 8,
		y = 2,
	},
	loc_vars = function(self,info_queue,card)
		local hearts = 0
		local diamonds = 0
		local spades = 0
		local clubs = 0
		if G.playing_cards then
			for k, v in ipairs(G.playing_cards) do
				if v:is_suit("Hearts") then hearts = hearts+1 end
				if v:is_suit("Diamonds") then diamonds = diamonds+1 end
				if v:is_suit("Spades") then spades = spades+1 end
				if v:is_suit("Clubs") then clubs = clubs+1 end
			end
		else
			hearts = 13
			diamonds = 13
			spades = 13
			clubs = 13
		end
		return {
			vars = {
				hearts,
				diamonds,
				spades,
				clubs,
			}
		}
	end,
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			local mult = 0
			for k, v in ipairs(G.playing_cards) do
				if v:is_suit(context.other_card.base.suit) then mult = mult+1 end
			end
			if mult > 0 then
				return {
					mult = mult,
				}
			end
		end
	end
}

SMODS.Atlas{
	key = "suits_lc",
	path = "suits_lc.png",
	px = 71,
	py = 95,
}

SMODS.Atlas{
	key = "suits_hc",
	path = "suits_hc.png",
	px = 71,
	py = 95,
}

SMODS.Atlas{
	key = "suits_ui_lc",
	path = "suits_ui_lc.png",
	px = 18,
	py = 18,
}

SMODS.Atlas{
	key = "suits_ui_hc",
	path = "suits_ui_hc.png",
	px = 18,
	py = 18,
}

SMODS.Suit {
	key = "suitless",
	card_key = "N",
	pos = { y = 0 },
	ui_pos = {
		x = 0,
		y = 0,
	},
	lc_atlas = "suits_lc",
	hc_atlas = "suits_hc",
	lc_ui_atlas = "suits_ui_lc",
	hc_ui_atlas = "suits_ui_hc",
	lc_colour = HEX("bfbfbf"),
	hc_colour = HEX("313a45"),
	in_pool = function(self, args)
		return false
	end,
}

SMODS.Joker{
	key = "gooner_guy",
	atlas = "jokers",
	pos = {
		x = 9,
		y = 3,
	},
	soul_pos = {
		x = 9,
		y = 4,
	},
	config = {
		extra = {
			xmult = 1,
			mult = 0,
			chips = 0,
			money = 0,
			xmult_mod = 0.5,
			mult_mod = 5,
			chips_mod = 30,
			money_mod = 1,
		}
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				card.ability.extra.xmult_mod,
				card.ability.extra.xmult,
				card.ability.extra.money_mod,
				card.ability.extra.money,
				card.ability.extra.chips_mod,
				card.ability.extra.chips,
				card.ability.extra.mult_mod,
				card.ability.extra.mult,
			}
		}
	end,
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.xmult,
			}
		end
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local other_card = context.other_card
			if other_card:is_suit("Hearts") then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			end
			if other_card:is_suit("Diamonds") then
				card.ability.extra.money = card.ability.extra.money+card.ability.extra.money_mod
			end
			if other_card:is_suit("Spades") then
				card.ability.extra.chips = card.ability.extra.chips+card.ability.extra.chips_mod
			end
			if other_card:is_suit("Clubs") then
				card.ability.extra.mult = card.ability.extra.mult+card.ability.extra.mult_mod
			end
			SMODS.change_base(other_card, "bra_suitless")
			G.E_MANAGER:add_event(Event({
				func = function()
					other_card:juice_up()
					return true
				end
			}))
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
}

SMODS.Atlas{
	key = "vouchers",
	path = "Vouchers.png",
	px = 71,
	py = 95,
}

SMODS.Voucher{
	key = "black_paint",
	atlas = "vouchers",
	pos = {
		x = 2,
		y = 0,
	},
	config = {
		extra = "Suit"
	},
	cost = 10,
	redeem = function(self, card)
		G.GAME.bra_suitless_mode = card.ability.extra
	end,
	in_pool = function(self, args)
		if G.playing_cards then
			for k, v in ipairs(G.playing_cards) do
				if v.base.suit == "bra_suitless" then
					return true
				end
			end
		end
		return false
	end
}

SMODS.Voucher{
	key = "washing_machine",
	atlas = "vouchers",
	pos = {
		x = 2,
		y = 1,
	},
	config = {
		extra = "Wild",
	},
	cost = 10,
	requires = {"v_bra_black_paint"},
	redeem = function(self, card)
		G.GAME.bra_suitless_mode = card.ability.extra
	end,
}

SMODS.Voucher{
	key = "bruck",
	atlas = "vouchers",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = 2,
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				card.ability.extra
			}
		}
	end,
	cost = 10,
	redeem = function(self,card)
		G.GAME.bra_brepic_mod = G.GAME.bra_brepic_mod*card.ability.extra
	end
}

SMODS.Voucher{
	key = "streamer_luck",
	atlas = "vouchers",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = 0.005,
	},
	cost = 10,
	requires = {"v_bra_bruck"},
	redeem = function(self,card)
		G.GAME.bra_legendary_chance = card.ability.extra
	end
}

local get_current_pool_ref = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
	if _type == 'Joker' and not _rarity and G.GAME.bra_legendary_chance and G.GAME.bra_legendary_chance*G.GAME.legendary_mod > pseudorandom("Streamer Luck") then
		return get_current_pool_ref(_type,nil,true,_append)
	end
	return get_current_pool_ref(_type,_rarity,_legendary,_append)
end

SMODS.Atlas{
	key = "tarots",
	path = "Tarots.png",
	px = 71,
	py = 95,
}

SMODS.Consumable{
	key = "shunned",
	set = "Tarot",
	atlas = "tarots",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		suit_conv = "bra_suitless",
		max_highlighted = 5
	},
	loc_vars = function(self,info_queue,card)
		return {
			vars = {
				card.ability.max_highlighted
			}
		}
	end,
	in_pool = function(self, args)
		if G.playing_cards then
			for k, v in ipairs(G.playing_cards) do
				if v.base.suit == "bra_suitless" then
					return true
				end
			end
		end
		return false
	end
}