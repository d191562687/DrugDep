//
//  StatisticsViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/8/10.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "StatisticsViewController.h"
#import "HomeTableViewCell.h"

#import "AStatisticsViewController.h"
#import "BStatisticsViewController.h"
#import "CStatisticsViewController.h"


@interface StatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) NSArray * array;


@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送统计";
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    
    self.array = @[@[@"配送信息列表",@"配送信息统计对比",@"配送信息年对比图"]];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array[section]count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell * cell = [HomeTableViewCell sharedHomeTableViewCell:tableView];
    //icon 图片
    NSArray * iconArr = @[@[@"过度页-icon1",@"过度页-icon2",@"过度页-icon3"]];
    cell.imageV.image = [UIImage imageNamed:iconArr[indexPath.section][indexPath.row]];
    cell.label.text = self.array[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //分页面跳转
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //配送信息列表
            AStatisticsViewController * AStatisticsVC = [[AStatisticsViewController alloc]init];
            [self
             .navigationController pushViewController:AStatisticsVC animated:YES];
            
        }else if (indexPath.row == 1)
        {
            //配送信息统计对比
            BStatisticsViewController * BStatisticsVC = [[BStatisticsViewController alloc]init];
            [self
             .navigationController pushViewController:BStatisticsVC animated:YES];
 
            
        }else if (indexPath.row == 2)
        {
            //配送信息年对比图
            CStatisticsViewController * CStatisticsVC = [[CStatisticsViewController alloc]init];
            [self
             .navigationController pushViewController:CStatisticsVC animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [UIView new];
    foot.backgroundColor = [UIColor clearColor];
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 52;
        _tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    }
    return  _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

@end
