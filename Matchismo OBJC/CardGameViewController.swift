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
    @IBOutlet private var cardButtons: [UIButton]!

    @IBOutlet private weak var gameModeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var matchDescriptionLabel: UILabel!

    private lazy var game: CardMatchingGame? = CardMatchingGame(cardCount: UInt(cardButtons!.count), using: createDeck())

    func createDeck() -> Deck {
        return PlayingCardDeck()
    }

    @IBAction func newGame() {
        gameModeSegmentedControl.isEnabled = true
        game = CardMatchingGame(cardCount: UInt(cardButtons!.count), using: createDeck())
        updateView()
    }

    @IBAction func touchCardButton(_ sender: UIButton) {
        let chosenButtonIndex = (cardButtons as NSArray).index(of: sender)
        gameModeSegmentedControl.isEnabled = false
        game?.numberOfCardMatchingMode = gameModeSegmentedControl.selectedSegmentIndex != 0 ? 3 : 2
        // if selectedSegmentIndex is 0, then false => returns 2, if it is 1, then true => returns 3
        game?.chooseCard(at: UInt(chosenButtonIndex))
        updateView()
    }

    func updateView() {
        for button in cardButtons {
            let cardButtonIndex = (cardButtons as NSArray).index(of: button)
            if let card = game?.card(at: UInt(cardButtonIndex)) {
                button.setTitle(title(for: card), for: .normal)
                button.setBackgroundImage(backgroundImage(for: card), for: .normal)
                button.isEnabled = !card.isMatched
                matchDescriptionLabel.text = game?.matchDesctiption
                scoreLabel.text = String(format: "Score: %ld", Int(game?.score ?? 0))
            }
        }
    }

    func title(for card: Card) -> String? {
        return card.isChosen ? card.contents : ""
    }

    func backgroundImage(for card: Card) -> UIImage? {
        return UIImage(named: card.isChosen ? "cardFront" : "cardBack")
    }
}
