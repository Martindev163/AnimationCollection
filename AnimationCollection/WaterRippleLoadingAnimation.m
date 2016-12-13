//
//  WaterRippleLoadingAnimation.m
//  AnimationCollection
//
//  Created by 马浩哲 on 16/12/12.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "WaterRippleLoadingAnimation.h"
#import "WaveView.h"

@interface WaterRippleLoadingAnimation ()

@property (nonatomic, strong) WaveView *waveView;

@end



@implementation WaterRippleLoadingAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _waveView = [WaveView loadingView];
    [self.view addSubview:_waveView];
    _waveView.center = self.view.center;
    [_waveView startLoading];
    
//    [self drawAPerson];
}

#pragma mark - UIBezierPatturntoh和CAShapeLayer结合使用 画一个小人
-(void)drawAPerson
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(kDeviceWidth/2 + 25, 164)];
    
    [path addArcWithCenter:CGPointMake(kDeviceWidth/2, 164) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(kDeviceWidth/2, 189)];
    [path addLineToPoint:CGPointMake(kDeviceWidth/2, 255)];
    
    [path addLineToPoint:CGPointMake(kDeviceWidth/2 - 30, 305)];
    [path moveToPoint:CGPointMake(kDeviceWidth/2, 255)];
    [path addLineToPoint:CGPointMake(kDeviceWidth/2 + 30, 305)];
    [path moveToPoint:CGPointMake(kDeviceWidth/2 - 40, 225)];
    [path addLineToPoint:CGPointMake(kDeviceWidth/2 + 40, 225)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithRed:147/255.0 green:231/255.0 blue:182/255.0 alpha:1].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}

-(void)dealloc
{
    [_waveView stopLoading];
}

@end
