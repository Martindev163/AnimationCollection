//
//  BlurDownloadView.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/22.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurDownloadView : UIView

@property (nonatomic, copy) NSString *pictureUrlStr;

@property (nonatomic)       UIViewContentMode contentMode;

-(void)startProgress;

@end
