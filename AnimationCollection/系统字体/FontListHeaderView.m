//
//  FontListHeaderView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "FontListHeaderView.h"
#import "FontInfoModel.h"

@interface FontListHeaderView ()

@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation FontListHeaderView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        
        [self buildSubView];
        
    }
    
    return self;
}


-(void)setupHeaderFooterView{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)buildSubView{
    
    self.fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth - 10, 40)];
    [self addSubview:self.fontLabel];
    
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 2, 20)];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
    }
    
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5f, kDeviceWidth, 0.5f)];
        lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1f];
        [self addSubview:lineView];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(void)loadContent{
    FontInfoModel *model = self.data;
    
    self.fontLabel.text = model.fontFamilyName;
    self.fontLabel.font = [UIFont fontWithName:model.fontFamilyName size:14.f];
}

-(void)buttonEvent{
    
    FontInfoModel *model = self.data;
    NSLog(@"Font Family Name : %@",model.fontFamilyName);
}

@end
