//
//  ViewController.m
//  钟表动画
//
//  Created by 王奥东 on 16/12/6.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ADClockView.h"

@interface ViewController ()

@end

@implementation ViewController {
    ADClockView * _clockView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //本案例太简单了，以前就写过类似的，只是没有写完整。
    //所以没啥可说的，看下代码就知道什么是什么了。
    
    _clockView = [[ADClockView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    
    [_clockView setClockBackgroundImage:[UIImage imageNamed:@"4.png"].CGImage];
    [_clockView setHourHandImage:[UIImage imageNamed:@"1.png"].CGImage];
    [_clockView setMinHandImage:[UIImage imageNamed:@"2.png"].CGImage];
    [_clockView setSecHandImage:[UIImage imageNamed:@"3.png"].CGImage];
    
    _clockView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_clockView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_clockView start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
