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

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)  // 角度转弧度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))    // 弧度转角度

@interface ProgressClassVC ()

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) CAShapeLayer *aniLayer;
@property (nonatomic, strong) UIBezierPath *aniPath;

@end

@implementation ProgressClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0 green:45/255.0 blue:66/255.0 alpha:1.f];
    [self screateDialPlate];
    
    
}


//创建表盘
-(void)screateDialPlate
{
    _aniPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:120 startAngle:DEGREES_TO_RADIANS(-225) endAngle:DEGREES_TO_RADIANS(45) clockwise:YES];
    
    _layer = [CAShapeLayer layer];
    _layer.lineWidth = 20;
    _layer.fillColor = [UIColor clearColor].CGColor;
    _layer.path = _aniPath.CGPath;
    _layer.strokeColor = [UIColor colorWithRed:90/255.0 green:88/255.0 blue:110/255.0 alpha:1.f].CGColor;
    _layer.lineDashPattern = @[@(2),@(6)];
    [self.view.layer addSublayer:_layer];
    
    _aniLayer = [CAShapeLayer layer];
    _aniLayer.lineWidth = 20;
    _aniLayer.fillColor = [UIColor clearColor].CGColor;
    _aniLayer.strokeColor = [UIColor whiteColor].CGColor;
    _aniLayer.path = _aniPath.CGPath;
    _aniLayer.strokeStart = 0.f;
    _aniLayer.strokeEnd = 0.f;
    _aniLayer.lineDashPattern = @[@(2),@(6)];
    [self.view.layer addSublayer:_aniLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setColors:@[(__bridge id)[UIColor redColor].CGColor,
                               (__bridge id)[UIColor yellowColor].CGColor,
                               (__bridge id)[UIColor blueColor].CGColor]];
    gradientLayer.type = kCAGradientLayerAxial;
    gradientLayer.locations = @[@(0.1),@(0.5),@(0.9)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0,300,400);
    gradientLayer.mask = _aniLayer;
    [self.view.layer addSublayer:gradientLayer];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startLoadNumAnimationWithPercent:1.0f];
    });
    
    
}

-(void)startLoadNumAnimationWithPercent:(CGFloat)persent
{
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"progress";
//    animation.duration = 3.f;
//    animation.values = [YXEasing calculateFrameFromValue:0 toValue:persent func:CircularEaseInOut frameCount:(30 * 3)];
//    [_aniLayer addAnimation:animation forKey:nil];
    
    _aniLayer.strokeEnd = persent;
}

@end
