//
//  LotteryView.m
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "LotteryView.h"

@implementation LotteryView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self layoutView];
    }
    return self;
}

- (void)layoutView
{
   
    self.bigRaceLampView = [[RaceLampView alloc] initWithFrame:CGRectMake(0, 0, 290, 310)];
    [self.bigRaceLampView raceLampImageNames:@"run_A_01" name2:@"run_A_02"];
    [self.bigRaceLampView bgPosition:CGRectMake(145, 0, 80, 69)];
    
  
    self.smallRaceLampView = [[RaceLampView alloc] initWithFrame:CGRectMake((290-95*2)/2, (297-95*2)/2, 95*2, 95*2)];
    [self.smallRaceLampView bgPosition:CGRectMake(95, 0, 95, 95)];
    [self.smallRaceLampView raceLampImageNames:@"run_B_01" name2:@"run_B_02"];
    
//    self.smallRaceLampView.layer.borderColor = [UIColor redColor].CGColor;
//    self.smallRaceLampView.layer.borderWidth = 1;
//    self.bigRaceLampView.layer.borderColor = [UIColor redColor].CGColor;
//    self.bigRaceLampView.layer.borderWidth = 1;
    
    
    [self addSubview:self.smallRaceLampView];
    [self addSubview:self.bigRaceLampView];
    
    self.lotteryBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"panmianico"]];
    [self addSubview:self.lotteryBg];
    
}


@end

