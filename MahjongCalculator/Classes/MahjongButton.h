//
//  MahjongButton.h
//  MahjongCalculator
//
//  Created by fyj on 2017/8/29.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Logic.h"

@interface MahjongButton : UIButton
{
    UILabel *_label;
}

@property(nonatomic) BYTE cardData;
@property(nonatomic) int tingCount;

@end
