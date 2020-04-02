//
//  MHZProgressHUD.h
//  AnimationCollection
//
//  Created by MaHaoZhe on 2020/4/1.
//  Copyright © 2020 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MHZProgressHUD : NSObject

/// 连环画式 loading 默认加在window上
/// @param imgs 图集（imageName）
+(void)showHUDWithImages:(NSArray<NSString *> *)imgs;


/// 连环画式 loading
/// @param view 指定视图
/// @param imgs 图集（imageName）
+(void)showHUDAddTo:(UIView *)view WithImages:(NSArray<NSString *> *)imgs;


/// 从window上移除HUD
+(void)hideHUDForWindow;


/// 隐藏HUD
/// @param view 被移除HUD的view
+(void)hideHUDForView:(UIView *)view;


/// 菊花Loading (默认添加在window上)
+(void)showLoading;


/// 显示loading 并在指定时间后隐藏
/// @param delay 延迟时间
+(void)showLoadingHideAfterDelay:(NSTimeInterval)delay;


/// 菊花Loading
/// @param view 需要添加HUD到的view上
+(void)showLoadingAddToView:(UIView *)view;


/// 显示loading 并在指定时间后隐藏
/// @param delay 延迟时间
+(void)showLoadingAddToView:(UIView *)view HideAfterDelay:(NSTimeInterval)delay;


/// 菊花Loading (默认添加在window上)
+(void)showLoading_Light;


/// 菊花Loading
/// @param view 需要添加HUD到的view上
+(void)showLoading_LightAddToView:(UIView *)view;


/// 文本tost
/// @param message 显示的内容
+(void)showMessage:(NSString *)message;


/// 文本tost
/// @param view 需要添加HUD的View
/// @param message 显示的内容
+(void)showMessageToView:(UIView *)view message:(NSString *)message;


/// 文本tost
/// @param view 需要添加HUD的View
/// @param message 显示的内容
/// @param delay 延迟消失
+(void)showMessageToView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay;


/// 文本tost
/// @param message 显示的内容
+(void)showMessage_Light:(NSString *)message;


/// 文本tost
/// @param message 显示的内容
/// @param delay 延迟消失
+(void)showMessage_Light:(NSString *)message afterDelay:(NSTimeInterval)delay;


/// 文本tost
/// @param view 需要添加HUD的View
/// @param message 显示的内容
+(void)showMessage_LightToView:(UIView *)view message:(NSString *)message;


/// 文本tost
/// @param view 需要添加HUD的View
/// @param message 显示的内容
/// @param delay 延迟消失
+(void)showMessage_LightToView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
