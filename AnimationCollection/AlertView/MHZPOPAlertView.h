//
//  MHZPOPAlertView.h
//  POPDemo
//
//  Created by MaHaoZhe on 2020/3/31.
//  Copyright © 2020 HachiTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SpringTopToCenterType,//自上而下
    SpringBottomToCenterType,//自下而上
    SpringCenterBouncinesType,//原地弹动
} MHZPOPAlertViewAnimationType;

NS_ASSUME_NONNULL_BEGIN

typedef void(^cancelBlock)(void);
typedef void(^otherBlaock)(NSInteger index);

@interface MHZPOPAlertView : UIView

@property (nonatomic, assign) MHZPOPAlertViewAnimationType animationType;


-(instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelBlock:(cancelBlock)cancel otherBlock:(otherBlaock)other cancelButtenTitle:(nullable NSString *)cancelTitle otherButtonTitle:(nullable NSString *)otherTitle, ... NS_REQUIRES_NIL_TERMINATION;

-(void)showAlert:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
