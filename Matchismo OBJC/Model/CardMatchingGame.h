//
//  CardMatchingGame.h
//  Matchismo OBJC
//
//  Created by Пермяков Андрей on 6/22/19.
//  Copyright © 2019 Пермяков Андрей. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject


//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger numberOfCardMatchingMode;

@end

NS_ASSUME_NONNULL_END
