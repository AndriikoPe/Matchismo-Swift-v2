//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  CardMatchingGame.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/22/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

import Foundation

let MISMATCH_PENALTY = 2
let MATCH_BONUS = 4
let COST_TO_CHOOSE = 1

class CardMatchingGame: NSObject {
    //designated initializer
    init?(cardCount count: Int, using deck: Deck) {
        cards = []

        for _ in 0..<count {
            let card = deck.drawRandomCard()
            if card != nil {
                cards.append(card!)
            } else {
                return nil
            }
        }
    }

    func chooseCard(at index: Int) {
        matchDesctiption = "" //removing description whenever a new card is chosen
        if let card = self.card(at: index) {
            if !card.isMatched {
                if card.isChosen {
                    card.isChosen = false
                } else {
                    var otherCards = [Card]()
                    for otherCard in cards {
                        if !otherCard.isMatched && otherCard.isChosen {
                            otherCards.append(otherCard)
                            if otherCards.count == numberOfCardMatchingMode - 1 {
                                var matchScore = Int(card.match(otherCards))
                                var description = ""
                                description = cardsContents(otherCards)
                                description = description + (card.contents) //description is now all the cards involved in a match
                                if matchScore != 0 {
                                    matchScore *= MATCH_BONUS
                                    score += matchScore
                                    card.isMatched = true
                                    markMatchedCards(otherCards)
                                } else {
                                    matchScore = -(MISMATCH_PENALTY * Int((pow(Double(numberOfCardMatchingMode - 1), 3))))
                                    score += matchScore //bigger mismatch penalty when mismatched more cards. If we got a 2 card game,pow(1, n) returns 1
                                    unchooseCards(otherCards)
                                }
                                matchDesctiption = matchScore > 0 ? ("Matched \(description) for \(matchScore) points") : ("\(description) is a mismatch! \(matchScore) penalty")
                                break
                            }
                        }
                    }
                    score -= COST_TO_CHOOSE * (numberOfCardMatchingMode - 1) // again, the cost is bigger when awards are bigger
                    card.isChosen = true
                }
            }
        }
    }

    func card(at index: Int) -> Card? {
        return (index < cards.count) ? cards[index] : nil
    }

    private(set) var score = 0
    var numberOfCardMatchingMode = 0
    var matchDesctiption = ""


    private var cards: [Card]

    func cardsContents(_ cards: [Card]) -> String {
        var contents = ""
        for card in cards {
            contents = contents + (card.contents)
        }
        return contents
    }

    func unchooseCards(_ cards: [Card]) {
        for card in cards {
            card.isChosen = false
        }
    }

    func markMatchedCards(_ cards: [Card]) {
        for card in cards {
            card.isMatched = true
        }
    }
}
