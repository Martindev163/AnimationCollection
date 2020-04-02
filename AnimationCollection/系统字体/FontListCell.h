//
//  FontListCell.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListCell : UITableViewCell


@property (nonatomic, weak) id data;


- (void)setupCell;

//加载内容，通过subclass重写
-(void)loadContent;

@end
