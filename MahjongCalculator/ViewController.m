//
//  ViewController.m
//  MahjongCalculator
//
//  Created by fyj on 2017/8/28.
//  Copyright © 2017年 Ricky Lee. All rights reserved.
//

#import "ViewController.h"
#import "MahjongButton.h"
#import "MahjongImageView.h"
#import "define.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    memset(_viewCards, 0xFF, sizeof(_viewCards));
    memset(_judgeCards, 0xFF, sizeof(_judgeCards));
    
    int row = 0;
    int col = 0;
    for (; row < 3; row++) {
        for (col = 0; col < 9; col++) {
            MahjongButton *button = [[MahjongButton alloc] initWithFrame:CGRectMake(col*CARD_WIDTH, 32+row*CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT)];
            button.cardData = row * 10 + col + 1;
            button.tag = (row << 4) + col + 1;
            [button addTarget:self action:@selector(addCardAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    for (col = 0; col < 4; col++) {
        MahjongButton *button = [[MahjongButton alloc] initWithFrame:CGRectMake(col*CARD_WIDTH, 32+row*CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT)];
        button.cardData = row * 10 + col + 1;
        button.tag = (row << 4) + col + 1;
        [button addTarget:self action:@selector(addCardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    MahjongButton *button = [[MahjongButton alloc] initWithFrame:CGRectMake(col*CARD_WIDTH, 32+row*CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT)];
    [button addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSelectCards
{
    int col = 0;
    for (col = 0; col < CARDS_MAX_COUNT; col++) {
        [[self.view viewWithTag:0xFF+col] removeFromSuperview];
        [[self.view viewWithTag:0xFF+0xFF+col] removeFromSuperview];
    }
    
    [[Logic shared] sort:_viewCards];
    [[Logic shared] sort:_judgeCards];
    
    int row = 4;
    col = 0;
    for (col = 0; col < CARDS_MAX_COUNT; col++) {
        if (_viewCards[col] != 0xFF) {
            MahjongButton *button = [[MahjongButton alloc] initWithFrame:CGRectMake(col >= 9 ? (col-9)*CARD_WIDTH : col*CARD_WIDTH,
                                                                                    col >= 9 ? 64+(row+1)*CARD_HEIGHT : 64+row*CARD_HEIGHT,
                                                                                    CARD_WIDTH,
                                                                                    CARD_HEIGHT)];
            button.cardData = ([[Logic shared] cardColor:_viewCards[col]] >> 4) * 10 + [[Logic shared] cardValue:_viewCards[col]];
            button.tag = 0xFF+col;
            [button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    NSArray *tingCards = [[Logic shared] tingArray:_judgeCards];
    row = 7;
    col = 0;
    for (col = 0; col < tingCards.count; col++) {
        MahjongImageView *cardImageView = [[MahjongImageView alloc] initWithFrame:CGRectMake(col >= 9 ? (col-9)*CARD_WIDTH : col*CARD_WIDTH,
                                                                                             col >= 9 ? 64+(row+1)*CARD_HEIGHT : 64+row*CARD_HEIGHT,
                                                                                             CARD_WIDTH,
                                                                                             CARD_HEIGHT)];
        cardImageView.cardData = [[tingCards objectAtIndex:col] integerValue];
        cardImageView.tag = 0xFF+0xFF+col;
        [self.view addSubview:cardImageView];
    }
}

- (void)addCardAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    for (int i = 0; i < CARDS_MAX_COUNT; i++) {
        if (_viewCards[i] == 0xFF) {
            _viewCards[i] = button.tag;
            memcpy(_judgeCards, _viewCards, sizeof(_judgeCards));
            [self updateSelectCards];
            return;
        }
    }
}

- (void)clearAction:(id)sender
{
    memset(_viewCards, 0xFF, sizeof(_viewCards));
    memset(_judgeCards, 0xFF, sizeof(_judgeCards));
    [self updateSelectCards];
}

- (void)testAction:(id)sender
{
    for (int col = 0; col < CARDS_MAX_COUNT; col++) {
        UIButton *button = (UIButton*)[self.view viewWithTag:0xFF+col];
        [button setSelected:NO];
    }
    memcpy(_judgeCards, _viewCards, sizeof(_judgeCards));
    
    UIButton *button = (UIButton*)sender;
    [button setSelected:YES];
    
    _judgeCards[button.tag-0xFF] = 0xFF;
    [self updateSelectCards];
}

@end
















