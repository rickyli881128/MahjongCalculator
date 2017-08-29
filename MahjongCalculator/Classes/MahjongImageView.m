//
//  MahjongImageView.m
//  MahjongCalculator
//
//  Created by fyj on 2017/8/29.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import "MahjongImageView.h"
#import "define.h"

@implementation MahjongImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"board.png"];
    }
    return self;
}

- (void)setCardData:(BYTE)cardData
{
    UIImageView *cardimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", ([[Logic shared] cardColor:cardData] >> 4) * 10 + [[Logic shared] cardValue:cardData]]]];
    [cardimg setFrame:CGRectMake((CARD_WIDTH - cardimg.bounds.size.width) / 2,
                                 (CARD_HEIGHT - cardimg.bounds.size.height) / 2 - 5,
                                 cardimg.bounds.size.width,
                                 cardimg.bounds.size.height)];
    [self addSubview:cardimg];
}

@end
