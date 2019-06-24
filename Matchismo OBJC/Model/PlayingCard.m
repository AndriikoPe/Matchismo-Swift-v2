//
//  PlayhingCard.m
//  Matchismo OBJC
//
//  Created by Пермяков Андрей on 6/21/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


//some constants that we can change if we come up with a better counting algorithm
static const int MATCHED_2_CARDS_RANKS = 8;
static const int MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE = 6;
static const int MATCHED_3_CARDS_RANKS = 18;
static const int MATCHED_2_CARDS_SUITS = 2;
static const int MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE = 1;
static const int MATCHED_3_CARDS_SUITS = 8;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = MATCHED_2_CARDS_RANKS;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = MATCHED_2_CARDS_SUITS;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *firstOtherCard = [otherCards firstObject];
        PlayingCard *secondOtherCard = [otherCards lastObject];
        int suitScore = 0;
        int rankScore = 0;
        if ([self.suit isEqualToString:firstOtherCard.suit] || [self.suit isEqualToString:secondOtherCard.suit]) {
            suitScore += MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE;
        }
        if ([firstOtherCard.suit isEqualToString:secondOtherCard.suit]) {
            suitScore = suitScore ? MATCHED_3_CARDS_SUITS : MATCHED_2_CARDS_SUITS_IN_3_CARDS_MODE;
        }
        
        if (self.rank == firstOtherCard.rank || self.rank == secondOtherCard.rank) {
            rankScore += MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE;
        }
        if (firstOtherCard.rank == secondOtherCard.rank) {
            rankScore = rankScore ? MATCHED_3_CARDS_RANKS : MATCHED_2_CARDS_RANKS_IN_3_CARDS_MODE;
        }
        score = suitScore + rankScore; // if no match, both are 0
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♥", @"♠", @"♦", @"♣"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
