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
#import "UIView+help.m"

#import "ProgressView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)  // 角度转弧度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))    // 弧度转角度

#define PROGREESS_WIDTH 240 //直径
#define PROGREESS_LINE_WIDTH 20 //弧线宽度

#define FUNCTION_BTN_HEIGHT 75//btn高度

@interface ProgressClassVC ()

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) CAShapeLayer *aniLayer;
@property (nonatomic, strong) UIBezierPath *aniPath;
@property (nonatomic, strong) ProgressView *progressView;

@property (nonatomic, strong) UIButton *policeBtn;
@property (nonatomic, strong) UIButton *incidentBtn;

@property (nonatomic, strong) UIView *velocityView;
@property (nonatomic, strong) UIView *cameraView;

@property (nonatomic, strong) POPSpringAnimation *policeAnimation;
@property (nonatomic, strong) POPSpringAnimation *incidentAnimation;
@property (nonatomic, strong) POPSpringAnimation *velocityAnimation;
@property (nonatomic, strong) POPSpringAnimation *cameraAnimation;


@property (nonatomic, strong) UILabel *nearestLabel;
@property (nonatomic, strong) UILabel *distanceLable;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) POPSpringAnimation *nearestAnimation;
@property (nonatomic, strong) POPSpringAnimation *distanceAnimation;
@property (nonatomic, strong) POPSpringAnimation *addressAnimation;

@end

@implementation ProgressClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:53/255.0 green:58/255.0 blue:79/255.0 alpha:1.f];
    
    __weak ProgressClassVC *weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressView = [[ProgressView alloc] initWithFrame:CGRectMake((kDeviceWidth-240)/2.0, 50, 240, 240)];
        
        [weakSelf.view addSubview:_progressView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _progressView.persent = 92;
        });
        
        [weakSelf loadViewAnimation];
    });
    
    
    
    [self loadFunctionBtn];
}

//添加功能按钮
-(void)loadFunctionBtn{
    ///录像机和地点bgView
    _velocityView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight- 64, kDeviceWidth, 180)];
    _velocityView.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:100/255.0 alpha:1.0];
    [self.view addSubview:_velocityView];
    
    ///录像机bgView
    _cameraView = [[UIView alloc] initWithFrame:CGRectMake(-90, 0, 90, 105)];
    _cameraView.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:110/255.0 alpha:1.f];
    [_velocityView addSubview:_cameraView];
    
    UIImageView *camaryImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 65/2.f, 40, 40)];
    camaryImg.image = [UIImage imageNamed:@"camary"];
    [_cameraView addSubview:camaryImg];
    
    ///police按钮
    _policeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 64 , kDeviceWidth/2 , FUNCTION_BTN_HEIGHT)];
    _policeBtn.backgroundColor = [UIColor colorWithRed:52/255.0 green:205/255.0 blue:190/255.0 alpha:1.0];
    [self.view addSubview:_policeBtn];
    
    UIImageView *carImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17.5, 40, 40)];
    carImgV.image = [UIImage imageNamed:@"car"];
    [_policeBtn addSubview:carImgV];
    
    UILabel *reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(carImgV.right + 10, 15, 60, 15)];
    reportLabel.text = @"REPORT";
    reportLabel.textColor = [UIColor colorWithRed:160/255.0 green:252/255.0 blue:253/255.0 alpha:1.f];
    reportLabel.font = [UIFont systemFontOfSize:14];
    [_policeBtn addSubview:reportLabel];
    
    UILabel *policeLabel = [[UILabel alloc] initWithFrame:CGRectMake(carImgV.right+10, reportLabel.bottom , 80, 30)];
    policeLabel.textColor = [UIColor whiteColor];
    policeLabel.text = @"Police";
    policeLabel.font = [UIFont systemFontOfSize:22];
    [_policeBtn addSubview:policeLabel];
    
    ///事件按钮
    _incidentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kDeviceHeight - 64 , kDeviceWidth/2, FUNCTION_BTN_HEIGHT)];
    _incidentBtn.backgroundColor = [UIColor colorWithRed:128/255.0 green:116/255.0 blue:252/255.0 alpha:1.0];
    [self.view addSubview:_incidentBtn];
    
    UIImageView *warnImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17.5, 40, 40)];
    warnImgV.image = [UIImage imageNamed:@"warn"];
    [_incidentBtn addSubview:warnImgV];
    
    UILabel *warnReportLabel = [[UILabel alloc] initWithFrame:CGRectMake(warnImgV.right + 10, 15, 60, 15)];
    warnReportLabel.text = @"REPORT";
    warnReportLabel.textColor = [UIColor colorWithRed:160/255.0 green:252/255.0 blue:253/255.0 alpha:1.f];
    warnReportLabel.font = [UIFont systemFontOfSize:14];
    [_incidentBtn addSubview:warnReportLabel];
    
    UILabel *incidentLabel = [[UILabel alloc] initWithFrame:CGRectMake(warnImgV.right + 10, reportLabel.bottom , 100, 30)];
    incidentLabel.textColor = [UIColor whiteColor];
    incidentLabel.text = @"Incident";
    incidentLabel.font = [UIFont systemFontOfSize:22];
    [_incidentBtn addSubview:incidentLabel];
    
    ///距离地点中的Label
    _nearestLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, _velocityView.height, 150, 20)];
    _nearestLabel.text = @"NEAREST";
    _nearestLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:162/255.0 alpha:1.f];
    _nearestLabel.font = [UIFont systemFontOfSize:14];
    [_velocityView addSubview:_nearestLabel];
    
    ///距离
    _distanceLable = [[UILabel alloc] initWithFrame:CGRectMake(_nearestLabel.left, _nearestLabel.bottom , 150, 40)];
    
    _distanceLable.font = [UIFont systemFontOfSize:35];
    NSString *distanceStr = @"220m";
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:distanceStr];
    [mutAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3, 1)];
    _distanceLable.attributedText = mutAttStr;
    
    _distanceLable.textColor = [UIColor colorWithRed:53/255.0 green:255/255.0 blue:234/255.0 alpha:1.f];
    [_velocityView addSubview:_distanceLable];
    
    ///地点
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nearestLabel.left, _distanceLable.bottom , 150, 30)];
    _addressLabel.text = @"Washington St";
    _addressLabel.textColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:193/255.0 alpha:1.f];
    _addressLabel.font = [UIFont systemFontOfSize:22];
    [_velocityView addSubview:_addressLabel];
    
    [self loadBtnUpAnimation];
}

