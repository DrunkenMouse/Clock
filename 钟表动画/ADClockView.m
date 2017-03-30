//
//  ADClockView.m
//  钟表动画
//
//  Created by 王奥东 on 16/12/6.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADClockView.h"

#define HOURS_HAND_LENGTH 0.65
#define MIN_HAND_LENGTH 0.75
#define SEC_HAND_LENGTH 0.8

#define HOURS_HAND_WIDTH 10
#define MIN_HAND_WIDTH 8
#define SEC_HAND_WIDTH 4

@implementation ADClockView {
    
    CALayer *_containerLayer;//背景,时钟盘
    CALayer *_hourHand;
    CALayer *_minHand;
    CALayer *_secHand;
    NSTimer *_timer;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _containerLayer = [CALayer layer];
        _hourHand = [CALayer layer];
        _minHand = [CALayer layer];
        _secHand = [CALayer layer];
        
        [self setClockBackgroundImage:NULL];
        [self setHourHandImage:NULL];
        [self setMinHandImage:NULL];
        [self setSecHandImage:NULL];
        
        [_containerLayer addSublayer:_hourHand];
        [_containerLayer addSublayer:_minHand];
        [_containerLayer addSublayer:_secHand];
        [self.layer addSublayer:_containerLayer];
    }
    return self;
}

-(void)start {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
}

-(void)stop {
    
    [_timer invalidate];
    _timer = nil;
}

//外观定制
-(void)setHourHandImage:(CGImageRef)image {
    
    if (image == NULL) {
        _hourHand.backgroundColor = [UIColor blackColor].CGColor;
        _hourHand.cornerRadius = 3;
    }else  {
        _hourHand.backgroundColor = [UIColor clearColor].CGColor;
        _hourHand.cornerRadius = 0.0;
    }
    _hourHand.contents = (__bridge id)(image);
}

-(void)setMinHandImage:(CGImageRef)image {
    
    if (image == NULL) {
        _minHand.backgroundColor = [UIColor grayColor].CGColor;
    }else {
        _minHand.backgroundColor = [UIColor clearColor].CGColor;
    }
    _minHand.contents = (__bridge id)(image);
}

-(void)setSecHandImage:(CGImageRef)image {
    
    if (image == NULL) {
        
        _secHand.backgroundColor = [UIColor whiteColor].CGColor;
        _secHand.borderWidth = 1.0;
        _secHand.borderColor = [UIColor grayColor].CGColor;
    }else {
        
        _secHand.backgroundColor = [UIColor clearColor].CGColor;
        _secHand.borderWidth = 0.0;
        _secHand.borderColor = [UIColor clearColor].CGColor;
    }
    _secHand.contents = (__bridge id)(image);
}



-(void)setClockBackgroundImage:(CGImageRef)image {
    
    if (image == NULL) {
        
        _containerLayer.borderColor = [UIColor blackColor].CGColor;
        _containerLayer.borderWidth = 1.0;
        _containerLayer.cornerRadius = 5.0;
    }else {
        
        _containerLayer.borderColor = [UIColor clearColor].CGColor;
        _containerLayer.borderWidth = 0.0;
        _containerLayer.cornerRadius = 0.0;
    }
    _containerLayer.contents = (__bridge id)(image);
}


float Degrees2Radians(float degress) {return degress * M_PI / 180;}

-(void)updateClock:(NSTimer *)theTimer {
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    NSInteger seconds = [dateComponents second];
    NSInteger minutes = [dateComponents minute];
    NSInteger hours = [dateComponents hour];
    if (hours > 12) {
        hours -= 12;//PM
    }
    
    //角度
    CGFloat secAngle = Degrees2Radians(seconds/60.0 * 360);
    CGFloat minAngle = Degrees2Radians(minutes/60.0 * 360);
    CGFloat hourAngle = Degrees2Radians(hours/12.0*360) + minAngle/12.0;
    
    //角度作用于layer,需要按Z轴旋转180°才能正确显示
    _secHand.transform = CATransform3DMakeRotation(secAngle + M_PI, 0, 0, 1);
    _minHand.transform = CATransform3DMakeRotation(minAngle + M_PI, 0, 0, 1);
    _hourHand.transform = CATransform3DMakeRotation(hourAngle + M_PI, 0, 0, 1);
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    _containerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    float length = MIN(self.frame.size.width, self.frame.size.height) / 2;
    CGPoint c = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //显示的位置为自身中心
    _hourHand.position = _minHand.position = _secHand.position = c;
    
    
    CGFloat width,height;
    //没有图片，则宽高使用默认值
    if (_hourHand.contents == NULL) {
        width = HOURS_HAND_WIDTH;
        height = length * HOURS_HAND_LENGTH;
    } else {
        width = CGImageGetWidth((CGImageRef)_hourHand.contents);
        height = CGImageGetHeight((CGImageRef)_hourHand.contents);
    }
    _hourHand.bounds = CGRectMake(0, 0, width, height);
 
    if (_minHand.contents == NULL) {
        width = MIN_HAND_WIDTH;
        height = length * MIN_HAND_LENGTH;
    }else {
        width = CGImageGetWidth((CGImageRef)_minHand.contents);
        height = CGImageGetHeight((CGImageRef)_minHand.contents);
    }
    _minHand.bounds = CGRectMake(0, 0, width, height);
    
    if (_secHand.contents == NULL) {
        width = SEC_HAND_WIDTH;
        height = length * SEC_HAND_LENGTH;
    }else {
        width = CGImageGetWidth((CGImageRef)_secHand.contents);
        height = CGImageGetHeight((CGImageRef)_secHand.contents);
    }
    _secHand.bounds = CGRectMake(0, 0, width, height);
    
    //卯点
    _hourHand.anchorPoint = CGPointMake(0.5, 0);
    _minHand.anchorPoint = CGPointMake(0.5, 0);
    _secHand.anchorPoint = CGPointMake(0.5, 0);
    
    _containerLayer.anchorPoint = CGPointMake(0.5, 0.5);
   
}


@end
