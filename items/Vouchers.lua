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
        y = 1,
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