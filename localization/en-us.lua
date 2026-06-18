return {
    descriptions = {
        Back={},
        Blind={
			bl_bra_roshambo = {
				name = "The Roshambo (WIP)",
				text = {
					"After {C:attention}playing your hand{},",
					"play a round of {C:attention}Roshambo{}.",
					"If you lose,",
					"all played cards get {C:attention}debuffed{}.",
					"{C:red,E:2}Not yet functional.",
					"{C:red,E:2}Will not show up during runs."
				}
			}
		},
        Edition={},
        Enhanced={},
        Joker={
			j_bra_kevines = {
				name = "KevinE.S.The Lost Knight",
				text = {
					"This Joker removes all {C:attention}Enhancements, Editions and Seals",
					"from scoring cards and gains {X:mult,C:white}X#1#{} Mult",
					"from each removal.",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
				}
			},
			j_bra_foegro = {
				name = "{C:tarot}Foegro the porble guy",
				text = {
					"Creates a {C:dark_edition}Negative {C:tarot}Tarot{} Card",
					"when a card is {C:attention}discarded",
					"and set their {C:attention}sell value {}to {C:attention}$0",
				}
			},
			j_bra_wiimote = {
				name = "Wiimote",
				text = {
					"Gains {C:chips}+#1#{} Chips",
					"for each played {C:attention}Three of a Kind{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
				}
			},
			j_bra_wii = {
				name = "Wii",
				text = {
					"Gains {C:mult}+#1#{} Mult",
					"for each played {C:attention}Three of a Kind{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				}
			},
			j_bra_cosmic_bringle = {
				name = "Cosmic Bringle",
				text = {
					"Gives {C:money}$#1#{} at the {C:attention}end of round.",
					"When {C:attention}Blind{} is selected, destroy the Joker to right,",
					"to increase the amount earned by {C:money}$#2#{}."
				}
			},
			j_bra_greentoad = {
				name = "Greentoad",
				text = {
					"+{C:mult}#1#{s:0.5,C:inactive}.{C:mult}0{} Mult"
				},
			},
			j_bra_chat = {
				name = "Chat",
				text = {
					"Occasionally gives you donations",
				}
			},
			j_bra_trans_flavio = {
				name = "Transgender Flavio",
				text = {
					"{C:green}#1# in #2#{} chance to give {C:money}$#3#",
					"when a {C:attention}Wild Card{} is scored",
				}
			},
			j_bra_bug_sticker_bucket_origami = {
				name = "The Bug, The Sticker, The Bucket and The Origami",
				text = {
					"For each scored card:",
					"{C:green}#1# in #2#{} chance to add an {C:attention}enhancement.",
					"{C:green}#1# in #3#{} chance to add an {C:attention}edition {C:inactive}(Negative excluded){}.",
					"{C:green}#1# in #4#{} chance to add a {C:attention}seal.",
					"{C:inactive}Does not apply if the card already has it."
				}
			},
			j_bra_bringle = {
				name = "Bringle",
				text = {
					"Gives {X:chips,C:white}X#1#{} Chips",
					"whenever a {C:attention}Joker{} is triggered.",
					"{C:inactive}(Bringle excluded)",
				},
			},
			j_bra_hampter_wheel = {
				name = "Hampter Wheel",
				text = {
					"Gains {C:mult}#1#{} Rubees per round.",
					"Sell to create a {C:legendary}Legendary{} Joker",
					"after gaining {C:mult}#2#{} Rubees.",
					"{X:mult,C:white}#3#/#2#{} Rubees",
				},
			},
			j_bra_broob = {
				name = "Broob",
				text = {
					"{X:mult,C:white}X2{} Mult",
					"At the {C:attention}end of round{}",
					"transforms {C:attention}adjacened{} Jokers into {C:attention}Broobs",
				},
			},
			j_bra_mods = {
				name = "Mod Team",
				text = {
					"Gives {X:chips,C:white}XChips{} equal to",
					"the total amount of {C:chips}Chips{} on all",
					"{C:attention}non-scoring{} or {C:attention}debuffed{} cards played",
				}
			},
			j_bra_joker3 = {
				name = "Joker 3",
				text = {
					"If hand contains at least {C:attention}3{} scoring {C:attention}Queens",
					"create a copy of a {C:attention}random{} one of them",
					"and place it in your hand",
				}
			},
			j_bra_floof = {
				name = "FloofDumbus",
				text = {
					"{X:mult,C:white}X#1#{} Mult for every {C:attention}Pair{}",
					"of a {C:attention}King{} and a {C:attention}Queen{} in your deck",
					"Currently {X:mult,C:white}X#2#{} Mult",
					"{C:inactive}Example: 5 Kings, 3 Queens -> 3 Pairs -> {X:mult,C:white}X4.5"
				}
			},
			j_bra_hampter_mario = {
				name = "Hampter Mario",
				text = {
					"Sell after {C:attention}#1#{} Round(s)",
					"to create a {C:attention}Hampter Wheel"
				}
			},
			j_bra_rescue_toads = {
				name = "Rescue Toads",
				text = {
					"Each scored card gives {C:mult}+Mult{} equal to the amount",
					"of cards of the same suit in your deck",
					"{C:hearts}Hearts: {C:mult}+#1#{} Mult",
					"{C:diamonds}Diamonds: {C:mult}+#2#{} Mult",
					"{C:spades}Spades: {C:mult}+#3#{} Mult",
					"{C:clubs}Clubs: {C:mult}+#4#{} Mult"
				}
			},
			j_bra_gooner_guy = {
				name = "Gooner Guy",
				text = {
					"Removes the suit of all scored cards.",
					"+{X:mult,C:white}X#1#{} Mult per removed {C:hearts}Heart{}. {C:inactive}(Currently: {X:mult,C:white}X#2#{})",
					"+{C:money}$#3#{} at the end of round per removed {C:diamonds}Diamond{}. {C:inactive}(Currently: {C:money}+$#4#{})",
					"{C:chips}+#5#{} Chips per removed {C:spades}Spade{}. {C:inactive}(Currently: {C:chips}+#6#{} Chips)",
					"{C:mult}+#7#{} Mult per removed {C:clubs}Club{}. {C:inactive}(Currently: {C:mult}+#8#{} Mult)",
				}
			},
			j_bra_roy = {
				name = "Roy Koopa",
				text = {
					"Removes the suit from every {C:attention}discarded{} card",
					"and gains {C:attention}#1# {C:dark_edition,E:2}Charge{} per suit removed.",
					"On each scored card:",
					"Consumes {C:attention}#2# {C:dark_edition,E:2}Charge{} to add an {C:attention}enhancement{}.",
					"Consumes {C:attention}#3# {C:dark_edition,E:2}Charges{} to add an {C:attention}edition{}. {C:inactive}(Negative excluded)",
					"Consumes {C:attention}#4# {C:dark_edition,E:2}Charges{} to add a {C:attention}seal{}.",
					"{C:inactive}(Currently {C:attention}#5# {C:dark_edition,E:2}Charge(s){C:inactive})",
					"	",
					"{C:inactive}Will only apply 1 per card",
					"{C:inactive}Always applies the most expensive addition,",
					"{C:inactive}that you have the {C:dark_edition,E:2}Charges{C:inactive} for",
					"{C:inactive}and that the card doesn't already have."
				}
			},
			j_bra_challenge_medal = {
				name = "Challenge Medal",
				text = {
					"{X:attention,C:white}X#1#{} Blind Size",
					"{X:money,C:white}X#2#{} end of round payout"
				}
			},
			j_bra_woop = {
				name = "Woop",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"Gains {X:mult,C:white}X#2#{} Mult whenever a card changes suit.",
					"{C:inactive}So gay he is every color of the rainbow"
				}
			},
			j_bra_code_bringle = {
				name = "Code Bringle",
				text = {
					"When you buy a card,",
					"{C:green}#1# in #2#{} Chance",
					"to gain {C:money}$#3#{}."
				}
			},
			j_bra_bowser = {
				name = "Bowser",
				text = {
					"{C:attention}+#1#{} hand size",
					"For every {C:attention}#2# {C:inactive}(#3#) {C:enhanced}Consumables{} sold,",
					"increase hand size by {C:attention}#4#",
				}
			},
			j_bra_bringles_can = {
				name = "Bringles Can",
				text = {
					"At end of round gives {C:money}$#1#{}",
					"and reduces amount by {C:money}$#2#{}",
				}
			},
			j_bra_uranium_cube={
				name="Uranium Cube",
				text={
					"{X:bra_e_mult,C:white} ^#1# {} Mult",
					"{C:green}#2# in #3#{} chance this",
					"card is destroyed",
					"at end of round",
				},
			},
			j_bra_drained = {
				name = "Drained Joker",
				text = {
					"{C:green}#1# in #2#{} Chance for",
					"played {C:bra_suitless}Suitless{} Cards",
					"to reduce the current {C:attention}Blind Size{}",
					"by {C:attention}#3#%"
				}
			}
		},
        Other={
			bra_suitless_no_suit = {
				name = "Suitless",
				text = {
					"Does not count as a suit.",
					"{C:inactive}(e.g. 5 Suitless Cards do not make a flush)"
				}
			},
			bra_suitless_wild = {
				name = "Suitless",
				text = {
					"Can be used",
					"as any suit."
				}
			},
			undiscovered_bra_pixels={
				name="Not Discovered",
				text={
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
		},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={
			c_bra_shunned = {
				name = "The Shunned",
				text = {
					"Turns up to {C:attention}#1#{} selected cards",
					"into {C:bra_suitless}Suitless{} Cards"
				}
			}
		},
        Voucher={
			v_bra_black_paint = {
				name = "Black Paint",
				text = {
					"{C:bra_suitless}Suitless{} Cards count as their own suit."
				}
			},
			v_bra_washing_machine = {
				name = "Washing Machine",
				text = {
					"{C:bra_suitless}Suitless{} cards count as {C:attention}any{} suit"
				}
			},
			v_bra_bruck = {
				name = "Bruck",
				text = {
					"{C:bra_brepic}Brepic{} Jokers appear",
					"{C:attention}X#1#{} times as often.",
				}
			},
			v_bra_streamer_luck = {
				name = "Streamer Luck",
				text = {
					"{C:legendary}Legendary{} Jokers can appear in shop",
				}
			},
		},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
			k_bra_brepic = "Brepic",
			k_bra_eee = "eeeeeeeeeeeeee",
			k_bra_big_eee = "EEEEEEEEEEEEEEEEEEEEEEE",
			k_bra_hampter = "Hampter!!!",
			k_bra_boobify = "Broobify",
			k_bra_pixels = "Pixel",
			b_bra_pixels_cards = "Pixels",
			k_bra_canned = "Canned!",
			k_bra_degraded = "Degraded"
		},
        high_scores={},
        labels={
			k_bra_brepic = "Brepic",
		},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={
			bra_suitless = "Nothings"
		},
        suits_singular={
			bra_suitless = "Suiless"
		},
        tutorial={},
        v_dictionary={
			a_bra_greentoad_mult = "+#1#.0 Mult",
			a_bra_rubees = "#1# Rubees!",
			a_bra_hampter = "Hampter in #1#!",
			a_bra_plus_xmult = "+#1# XMult",
			a_bra_plus_money = "+$#1#",
			a_bra_charges = "#1# Charges",
			a_bra_e_chips = "^#1# Chips",
			a_bra_e_mult = "^#1# Mult",
			a_bra_percent_minus = "-#1#%"
		},
        v_text={},
    },
}