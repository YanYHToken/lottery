//
//  LotteryViewManager.m
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "LotteryViewManager.h"

int randomAngel(int openid)
{
    int open1[2] = {0, 180};
    int open2[2] = {90, 270};
    int index = rand() % 2; //调用随机函数
    int result = 0;
    if(openid == 1)
    {
        result = open1[index];
    }
    else
    {
        result = open2[index];
    }
    printf("randomAngel = %i\n", result);
    return result;
}
int outRunAngles[13]  = {0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360};
int inRunAngles[4]  = {0, 90, 180, 270};
int error[12] = {3,9,6,1,5,11,8,2,10,4,7,0};
static int const out_time = 30;
static int const in_time = 60;
@interface LotteryViewManager()
{
    dispatch_source_t stopRunTimeOutId;
    dispatch_source_t inSideIntevalId;
    dispatch_source_t outSideIntevalId;
}
@end

@implementation LotteryViewManager


- (void)clearTimer:(dispatch_source_t)timer
{
    if(timer)
    {
        dispatch_source_cancel(timer);
    }
    timer = NULL;
}
//启动倒计时
- (dispatch_source_t)setTimeout:(SEL)selector
         timeOut:(int)timeOut
{
    __block dispatch_source_t timer = [self createTimer:timeOut];
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
            //这句话必须写否则会出问题
            if(timer)
            {
                dispatch_source_cancel(timer);
            }
            timer = NULL;
        });
    });
    return timer;
}

//启动倒计时
- (dispatch_source_t)setTimeInteval:(SEL)selector
                        timeInteval:(int)timeInteval
{
    dispatch_source_t timer = [self createTimer:timeInteval];
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
        });
    });
    return timer;
}


- (dispatch_source_t)createTimer:(int)interval
{
    dispatch_source_t timer;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    uint64_t milsec = NSEC_PER_SEC * interval * 0.001;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, milsec, 0);
    //启动源
    dispatch_resume(timer);
    NSLog(@"create %p",timer);

    return timer;
}

- (void)reset
{
    self.inSideOpenID = -1;
    self.outSideOpenID =-1;
    self.arrOutId = -1;
    self.index_in = 0;
    self.index_out = 0;
    self.OutBo = NO;
    self.runing = NO;
    self.delayInSide = in_time;
    self.delayOutSide = out_time;
    [self clearTimer:inSideIntevalId];
    [self clearTimer:outSideIntevalId];
    [self clearTimer:stopRunTimeOutId];
}

- (void)startRun
{
    if(self.runing)
    {
        return;
    }
    [self reset];
    
    inSideIntevalId = [self setTimeInteval:@selector(runInSideFunction) timeInteval:self.delayInSide];
    outSideIntevalId = [self setTimeInteval:@selector(runOutSideFunction) timeInteval:self.delayOutSide];
    self.runing = true;
}

- (void)stopRun
{
    NSLog(@"stopRun");
    [self reset];
}

- (void)runInSideFunction
{
    if (self.inSideOpenID != -1)
    {
        if (self.delayInSide <= 660)
        {
            self.delayInSide += 50;
        }
        [self clearTimer:inSideIntevalId];
        inSideIntevalId = [self setTimeInteval:@selector(runInSideFunction) timeInteval:self.delayInSide];
        if (self.delayInSide >= 660)
        {
            if (self.inSideOpenID == 1 || self.inSideOpenID == 2)
            {
                if(self.turntableView.smallRaceLampView.rotation == self.random_in)
                {
                    [self clearTimer:inSideIntevalId];
                }
            }
        }
    }
    self.index_in++;
    self.turntableView.smallRaceLampView.rotation = inRunAngles[self.index_in%4];
}

- (void)runOutSideFunction
{
    if (self.outSideOpenID != -1)
    {
        if (self.index_out % 12 == self.arrOutId)
        {
            self.OutBo = YES;
        }
        if (self.OutBo)
        {
            if (self.delayOutSide <= 530)
            {
                self.delayOutSide += 50;
            }
            [self clearTimer:outSideIntevalId];
            outSideIntevalId = [self setTimeInteval:@selector(runOutSideFunction) timeInteval:self.delayOutSide];
            if (self.delayOutSide >= 530)
            {
                if (((self.index_out + 1) % 12) == self.outSideOpenID )
                {
                    [self clearTimer:outSideIntevalId];
                    stopRunTimeOutId = [self setTimeout:@selector(stopRun) timeOut:5000];
                }
            }
        }
    }
    self.index_out++;
    self.turntableView.bigRaceLampView.rotation = outRunAngles[self.index_out%12];
}

- (void)delaySetIndex:(int)inSideId outSideId:(int)outSideId
{
    self.inSideOpenID = inSideId;
    self.outSideOpenID = outSideId;
    if (self.outSideOpenID == 8 || self.outSideOpenID == 7)
    {
        self.inSideOpenID = -1;
    }
    self.outSideOpenID = self.outSideOpenID - 3;
    self.outSideOpenID = error[self.outSideOpenID];
    self.arrOutId = self.outSideOpenID;
   
    self.random_in = randomAngel(inSideId);;
}



@end

