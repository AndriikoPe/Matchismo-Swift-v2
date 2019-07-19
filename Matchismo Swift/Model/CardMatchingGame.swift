//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  CardMatchingGame.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/22/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

import Foundation

class CardMatchingGame: NSObject {
  private(set) var score = 0
  var numberOfCardMatchingMode = 0
  private(set) var matchDesctiption = ""
  private var cards: [Card]
  
  // Designated initializer
  init?(cardCount count: Int, using deck: Deck) {
    cards = []
    for _ in 0..<count {
      let card = deck.drawRandomCard()
      guard card != nil else {
        return nil
      }
      // Use non-optional `card` further in the code
      cards.append(card!)
    }
  }
  
  func chooseCard(at index: Int) {
    guard let card = self.card(at: index), !card.isMatched else { return }
    matchDesctiption = ""
    if card.isChosen {
      card.isChosen = false
      return
    }
    var otherCards: [Card] = []
    for otherCard in cards {
      if !otherCard.isMatched && otherCard.isChosen {
        otherCards.append(otherCard)
        // We got an arr otherCards + current card involved in a match
        if (otherCards.count + 1) == numberOfCardMatchingMode {
          var matchScore = card.match(otherCards)
          modifyScoreInformation(&matchScore, withCards: otherCards + [card])
          break
        }
      }
    }
    score -= ScoreMultipliers.costToChoose * (numberOfCardMatchingMode - 1)
    card.isChosen = true
  }
  
  private func modifyScoreInformation(_ matchScore: inout Int, withCards cards: [Card]) {
    let cardsDescription = cardsContents(cards)
    if matchScore != 0 {
      matchScore *= ScoreMultipliers.matchBonus
      score += matchScore
      markMatchedCards(cards)
      matchDesctiption = "Matched \(cardsDescription) for \(matchScore) points"
    } else {
      matchScore = -(ScoreMultipliers.mismatchPenalty *
        Int((pow(Double(numberOfCardMatchingMode), 3))))
      score += matchScore
      unchooseCards(cards)
      matchDesctiption = "\(cardsDescription) is a mismatch! \(matchScore) penalty"
    }
  }
  
  func card(at index: Int) -> Card? {
    return (index < cards.count) ? cards[index] : nil
  }
  
  private func cardsContents(_ cards: [Card]) -> String {
    var contents = ""
    for card in cards {
      contents += (card.contents)
    }
    return contents
  }
  
  private func unchooseCards(_ cards: [Card]) {
    for card in cards {
      card.isChosen = false
    }
  }
  
  private func markMatchedCards(_ cards: [Card]) {
    for card in cards {
      card.isMatched = true
    }
  }
}

struct ScoreMultipliers {
  static let mismatchPenalty = 2
  static let matchBonus = 4
  static let costToChoose = 1
}
