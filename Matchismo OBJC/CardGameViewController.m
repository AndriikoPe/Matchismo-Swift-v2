//
//  ViewController.m
//  Matchismo OBJC
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/Deck.h"
#import "Model/PlayingCardDeck.h"
#import "Model/Card.h"
#import "Model/PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deck;
@property (nonatomic) Card *card;
@end

@implementation CardGameViewController

+ (NSUInteger)maxFlipCount {
    return 104; //52 * 2
}

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (Card *)card {
    if (!_card) _card = [[PlayingCard alloc] init];
    return _card;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
                          forState:UIControlStateNormal];
        NSString *title;
        if (self.flipCount < [CardGameViewController maxFlipCount]) {
            self.card = [self.deck drawRandomCard];
            title = [self.card contents];
        } else {
            title = @"0 cards left";
        }
        sender.titleLabel.textAlignment = NSTextAlignmentCenter;
        [sender setTitle:title forState:UIControlStateNormal];
    }
    self.flipCount++;
}
@end
