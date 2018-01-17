//
//  ScanListViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/29.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "ScanListViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "UserInfoManager.h"
#import "ScanListModel.h"
#import "ScanListTableViewCell.h"
#import "TNCustomSegment.h"

@interface ScanListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,TNCustomSegmentDelegate>
/** 搜索表 */
@property (nonatomic, strong) UITableView * tableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;

@property (nonatomic, assign) NSInteger selectIndex;

@property (strong,nonatomic) NSString * pass;
@property (strong,nonatomic) NSString * user;

@end

@implementation ScanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"";
    
    [self setupSubviews];
    
//    NSArray *items = @[@"未出库",@"已出库"];
//    
//    TNCustomSegment *segment = [[TNCustomSegment alloc] initWithItems:items withFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 20, 40) withSelectedColor:nil withNormolColor:nil withFont:nil];
//    segment.delegate = self;
//    segment.selectedIndex = 0;
//    [self.view addSubview:segment];
//    
//    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(segment.frame) + 5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(segment.frame) + 5);
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
    NSString * dicID = [defaults objectForKey:@"dicID"];
//    NSString * stringValue = [defaults objectForKey:@"stringValue"];
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;
    
//    self.Id = userModel.id;
    
//    json={
//        "data": "6933346880552",
//        "officeId": "95ce99bda3cd4309b0b114d05ffda55c",
//        "passWord": "test1234",
//        "userName": "majp01"
//    }
    
    NSDictionary *params = @{
                             @"data":@"s",
                             @"officeId": dicID,
                             @"passWord": self.pass,
                             @"userName": self.user,
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [ScanListModel mj_objectArrayWithKeyValuesArray:data];
///        NSLog(@"self.responseObject= %@",responseObject);
//        NSLog(@"self.data= %@",data);
//        NSLog(@"self.resultArray = %@",self.resultArray);
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
    ScanListTableViewCell * cell = [ScanListTableViewCell actcellWithactScanListModel:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    /** 获取当前的模型，设置cell数据 */
    ScanListModel * model = self.resultArray[indexPath.row];
    cell.ActScanListModel = model;
    //textField
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    ScanListModel * model = self.resultArray[indexPath.row];
    
    NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmDetail.do";
    //读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * dicID = [defaults objectForKey:@"dicID"];
 //   NSString * stringValue = [defaults objectForKey:@"stringValue"];
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;

    //ScanListModel * model = [[ScanListModel alloc]init];
    model = self.resultArray[indexPath.row];

    NSDictionary * modeldata = @{
                             @"djSn":model.djSn,
                             @"djbh": model.djbh,
                             @"shhshl": model.shhshl,
                             @"status": @"1",
                             @"ckdh": model.ckdh,
                             };
    NSArray * dataArr = [[NSArray alloc]initWithObjects:modeldata, nil];

    NSDictionary *params = @{
                             @"data":dataArr,
                             @"officeId": dicID,
                             @"passWord": self.pass,
                             @"userName": self.user,
                             };
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};

     NSLog(@"json= %@",json);

    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [ScanListModel mj_objectArrayWithKeyValuesArray:data];
//        NSLog(@"self.responseObject= %@",responseObject);
//        NSLog(@"self.data= %@",data);
        NSLog(@"self.resultArray = %@",self.resultArray);

        [self loadWithName:@""];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];

}

#pragma mark - UITextField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
NSLog(@"1");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
NSLog(@"1");
}
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    

    NSLog(@"1");
    
    return YES;
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
    NSLog(@"11111");
    switch (self.selectIndex) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}

@end
