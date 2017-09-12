//
//  PurchaseSearchViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/9/12.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "PurchaseSearchViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "PurchaseModel.h"
#import "PurchaseTableViewCell.h"

@interface PurchaseSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 表 */
@property (nonatomic, strong) UITableView * tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@end

@implementation PurchaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubviews];
}

#pragma 表格相关
- (void)setupSubviews
{

    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadWithName:@""];
    }];
    /** 每次加载先刷新数据 */
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 数据请求
- (void)loadWithName:(NSString *)name;
{
    //内网ip：192.168.1.70
    //外网ip：124.207.212.87
    //http://192.168.1.236:9000/transfer-manager-web/app/drugStoresPurchasePlan/purchaseSelectionList.do
    
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/purchaseSelectionList";
//    json={
//        "currentPage": "1",
//        "officeId": "95ce99bda3cd4309b0b114d05ffda55c",
//        "pageSize": "2",
//        "passWord": "test1234",
//        "userName": "majp01",
//        "code": "",
//        "medicalname": "",
//        "productname": "",
//        "factoryname": "",
//        "medicalmode": "",
//        "packageSpec": "",
//        "medicalspec": "",
//        "metricname": ""
//    }
    NSDictionary *params = @{
                             @"currentPage": @"1",
                             @"officeId": @"95ce99bda3cd4309b0b114d05ffda55c",
                             @"pageSize": @"10",
                             @"passWord": @"test1234",
                             @"userName": @"majp01",
                             @"code": @"",
                             @"medicalname": @"",
                             @"productname": @"",
                             @"factoryname": @"",
                             @"medicalmode": @"",
                             @"packageSpec": @"",
                             @"medicalspec": @"",
                             @"metricname": @""
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [PurchaseModel mj_objectArrayWithKeyValuesArray:data];
//        NSLog(@"self.responseObject= %@",responseObject);
        NSLog(@"self.data= %@",data);
        NSLog(@"self.resultArray = %@",self.resultArray);
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /** 搜索前全查 */
    /** 创建cell */
    PurchaseTableViewCell * cell = [PurchaseTableViewCell actcellWithactPurchaseModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    PurchaseModel * model = self.resultArray[indexPath.row];
    cell.ActPurchaseModel = model;
    
    return cell;
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        _tableView.rowHeight = 160;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = self.view.backgroundColor;
//        _tableView.separatorColor = NavColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
