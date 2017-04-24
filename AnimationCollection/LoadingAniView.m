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

@property (nonatomic, strong) CAShapeLayer *thickLayer;//粗线

@property (nonatomic, strong) CAShapeLayer *leftLayer;//左方分出的线

@property (nonatomic, strong) CAShapeLayer *rightLayer;//右方分出的线

@property (nonatomic, strong) CAShapeLayer *tickLayer;//对号

@property (nonatomic, strong) CAShapeLayer *exclamationSuperLayer;//共同的layer
@property (nonatomic, strong) CAShapeLayer *exclamationTopLayer;//感叹号上边
@property (nonatomic, strong) CAShapeLayer *exclamationBottomLayer;//感叹号下边的点

@property (nonatomic, strong) UIBezierPath *circlePath;//圆形的贝塞尔曲线

@property (nonatomic, assign) BOOL succeed;
@end

@implementation LoadingAniView

-(instancetype)initWithFrame:(CGRect)frame WithIsSucceed:(BOOL)succeed
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _succeed = succeed;
        
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
    _circlePath       = \
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2.f, self.width/2.f) radius:(self.width-10)/2.f startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];
    _circleLayer.path        = _circlePath.CGPath;
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
    [dropPath addLineToPoint:CGPointMake(self.width/2.f, (self.width*1.2)/2.f)];
    _dropLayer.path = dropPath.CGPath;
    _dropLayer.strokeStart = 0;
    _dropLayer.strokeEnd   = 0;
    [self.layer addSublayer:_dropLayer];
    
    ///粗线
    _thickLayer = [CAShapeLayer layer];
    _thickLayer.lineWidth = 10;
    _thickLayer.fillColor = [UIColor clearColor].CGColor;
    _thickLayer.strokeColor = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
//    _thickLayer.strokeColor = [UIColor redColor].CGColor;
    UIBezierPath *thickPath = [UIBezierPath bezierPath];
    [thickPath moveToPoint:CGPointMake(self.width/2.f, self.width/2.f)];
    [thickPath addLineToPoint:CGPointMake(self.width/2.f, self.height)];
    _thickLayer.path = thickPath.CGPath;
    _thickLayer.strokeStart = 0.15;
    _thickLayer.strokeEnd = 0.15;
    [self.layer addSublayer:_thickLayer];
    
    ///左边线
    _leftLayer = [CAShapeLayer layer];
    _leftLayer.lineWidth = 10;
    _leftLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLayer.strokeColor = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:CGPointMake(self.width/2.f, self.height - self.width/2.f)];
    [leftPath addLineToPoint:CGPointMake(0.2*self.width, self.height - 0.2*self.width)];
    _leftLayer.path = leftPath.CGPath;
    _leftLayer.strokeStart = 0;
    _leftLayer.strokeEnd = 0;
    [self.layer addSublayer:_leftLayer];
    
    ///右边线
    _rightLayer = [CAShapeLayer layer];
    _rightLayer.lineWidth = 10;
    _rightLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLayer.strokeColor = [UIColor colorWithRed:54/255.0 green:59/255.0 blue:82/255.0 alpha:1.f].CGColor;
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(self.width/2.f, self.height - self.width/2.f)];
    [rightPath addLineToPoint:CGPointMake(0.8*self.width, self.height - 0.2*self.width)];
    _rightLayer.path = rightPath.CGPath;
    _rightLayer.strokeStart = 0;
    _rightLayer.strokeEnd = 0;
    [self.layer addSublayer:_rightLayer];
    
    ///对号
    _tickLayer = [CAShapeLayer layer];
    
    _tickLayer.lineWidth = 8;
    _tickLayer.fillColor = [UIColor clearColor].CGColor;
    _tickLayer.strokeColor = [UIColor colorWithRed:60/255.0 green:157/255.0 blue:119/255.0 alpha:1.f].CGColor;
    UIBezierPath *tickPath = [UIBezierPath bezierPath];
    [tickPath moveToPoint:CGPointMake(self.width*0.25, self.height - self.width/2.2f)];
    [tickPath addLineToPoint:CGPointMake(self.width*0.42, self.height - self.width/3.5f)];
    
    [tickPath addLineToPoint:CGPointMake(self.width*0.72, 1.72*self.width/2.f)];
    _tickLayer.path = tickPath.CGPath;
    _tickLayer.strokeStart = 0;
    _tickLayer.strokeEnd = 0;
    [self.layer addSublayer:_tickLayer];
    
    ///感叹号
    UIBezierPath *exclamationPath = [UIBezierPath bezierPath];
    [exclamationPath moveToPoint:CGPointMake(self.width/2.f, 0)];
    [exclamationPath addLineToPoint:CGPointMake(self.width/2.f, self.width)];
    
    _exclamationTopLayer = [CAShapeLayer layer];
    _exclamationTopLayer.lineWidth = 12;
    _exclamationTopLayer.fillColor = [UIColor clearColor].CGColor;
    _exclamationTopLayer.strokeColor = [UIColor colorWithRed:252/255.0 green:72/255.0 blue:64/255.0 alpha:1.f].CGColor;
    _exclamationTopLayer.path = exclamationPath.CGPath;
    _exclamationTopLayer.strokeStart = 0;
    _exclamationTopLayer.strokeEnd = 0;
    
    _exclamationBottomLayer = [CAShapeLayer layer];
    _exclamationBottomLayer.lineWidth = 12;
    _exclamationBottomLayer.fillColor = [UIColor clearColor].CGColor;
    _exclamationBottomLayer.strokeColor = [UIColor colorWithRed:252/255.0 green:72/255.0 blue:64/255.0 alpha:1.f].CGColor;
    _exclamationBottomLayer.path = exclamationPath.CGPath;
    _exclamationBottomLayer.strokeStart = 0;
    _exclamationBottomLayer.strokeEnd = 0;
    
    _exclamationSuperLayer = [CAShapeLayer layer];
    _exclamationSuperLayer.frame = CGRectMake(0, self.height - self.width, self.width, self.width);
    [_exclamationSuperLayer addSublayer:_exclamationTopLayer];
    [_exclamationSuperLayer addSublayer:_exclamationBottomLayer];
    [self.layer addSublayer:_exclamationSuperLayer];
    
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
    aniGroup.duration = 0.5;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_flyLayer addAnimation:aniGroup forKey:nil];
    
    if (self.succeed == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadDropAnimation];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadExclamationAnimation];
        });
    }
}

