//
//  RaceLampView.m
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "RaceLampView.h"

@implementation RaceLampView



- (void)raceLampImageNames:(NSString *)name1 name2:(NSString *)name2
{
    [self addSubview:self.raceLampBg];
    UIImage *image1 = [UIImage imageNamed:name1];
    UIImage *image2 = [UIImage imageNamed:name2];
    NSArray *animationImages = @[image1, image2];
    self.raceLampBg.animationDuration = 0.5;//设置动画时间
    self.raceLampBg.animationRepeatCount = 0;//设置动画次数 0 表示无限
    self.raceLampBg.animationImages = animationImages;
    [self.raceLampBg startAnimating];//开始播放动画
}

- (void)setRotation:(int)rotation
{
//    _rotation = rotation;
    self.transform = CGAffineTransformMakeRotation(rotation * M_PI / 180.0);
}


- (int)rotation
{
    CGAffineTransform _trans = self.transform;
    CGFloat rotate = acosf(_trans.a);
    if(_trans.b < 0)
    {
        rotate = M_PI * 2 - rotate;
    }
    // 将弧度转换为角度
    float degree = rotate * 180.0 / M_PI + 0.001;
    NSLog(@"degree = %i", (int)degree);
    return (int)degree;
}

- (void)bgPosition:(CGRect)frame
{
    self.raceLampBg.frame = frame;
}

- (UIImageView *)raceLampBg
{
    if(!_raceLampBg)
    {
        _raceLampBg = [[UIImageView alloc] init];
        [_raceLampBg setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _raceLampBg;
}
@end
