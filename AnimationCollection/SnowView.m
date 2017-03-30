//
//  SnowView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/30.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "SnowView.h"

@implementation SnowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadPropretys];
        
    }
    return self;
}

-(void)loadPropretys
{
    self.emitterLayer.masksToBounds   = YES;
    self.emitterLayer.emitterShape    = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode     = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize     = self.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width/2.f, -20);
}

-(void)show
{
    //配置
    CAEmitterCell *snowFlake = [CAEmitterCell emitterCell];
    snowFlake.birthRate = 1.f;
    snowFlake.speed     = 10.f;
    snowFlake.velocity  = 2.f;
    snowFlake.velocityRange = 10.f;
    snowFlake.yAcceleration = 20.f;
    snowFlake.emissionRange = 0.5*M_PI;
    snowFlake.spinRange     = 0.25*M_PI;
    snowFlake.contents      = (__bridge id)([UIImage imageNamed:@"snowIcon"].CGImage);
    snowFlake.color         = [UIColor redColor].CGColor;
    snowFlake.lifetime      = 60.f;
    snowFlake.scale         = 0.5f;
    snowFlake.scaleRange    = 0.3f;
    
    //添加动画
    self.emitterLayer.emitterCells = @[snowFlake];
}

@end
