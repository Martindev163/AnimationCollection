//
//  BaseAntimationView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "BaseAntimationView.h"

#import "TranslationAnimationView.h"
#import "CircleView.h"
#import "PercentView.h"
#import "SourceView.h"

@interface BaseAntimationView ()

@property (nonatomic, strong) SourceView *transView;
@property (nonatomic, strong) SourceView *circleView;

@end

@implementation BaseAntimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


- (void)showAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation{
    
    [self.transView showAniamtionWithDurition:time animation:animation];
    [self.circleView showAniamtionWithDurition:time animation:animation];
}

- (void)hideAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation{
    [self.transView hideAniamtionWithDurition:time animation:animation];
    [self.circleView hideAniamtionWithDurition:time animation:animation];
}

- (void)buildView{
    self.transView = [[TranslationAnimationView alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.transView.offsetX = 50;
    self.transView.backgroundColor = [UIColor redColor];
    [self.transView buildView];
    [self addSubview:self.transView];
    
    self.circleView = [[CircleView alloc] initWithFrame:CGRectMake(10, 50, 100, 100)];
    [self addSubview:self.circleView];
}

- (void)percent{
    [self.transView percent];
    [self.circleView percent];
}

@end
