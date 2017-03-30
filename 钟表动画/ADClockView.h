//
//  ADClockView.h
//  钟表动画
//
//  Created by 王奥东 on 16/12/6.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADClockView : UIView

-(void)setHourHandImage:(CGImageRef)image;
-(void)setMinHandImage:(CGImageRef)image;
-(void)setSecHandImage:(CGImageRef)image;
-(void)setClockBackgroundImage:(CGImageRef)image;

-(void)start;
-(void)stop;
@end

