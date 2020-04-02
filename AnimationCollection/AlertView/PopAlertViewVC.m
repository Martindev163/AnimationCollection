//
//  PopAlertViewVC.m
//  POPDemo
//
//  Created by MaHaoZhe on 2020/3/31.
//  Copyright © 2020 HachiTech. All rights reserved.
//

#import "PopAlertViewVC.h"
#import "MHZPOPAlertView.h"
#import "Masonry.h"
#import "MHZProgressHUD.h"

@interface PopAlertViewVC ()

@end

@implementation PopAlertViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"AlertView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *tap = [[UIButton alloc] init];
    tap.backgroundColor = [UIColor redColor];
    [tap setTitle:@"从上到下" forState:UIControlStateNormal];
    tap.titleLabel.font = [UIFont systemFontOfSize:14];
    [tap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tap.layer.cornerRadius = 5;
    [tap addTarget:self action:@selector(popAlertViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tap];
    
    [tap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *tap1 = [[UIButton alloc] init];
    tap1.backgroundColor = [UIColor redColor];
    [tap1 setTitle:@"从下到上" forState:UIControlStateNormal];
    tap1.titleLabel.font = [UIFont systemFontOfSize:14];
    [tap1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tap1.layer.cornerRadius = 5;
    [tap1 addTarget:self action:@selector(popAlertViewAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tap1];
    
    [tap1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tap.mas_top).offset(-20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *tap2 = [[UIButton alloc] init];
    tap2.backgroundColor = [UIColor redColor];
    [tap2 setTitle:@"原地不动" forState:UIControlStateNormal];
    tap2.titleLabel.font = [UIFont systemFontOfSize:14];
    [tap2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tap2.layer.cornerRadius = 5;
    [tap2 addTarget:self action:@selector(popAlertViewAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tap2];
    
    [tap2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tap.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
}


-(void)popAlertViewAction{
    MHZPOPAlertView *alertView = [[MHZPOPAlertView alloc] initWithTitle:@"标题" message:@"图像由于其直观感受最强并且体积也比较大，构成了一个视频内容的主要部分。图像采集和编码面临的主要挑战在于：设备兼容性差、延时敏感、卡顿敏感以及各种对图像的处理操作如美颜和水印等" cancelBlock:^{
        NSLog(@"取消");
    } otherBlock:^(NSInteger index) {
        NSLog(@"我点了第 %li 个",(long)index+1);
    } cancelButtenTitle:@"取消" otherButtonTitle:@"第一个",nil];
    
    alertView.animationType = SpringTopToCenterType;
    
    [alertView showAlert:YES];
}


-(void)popAlertViewAction1{
    MHZPOPAlertView *alertView = [[MHZPOPAlertView alloc] initWithTitle:@"标题" message:@"图像由于其直观感受最强并且体积也比较大，构成了一个视频内容的主要部分。图像采集和编码面临的主要挑战在于：设备兼容性差、延时敏感、卡顿敏感以及各种对图像的处理操作如美颜和水印等" cancelBlock:^{
        NSLog(@"取消");
    } otherBlock:^(NSInteger index) {
        NSLog(@"我点了第 %li 个",(long)index+1);
    } cancelButtenTitle:@"确定" otherButtonTitle:nil];
    
    alertView.animationType = SpringBottomToCenterType;
    
    [alertView showAlert:YES];
}

-(void)popAlertViewAction2{
    MHZPOPAlertView *alertView = [[MHZPOPAlertView alloc] initWithTitle:@"标题" message:@"图像由于其直观感受最强并且体积也比较大，构成了一个视频内容的主要部分。图像采集和编码面临的主要挑战在于：设备兼容性差、延时敏感、卡顿敏感以及各种对图像的处理操作如美颜和水印等" cancelBlock:^{
        NSLog(@"取消");
    } otherBlock:^(NSInteger index) {
        NSLog(@"我点了第 %li 个",(long)index+1);
        if (index == 0) {
            [MHZProgressHUD showHUDAddTo:self.navigationController.view WithImages:@[@"lite_loading_1",@"lite_loading_2",@"lite_loading_3",@"lite_loading_4",@"lite_loading_5",@"lite_loading_6",@"lite_loading_7",@"lite_loading_8",@"lite_loading_9",@"lite_loading_10",@"lite_loading_11",@"lite_loading_12",@"lite_loading_13",@"lite_loading_14",@"lite_loading_15",@"lite_loading_16",@"lite_loading_17",@"lite_loading_18",@"lite_loading_19",@"lite_loading_20",@"lite_loading_21",@"lite_loading_22",@"lite_loading_23",@"lite_loading_24"]];
        }
    } cancelButtenTitle:@"取消" otherButtonTitle:@"第一个",@"第二个",@"第三个",@"第四个",nil];
    
    alertView.animationType = SpringCenterBouncinesType;
    
    [alertView showAlert:YES];
}

@end
