//
//  LoadingAniView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/12.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "LoadingAniView.h"
#import "UIView+help.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)  // 角度转弧度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))    // 弧度转角度

@interface LoadingAniView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;//旋转的圆圈

@property (nonatomic, strong) CAShapeLayer *flyLayer;//向上飞的弧线

@property (nonatomic, strong) CAShapeLayer *dropLayer;//下坠的直线
@end

@implementation LoadingAniView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCircleLayer];
    }
    return self;
}

///设置圆圈
-(void)createCircleLayer{
    ///旋转的圆圈
    _circleLayer             = [CAShapeLayer layer];
    _circleLayer.frame       = CGRectMake(0, self.height - self.width, self.width, self.width);
    _circleLayer.lineWidth   = 10.f;
    _circleLayer.fillColor   = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
    UIBezierPath *path       = \
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2.f, self.width/2.f) radius:(self.width-10)/2.f startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];
    _circleLayer.path        = path.CGPath;
    _circleLayer.strokeStart = 0.375;
    _circleLayer.strokeEnd   = 0.5;
    [self.layer addSublayer:_circleLayer];
    
    ///向上的弧线
    _flyLayer              = [CAShapeLayer layer];
    _flyLayer.lineWidth    = 5;
    _flyLayer.fillColor    = [UIColor clearColor].CGColor;
    _flyLayer.strokeColor  = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
    UIBezierPath *flyPath2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5 , self.width-10, 2*self.width)];
    _flyLayer.strokeStart  = 0;
    _flyLayer.strokeEnd    = 1;
    _flyLayer.path         = flyPath2.CGPath;
    _flyLayer.hidden       = YES;
    [self.layer addSublayer:_flyLayer];
    
    ///向下的直线
    _dropLayer             = [CAShapeLayer layer];
    _dropLayer.lineWidth   = 5;
    _dropLayer.fillColor    = [UIColor clearColor].CGColor;
    _dropLayer.strokeColor  = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
    UIBezierPath *dropPath = [UIBezierPath bezierPath];
    [dropPath moveToPoint:CGPointMake(self.width/2.f, 5)];
    [dropPath addLineToPoint:CGPointMake(self.width/2.f, self.width/2.f)];
    _dropLayer.path = dropPath.CGPath;
    _dropLayer.strokeStart = 0;
    _dropLayer.strokeEnd   = 0;
    [self.layer addSublayer:_dropLayer];
    
    
    ///开启动画
    [self loadAnimation];
}

///设置动画
-(void)loadAnimation
{
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @(0.375);
    startAni.toValue =@(0);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.5);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[startAni,strokeEndAnimation];
    aniGroup.duration = 1;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    [_circleLayer addAnimation:aniGroup forKey:nil];
    
    CABasicAnimation *rotationAni = [CABasicAnimation animation];
    rotationAni.keyPath = @"transform.rotation.z";
    rotationAni.fromValue = [NSNumber numberWithFloat:M_PI *2];
    rotationAni.toValue   = [NSNumber numberWithFloat:0];
    rotationAni.removedOnCompletion = YES;
    rotationAni.duration = 1;
    rotationAni.repeatCount = 1;
    [_circleLayer addAnimation:rotationAni forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadFlyAnimation];
    });
}

///设置弧线向上飞的动画
-(void)loadFlyAnimation
{
    _flyLayer.hidden = NO;
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @(0.97);
    startAni.toValue =@(0.75);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(1);
    strokeEndAnimation.toValue = @(0.77);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[startAni,strokeEndAnimation];
    aniGroup.duration = 1;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_flyLayer addAnimation:aniGroup forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadDropAnimation];
    });
}

///设置向下插入的动画
-(void)loadDropAnimation
{
    _flyLayer.hidden = YES;
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @(0);
    startAni.toValue =@(1);
    startAni.duration = 1.5f;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    strokeEndAnimation.duration = 1;
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[strokeEndAnimation];
    aniGroup.duration = 1;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_dropLayer addAnimation:aniGroup forKey:nil];
}


@end
