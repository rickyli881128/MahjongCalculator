//
//  Logic.h
//  MahjongCalculator
//
//  Created by fyj on 2017/8/28.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CARDS_MAX_COUNT 14
#define MAX_CARD_VALUE (0x44+1+2)

typedef unsigned char BYTE;

@interface Logic : NSObject

+ (Logic*)shared;

- (void)sort:(BYTE[CARDS_MAX_COUNT])cards;
- (NSArray*)tingArray:(BYTE[CARDS_MAX_COUNT])cards;

- (BYTE)cardColor:(BYTE)card;
- (BYTE)cardValue:(BYTE)card;

@end
