//
//  BStatisticsViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/8/10.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "BStatisticsViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "BcodeModel.h"
#import "BcodeTableViewCell.h"
#import "TNCustomSegment.h"

@interface BStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,TNCustomSegmentDelegate>
/** 表 */
@property (nonatomic, strong) UITableView * tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@property (strong,nonatomic) NSString * pass;
@property (strong,nonatomic) NSString * user;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation BStatisticsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"助计码查询";
    [self setupSubviews];
    
    NSArray *items = @[@"未出库",@"已出库"];

    TNCustomSegment *segment = [[TNCustomSegment alloc] initWithItems:items withFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 20, 40) withSelectedColor:nil withNormolColor:nil withFont:nil];
    segment.backgroundColor = [UIColor whiteColor];
    segment.delegate = self;
    segment.selectedIndex = 0;
    [self.view addSubview:segment];

    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(segment.frame) + 5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(segment.frame) + 5);
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
    
    NSString *url = @"http://192.168.1.34:9000/app/outStorage/unConfirmList.do";
    //读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * number = [defaults objectForKey:@"number"];

    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;
    
    NSDictionary *params = @{
                             @"data":number,
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"passWord":self.pass,
                             @"userName":self.user
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [BcodeModel mj_objectArrayWithKeyValuesArray:data];
        
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
    BcodeTableViewCell * cell = [BcodeTableViewCell actcellWithactBcodeModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    BcodeModel * model = self.resultArray[indexPath.row];
    cell.ActBcodeModel = model;

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BcodeModel * model = [[BcodeModel alloc]init];
    model = self.resultArray[indexPath.row];
    
    
    NSLog(@"点击的数据  --   %@",model.ypmc);

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

#pragma mark - TNCustomsegmentDelegate
- (void)segment:(TNCustomSegment *)segment didSelectedIndex:(NSInteger)selectIndex{
    
    self.selectIndex = selectIndex;
    switch (self.selectIndex) {
        case 0:
            [self loadWithName:@""];
            break;
        case 1:
            [self loadWithChoice];
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}


#pragma mark - 数据请求
- (void)loadWithChoice;
{
    
    NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmList.do";
    //读取
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString * identificationTF = [defaults objectForKey:@"identificationTF"];
    
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;
    
    NSDictionary *params = @{
                             @"data":@"69",
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"passWord":self.pass,
                             @"userName":self.user
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [BcodeModel mj_objectArrayWithKeyValuesArray:data];
        
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}

@end
