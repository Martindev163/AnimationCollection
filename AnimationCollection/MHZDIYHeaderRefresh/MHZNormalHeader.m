//
//  MHZNormalHeader.m
//  AnimationCollection
//
//  Created by MaHaoZhe on 2020/4/2.
//  Copyright © 2020 junanxin. All rights reserved.
//

#import "MHZNormalHeader.h"

@interface MHZNormalHeader ()

@property (nonatomic, strong) UILabel *label;//文本标签

@property (nonatomic, strong) UIActivityIndicatorView *loading;//活动指示器

@end

@implementation MHZNormalHeader

//MARK: 重写方法
//MARK: 在这里做一些初始化配置（比如添加子控件）
-(void)prepare{
    [super prepare];
    
    //设置控件高度
    self.mj_h = 50;
    
    //添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.f];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //添加loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}


//MARK: 在这里设置子控件的位置和尺寸
-(void)placeSubviews{
    [super placeSubviews];
    self.label.frame = self.bounds;
    self.loading.center = CGPointMake(self.mj_w/2 - 60, self.mj_h * 0.5);
}


//MARK: 监听ScrollView的contentOffset改变
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
}

//MARK: 监听scrollView的contentSize改变
-(void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
}

//MARK: 监听scrollView的拖拽状态改变
-(void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
}

//MARK: 监听控件刷新状态
-(void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
        {
            //提示下拉
            [self.loading stopAnimating];
            self.label.text = @"下拉可以刷新";
        }
            break;
        case MJRefreshStatePulling:
        {
            //提示放开
            self.label.text = @"释放立即刷新";
        }
            break;
        case MJRefreshStateRefreshing:
        {
            //放开后的提示
            self.label.text = @"正在刷新...";
            [self.loading startAnimating];
        }
            break;
        default:
            break;
    }
}


//MARK: 监听拖拽比例（控件被拖出来的比例）
-(void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    
    
}

@end
