SMODS.Gradient{
    key = "e_chips",
    colours = {
        G.C.CHIPS,
        HEX("d128c8"),
    },
    cycle = 5,
}
SMODS.Gradient{
    key = "e_mult",
    colours = {
        G.C.MULT,
        HEX("d128c8"),
    },
    cycle = 5,
}

local chips_ref = SMODS.Scoring_Parameters.chips
chips_ref.calculation_keys[#chips_ref.calculation_keys+1] = "bra_e_chips"
chips_ref.calculation_keys[#chips_ref.calculation_keys+1] = "bra_e_chips_mod"
SMODS.scoring_parameter_keys[#SMODS.scoring_parameter_keys+1] = "bra_e_chips"
SMODS.scoring_parameter_keys[#SMODS.scoring_parameter_keys+1] = "bra_e_chips_mod"
SMODS.calculation_keys[#SMODS.calculation_keys+1] = "bra_e_chips"
SMODS.calculation_keys[#SMODS.calculation_keys+1] = "bra_e_chips_mod"
local mult_ref = SMODS.Scoring_Parameters.mult
mult_ref.calculation_keys[#mult_ref.calculation_keys+1] = "bra_e_mult"
mult_ref.calculation_keys[#mult_ref.calculation_keys+1] = "bra_e_mult_mod"
SMODS.scoring_parameter_keys[#SMODS.scoring_parameter_keys+1] = "bra_e_mult"
SMODS.scoring_parameter_keys[#SMODS.scoring_parameter_keys+1] = "bra_e_mult_mod"
SMODS.calculation_keys[#SMODS.calculation_keys+1] = "bra_e_mult"
SMODS.calculation_keys[#SMODS.calculation_keys+1] = "bra_e_mult_mod"

SMODS.Scoring_Parameter_Calculation.bra_e_chips = "chips"
SMODS.Scoring_Parameter_Calculation.bra_e_chips_mod = "chips"
SMODS.Scoring_Parameter_Calculation.bra_e_mult = "mult"
SMODS.Scoring_Parameter_Calculation.bra_e_mult_mod = "mult"

local chips_calc_effect_ref = chips_ref.calc_effect
chips_ref.calc_effect = function(self, effect, scored_card, key, amount, from_edition)
    local ret = chips_calc_effect_ref(self, effect, scored_card, key, amount, from_edition)
    if ret ~= nil then return ret end
    if (key == 'bra_e_chips' or key == 'bra_e_chips_mod') and amount ~= 1 then
        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
        self:modify((hand_chips^(amount))-hand_chips)
        if not effect.remove_default_message then
            if from_edition then
                card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable','a_bra_e_chips',vars={amount}}, bra_e_chips_mod =  amount, colour =  G.C.EDITION, edition = true})
            else
                if key ~= 'bra_e_chip_mod' then
                    if effect.bra_e_chips_message then
                        card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.bra_e_chips_message)
                    else
                        card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'bra_e_chips', amount, percent)
                    end
                end
            end
        end
        return true
    end
end

local mult_calc_effect_ref = mult_ref.calc_effect
mult_ref.calc_effect = function(self, effect, scored_card, key, amount, from_edition)
    local ret = mult_calc_effect_ref(self, effect, scored_card, key, amount, from_edition)
    if ret ~= nil then return ret end
    if (key == 'bra_e_mult' or key == 'bra_e_mult_mod') and amount ~= 1 then
        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
        self:modify((mult^(amount))-mult)
        if not effect.remove_default_message then
            if from_edition then
                card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable','a_bra_e_mult',vars={amount}}, bra_e_mult_mod =  amount, colour =  G.C.EDITION, edition = true})
            else
                if key ~= 'bra_e_chip_mod' then
                    if effect.bra_e_mult_message then
                        card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.bra_e_mult_message)
                    else
                        card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'bra_e_mult', amount, percent)
                    end
                end
            end
        end
        return true
    end
end