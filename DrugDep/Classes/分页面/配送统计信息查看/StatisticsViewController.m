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
//扫码
#import "HMScannerController.h"
#import "ScanListViewController.h"
#import "PasswordView.h"

@interface StatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    PasswordView *passView;
}

@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) NSArray * array;
//扫码
@property (weak, nonatomic) UILabel *scanResultLabel;

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    //self.title = @"HIS查询";

}

- (void)setupSubViews
{
    
    self.array = @[@[@"扫码查询",@"助记码查询",@"配送差异表"]];
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
//            AStatisticsViewController * AStatisticsVC = [[AStatisticsViewController alloc]init];
//            [self
//             .navigationController pushViewController:AStatisticsVC animated:YES];
            
            NSString *cardName = @"";
            UIImage *avatar = [UIImage imageNamed:@"avatar"];
            
            HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
                
//                self.scanResultLabel.text = stringValue;
//                NSLog(@"--  %@ --",stringValue);
                //存储
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:stringValue forKey:@"number"];
                
                BStatisticsViewController * BStatisticsVC = [[BStatisticsViewController alloc]init];
                [self
                 .navigationController pushViewController:BStatisticsVC animated:YES];
                
            }];
            
            [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
            
            [self showDetailViewController:scanner sender:nil];
            
        }else if (indexPath.row == 1)
        {
            passView = [[PasswordView alloc] initWithTitle:@"助记码查询" cancelBtn:@"取消" sureBtn:@"确定" btnClickBlock:^(NSInteger index,NSString *str) {
                if (index == 0) {
                    NSLog(@"0000000");
                }else if (index == 1){
                    NSLog(@"111111");
                    NSLog(@"^^^^^%@",str);
                    //存储
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:str forKey:@"number"];
                    //
                    BStatisticsViewController * BStatisticsVC = [[BStatisticsViewController alloc]init];
                    [self
                     .navigationController pushViewController:BStatisticsVC animated:YES];

                }
                
            }];
            [passView show];


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
