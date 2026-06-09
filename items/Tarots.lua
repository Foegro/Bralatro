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