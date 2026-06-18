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
                SMODS.scale_card(card,{
                    ref_table = card.ability,
                    ref_value = "x_mult",
                    scalar_value = "extra",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial+(#enhanced+#editioned+#sealed)*change
                    end,
                })
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_bra_artist'), G.C.RED, G.C.WHITE, 1.2 )
    end,
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
            local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
            tarot:set_edition({negative = true})
            tarot:add_to_deck()
            tarot.sell_cost = 0
            tarot.sell_cost_label = tarot.facing == 'back' and '?' or tarot.sell_cost
            G.consumeables:emplace(tarot)
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_bra_coder'), G.C.GREEN, G.C.WHITE, 1.2 )
    end,
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
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                scaling_message = {
                    message = localize("k_bra_big_eee"),
                    message_card = card,
                    colour = G.C.CHIPS,
                    sound = "bra_wiicrash"
                }
            })
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
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                scaling_message = {
                    message = localize("k_bra_big_eee"),
                    message_card = card,
                    colour = G.C.MULT,
                    sound = "bra_wiicrash"
                }
            })
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
                    SMODS.scale_card(card,{
                        ref_table = card.ability.extra,
                        ref_value = "money",
                        scalar_value = "money_mod",
                        scaling_message = {
                            message = localize("$")+card.ability.extra.money
                        }
                    })
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
        if SMODS.pseudorandom_probability(card, "bra_chat_tigger", 1, card.ability.extra.money_chance) then
            return {
                dollars = math.ceil(pseudorandom('bra_chat_payout')*card.ability.extra.money_max),
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
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.money
            }
        }
    end,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.individual and context.other_card.ability.name == 'Wild Card'
                and SMODS.pseudorandom_probability(card, "bra_trans_flaviob", 1, card.ability.extra.chance) then
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
        local num, en_denom = SMODS.get_probability_vars(card, 1, card.ability.extra.enhancement_chance)
        local _, ed_denom = SMODS.get_probability_vars(card, 1, card.ability.extra.edition_chance)
        local _, s_denom = SMODS.get_probability_vars(card, 1, card.ability.extra.seal_chance)
        return {
            vars = {
                num,
                en_denom,
                ed_denom,
                s_denom,
            }
        }
    end,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.before then
            local enhanced = false
            for k, v in ipairs(context.scoring_hand) do
                local card_enhanced = false
                if v.config.center == G.P_CENTERS.c_base and SMODS.pseudorandom_probability(card, "bra_bug_sticker_origami", 1, card.ability.extra.enhancement_chance) then
                    v:set_ability(SMODS.poll_enhancement{
                        guaranteed = true,
                        type_key = "bug_sticker_bucket_origami"
                    })
                    enhanced = true
                    card_enhanced = true
                end
                if not v.edition and SMODS.pseudorandom_probability(card, "bra_bug_sticker_origami", 1, card.ability.extra.edition_chance) then
                    v:set_edition(SMODS.poll_edition{
                        guaranteed = true,
                        type_key = "bug_sticker_bucket_origami",
                        no_negative = true,
                    })
                    enhanced = true
                    card_enhanced = true
                end
                if not v.seal and SMODS.pseudorandom_probability(card, "bra_bug_sticker_origami", 1, card.ability.extra.seal_chance) then
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
        local changed = false
        if card.ability then
            if not card.ability.extra.image then
                card.ability.extra.image = math.min(4,math.floor(5*pseudorandom("bra_bringle_image")))
                card.config.center.pos.x = 4+card.ability.extra.image
                changed = true
            end
            card.config.center.pos.x = 4+card.ability.extra.image
            if changed then card:set_sprites(card.config.center) end
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
                key_append = "bra_hampter_wheel",
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
        local changed = false
        if card.ability then
            if not card.ability.extra.image then
                if pseudorandom("Mods Image") < 0.01 then
                    card.ability.extra.image = {
                        x = 1+math.min(3,math.floor(4*pseudorandom("bra_mods_image"))),
                        y =	2
                    }
                else
                    card.ability.extra.image = {
                        x = 2+math.min(5,math.floor(6*pseudorandom("bra_mods_image"))),
                        y =	4
                    }
                end
                changed = true
            end
            card.config.center.soul_pos = card.ability.extra.image
            if changed then card:set_sprites(card.config.center) end
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
                local _card = copy_card(pseudorandom_element(queens,"bra_joker3"), nil, nil, G.playing_card)
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
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_bra_artist'), G.C.RED, G.C.WHITE, 1.2 )
    end,
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
    eternal_compat = false,
    perishable_compat = false,
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
                key = "j_bra_hampter_wheel",
            }
            joker:add_to_deck()
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
        Bralatro.add_suitless_info_queue(info_queue)
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
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_mod",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT
                })
            end
            if other_card:is_suit("Diamonds") then
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "money",
                    scalar_value = "money_mod",
                    scaling_message = {
                        message = localize("$")+card.ability.extra.money
                    }
                })
            end
            if other_card:is_suit("Spades") then
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    message_key = "a_chips",
                    message_colour = G.C.CHIPS
                })
            end
            if other_card:is_suit("Clubs") then
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    message_key = "a_mult",
                    message_colour = G.C.MULT
                })
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

