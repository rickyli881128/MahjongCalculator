//
//  ViewController.h
//  MahjongCalculator
//
//  Created by fyj on 2017/8/28.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Logic.h"

@interface ViewController : UIViewController
{
    BYTE _viewCards[CARDS_MAX_COUNT];
    BYTE _judgeCards[CARDS_MAX_COUNT];
}


@end

