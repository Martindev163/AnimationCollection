//
//  PopNumberAnimation.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/11.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "PopNumberAnimation.h"
#import "POP.h"


@interface PopNumberAnimation ()

@property (nonatomic, strong) POPBasicAnimation *countAnimation;

@end

@implementation PopNumberAnimation


-(instancetype)init
{
    if (self = [super init]) {
        self.countAnimation = [POPBasicAnimation animation];
    }
    return self;
}

-(void)saveValues{
    self.countAnimation.fromValue = @(self.fromValue);
    self.countAnimation.toValue   = @(self.toValue);
    self.countAnimation.duration  = (self.duration<=0?0.4f:self.duration);
    
    if (self.timingFunction) {
        self.countAnimation.timingFunction = self.timingFunction;
    }
}

-(void)startAnimation{
    if (self.delegate && [self.delegate respondsToSelector:@selector(POPNumberAnimationWithCurrentValue:animation:)]) {
        
        __weak PopNumberAnimation *weakSelf = self;
        
        //将计算出来的值通过writeBlock动态传给控件设定
        self.countAnimation.property = \
        [POPMutableAnimatableProperty propertyWithName:@"countAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.writeBlock = ^(id obj, const CGFloat values[]){
                
                [weakSelf.delegate POPNumberAnimationWithCurrentValue:values[0] animation:weakSelf];
            };
        }];
        
        //添加动画
        [self pop_addAnimation:self.countAnimation forKey:nil];
    }
}

-(void)stopAnimation{
    
    [self pop_removeAllAnimations];
}

@end
