//
//  FontInfomation.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "FontInfomation.h"

static NSMutableDictionary *_systemFontDictionary = nil;//系统字体信息

@implementation FontInfomation

+(void)initialize {
    if (self == [FontInfomation class]) {
        _systemFontDictionary = [[NSMutableDictionary alloc] init];
        
        //获取系统字体族
        [FontInfomation getSystemFontList];
    }
}

+(void)getSystemFontList{
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames) {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [_systemFontDictionary setObject:fontNames forKey:familyName];
    }
}

+(NSDictionary *)systemFontNameList{
    
    return [NSDictionary dictionaryWithDictionary:_systemFontDictionary];
}

@end