SMODS.Joker{
    key = "roy",
    atlas = "jokers",
    pos = {
        x = 2,
        y = 5,
    },
    config = {
        extra = {
            charges = 0,
            per_card = 1,
            enhancement = 1,
            edition = 5,
            seal = 20,
        }
    },
    loc_vars = function(self,info_queue,card)
        Bralatro.add_suitless_info_queue(info_queue)
        return {
            vars = {
                card.ability.extra.per_card,
                card.ability.extra.enhancement,
                card.ability.extra.edition,
                card.ability.extra.seal,
                card.ability.extra.charges,
            }
        }
    end,
    rarity = 3,
    cost = 8,
    calculate = function(self,card,context)
        if context.discard then
            if context.other_card.base.suit ~= "bra_suitless" then
                SMODS.change_base(context.other_card,"bra_suitless")
                card.ability.extra.charges = card.ability.extra.charges+card.ability.extra.per_card
                return {
                    message_card = card,
                    message = localize{
                        type = "variable",
                        key = "a_bra_charges",
                        vars = {
                            card.ability.extra.charges
                        }
                    },
                    colour = G.C.EDITION
                }
            end
        end
        if context.before then
            for _, v in ipairs(context.scoring_hand) do
                if card.ability.extra.charges >= card.ability.extra.seal and not v.seal then
                    v:set_seal(SMODS.poll_seal{
                        guaranteed = true,
                        type_key = "bra_roy",
                    })
                    card.ability.extra.charges = card.ability.extra.charges-card.ability.extra.seal
                elseif card.ability.extra.charges >= card.ability.extra.edition and not v.edition then
                    v:set_edition(SMODS.poll_edition{
                        guaranteed = true,
                        type_key = "bra_roy",
                        no_negative = true,
                    })
                    card.ability.extra.charges = card.ability.extra.charges-card.ability.extra.edition
                elseif card.ability.extra.charges >= card.ability.extra.enhancement and v.config.center == G.P_CENTERS.c_base then
                    v:set_ability(SMODS.poll_enhancement{
                        guaranteed = true,
                        type_key = "bra_roy",
                    })
                    card.ability.extra.charges = card.ability.extra.charges-card.ability.extra.enhancement
                end
            end
            return {
                message_card = card,
                message = localize{
                    type = "variable",
                    key = "a_bra_charges",
                    vars = {
                        card.ability.extra.charges
                    }
                },
                colour = G.C.EDITION,
            }
        end
    end
}

SMODS.Joker{
    key = "challenge_medal",
    atlas = "jokers",
    pos = {
        x = 0,
        y = 4,
    },
    soul_pos = {
        x = 0,
        y = 5,
    },
    config = {
        extra = {
            blind_size = 1.5,
            dollar_mult = 1.5,
        }
    },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.blind_size,
                card.ability.extra.dollar_mult,
            }
        }
    end,
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*card.ability.extra.blind_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling/card.ability.extra.blind_size
    end,
    calculate = function(self,card,context)
        if context.bra_dollar_mult then
            return {
                dollar_mult = card.ability.extra.dollar_mult
            }
        end
    end
}

local card_change_suit_ref = Card.change_suit
function Card:change_suit(new_suit)
    if self.base.suit ~= suit then
        SMODS.calculate_context({
            bra_suit_change = true,
            card = self,
            old_suit = self.base.suit,
            new_suit = new_suit
        })
    end
    card_change_suit_ref(self,new_suit)
end

local smods_change_base_ref = SMODS.change_base
SMODS.change_base = function(card, suit, rank, manual_sprites)
    if card.base.suit ~= suit then
        SMODS.calculate_context({
            bra_suit_change = true,
            card = card,
            old_suit = card.base.suit,
            new_suit = suit
        })
    end
    return smods_change_base_ref(card,suit,rank,manual_sprites)
end

SMODS.Joker{
    key = "woop",
    atlas = "jokers",
    pos = {
        x = 1,
        y = 4,
    },
    soul_pos = {
        x = 1,
        y = 5,
    },
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 0.2
        }
    },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod,
            }
        }
    end,
    calculate = function(self,card,context)
        if context.bra_suit_change then
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_key = "a_xmult",
                message_colour = G.C.MULT
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_bra_ideas'), G.C.BLUE, G.C.WHITE, 1.2 )
    end,
}

SMODS.Joker{
    key = "code_bringle",
    atlas = "jokers",
    pos = {
        x = 2,
        y = 6,
    },
    config = {
        extra = {
            money = 5,
            chance = 2,
        }
    },
    loc_vars = function(self,info_queue,card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.money,
            }
        }
    end,
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.buying_card and SMODS.pseudorandom_probability(card, "bra_code_bringle", 1, card.ability.extra.chance) then
            return {
                dollars = card.ability.extra.money,
                message_card = card,
            }
        end
    end
}

