//  Converted to Swift 5 by Swiftify v5.0.37171 - https://objectivec2swift.com/
//
//  CardGameViewController.swift
//  Matchismo
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {
  @IBOutlet private weak var scoreLabel: UILabel!
  @IBOutlet private weak var gameModeSegmentedControl: UISegmentedControl!
  @IBOutlet private weak var matchDescriptionLabel: UILabel!
  
  @IBOutlet private var cardButtons: [UIButton]!
  
  private lazy var game = CardMatchingGame(cardCount: cardButtons.count, using: createDeck())
  
  private func createDeck() -> Deck {
    return PlayingCardDeck()
  }
  
  private func updateView() {
    for button in cardButtons {
      guard let cardButtonIndex = cardButtons.firstIndex(of: button) else {
        return
      }
      if let card = game?.card(at: cardButtonIndex) {
        button.setTitle(title(for: card), for: .normal)
        button.setBackgroundImage(backgroundImage(for: card), for: .normal)
        button.isEnabled = !card.isMatched
        matchDescriptionLabel.text = game?.matchDesctiption
        scoreLabel.text = "Score: \(game?.score ?? 0)"
      }
    }
  }
  
  private func title(for card: Card) -> String? {
    return card.isChosen ? card.contents : ""
  }
  
  private func backgroundImage(for card: Card) -> UIImage? {
    return UIImage(named: card.isChosen ? "cardFront" : "cardBack")
  }
}

// IBActions
extension CardGameViewController {
  @IBAction private func newGame() {
    gameModeSegmentedControl.isEnabled = true
    game = CardMatchingGame(cardCount: cardButtons!.count, using: createDeck())
    updateView()
  }
  
  @IBAction private func touchCardButton(_ sender: UIButton) {
    guard let chosenButtonIndex = cardButtons.firstIndex(of: sender) else {
      return
    }
    gameModeSegmentedControl.isEnabled = false
    // If selectedSegmentIndex is 0, then false => returns 2, if it is 1, then true => returns 3
    game?.numberOfCardMatchingMode = gameModeSegmentedControl.selectedSegmentIndex != 0 ? 3 : 2
    game?.chooseCard(at: chosenButtonIndex)
    updateView()
  }
}
