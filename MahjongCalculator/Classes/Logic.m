//
//  Logic.m
//  MahjongCalculator
//
//  Created by fyj on 2017/8/28.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import "Logic.h"

static Logic *s_logic = nil;

@implementation Logic

+ (Logic*)shared
{
    if (!s_logic) {
        s_logic = [[Logic alloc] init];
    }
    return s_logic;
}

- (int)cardsCount:(BYTE[CARDS_MAX_COUNT])cards
{
    for (int i = 0; i < CARDS_MAX_COUNT; i++) {
        if (cards[i] == 0xFF) {
            return i;
        }
    }
    return CARDS_MAX_COUNT;
}

- (void)sort:(BYTE[CARDS_MAX_COUNT])cards startIndex:(int)startIndex endIndex:(int)endIndex
{
    if (startIndex < endIndex)
    {
        int i = startIndex, j = endIndex, x = cards[startIndex];
        while (i < j)
        {
            while(i < j && cards[j] >= x)
                j--;
            if(i < j)
                cards[i++] = cards[j];
            while(i < j && cards[i]< x)
                i++;
            if(i < j)
                cards[j--] = cards[i];
        }
        cards[i] = x;
        
        [self sort:cards startIndex:startIndex endIndex:i-1];
        [self sort:cards startIndex:i+1 endIndex:endIndex];
    }
}

- (void)sort:(BYTE[CARDS_MAX_COUNT])cards
{
    [self sort:cards startIndex:0 endIndex:CARDS_MAX_COUNT-1];
}

- (BOOL)judgeHu:(BYTE[CARDS_MAX_COUNT])cards
{
    if (([self cardsCount:cards]-2) % 3 != 0) {
        return NO;
    }
    
    int indexCardCount[MAX_CARD_VALUE] = {0};
    for (int i = 0; i < CARDS_MAX_COUNT; i++) {
        indexCardCount[cards[i]]++;
    }
    
    for (int i = 0; i < MAX_CARD_VALUE; i++) {
        if (indexCardCount[i] >= 2) {
            int _indexCardCount[MAX_CARD_VALUE];
            memcpy(_indexCardCount, indexCardCount, sizeof(_indexCardCount));
            _indexCardCount[i] -= 2;
            if ([self testHu:_indexCardCount]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL)testHu:(int[MAX_CARD_VALUE])indexCardCount
{
    for (int i = 0; i < MAX_CARD_VALUE; i++) {
        if (indexCardCount[i] >= 3) {
            int _indexCardCount[MAX_CARD_VALUE];
            memcpy(_indexCardCount, indexCardCount, sizeof(_indexCardCount));
            _indexCardCount[i] -= 3;
            if ([self testHu:_indexCardCount]) {
                return YES;
            }
        }
        if (indexCardCount[i] > 0 && indexCardCount[i+1] > 0 && indexCardCount[i+2] > 0) {
            int _indexCardCount[MAX_CARD_VALUE];
            memcpy(_indexCardCount, indexCardCount, sizeof(_indexCardCount));
            _indexCardCount[i]--;
            _indexCardCount[i+1]--;
            _indexCardCount[i+2]--;
            if ([self testHu:_indexCardCount]) {
                return YES;
            }
        }
    }
    for (int i = 0; i < MAX_CARD_VALUE; i++) {
        if (indexCardCount[i] > 0) {
            return NO;
        }
    }
    return YES;
}

- (NSArray*)tingArray:(BYTE[CARDS_MAX_COUNT])cards
{
    NSMutableArray *ret = [NSMutableArray array];
    
    const int testCardsCount = 31;
    BYTE testCards[testCardsCount] = {
        0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,
        0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,
        0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,
        0x31,0x32,0x33,0x34
    };
    
    for (int i = 0; i < testCardsCount; i++) {
        BYTE _cards[CARDS_MAX_COUNT];
        memcpy(_cards, cards, sizeof(_cards));
        BYTE testCard = testCards[i];
        _cards[[self cardsCount:_cards]] = testCard;
        if ([self judgeHu:_cards]) {
            [ret addObject:[NSNumber numberWithInteger:testCard]];
        }
    }
    return ret;
}

- (BYTE)cardColor:(BYTE)card
{
    return card & 0xF0;
}

- (BYTE)cardValue:(BYTE)card
{
    return card & 0x0F;
}

@end






































