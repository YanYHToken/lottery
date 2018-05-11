//
//  LotteryViewManager.h
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryView.h"

@interface LotteryViewManager : NSObject
@property(nonatomic, strong)LotteryView *turntableView;
@property(nonatomic, assign)int inSideOpenID;
@property(nonatomic, assign)int outSideOpenID;
@property(nonatomic, assign)int arrOutId;
@property(nonatomic, assign)int index_out;
@property(nonatomic, assign)int index_in;
@property(nonatomic, assign)BOOL OutBo;
@property(nonatomic, assign)BOOL runing;
@property(nonatomic, assign)int delayInSide;
@property(nonatomic, assign)int delayOutSide;
- (void)stopRun;

- (void)startRun;

- (void)delaySetIndex:(int)inSideId outSideId:(int)outSideId;
@end
