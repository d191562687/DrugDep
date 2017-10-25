//
//  UpDownSearchViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/8/15.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "UpDownSearchViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "FrontViewModel.h"
#import "FrontTableViewCell.h"

@interface UpDownSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;

@end

@implementation UpDownSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

/** 当搜索内容改变时开始搜索 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //如果数据量过大的话  采用多线程防止卡顿
    NSLog(@"正在搜索...");
    //子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([searchText isEqualToString:@""]) {
            _resultArray = [NSArray array];
        }
        else{
            // 主要功能，调用方法实现搜索
            NSLog(@"searchText  ===   %@",searchText);
            NSString * strname = [NSString stringWithFormat:@"%@",searchText];
            [self loadWithName:strname];
            
        }
        // 主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_searchTableView reloadData];
            NSLog(@"隐藏旋转按钮");
        });
    });
}
#pragma 表格相关
- (void)setupSubviews
{
    //UI创建
    [self createSearchBar];
    [self.view addSubview:self.searchTableView];
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadWithName:@""];
    }];
    /** 每次加载先刷新数据 */
    [self.searchTableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /** 搜索前全查 */
    /** 创建cell */
    FrontTableViewCell * cell = [FrontTableViewCell actcellWithactFrontModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    FrontViewModel * model = self.dataSource[indexPath.row];
    cell.ActFrontModel = model;
    
    return cell;
}
/** cell点击 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //存储
//    FrontViewModel * status = self.dataSource[indexPath.row];
//    NSDictionary *statusDict = status.mj_keyValues;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:statusDict forKey:@"userData"];
    
    [self.navigationController popViewControllerAnimated:YES];  
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - 数据请求
- (void)loadWithName:(NSString *)name;
{
    //内网ip：192.168.1.70
    //外网ip：124.207.212.87
    
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/stockList";
    //    json={
    //        "currentPage": "1",
    //        "officeId": "95ce99bda3cd4309b0b114d05ffda55c",
    //        "pageSize": "2",
    //        "passWord": "test1234",
    //        "typeCode": "",
    //        "keywords": "",
    //        "userName": "majp01"
    //    }
    NSDictionary *params = @{
                             @"currentPage":@"1",
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"pageSize":@"10",
                             @"passWord":@"test1234",
                             @"typeCode":@"",
                             @"keywords":name,
                             @"userName":@"majp01"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.searchTableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.dataSource = [FrontViewModel mj_objectArrayWithKeyValuesArray:data];
        
        NSLog(@"self.dataSource = %@",self.dataSource);
        [self.searchTableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.searchTableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}



#pragma mark - 创建UISearchBar
- (void)createSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入药品名称／拼音缩写";
    [self.view addSubview:_searchBar];
}


#pragma mark - 懒加载
- (UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50) style:UITableViewStylePlain];
        
        _searchTableView.rowHeight = 160;
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        _searchTableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_searchTableView];
    }
    return _searchTableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
