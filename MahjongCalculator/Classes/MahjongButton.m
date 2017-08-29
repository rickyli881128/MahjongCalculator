//
//  MahjongButton.m
//  MahjongCalculator
//
//  Created by fyj on 2017/8/29.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import "MahjongButton.h"

@implementation MahjongButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"board.png"] forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    }
    return self;
}

- (void)setCardData:(BYTE)cardData
{
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", cardData]] forState:UIControlStateNormal];
}

@end
