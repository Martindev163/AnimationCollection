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
    UIVisualEffectView *effectView = [hud.bezelView valueForKey:@"effectView"];
    effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView.contentView.backgroundColor = [UIColor blackColor];
    
    hud.customView = imgView;
    hud.square = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hideAnimated:YES afterDelay:3.f];
}

+(void)showHUDWithImages:(NSArray *)imgs{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showHUDAddTo:window WithImages:imgs];
}

@end
