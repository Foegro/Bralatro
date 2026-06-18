SMODS.Consumable{
    key = "shunned",
    set = "Tarot",
    atlas = "consumables",
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
        return Bralatro.suitless_in_deck()
    end
}