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
        
        int radius = 8;
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - radius * 2,
//                                                                0,
//                                                                radius * 2,
//                                                                radius * 2)];
//        view.backgroundColor = [UIColor redColor];
//        view.layer.cornerRadius = radius;
//        view.layer.masksToBounds = YES;
//        [self addSubview:view];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - radius * 2,
                                                           0,
                                                           radius * 2,
                                                           radius * 2)];
        _label.backgroundColor = [UIColor redColor];
        _label.layer.cornerRadius = radius;
        _label.layer.masksToBounds = YES;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _label.hidden = YES;
    }
    return self;
}

- (void)setCardData:(BYTE)cardData
{
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", cardData]] forState:UIControlStateNormal];
}

- (void)setTingCount:(int)tingCount
{
    if (tingCount > 0) {
        _label.hidden = NO;
        _label.text = [NSString stringWithFormat:@"%d", tingCount];
        return;
    }
    _label.hidden = YES;
}

@end
