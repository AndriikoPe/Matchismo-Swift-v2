//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  Deck.swift
//  Matchismo 
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

import Foundation

class Deck: NSObject {
    func add(_ card: Card, atTop: Bool) {
        if atTop {
            cards.insert(card, at: 0)
        } else {
            cards.append(card)
        }
    }

    func add(_ card: Card) {
        add(card, atTop: false)
    }

    func drawRandomCard() -> Card? {
        var randomCard: Card? = nil

        if cards.count != 0 {
            let index = Int(arc4random()) % cards.count
            randomCard = cards[index]
            cards.remove(at: Int(index))
        }
        return randomCard
    }


    private var cards = [Card]()
}
