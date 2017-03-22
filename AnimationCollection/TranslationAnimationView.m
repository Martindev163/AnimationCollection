//
//  TranslationAnimationView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "TranslationAnimationView.h"

@interface TranslationAnimationView ()

@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) CGRect middleRect;
@property (nonatomic, assign) CGRect endRect;

@end

@implementation TranslationAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.alpha = 0.f;
    }
    return self;
}

- (void)showAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation{
    if (animation == YES) {
        [UIView animateWithDuration:time animations:^{
            self.frame = _middleRect;
            self.alpha = 1.f;
        }];
    }else{
        self.frame = _middleRect;
        self.alpha = 1.f;
    }
}

- (void)hideAniamtionWithDurition:(NSInteger)time animation:(BOOL)animation{
    if (animation == YES) {
        [UIView animateWithDuration:time animations:^{
            self.frame = _endRect;
            self.alpha = 0.f;
        }];
    }else{
        self.frame = _endRect;
        self.alpha = 0.f;
    }
}

- (void)buildView{
    
    self.startRect = self.frame;
    self.middleRect = CGRectMake(self.frame.origin.x + self.offsetX,
                                 self.frame.origin.y,
                                 self.frame.size.width,
                                 self.frame.size.height);
    self.endRect = CGRectMake(self.frame.origin.x + self.offsetX * 2,
                              self.frame.origin.y,
                              self.frame.size.width,
                              self.frame.size.height);
}
- (void)percent{
    
}


@end
