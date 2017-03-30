//
//  CAEmitterLayerView.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/30.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAEmitterLayerView : UIView


/**
 模拟set 、 get 方法
 */
-(void)setEmitterLayer:(CAEmitterLayer *)emitterLayer;

-(CAEmitterLayer *)emitterLayer;


/**
 显示view
 */
-(void)show;

/**
 隐藏view
 */
-(void)hide;

@end
