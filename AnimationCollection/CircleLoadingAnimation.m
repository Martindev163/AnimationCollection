//
//  CircleLoadingAnimation.m
//  AnimationCollection
//
//  Created by 马浩哲 on 16/11/16.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "CircleLoadingAnimation.h"
#import "LoadingAniView.h"

#define ShapelayerLineWidth 5
#define ShapelayerWidth 100
#define ShapelayerMargin (kDeviceWidth - ShapelayerWidth)/2.0
#define ShapelayerY 50
#define ShapelayerRadius ShapelayerWidth/2.0
#define AnimationDuration 2

@interface CircleLoadingAnimation ()

@property (nonatomic, strong) CAShapeLayer *bgShapLayer;
@property (nonatomic, strong) CAShapeLayer *colorShapeLayer;

//@property (nonatomic, weak) LoadingAniView *loadView;

@end

@implementation CircleLoadingAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCircle];
    [self addLoadingAnimation];
    
    UIButton *succeedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, kDeviceHeight - 100, 100, 44)];
    succeedBtn.backgroundColor = [UIColor redColor];
    [succeedBtn setTitle:@"成功" forState:UIControlStateNormal];
    [succeedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    succeedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [succeedBtn addTarget:self action:@selector(succeedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:succeedBtn];
    
    UIButton *failBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 120, kDeviceHeight - 100, 100, 44)];
    failBtn.backgroundColor = [UIColor redColor];
    [failBtn setTitle:@"失败" forState:UIControlStateNormal];
    [failBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    failBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [failBtn addTarget:self action:@selector(failAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:failBtn];
}

-(void)succeedAction{
//    [_loadView removeFromSuperview];
    LoadingAniView *loadView = [[LoadingAniView alloc] initWithFrame:CGRectMake((kDeviceWidth - 120)/2.f, 250, 120, 180) WithIsSucceed:YES];//宽高比为1:1.5
    
    [self.view addSubview:loadView];
}

-(void)failAction{
    LoadingAniView *loadView = [[LoadingAniView alloc] initWithFrame:CGRectMake((kDeviceWidth - 120)/2.f, 250, 120, 180) WithIsSucceed:NO];//宽高比为1:1.5
    
    [self.view addSubview:loadView];
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
