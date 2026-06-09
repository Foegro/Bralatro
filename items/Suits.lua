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
        return G.GAME.bra_suitless_mode and (G.GAME.bra_suitless_mode == "Suit" or G.GAME.bra_suitless_mode == "Wild")
    end,
    loc_vars = function(self, info_queue, card)
        Bralatro.add_suitless_info_queue(info_queue)
        return {}
    end
}