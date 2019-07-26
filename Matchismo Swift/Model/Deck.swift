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
  private var cards: [Card] = []
  
  func add(_ card: Card, atTop: Bool = false) {
    if atTop {
      cards.insert(card, at: 0)
    } else {
      cards.append(card)
    }
  }
  
  func drawRandomCard() -> Card? {
    var randomCard: Card? = nil
    
    if cards.count > 0 {
      let index = Int(arc4random()) % cards.count
      randomCard = cards[index]
      cards.remove(at: Int(index))
    }
    return randomCard
  }
}
