//
//  CAEmitterLayerView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/30.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "CAEmitterLayerView.h"


@interface CAEmitterLayerView (){
    
    CAEmitterLayer *_emitterLayer;
    
}

@end

@implementation CAEmitterLayerView

+(Class)layerClass{
    return [CAEmitterLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _emitterLayer = (CAEmitterLayer *)self.layer;
    }
    return self;
}

-(void)setEmitterLayer:(CAEmitterLayer *)emitterLayer{
    _emitterLayer = emitterLayer;
}

-(CAEmitterLayer *)emitterLayer{
    return _emitterLayer;
}

-(void)show{
    
}

-(void)hide{
    
}

@end
