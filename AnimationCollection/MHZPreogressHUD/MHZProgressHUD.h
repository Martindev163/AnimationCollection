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



@end

NS_ASSUME_NONNULL_END
