//
//  UpDownViewController.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/29.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "UpDownViewController.h"
#import "UpdownHeadView.h"
#import "HomeTableViewCell.h"
#import "UpDownSearchViewController.h"

#import "HomeTableViewCell.h"
#import "FrontViewController.h"
#import "TrackViewController.h"
#import "PurchaseViewTextController.h"
#import "UpDownViewController.h"
#import "EveryDayViewController.h"
#import "StatisticsViewController.h"
#import "StockViewControllerTextViewController.h"

@interface UpDownViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (copy,nonatomic) NSArray *array;

@property (strong,nonatomic) UpdownHeadView *headView;


@end

@implementation UpDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药房库存补货添加";
    [self setupSubViews];
}

- (void)setupSubViews
{
    
    self.array = @[@[@"过度页-icon1",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon3",@"过度页-icon3"],@[@"药房日均量补货",@"配送统计信息查看"]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.headView = [[UpdownHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.60)];
    __weak typeof(self) weakSelf = self;
    self.headView.SelectBlock = ^(ButtonClickType clickType) {
      // 点击事件的回调
        if (clickType == AddClickType) {
            [MBProgressHUD showSuccess:@"新增"];
            UpDownSearchViewController * upDownSearchVC = [[UpDownSearchViewController alloc]init];
            [weakSelf.navigationController pushViewController:upDownSearchVC animated:YES];
            
        }else if (clickType == SaveClickType){
            // 保存
            [MBProgressHUD showSuccess:@"save"];
        }else if (clickType == TijiaoClickType){
            // 提交
            [MBProgressHUD showSuccess:@"提交"];
        }else if (clickType == CancleClickType){
            // 取消
            [MBProgressHUD showSuccess:@"取消"];
        }
    };
    _headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * iconArr = @[@[@"过度页-icon1",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon2",@"过度页-icon3",@"过度页-icon3"],@[@"过度页-icon6",@"过度页-icon7"]];
    
    HomeTableViewCell *cell = [HomeTableViewCell sharedHomeTableViewCell:tableView];
    cell.imageV.image = [UIImage imageNamed:iconArr[indexPath.section][indexPath.row]];
    cell.label.text = self.array[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            //药房上下限补货
            UpDownViewController * UpDownVC = [[UpDownViewController alloc]init];
            [self
             .navigationController pushViewController:UpDownVC animated:YES];
            
            
            
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}





@end
