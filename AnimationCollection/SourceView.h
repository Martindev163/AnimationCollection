//
//  SourceView.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SourceView : UIView

@property (nonatomic, assign) CGFloat offsetX;

- (void)showAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation;
- (void)hideAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation;
- (void)buildView;
- (void)percent;

@end
