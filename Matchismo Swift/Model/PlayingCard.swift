//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  PlayhingCard.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//


//some constants that we can change if we come up with a better counting algorithm

let MATCHED_2_CARDS_RANKS = 8
let MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE = 6
let MATCHED_3_CARDS_RANKS = 18
let MATCHED_2_CARDS_SUITS = 2
let MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE = 1
let MATCHED_3_CARDS_SUITS = 8

class PlayingCard: Card {
    private var _suit = ""
    var suit: String {
        get {
            return _suit != "" ? _suit : "?"
        }
        set(suit) {
            if (PlayingCard.validSuits() as Array).contains(suit) {
                _suit = suit
            }
        }
    }

    private var _rank = 0
    var rank: Int {
        get {
            return _rank
        }
        set(rank) {
            if rank <= PlayingCard.maxRank() {
                _rank = rank
            }
        }
    }

    static func validSuits() -> [String] {
        return ["♥", "♠", "♦", "♣"]
    }

    class func maxRank() -> Int {
        return self.rankStrings().count - 1
    }

    override func match(_ otherCards: [Card]?) -> Int {
        var score = 0
        if otherCards?.count == 1 {
            let otherCard = otherCards?.first as? PlayingCard
            if otherCard?.rank == rank {
                score = MATCHED_2_CARDS_RANKS
            } else if (otherCard?.suit == suit) {
                score = MATCHED_2_CARDS_SUITS
            }
        } else if otherCards?.count == 2 {
            let firstOtherCard = otherCards?.first as? PlayingCard
            let secondOtherCard = otherCards?.last as? PlayingCard
            var suitScore = 0
            var rankScore = 0
            if (suit == firstOtherCard?.suit) || (suit == secondOtherCard?.suit) {
                suitScore += MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE
            }
            if (firstOtherCard?.suit == secondOtherCard?.suit) {
                suitScore = suitScore != 0 ? MATCHED_3_CARDS_SUITS : MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE
            }

            if rank == firstOtherCard?.rank || rank == secondOtherCard?.rank {
                rankScore += MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE
            }
            if firstOtherCard?.rank == secondOtherCard?.rank {
                rankScore = rankScore != 0 ? MATCHED_3_CARDS_RANKS : MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE
            }
            score = suitScore + rankScore // if no match, both are 0
        }
        return score
    }

    override var contents: String {
        get {
            let rankStrings = PlayingCard.rankStrings()
            return rankStrings[rank] + suit
        }
        set {}
    }

    class func rankStrings() -> [String] {
        return [
        "?",
        "A",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "J",
        "Q",
        "K"
        ]
    }
}
