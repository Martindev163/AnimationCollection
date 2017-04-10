//
//  MaskVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/1.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "MaskVC.h"

@interface MaskVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) CALayer *moveMask;

@end

@implementation MaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageV.image = [UIImage imageNamed:@"myImage"];
    _imageV.userInteractionEnabled = YES;
    [self.view addSubview:_imageV];
    
    
    //形成遮罩
    UIImage *image     = [UIImage imageNamed:@"maskImg"];
    _moveMask          = [CALayer layer];
    _moveMask.frame    = (CGRect){CGPointZero, image.size};
    _moveMask.contents = (__bridge id)(image.CGImage);
    _moveMask.position = self.view.center;
    _imageV.layer.mask = _moveMask;
    
    
    //拖拽的view
    UIView *drageView = [[UIView alloc]initWithFrame:(CGRect){CGPointZero, image.size}];
    drageView.center = self.view.center;
    [self.view addSubview:drageView];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
    pan.delegate = self;
    [drageView addGestureRecognizer:pan];
    
}

-(void)panEvent:(UIPanGestureRecognizer *)recognizer{
    // 拖拽
    CGPoint translation    = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    // 关闭CoreAnimation实时动画绘制(核心)
    [CATransaction setDisableActions:YES];
    _moveMask.position = recognizer.view.center;
}
@end
