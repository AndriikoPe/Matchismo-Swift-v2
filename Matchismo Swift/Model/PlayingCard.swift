//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  PlayhingCard.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

class PlayingCard: Card {
  private var _suit: String?
  var suit: String {
    get {
      if let count = _suit?.count, count > 0 {
        // If _suit?.count succeeded, then _suit is not nil, so _suit! is ok
        return _suit!
      } else {
        return "?"
      }
    }
    set(suit) {
      if (PlayingCard.validSuits() as Array).contains(suit) {
        _suit = suit
      }
    }
  }
  
  private var _rank: Int?
  var rank: Int {
    get {
      return _rank ?? 0
    }
    set(rank) {
      if rank <= PlayingCard.maxRank() {
        _rank = rank
      }
    }
  }
  
  override var contents: String {
    get {
      let rankStrings = PlayingCard.rankStrings()
      return rankStrings[rank] + suit
    }
    set {}
  }
  
  class func validSuits() -> [String] {
    return ["♥", "♠", "♦", "♣"]
  }
  
  class func maxRank() -> Int {
    return self.rankStrings().count - 1
  }
  
  private class func rankStrings() -> [String] {
    return ["?","A","2","3","4","5","6","7","8","9","10","J","Q","K"]
  }
  
  // Returns 0 if no match, positive Int otherwise
  override func match(_ otherCards: [Card]?) -> Int {
    var score = 0
    if otherCards?.count == 1 {
      let otherCard = otherCards?.first as? PlayingCard
      if otherCard?.rank == rank {
        score = CardMatchingBounses.twoRanks
      } else if (otherCard?.suit == suit) {
        score = CardMatchingBounses.twoSuits
      }
    } else if otherCards?.count == 2 {
      let firstOtherCard = otherCards?.first as? PlayingCard, secondOtherCard = otherCards?.last as? PlayingCard
      var suitScore = 0, rankScore = 0
      if (suit == firstOtherCard?.suit) || (suit == secondOtherCard?.suit) {
        suitScore += CardMatchingBounses.twoSuitsInThreeCardMode
      }
      if (firstOtherCard?.suit == secondOtherCard?.suit) {
        suitScore = suitScore != 0 ? CardMatchingBounses.threeSuits : CardMatchingBounses.twoSuitsInThreeCardMode
      }
      
      if rank == firstOtherCard?.rank || rank == secondOtherCard?.rank {
        rankScore += CardMatchingBounses.twoRanksInThreeCardMode
      }
      if firstOtherCard?.rank == secondOtherCard?.rank {
        rankScore = rankScore != 0 ? CardMatchingBounses.threeRanks : CardMatchingBounses.twoRanksInThreeCardMode
      }
      // If no match, both are 0
      score = suitScore + rankScore
    }
    return score
  }
}

struct CardMatchingBounses {
  static let twoRanks = 8
  static let twoRanksInThreeCardMode = 6
  static let threeRanks = 18
  static let twoSuits = 2
  static let twoSuitsInThreeCardMode = 1
  static let threeSuits = 8
}
