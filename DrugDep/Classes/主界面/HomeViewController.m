//
//  HomeViewController.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
//分页面
#import "FrontViewController.h"
#import "TrackViewController.h"
#import "PurchaseViewTextController.h"
#import "UpDownViewController.h"
#import "EveryDayViewController.h"
#import "StatisticsViewController.h"
#import "AddListTextViewController.h"
#import "StockViewControllerTextViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) NSArray * array;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"丰台区医疗机构药械调配平台";
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    
//    [self showEmptyViewWithMessage:[NSString stringWithFormat:@"检测用户信息是否保存\r  .userModel.name = %@",userModel.name]];
  
    self.array = @[@[@"实时追踪",@"前置库库存查询",@"药房上下限补货",@"药房补货列表"],@[@"配送商库存查询",@"药品采购目录遴选"],@[@"药房日均量补货",@"配送统计信息查看"]];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array[section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell * cell = [HomeTableViewCell sharedHomeTableViewCell:tableView];
    //icon 图片
    NSArray * iconArr = @[@[@"过度页-icon1",@"过度页-icon2",@"过度页-icon3",@"过度页-icon3"],@[@"过度页-icon4",@"过度页-icon5"],@[@"过度页-icon6",@"过度页-icon7"]];
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
            //实时追踪
            TrackViewController * TrackVC = [[TrackViewController alloc]init];
            [self
             .navigationController pushViewController:TrackVC animated:YES];

                   }else if (indexPath.row == 1)
        {
            //前置库库存查询
            FrontViewController * FrontVC = [[FrontViewController alloc]init];
            [self
             .navigationController pushViewController:FrontVC animated:YES];
            

            
        }else if (indexPath.row == 2)
        {
            //药房上下限补货
            UpDownViewController * UpDownVC = [[UpDownViewController alloc]init];
            [self
             .navigationController pushViewController:UpDownVC animated:YES];
           
            
            
        }else if (indexPath.row == 3)
        {
            //药房补货列表
            AddListTextViewController * addListVC = [[AddListTextViewController alloc]init];
            [self
             .navigationController pushViewController:addListVC animated:YES];
            
            
            
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            //配送商库存查询
            StockViewControllerTextViewController * StockVC = [[StockViewControllerTextViewController alloc]init];
            [self
             .navigationController pushViewController:StockVC animated:YES];
            
        }else if (indexPath.row == 1)
        {
            //药品采购目录遴选
            PurchaseViewTextController * PurchaseVC = [[PurchaseViewTextController alloc]init];
            [self
             .navigationController pushViewController:PurchaseVC animated:YES];
            
            
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            //药房日均量补货
            EveryDayViewController * EveryDayVC = [[EveryDayViewController alloc]init];
            [self
             .navigationController pushViewController:EveryDayVC animated:YES];

            
        }else if (indexPath.row == 1)
        {
            //配送统计信息查看
            StatisticsViewController * StatisticsVC = [[StatisticsViewController alloc]init];
            [self
             .navigationController pushViewController:StatisticsVC animated:YES];
            
            
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