///设置向下插入的动画
-(void)loadDropAnimation
{
    _flyLayer.hidden = YES;
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @(0);
    startAni.toValue =@(0.4);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.4);
    strokeEndAnimation.toValue = @(0.8);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[startAni,strokeEndAnimation];
    aniGroup.duration = 0.3;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_dropLayer addAnimation:aniGroup forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadShapeChangeGather];
    });
}

/////圆形变形
-(void)loadShapeChangeGather{
    
    ///细线变短插入椭圆
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @(0.4);
    startAni.toValue =@(1);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.8);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[startAni,strokeEndAnimation];
    aniGroup.duration = 0.2;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_dropLayer addAnimation:aniGroup forKey:nil];
    
    ///园变椭圆
    CABasicAnimation *pathAni = [CABasicAnimation animation];
    pathAni.keyPath = @"transform.scale.y";
    pathAni.fromValue = [NSNumber numberWithFloat:1.f];
    pathAni.toValue   = [NSNumber numberWithFloat:0.9f];
    pathAni.duration = .2f;
    pathAni.removedOnCompletion = NO;
    pathAni.fillMode = kCAFillModeForwards;
    [_circleLayer addAnimation:pathAni forKey:nil];
    
    CABasicAnimation *pathAni2 = [CABasicAnimation animation];
    pathAni2.keyPath = @"transform.scale.x";
    pathAni2.fromValue = [NSNumber numberWithFloat:1.f];
    pathAni2.toValue   = [NSNumber numberWithFloat:1.1f];
    pathAni2.duration = .2f;
    pathAni2.removedOnCompletion = NO;
    pathAni2.fillMode = kCAFillModeForwards;
    [_circleLayer addAnimation:pathAni2 forKey:nil];
    
    CGRect tempFrame = _circleLayer.frame;
    _circleLayer.anchorPoint = CGPointMake(0.5, 1);
    _circleLayer.frame = tempFrame;
    
    ///粗线变长
    CABasicAnimation *thickStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    thickStartAni.fromValue = @(0);
    thickStartAni.toValue =@(0.15);
    
    CABasicAnimation *thickEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    thickEndAnimation.fromValue = @(0.15);
    thickEndAnimation.toValue = @(0.5);
    
    CAAnimationGroup *aniGroup2 = [CAAnimationGroup animation];
    aniGroup2.animations = @[thickStartAni,thickEndAnimation];
    aniGroup2.duration = 0.2;
    aniGroup2.repeatCount = 1;
    aniGroup2.fillMode = kCAFillModeForwards;
    aniGroup2.removedOnCompletion = NO;
    
    [_thickLayer addAnimation:aniGroup2 forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadRecoverAnimation];
    });
    
}

