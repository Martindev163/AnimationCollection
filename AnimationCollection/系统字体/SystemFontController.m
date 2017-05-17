//
//  SystemFontController.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/5/17.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "SystemFontController.h"
#import "FontInfoModel.h"
#import "FontInfomation.h"
#import "FontListCell.h"
#import "FontListHeaderView.h"

@interface SystemFontController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *fontsList;

@end

@implementation SystemFontController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


-(void)setup{
    //设置UI从导航栏下边开始
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *fontListDictionary = [FontInfomation systemFontNameList];
    
    NSMutableArray *fontList = [NSMutableArray array];
    
    [fontListDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        FontInfoModel *tempModel = [FontInfoModel new];
        tempModel.fontFamilyName = key;
        tempModel.fontNames = obj;
        
        [fontList addObject:tempModel];
    }];
    
    self.fontsList = fontList;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 40;
    self.tableView.sectionHeaderHeight = 40;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[FontListCell class] forCellReuseIdentifier:@"FontListCell"];
    [self.tableView registerClass:[FontListHeaderView class] forHeaderFooterViewReuseIdentifier:@"FontListHeaderView"];
    
}


#pragma mark - tableview delegate / datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fontsList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FontInfoModel *model = self.fontsList[section];
    return model.fontNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FontInfoModel *model = self.fontsList[indexPath.section];
    
    FontListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontListCell"];
    cell.data = model.fontNames[indexPath.row];
    [cell loadContent];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FontInfoModel *model = self.fontsList[section];
    
    FontListHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FontListHeaderView"];
    titleView.data = model;
    titleView.section = section;
    [titleView loadContent];
    return titleView;
}


@end
