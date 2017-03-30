//
//  RunView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/30.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "RunView.h"

@implementation RunView

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
    CAEmitterCell *runFlake = [CAEmitterCell emitterCell];
    runFlake.birthRate     = 20.f;
    runFlake.speed         = 10.f;
    runFlake.velocity      = 10.f;
    runFlake.velocityRange = 10.f;
    runFlake.yAcceleration = 1000.f;
    //snowFlake.emissionRange = 0.5*M_PI;
    //snowFlake.spinRange     = 0.25*M_PI;
    runFlake.contents      = (__bridge id)([UIImage imageNamed:@"runIcon"].CGImage);
    runFlake.color         = [UIColor blackColor].CGColor;
    runFlake.lifetime      = 7.f;
    runFlake.scale         = 0.2f;
    runFlake.scaleRange    = 0.f;
    
    //添加动画
    self.emitterLayer.emitterCells = @[runFlake];
}

@end
