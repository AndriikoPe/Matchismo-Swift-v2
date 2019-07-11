//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  PlayingCardDeck.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

class PlayingCardDeck: Deck {
    override init() {
        super.init()

        for suit in PlayingCard.validSuits() {
            for rank in 1...PlayingCard.maxRank() {
                let card = PlayingCard()
                card.suit = suit
                card.rank = rank
                add(card)
            }
        }
    }
}
