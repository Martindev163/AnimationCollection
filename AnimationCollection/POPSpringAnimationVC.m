//
//  POPSpringAnimationVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/28.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "POPSpringAnimationVC.h"
#import "POP.h"

@interface POPSpringAnimationVC ()

@property (nonatomic, strong) UIView *popView;

@end

@implementation POPSpringAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _popView = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 50, 50)];
    
    _popView.layer.cornerRadius = 10;
    _popView.layer.masksToBounds = YES;
    
    _popView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_popView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnimation)];
    [_popView addGestureRecognizer:tap];
    
    //设置延时
//    [self performSelector:@selector(showAnimation) withObject:nil afterDelay:1];
    
    
}

-(void)showAnimation
{
    _popView.frame = CGRectMake(150, 150, 50, 50);
    
    //初始化动画
    POPSpringAnimation *springAni = \
        [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    springAni.springSpeed         = 0.f;
    springAni.toValue             = [NSValue valueWithCGRect:CGRectMake(150,
                                                                        150,
                                                                        100,
                                                                        100)];
    //添加动画
    [self.popView pop_addAnimation:springAni forKey:nil];
}

@end
