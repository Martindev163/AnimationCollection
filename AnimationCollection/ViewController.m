//
//  ViewController.m
//  AnimationCollection
//
//  Created by 马浩哲 on 16/11/16.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ViewController.h"
#import "CircleLoadingAnimation.h"
#import "WaterRippleLoadingAnimation.h"
#import "LearnAnimationVC.h"
#import "ImageHandleVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray *itemArrays;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画收集";
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}

-(NSArray *)itemArrays
{
    if (_itemArrays == nil) {
        _itemArrays = [[NSArray alloc] init];
        _itemArrays = @[@"加载动画",@"水纹动画",@"学习动画",@"图片模糊处理",@"未知",@"未知",@"未知",@"未知",@"未知",@"未知"];
    }
    return _itemArrays;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArrays.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _itemArrays[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CircleLoadingAnimation *lodingVC = [[CircleLoadingAnimation alloc] init];
        [self.navigationController pushViewController:lodingVC animated:YES];
    }else if (indexPath.row == 1){
        WaterRippleLoadingAnimation *waterVC = [[WaterRippleLoadingAnimation alloc] init];
        [self.navigationController pushViewController:waterVC animated:YES];
    }else if (indexPath.row == 2){
        LearnAnimationVC *learnVC = [[LearnAnimationVC alloc] init];
        [self.navigationController pushViewController:learnVC animated:YES];
    }else if (indexPath.row == 3){
        ImageHandleVC *imagVC = [[ImageHandleVC alloc] init];
        [self.navigationController pushViewController:imagVC animated:YES];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}



@end
