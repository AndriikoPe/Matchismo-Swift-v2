//
//  CardMatchingGame.m
//  Matchismo OBJC
//
//  Created by Пермяков Андрей on 6/22/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

#import "CardMatchingGame.h"

@interface  CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen =  NO;
        } else {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    [otherCards addObject:otherCard];
                    if ([otherCards count] == self.numberOfCardMatchingMode - 1) {
                        int matchScore = [card match: otherCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            [self markMatchedCards:otherCards];
                        } else {
                            self.score -= MISMATCH_PENALTY * (pow(self.numberOfCardMatchingMode - 1, 3)); //bigger mismatch penalty when mismatched more cards. If we got a 2 card game,pow(1, n) returns 1
                            [self unchooseCards:otherCards];
                        }
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE * (self.numberOfCardMatchingMode - 1); // again, the cost is bigger when awards are bigger
            card.chosen = YES;
        }
    }
}

- (void)unchooseCards:(NSArray *)cards {
    for (Card *card in cards) {
        card.chosen = NO;
    }
}

- (void)markMatchedCards:(NSArray *)cards {
    for (Card *card in cards) {
        card.matched = YES;
    }
}

@end
