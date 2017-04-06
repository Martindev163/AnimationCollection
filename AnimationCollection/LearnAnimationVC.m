//
//  LearnAnimationVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "LearnAnimationVC.h"
#import "BaseAntimationView.h"
#import "YXEasing.h"

@interface LearnAnimationVC ()

@property (nonatomic, strong) BaseAntimationView *baseView;

@property (nonatomic, strong) UIButton *iconImageBtn;

@property (nonatomic, strong) UILabel *label;

@end

@implementation LearnAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _baseView = [[BaseAntimationView alloc] initWithFrame:CGRectMake(10, 100, 300, 500)];
    [self.view addSubview:_baseView];
    [_baseView buildView];
    [_baseView showAniamtionWithDurition:1 animation:YES];
    
    [self performSelector:@selector(hideBaseView) withObject:nil afterDelay:2];
    
    _iconImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 60, 200, 40, 40)];
    _iconImageBtn.backgroundColor = [UIColor redColor];
    
    [_iconImageBtn addTarget:self action:@selector(beginAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_iconImageBtn];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 80, 200, 0, 40)];
    _label.text = @"大手大脚福利撒娇的六块";
    _label.backgroundColor = [UIColor redColor];
    _label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_label];
}

//创建抖动动画
-(void)beginAnimation
{
    //创建动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度
    
    keyAnimaion.duration = 0.2;
    keyAnimaion.repeatCount = 3;
    [self.iconImageBtn.layer addAnimation:keyAnimaion forKey:nil];
    
    //文本动画
//    CAKeyframeAnimation *laberAnimation = [CAKeyframeAnimation animation];
    [UIView animateWithDuration:1.f animations:^{
        _label.frame = CGRectMake(kDeviceWidth - 280, 200, 200, 40);
    }];
    
    
    
}

-(void)hideBaseView
{
    [_baseView hideAniamtionWithDurition:1 animation:YES];
}

@end
