//
//  LotteryView.h
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceLampView.h"


@interface LotteryView : UIView
@property(nonatomic, strong)UIImageView *lotteryBg;
@property(nonatomic, strong)RaceLampView *bigRaceLampView;
@property(nonatomic, strong)RaceLampView *smallRaceLampView;

@end
