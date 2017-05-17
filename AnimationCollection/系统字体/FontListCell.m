//
//  FontListCell.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "FontListCell.h"

@interface FontListCell ()

@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation FontListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
        [self buildSubView];
    }
    return self;
}

-(void)setupCell{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)buildSubView{
    self.fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth - 20, 40)];
    [self addSubview:self.fontLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(void)loadContent{
    
    NSString *fontName = self.data;
    
    self.fontLabel.text = fontName;
    
    self.fontLabel.font = [UIFont fontWithName:fontName size:14.f];
}

-(void)buttonEvent{
    NSLog(@"%@",self.data);
}

@end
