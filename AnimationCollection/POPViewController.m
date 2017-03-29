//
//  POPViewController.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/27.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "POPViewController.h"
#import "POP.h"

@interface POPViewController ()

@property (nonatomic, strong) UIButton *testBtn ;

@end

@implementation POPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //创建测试控件
    _testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    _testBtn.center = self.view.center;
    
    [_testBtn addTarget:self action:@selector(clickBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    _testBtn.backgroundColor = [UIColor redColor];
    
    _testBtn.layer.cornerRadius = 50;
    
    _testBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:_testBtn];
    
    //创建拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [_testBtn addGestureRecognizer:pan];
}

-(void)clickBtnEvent:(id)sender
{
    [_testBtn.layer pop_removeAllAnimations];
}


-(void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                      gesture.view.center.y + translation.y);
    
    [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"收拾结束");
        CGPoint velocity = [gesture velocityInView:self.view];
        
        POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [gesture.view.layer pop_addAnimation:decayAnimation forKey:nil];
    }
}

@end
