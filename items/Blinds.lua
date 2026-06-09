SMODS.Atlas{
    key = "blinds",
    path = "Blinds.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Atlas{
    key = "roshamboAnim",
    path = "RoshamboAnim.png",
    px = 34,
    py = 34,
}

SMODS.Atlas{
    key = "roshamboAnimFull",
    path = "roshamboAnimFull.png",
    px = 34,
    py = 34,
    frames = 36,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Blind{
    key = "roshambo",
    atlas = "roshamboAnimFull",
    pos = {
        x = 0,
        y = 0,
    },
    boss = {min=0},
    boss_colour = HEX("ff0000"),
    in_pool = function(self)
        return false
    end
}

G.P_CENTERS.bra_rock = {
    order = 1,
    unlocked = true,
    start_alerted = true,
    discovered = true,
    name = "bra_rock",
    pos = {x=8,y=0},
    atlas = "bra_jokers",
    set = "Roshambo",
    config = {}
}

function Blind:roshambo()
    G.E_MANAGER:add_event(Event{
        trigger = "immediate",
        func = function()
            if self.roshambo_result then
                if self.roshambo_result == "Lost" then
                    for _, v in ipairs(G.play) do
                        SMODS.debuff_card(v, true, "Roshambo")
                    end
                end
                self.roshambo_result = nil
                G.play.T.w = G.play.T.w*5
                G.play.T.x = G.play.T.x+3
                return true
            end
        end,
    })
    self.area = CardArea(G.play.T.x+G.play.T.w/2-3*1.02*G.CARD_W/2,G.play.T.y-0.5,3*1.02*G.CARD_W,1.05*G.CARD_H,{
        card_limit = 3,
        type = 'consumeable',
        highlight_limit = 1
    })
    G.play.T.w = G.play.T.w/5
    G.play.T.x = G.play.T.x-3

    local rock = Card(self.area.T.x+self.area.T.w/2,self.area.T.y+self.area.T.h/2,G.CARD_W,G.CARD_H,G.P_CARDS.empty,G.P_CENTERS.bra_rock)
    rock:add_to_deck()
    self.area:emplace(rock)

    self:juice_up()
    self.children.animatedSprite = AnimatedSprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ANIMATION_ATLAS.bra_blinds, {x = 0, y = 3})
    self:change_dim(self.T.w*3,self.T.h*3)
end