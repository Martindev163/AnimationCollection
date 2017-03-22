//
//  LearnAnimationVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "LearnAnimationVC.h"
#import "BaseAntimationView.h"

@interface LearnAnimationVC ()

@property (nonatomic, strong) BaseAntimationView *baseView;

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
}

-(void)hideBaseView
{
    [_baseView hideAniamtionWithDurition:1 animation:YES];
}

@end
