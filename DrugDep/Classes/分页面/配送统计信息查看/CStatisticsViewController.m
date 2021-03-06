//
//  CStatisticsViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/8/10.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "CStatisticsViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "UserInfoManager.h"
#import "DifferenceListModel.h"
#import "DifferenceListTableViewCell.h"
#import "BStatisticsViewController.h"


@interface CStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;


@property (strong,nonatomic) NSString * pass;
@property (strong,nonatomic) NSString * user;

@end

@implementation CStatisticsViewController

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
//    //UI创建
//    [self createSearchBar];
//    [self.view addSubview:self.searchTableView];
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
    DifferenceListTableViewCell * cell = [DifferenceListTableViewCell actcellWithactDifferenceListModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    DifferenceListModel * model = self.dataSource[indexPath.row];
    cell.ActDifferenceListModel = model;
    
    //在cell里面添加按钮的点击事件;
    [cell.firstChoose addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.secondChoose addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag值区分点击的是哪个按钮
    cell.firstChoose.tag=1;
    cell.secondChoose.tag=2;
    
    return cell;
}

-(void)onBtnClick:(UIButton *)sender{
    DifferenceListTableViewCell *cell=(DifferenceListTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath=[self.searchTableView indexPathForCell:cell];
    
    //这个就是添加新选中的按钮答案到字典,根据indexPath作为key,并改变选中时的背景图片
    if (sender.tag == 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (sender.tag == 2){
        NSLog(@"下次处理");
        DifferenceListModel * model = [[DifferenceListModel alloc]init];
        model = self.dataSource[indexPath.row];
        NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmDetail.do";
        //读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString * dicID = [defaults objectForKey:@"dicID"];
        UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
        self.pass = userModel.passWord;
        self.user = userModel.loginName;
        //NSLog(@" -- %@   %@   %@   %@ ",model.djSn,model.djbh,model.sl,model.ckdh);
        NSDictionary * modeldata1 = @{
                                      @"djSn":model.djSn,
                                      @"djbh": model.djbh,
                                      @"shhshl":model.sl,
                                      @"status": @"2",
                                      @"ckdh": model.ckdh,
                                      };

        NSArray * dataArr1 = [[NSArray alloc]initWithObjects:modeldata1, nil];

        NSDictionary *params1 = @{
                                  @"data":dataArr1,
                                  @"officeId": dicID,
                                  @"passWord": self.pass,
                                  @"userName": self.user,
                                  };
        NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params1 options:0 error:nil] encoding:NSUTF8StringEncoding];
        NSDictionary *json = @{@"json":p1Str};
    
        
        [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.searchTableView.mj_header endRefreshing];
            // 成功
            NSArray *data = [responseObject objectForKey:@"data"];
            [self loadWithName:@""];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            [self.searchTableView.mj_header endRefreshing];
            [self sendAlertAction:error.localizedDescription];
        }];
        
    }
}
/** cell点击 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        _searchTableView.rowHeight = 185;
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        _searchTableView.backgroundColor = self.view.backgroundColor;
//        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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


#pragma mark - 数据请求
- (void)loadWithName:(NSString *)name;
{
    
    NSString *url = @"http://192.168.1.34:9000/app/outStorage/unConfirmListEnd.do";
    //读取
    //读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * dicID = [defaults objectForKey:@"dicID"];
    
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;

    NSDictionary *params = @{
                             @"officeId": dicID,
                             @"passWord": self.pass,
                             @"userName": self.user,
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.searchTableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.dataSource = [DifferenceListModel mj_objectArrayWithKeyValuesArray:data];
        
        NSLog(@"self.dataSource = %@",responseObject);
        [self.searchTableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.searchTableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}
@end
