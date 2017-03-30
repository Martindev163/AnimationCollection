//
//  CAEmitterLayerVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/30.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "CAEmitterLayerVC.h"
#import "CAEmitterLayerView.h"
#import "SnowView.h"
#import "RunView.h"

@interface CAEmitterLayerVC ()

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *maksImag1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    maksImag1.image = [UIImage imageNamed:@"maskImg"];
    
    UIImageView *maksImag2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    maksImag2.image = [UIImage imageNamed:@"maskImg"];
    
    CAEmitterLayerView *snow = [[SnowView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    snow.maskView = maksImag1;
    [self.view addSubview:snow];
    [snow show];
    
    CAEmitterLayerView *run = [[RunView alloc] initWithFrame:CGRectMake(100, 250, 100, 100)];
    run.maskView = maksImag2;
    [self.view addSubview:run];
    [run show];
    
    
    /**
     CAEmitterLayerView *emitterLayerView = [[CAEmitterLayerView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
     NSLog(@"%@",emitterLayerView.class);
     
     //创建emitterLayer
     CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
     
     emitterLayer.frame = CGRectMake(100, 100, 200, 200);
     
     //显示边框
     emitterLayer.borderWidth = 1.f;
     
     //发射点
     emitterLayer.emitterPosition = CGPointMake(0, 0);
     
     //发射模式
     emitterLayer.emitterMode = kCAEmitterLayerSurface;
     
     //发射形状
     emitterLayer.emitterShape = kCAEmitterLayerLine;
     
     
     [self.view.layer addSublayer:emitterLayer];
     
     
     //创建粒子
     CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
     
     //例子生产率
     emitterCell.birthRate = 1.f;
     
     //例子生命周期
     emitterCell.lifetime = 30.f;
     
     //速度值
     emitterCell.velocity = 10;
     
     //速度值的微调 7-13
     emitterCell.velocityRange = 3;
     
     //y轴加速度
     emitterCell.yAcceleration = 2.f;
     
     //发射角度
     emitterCell.emissionRange = 0.5*M_PI;
     
     //设置图片
     emitterCell.contents = (__bridge id)([UIImage imageNamed:@"雪花"].CGImage);
     
     //让emitterLayer与emitterCell产生联系
     emitterLayer.emitterCells = @[emitterCell];
     */
    
}

@end
