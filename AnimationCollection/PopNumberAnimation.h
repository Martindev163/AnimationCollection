//
//  PopNumberAnimation.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/11.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PopNumberAnimation;

@protocol POPNumberAnimationDelegate <NSObject>

@required
/**
 当执行开始动画，该代理方法将获取当前值
 */
-(void)POPNumberAnimationWithCurrentValue:(CGFloat)currentValue animation:(PopNumberAnimation *)popAnimation;

@end

@interface PopNumberAnimation : NSObject

@property (nonatomic, weak) id<POPNumberAnimationDelegate> delegate;

@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;
@property (nonatomic, assign) CGFloat currentValue;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

//当设置所有属性后，需要保存该配置的动画效果
-(void)saveValues;

//开始动画
-(void)startAnimation;

//停止动画
-(void)stopAnimation;

@end