///椭圆回复，西线分出三根
-(void)loadRecoverAnimation{
    ///椭圆变圆
    CABasicAnimation *pathAni = [CABasicAnimation animation];
    pathAni.keyPath = @"transform.scale.y";
    pathAni.fromValue = [NSNumber numberWithFloat:.9f];
    pathAni.toValue   = [NSNumber numberWithFloat:1.f];
    pathAni.duration = .2f;
    pathAni.removedOnCompletion = NO;
    pathAni.fillMode = kCAFillModeForwards;
    [_circleLayer addAnimation:pathAni forKey:nil];
    
    CABasicAnimation *pathAni2 = [CABasicAnimation animation];
    pathAni2.keyPath = @"transform.scale.x";
    pathAni2.fromValue = [NSNumber numberWithFloat:1.1f];
    pathAni2.toValue   = [NSNumber numberWithFloat:1.f];
    pathAni2.duration = .2f;
    pathAni2.removedOnCompletion = NO;
    pathAni2.fillMode = kCAFillModeForwards;
    [_circleLayer addAnimation:pathAni2 forKey:nil];
    
    //粗线变长
    CABasicAnimation *thickStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    thickStartAni.fromValue = @(0.15);
    thickStartAni.toValue =@(0);
    
    CABasicAnimation *thickEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    thickEndAnimation.fromValue = @(0.5);
    thickEndAnimation.toValue = @(0.95);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[thickStartAni,thickEndAnimation];
    aniGroup.duration = 0.2;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    [_thickLayer addAnimation:aniGroup forKey:nil];
    
    ///左边线右边线
    CABasicAnimation *LRStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    LRStartAni.fromValue = @(0);
    LRStartAni.toValue =@(0);
    
    CABasicAnimation *LREndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    LREndAnimation.fromValue = @(0);
    LREndAnimation.toValue = @(1);
    
    CAAnimationGroup *aniGroup2 = [CAAnimationGroup animation];
    aniGroup2.animations = @[LRStartAni,LREndAnimation];
    aniGroup2.duration = 0.2;
    aniGroup2.repeatCount = 1;
    aniGroup2.fillMode = kCAFillModeForwards;
    aniGroup2.removedOnCompletion = NO;
    
    [_leftLayer addAnimation:aniGroup2 forKey:nil];
    [_rightLayer addAnimation:aniGroup2 forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadSucceedAnimaiotn];
    });
}

///前期动画结束后 成功的图片变绿并出现“对号”
-(void)loadSucceedAnimaiotn{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _leftLayer.hidden = YES;
    _rightLayer.hidden = YES;
    _thickLayer.hidden = YES;
    _circleLayer.strokeColor = [UIColor colorWithRed:60/255.0 green:157/255.0 blue:119/255.0 alpha:1.f].CGColor;
    [CATransaction commit];
    
    CABasicAnimation *tickAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tickAnimation.fromValue = @(0);
    tickAnimation.toValue = @(1);
    
    CABasicAnimation *tickDisplacementAni = [CABasicAnimation animationWithKeyPath:@"position"];
    tickDisplacementAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(10, 0)];
    tickDisplacementAni.toValue = [NSValue valueWithCGPoint:CGPointMake(0,0)];

    _tickLayer.backgroundColor = [UIColor redColor].CGColor;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[tickAnimation,tickDisplacementAni];
    group.duration = 0.5f;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [_tickLayer addAnimation:group forKey:nil];
}

/**
 *  错误情况
 */
///橙色感叹号出现
-(void)loadExclamationAnimation{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _flyLayer.hidden = YES;
    _circleLayer.strokeColor = [UIColor colorWithRed:252/255.0 green:72/255.0 blue:64/255.0 alpha:1.f].CGColor;
    [CATransaction commit];
    
    
    
    ///上边部分
    CABasicAnimation *topStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    topStartAni.fromValue = @(- 0.5);
    topStartAni.toValue =@(0.2);
    
    CABasicAnimation *topEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    topEndAnimation.fromValue = @(0);
    topEndAnimation.toValue = @(0.7);
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[topStartAni,topEndAnimation];
    aniGroup.duration = 0.3;
    aniGroup.repeatCount = 1;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    
    [_exclamationTopLayer addAnimation:aniGroup forKey:nil];
    
    
    ///下半部分
    CABasicAnimation *bottomStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    bottomStartAni.fromValue = @(1.2);
    bottomStartAni.toValue =@(0.75);
    
    CABasicAnimation *bottomEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bottomEndAnimation.fromValue = @(1.3);
    bottomEndAnimation.toValue = @(0.85);
    
    CAAnimationGroup *aniGroup2 = [CAAnimationGroup animation];
    aniGroup2.animations = @[bottomStartAni,bottomEndAnimation];
    aniGroup2.duration = 0.3;
    aniGroup2.repeatCount = 1;
    aniGroup2.fillMode = kCAFillModeForwards;
    aniGroup2.removedOnCompletion = NO;
    
    [_exclamationBottomLayer addAnimation:aniGroup2 forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadWaggleAnimation];
    });
}

///添加感叹号晃动
-(void)loadWaggleAnimation{
    
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.duration = 0.2;
    keyAnimaion.repeatCount = 3;
    
    [_exclamationSuperLayer addAnimation:keyAnimaion forKey:nil];
    
}

@end