SMODS.Joker{
    key = "bowser",
    atlas = "jokers",
    pos = {
        x = 0,
        y = 6,
    },
    soul_pos = {
        x = 0,
        y = 7,
    },
    config = {
        extra = {
            handsize = 0,
            handsize_mod = 1,
            sells = 5,
            sells_left = 5,
        },
    },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.handsize,
                card.ability.extra.sells,
                card.ability.extra.sells_left,
                card.ability.extra.handsize_mod,
            }
        }
    end,
    cost = 20,
    rarity = 4,
    calculate = function(self,card,context)
        if context.selling_card and context.card.ability.consumeable then
            card.ability.extra.sells_left = card.ability.extra.sells_left-1
            if card.ability.extra.sells_left <= 0 then
                card.ability.extra.sells_left = card.ability.extra.sells
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "handsize",
                    scalar_value = "handsize_mod",
                    no_message = true
                })
                G.hand:change_size(card.ability.extra.handsize_mod)
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.hand:change_size(-card.ability.extra.handsize)
        end
    end,
    update = function(self, card, dt)
        local changed = false
        if not card.ability.extra.image then
            if pseudorandom("bra_bowser") < 0.05 then
                card.ability.extra.image = 1
            else
                card.ability.extra.image = 0
            end
            changed = true
        end
        card.config.center.soul_pos.x = card.ability.extra.image
        card.config.center.pos.x = card.ability.extra.image
        if (changed) then card:set_sprites(card.config.center) end
    end
}

SMODS.Joker{
    key = "bringles_can",
    atlas = "jokers",
    pos = {
        x = 7,
        y = 0,
    },
    config = {
        extra = {
            money = 10,
            money_mod = 2,
        }
    },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.money_mod
            }
        }
    end,
    cost = 8,
    rarity = 2,
    perishable_compat = false,
    eternal_compat = false,
    calc_dollar_bonus = function(self, card)
        G.E_MANAGER:add_event(Event{
            func = function()
                SMODS.scale_card(card,{
                    ref_table = card.ability.extra,
                    ref_value = "money",
                    scalar_value = "money_mod",
                    operation = "-",
                    no_message = true
                })
                if card.ability.extra.money <= 0 then
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    })
                    card_eval_status_text(card,"extra",nil,nil,nil,{
                        message = localize("k_bra_canned"),
                    })
                else
                    card_eval_status_text(card,"extra",nil,nil,nil,{
                        message = localize{
                            type = "variable",
                            key = "a_chips_minus",
                            vars = {
                                card.ability.extra.money_mod
                            },
                        },
                        colour = G.C.RED
                    })
                end
                return true
            end
        })
        return card.ability.extra.money
    end
}

SMODS.Joker:take_ownership('cavendish',
    {
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    x_mult = card.ability.extra.Xmult
                }
            end
            if context.end_of_round and context.main_eval and not context.blueprint then
                if SMODS.pseudorandom_probability(card,"cavendish", 1, card.ability.extra.odds) then
                    G.GAME.pool_flags.cavendish_extinct = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                 func = function()
                                     G.jokers:remove_card(self)
                                     card:remove()
                                     card = nil
                                     return true; end}))
                            return true
                        end
                    }))
                    return {
                        message = localize('k_extinct_ex')
                    }
                else
                    return {
                        message = localize('k_safe_ex')
                    }
                end
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.gros_michel_extinct and not G.GAME.pool_flags.cavendish_extinct
        end
    },
    true
)

SMODS.Joker{
    key = "uranium_cube",
    atlas = "jokers",
    pos = {
        x = 8,
        y = 1,
    },
    config = {
        extra = {
            e_mult = 2,
            chance = 10000
        }
    },
    loc_vars = function(self,info_queue,card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {
            vars = {
                card.ability.extra.e_mult,
                num,
                denom,
            }
        }
    end,
    cost = 3,
    eternal_compat = false,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                bra_e_mult = card.ability.extra.e_mult
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, "bra_uranium_cube", 1, card.ability.extra.chance) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
                            G.jokers:remove_card(self)
                            card:remove()
                            card = nil
                            return true; end}))
                        return true
                    end
                }))
                return {
                    message = localize("k_bra_degraded")
                }
            else
                return {
                    message = localize("k_safe_ex")
                }
            end
        end
    end,
    in_pool = function(self,args)
        return G.GAME.pool_flags.cavendish_extinct
    end
}

SMODS.Joker{
    key = "drained",
    atlas = "jokers",
    pos = {
        x = 0,
        y = 3,
    },
    config = {
        extra = {
            reduction = 0.25,
            chance = 2
        }
    },
    loc_vars = function(self,info_queue,card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.reduction*100,
            }
        }
    end,
    rarity = 2,
    cost = 6,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.individual then
            return {
                message = localize{
                    type = "variable",
                    key = "a_bra_percent_minus",
                    vars = {
                        card.ability.extra.reduction*100
                    }
                },
                colour = G.C.DYN_UI.DARK,
                func = function()
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            G.GAME.blind.chips = G.GAME.blind.chips*(1-card.ability.extra.reduction)
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.HUD_blind:recalculate(false)
                            return true
                        end
                    })
                end
            }
        end
    end,
    in_pool = function(self,args)
        return Bralatro.suitless_in_deck()
    end
}