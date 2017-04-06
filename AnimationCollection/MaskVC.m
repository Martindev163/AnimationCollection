//
//  MaskVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/1.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "MaskVC.h"

@interface MaskVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *maskLayer;


@property (nonatomic, strong) UIImageView *imageV;


@property (nonatomic, strong) CALayer *mask;
@end

@implementation MaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageV.image = [UIImage imageNamed:@"myImage"];
    _imageV.userInteractionEnabled = YES;
    [self.view addSubview:_imageV];
    
    self.maskLayer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    self.maskLayer.image = [UIImage imageNamed:@"maskImg"];
    self.maskLayer.backgroundColor = [UIColor clearColor];
    self.maskLayer.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
    pan.delegate = self;
    [self.maskLayer addGestureRecognizer:pan];
    
    [self.view addSubview:_maskLayer];
    
    
    _mask = [CALayer layer];
    
    _mask.frame = CGRectMake(0, 0, 100, 100);
    
    _mask.contents = (__bridge id)[UIImage imageNamed:@"maskImg"].CGImage;
    
    _imageV.layer.mask = _mask;
    
}

-(void)panEvent:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:self.maskLayer];
    
    CGFloat x = pan.view.center.x + point.x;
    CGFloat y = pan.view.center.y + point.y;
    
    NSLog(@"%@",[NSValue valueWithCGPoint:point]);

//    pan.view.frame = CGRectMake(pan.view.center.x + point.x ,pan.view.center.y + point.y, 100, 100);
    
    pan.view.center =  CGPointMake(x, y);
    
    _mask.frame = CGRectMake(x-50, y-50, 100, 100);
    
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}
@end
