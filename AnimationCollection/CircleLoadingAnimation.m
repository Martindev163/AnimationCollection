//
//  CircleLoadingAnimation.m
//  AnimationCollection
//
//  Created by 马浩哲 on 16/11/16.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "CircleLoadingAnimation.h"

#define ShapelayerLineWidth 5
#define ShapelayerWidth 100
#define ShapelayerMargin (kDeviceWidth - ShapelayerWidth)/2.0
#define ShapelayerY (kDeviceHeight - ShapelayerWidth)/3.0
#define ShapelayerRadius ShapelayerWidth/2.0
#define AnimationDuration 2

@interface CircleLoadingAnimation ()

@property (nonatomic, strong) CAShapeLayer *bgShapLayer;
@property (nonatomic, strong) CAShapeLayer *colorShapeLayer;

@end

@implementation CircleLoadingAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCircle];
    [self addLoadingAnimation];
}

#pragma mark - 画圈
-(void)createCircle
{
    _bgShapLayer = [CAShapeLayer layer];
    _bgShapLayer.strokeColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    _bgShapLayer.fillColor = [UIColor clearColor].CGColor;
    _bgShapLayer.lineWidth = ShapelayerLineWidth;
    _bgShapLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(ShapelayerMargin, ShapelayerY, ShapelayerWidth, ShapelayerWidth) cornerRadius:ShapelayerRadius].CGPath;
    [self.view.layer addSublayer:_bgShapLayer];
    
    _colorShapeLayer = [CAShapeLayer layer];
    _colorShapeLayer.strokeColor = [UIColor redColor].CGColor;
    _colorShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _colorShapeLayer.lineWidth = ShapelayerLineWidth;
    _colorShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(ShapelayerMargin, ShapelayerY, ShapelayerWidth, ShapelayerWidth) cornerRadius:ShapelayerRadius].CGPath;
    [self.view.layer addSublayer:_colorShapeLayer];
    _colorShapeLayer.lineDashPattern = @[@6,@3];
}

#pragma mark - 设置动画
-(void)addLoadingAnimation
{
    //起点动化
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    //终点动画
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation,strokeEndAnimation];
    animationGroup.duration = AnimationDuration;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [_colorShapeLayer addAnimation:animationGroup forKey:nil];
}

@end
