//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  Card.swift
//  Matchismo 
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

import Foundation

class Card: NSObject {
    var contents = ""
    var isChosen = false
    var isMatched = false

    func match(_ otherCards: [Card]?) -> Int {
        var score = 0

        for card in otherCards ?? [] {
            if (card.contents == contents) {
                score = 1
            }
        }
        return score
    }
}
