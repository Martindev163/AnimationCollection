//
//  FontInfomation.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FontInfomation : NSObject

/**
 * 系统字体信息
 *
 * 返回系统字体的字典信息
 */

+(NSDictionary *)systemFontNameList;

@end
