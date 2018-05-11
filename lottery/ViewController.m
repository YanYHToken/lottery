//
//  ViewController.m
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ViewController.h"
#import "LotteryView.h"

@interface ViewController ()
@property(nonatomic, strong)LotteryView *lotteryView;
@property(nonatomic, strong)LotteryViewManager *lotteryManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    290 × 297
    self.lotteryView = [[LotteryView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-290)/2, 100, 290, 297)];
    [self.view addSubview:self.lotteryView];
    self.lotteryManager = [[LotteryViewManager alloc] init];
    self.lotteryManager.turntableView = self.lotteryView;
    [self startRun];
}

- (void)startRun
{
    [self.lotteryManager startRun];
    [self performSelector:@selector(openLottery) withObject:nil afterDelay:5];
}

- (void)openLottery
{
    [self.lotteryManager delaySetIndex:2 outSideId:5];
    [self performSelector:@selector(startRun) withObject:nil afterDelay:7];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
