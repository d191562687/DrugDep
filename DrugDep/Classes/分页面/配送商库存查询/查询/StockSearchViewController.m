//
//  StockSearchViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/10/23.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "StockSearchViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "UserInfoManager.h"
#import "StockModel.h"
#import "StockTableViewCell.h"


@interface StockSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 表 */
@property (nonatomic, strong) UITableView * tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@property (strong,nonatomic) NSString * pass;
@property (strong,nonatomic) NSString * user;

@end

@implementation StockSearchViewController

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
    
    
    //    json={
    //        "currentPage": "1",
    //        "officeId": "95ce99bda3cd4309b0b114d05ffda55c",
    //        "pageSize": "2",
    //        "passWord": "test1234",
    //        "userName": "majp01",
    //        "jybj": "",
    //        "cpbm": "",
    //        "cpmc": "",
    //        "scqy": "",
    //        "pss": ""
    //    }
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/distributorStockList";
    //读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * identificationTF = [defaults objectForKey:@"identificationTF"];
    NSString * numberTF = [defaults objectForKey:@"numberTF"];
    NSString * nameTF = [defaults objectForKey:@"nameTF"];
    NSString * productionTF = [defaults objectForKey:@"productionTF"];
    NSString * dispatchingTF = [defaults objectForKey:@"dispatchingTF"];
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;

    NSDictionary *params = @{
                             @"currentPage":@"1",
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"pageSize":@"10",
                             @"passWord":self.pass,
                             @"userName":self.user,
                             @"jybj": identificationTF,
                             @"cpbm": numberTF,
                             @"cpmc": nameTF,
                             @"scqy": productionTF,
                             @"pss": dispatchingTF
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [StockModel mj_objectArrayWithKeyValuesArray:data];
            NSLog(@"self.responseObject= %@",responseObject);

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
    StockTableViewCell * cell = [StockTableViewCell actcellWithactStockModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    StockModel * model = self.resultArray[indexPath.row];
    cell.ActStockModel = model;
    
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
