//
//  MHZProgressHUD.m
//  AnimationCollection
//
//  Created by MaHaoZhe on 2020/4/1.
//  Copyright © 2020 junanxin. All rights reserved.
//

#import "MHZProgressHUD.h"
#import "MBProgressHUD.h"

@implementation MHZProgressHUD

+(void)showHUDAddTo:(UIView *)view WithImages:(NSArray *)imgs{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置图片动画
    UIImage *image = [[UIImage imageNamed:imgs[0]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (NSString *imgName in imgs) {
        [tempArr addObject:[UIImage imageNamed:imgName]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.animationImages = tempArr;
    [imgView setAnimationDuration:0.5f];
    [imgView setAnimationRepeatCount:0];
    [imgView startAnimating];
    
    //背景色设置为 黑色 模式
//    UIVisualEffectView *effectView = [hud.bezelView valueForKey:@"effectView"];
//    effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    effectView.contentView.backgroundColor = [UIColor blackColor];
    
    hud.customView = imgView;
    hud.square = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hideAnimated:YES afterDelay:3.f];
}


+(void)showHUDWithImages:(NSArray *)imgs{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showHUDAddTo:window WithImages:imgs];
}


+(void)hideHUDForWindow{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}


+(void)hideHUDForView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)showLoading{
    
    [self showHUDToView:nil message:nil isDark:YES hideAfterDelay:-1];
}

+(void)showLoadingHideAfterDelay:(NSTimeInterval)delay{
    [self showHUDToView:nil message:nil isDark:YES hideAfterDelay:delay];
}


+(void)showLoadingAddToView:(UIView *)view HideAfterDelay:(NSTimeInterval)delay{
    [self showHUDToView:view message:nil isDark:YES hideAfterDelay:delay];
}


+(void)showLoading_Light{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}


+(void)showLoadingAddToView:(UIView *)view{
    
    [self showHUDToView:view message:nil isDark:YES hideAfterDelay:-1];
}


+(void)showLoading_LightAddToView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}


+(void)showMessage:(NSString *)message{
    
    [self showHUDToView:nil message:message isDark:YES hideAfterDelay:-1];
}


+(void)showMessageToView:(UIView *)view message:(NSString *)message{
    
    [self showHUDToView:view message:message isDark:YES hideAfterDelay:-1];
}

+(void)showMessageToView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay{
    [self showHUDToView:view message:message isDark:YES hideAfterDelay:delay];
}


+(void)showMessage_Light:(NSString *)message{
    
    [self showHUDToView:nil message:message isDark:NO hideAfterDelay:-1];
}


+(void)showMessage_Light:(NSString *)message afterDelay:(NSTimeInterval)delay{
    
    [self showHUDToView:nil message:message isDark:NO hideAfterDelay:delay];
    
}


+(void)showMessage_LightToView:(UIView *)view message:(NSString *)message{
    
    [self showHUDToView:view message:message isDark:NO hideAfterDelay:-1];
}


+(void)showMessage_LightToView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay{
    [self showHUDToView:view message:message isDark:NO hideAfterDelay:delay];
}


+(void)showHUDToView:(nullable UIView *)view message:(nullable NSString *)message isDark:(BOOL)isDark hideAfterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud ;
    if (view) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }else{
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    if (message && message.length > 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
    }
    
    if (isDark == YES) {
        //背景色设置为 黑色 模式
        UIVisualEffectView *effectView = [hud.bezelView valueForKey:@"effectView"];
        effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIActivityIndicatorView *indicator ;
        for (UIView *view in hud.bezelView.subviews) {
            if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                indicator = (UIActivityIndicatorView *)view;
            }
        }
        indicator.color = [UIColor whiteColor];
    }
    
    if (delay > -1) {
        [hud hideAnimated:YES afterDelay:delay];
    }
    
}
@end
