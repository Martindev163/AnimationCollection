//
//  MHZAnimationHeader.m
//  AnimationCollection
//
//  Created by MaHaoZhe on 2020/4/2.
//  Copyright © 2020 junanxin. All rights reserved.
//

#import "MHZAnimationHeader.h"

@interface MHZAnimationHeader ()

@property (nonatomic, strong) UILabel *label;//文字标签
@property (nonatomic, strong) UIImageView *imageView;//动画载体

@property (nonatomic, assign) BOOL isEnd;//是否是完成刷新

@end


@implementation MHZAnimationHeader

//MARK: 重写方法
//MARK: 在这里做一些初始化配置（比如添加子控件）
-(void)prepare{
    [super prepare];
    
    //设置控件高度
    self.mj_h = 70;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.f];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // imageview
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i=0; i<24; i++) {
        [tempArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"lite_loading_%i",i+1]]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lite_loading_1"]];
    imageView.animationImages = tempArr;
    [imageView setAnimationDuration:0.5f];
    [imageView setAnimationRepeatCount:0];
    [imageView startAnimating];
    [self addSubview:imageView];
    self.imageView = imageView;
}


//MARK: 刷新结束
-(void)endRefreshing{
    [super endRefreshing];
    _isEnd = YES;
}



//MARK: 在这里设置子控件的位置和尺寸
-(void)placeSubviews{
    [super placeSubviews];
    self.label.frame = CGRectMake(0, 40, self.mj_w, 30);
    self.imageView.bounds = CGRectMake(0, 0, 30, 30);
    self.imageView.center = CGPointMake(self.mj_w * 0.5, 25);
}


//MARK: 监听ScrollView的contentOffset改变
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.scrollView.contentOffset.y == 0) {
        NSLog(@"ok");
        self.label.text = @"下拉刷新";
    }
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
            if (_isEnd) {
                //加载完成，提示刷新完成
                self.label.text = @"刷新完成";
                NSLog(@"1111111");
            }else{
                //提示下拉
                self.label.text = @"下拉刷新";
                NSLog(@"2222222");
            }
        }
            break;
        case MJRefreshStatePulling:
        {
            //提示放开
            self.label.text = @"松手刷新";
        }
            break;
        case MJRefreshStateRefreshing:
        {
            //放开后的提示
            self.label.text = @"正在刷新";
        }
            break;
        default:
            break;
    }
}


//MARK: 监听拖拽比例（控件被拖出来的比例）
-(void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    
//    if (self.isRefreshing == YES) {
//        _isEnd = NO;
//    }else{
//        NSLog(@"%f",pullingPercent);
//        _isEnd = YES;
//    }
}

@end
