//
//  RaceLampView.h
//  lottery
//
//  Created by qwater on 2018/5/11.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceLampView : UIView

@property(nonatomic, strong)UIImageView *raceLampBg;

@property(nonatomic, assign)int rotation;

- (void)bgPosition:(CGRect)frame;

- (void)raceLampImageNames:(NSString *)name1 name2:(NSString *)name2;
@end
