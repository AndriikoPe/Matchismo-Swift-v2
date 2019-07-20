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
    return getScore(forRank: rank, comparingToCards: otherCards ?? []) +
      getScore(forSuit: suit, comparingToCards: otherCards ?? [])
  }
  
  private func getScore(forSuit suit: String, comparingToCards cards: [Card]) -> Int {
    var score = 0
    switch cards.count {
    case 1:
      if (cards.first as? PlayingCard)?.suit == suit {
        score = CardMatchingBounses.twoSuits
      }
    case 2:
      let firstOtherCard = cards.first as? PlayingCard, secondOtherCard = cards.last as? PlayingCard
      if (suit == firstOtherCard?.suit) || (suit == secondOtherCard?.suit) {
        score += CardMatchingBounses.twoSuitsInThreeCardMode
      }
      if (firstOtherCard?.suit == secondOtherCard?.suit) {
        score = score != 0 ? CardMatchingBounses.threeSuits :
          CardMatchingBounses.twoSuitsInThreeCardMode
      }
    default:
      break
    }
    return score
  }
  
  private func getScore(forRank rank: Int, comparingToCards cards: [Card]) -> Int {
    var score = 0
    switch cards.count {
    case 1:
      if (cards.first as? PlayingCard)?.rank == rank {
        score = CardMatchingBounses.twoRanks
      }
    case 2:
      let firstOtherCard = cards.first as? PlayingCard, secondOtherCard = cards.last as? PlayingCard
      if rank == firstOtherCard?.rank || rank == secondOtherCard?.rank {
        score += CardMatchingBounses.twoRanksInThreeCardMode
      }
      if firstOtherCard?.rank == secondOtherCard?.rank {
        score = score != 0 ? CardMatchingBounses.threeRanks :
          CardMatchingBounses.twoRanksInThreeCardMode
      }
    default:
      break
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
