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

SMODS.Sound{
    key = "wiicrash",
    path = "wii_crash.ogg",
}