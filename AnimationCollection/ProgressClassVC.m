//
//  ProgressClassVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/5.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "ProgressClassVC.h"
#import "POP.h"
#import "YXEasing.h"

#import "ProgressView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)  // 角度转弧度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))    // 弧度转角度

#define PROGREESS_WIDTH 240 //直径
#define PROGREESS_LINE_WIDTH 20 //弧线宽度

@interface ProgressClassVC ()

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) CAShapeLayer *aniLayer;
@property (nonatomic, strong) UIBezierPath *aniPath;
@property (nonatomic, strong) ProgressView *progressView;

@end

@implementation ProgressClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0 green:45/255.0 blue:66/255.0 alpha:1.f];
    
    _progressView = [[ProgressView alloc] initWithFrame:CGRectMake((kDeviceWidth-240)/2.0, 50, 240, 240)];
    
    [self.view addSubview:_progressView];
    
   
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressView.persent = 100;
    });
    
    [self loadViewAnimation];
}

//添加弹动动画
-(void)loadViewAnimation{
    //关键帧-缓动函数动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath              = @"transform.scale";
    keyFrameAnimation.duration             = 1.f;
    keyFrameAnimation.values               = [YXEasing calculateFrameFromValue:0.7 toValue:1.f func:BounceEaseOut frameCount:30];
    [_progressView.layer addAnimation:keyFrameAnimation forKey:nil];
}

@end