//添加弹动动画
-(void)loadViewAnimation{
    //关键帧-缓动函数动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath              = @"transform.scale";
    keyFrameAnimation.duration             = 1.f;
    keyFrameAnimation.values               = [YXEasing calculateFrameFromValue:0.8 toValue:1.f func:BounceEaseOut frameCount:30];
    [_progressView.layer addAnimation:keyFrameAnimation forKey:nil];
}

//加载按钮上弹动画
-(void)loadBtnUpAnimation{
    
    ///下边两个按钮
    _policeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    _policeAnimation.fromValue = [NSValue valueWithCGRect:_policeBtn.frame];
    
    CGRect tempRect = _policeBtn.frame;
    tempRect.origin.y -= 75;
    _policeAnimation.toValue = [NSValue valueWithCGRect:tempRect];
    _policeAnimation.springBounciness = 15;
    _policeAnimation.springSpeed = 10;
    _policeAnimation.beginTime = CACurrentMediaTime() + 0.1;
    [_policeBtn pop_addAnimation:_policeAnimation forKey:nil];
    
    
    _incidentAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    _incidentAnimation.fromValue = [NSValue valueWithCGRect:_incidentBtn.frame];
    CGRect tempRect2 = _incidentBtn.frame;
    tempRect2.origin.y -= 75;
    _incidentAnimation.toValue = [NSValue valueWithCGRect:tempRect2];
    _incidentAnimation.springBounciness = 15;
    _incidentAnimation.springSpeed = 10;
    _incidentAnimation.beginTime = CACurrentMediaTime() + 0.3;
    [_incidentBtn pop_addAnimation:_incidentAnimation forKey:nil];
    
    ///显示录像机和地点的view
    _velocityAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    _velocityAnimation.fromValue = [NSValue valueWithCGRect:_velocityView.frame];
    CGRect tempRect3 = _velocityView.frame;
    tempRect3.origin.y -= 180;
    _velocityAnimation.toValue = [NSValue valueWithCGRect:tempRect3];
    _velocityAnimation.springBounciness = 1;
    _velocityAnimation.springSpeed = 10;
    _velocityAnimation.beginTime = CACurrentMediaTime() + 0.2;
    [_velocityView pop_addAnimation:_velocityAnimation forKey:nil];
    
    ///录像机
    _cameraAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    _cameraAnimation.fromValue = [NSValue valueWithCGRect:_cameraView.frame];
    CGRect tempRect4 = _cameraView.frame;
    tempRect4.origin.x += 90;
    _cameraAnimation.toValue = [NSValue valueWithCGRect:tempRect4];
    _cameraAnimation.springBounciness = 1;
    _cameraAnimation.springSpeed = 10;
    _cameraAnimation.beginTime = CACurrentMediaTime() + 0.6;
    [_cameraView pop_addAnimation:_cameraAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        ///上边label
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
        keyFrameAnimation.keyPath              = @"position";
        keyFrameAnimation.duration             = .5f;
        keyFrameAnimation.values               = [YXEasing calculateFrameFromPoint:_nearestLabel.center toPoint:CGPointMake(_nearestLabel.center.x, _nearestLabel.center.y - 170) func:ExponentialEaseOut frameCount:(30 * 3)];
        _nearestLabel.center = CGPointMake(_nearestLabel.center.x, _nearestLabel.center.y - 170);
        [_nearestLabel.layer addAnimation:keyFrameAnimation forKey:nil];
        
        ///中间label
        CAKeyframeAnimation *keyFrameAnimation2 = [CAKeyframeAnimation animation];
        keyFrameAnimation2.keyPath              = @"position";
        keyFrameAnimation2.duration             = .5f;
        keyFrameAnimation2.values               = [YXEasing calculateFrameFromPoint:_distanceLable.center toPoint:CGPointMake(_distanceLable.center.x, _distanceLable.center.y - 170) func:ExponentialEaseOut frameCount:(30 * 3)];
        _distanceLable.center = CGPointMake(_distanceLable.center.x, _distanceLable.center.y - 170);
        [_distanceLable.layer addAnimation:keyFrameAnimation2 forKey:nil];
        
        
        ///最下边label
        CAKeyframeAnimation *keyFrameAnimation3 = [CAKeyframeAnimation animation];
        keyFrameAnimation3.keyPath              = @"position";
        keyFrameAnimation3.duration             = .5f;
        keyFrameAnimation3.values               = [YXEasing calculateFrameFromPoint:_addressLabel.center toPoint:CGPointMake(_addressLabel.center.x, _addressLabel.center.y - 170) func:ExponentialEaseOut frameCount:(30 * 3)];
        _addressLabel.center = CGPointMake(_addressLabel.center.x, _addressLabel.center.y - 170);
        [_addressLabel.layer addAnimation:keyFrameAnimation3 forKey:nil];
    });
    
}

@end
