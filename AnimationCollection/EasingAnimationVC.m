//
//  EasingAnimationVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/28.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "EasingAnimationVC.h"
#import "YXEasing.h"

//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface EasingAnimationVC ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIView *lockView;

@property (nonatomic, strong) CALayer *secondLayer;

@end

@implementation EasingAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(20, 20 , 100, 100)];
    showView.layer.cornerRadius  = 50;
    showView.layer.masksToBounds = YES;
    showView.backgroundColor     = [UIColor redColor];
    [self.view addSubview:showView];
    
    
    //关键帧-缓动函数动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath              = @"position";
    keyFrameAnimation.duration             = 3.f;
    keyFrameAnimation.values               = [YXEasing calculateFrameFromPoint:showView.center toPoint:CGPointMake(250, 70) func:BounceEaseInOut frameCount:(30 * 3)];
    showView.center = CGPointMake(250, 70);
    [showView.layer addAnimation:keyFrameAnimation forKey:nil];
    
    
    //缓动函数-时钟
    _lockView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _lockView.center              = CGPointMake(self.view.center.x,
                                               self.view.center.y);
    _lockView.layer.borderColor   = [UIColor redColor].CGColor;
    _lockView.layer.borderWidth   = 1.f;
    _lockView.layer.cornerRadius  = 100;
    _lockView.layer.masksToBounds = YES;
    [self.view addSubview:_lockView];
    
    //秒针
    _secondLayer = [CALayer layer];
    _secondLayer.anchorPoint = CGPointMake(0, 0);
    _secondLayer.frame = CGRectMake(100, 100, 1, 100);
    
    _secondLayer.backgroundColor = [UIColor blackColor].CGColor;
    [_lockView.layer addSublayer:_secondLayer];
    
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(letSecondGo) userInfo:nil repeats:YES];
}

-(void)letSecondGo
{
    static int i = 1;
    
    CGFloat oldValue = DEGREES_TO_RADIANS((360/60.f) * i++);
    CGFloat newValue = DEGREES_TO_RADIANS((360/60.f) * i);
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath = @"transform.rotation.z";
    keyFrameAnimation.duration = .5f;
    keyFrameAnimation.values = [YXEasing calculateFrameFromValue:oldValue toValue:newValue func:ElasticEaseOut frameCount:.5*30];
    _secondLayer.transform = CATransform3DMakeRotation(newValue, 0, 0, 1);
    [self.secondLayer addAnimation:keyFrameAnimation forKey:nil];
}

@end
