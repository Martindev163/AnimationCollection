//
//  FontListHeaderView.h
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "CustomHeaderFooterView.h"

@interface FontListHeaderView : CustomHeaderFooterView

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, weak) id data;


-(void)setupHeaderFooterView;

-(void)buildSubView;

-(void)loadContent;

@end
