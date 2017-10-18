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

#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "UserInfoManager.h"
#import "UpDownNewModel.h"
#import "UpDownNewTableViewCell.h"


@interface UpDownViewController ()<UITableViewDataSource,UITableViewDelegate,UpDownNewCellDelegate>

@property (strong,nonatomic) UITableView *tableView;

/** 数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@property (strong,nonatomic) UpdownHeadView *headView;

@property (weak, nonatomic) NSString  * totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

@implementation UpDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药房库存补货添加";
    [self setupSubViews];
}

- (void)setupSubViews
{
    

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 160;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadWithName];
    }];
    /** 每次加载先刷新数据 */
    [self.tableView.mj_header beginRefreshing];
    
    
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
    UpDownNewTableViewCell * cell = [UpDownNewTableViewCell actcellWithactFrontModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    cell.ActFrontModel = self.resultArray[indexPath.row];
    cell.delegate = self;
    
    return cell;
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



#pragma mark - 数据请求
- (void)loadWithName;
{
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/stockList";
    NSDictionary *params = @{
                             @"currentPage":@"1",
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"pageSize":@"10",
                             @"passWord":@"test1234",
                             @"typeCode":@"",
                             @"keywords":@"",
                             @"userName":@"majp01"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [UpDownNewModel mj_objectArrayWithKeyValuesArray:data];
        
        NSLog(@"self.dataSource = %@",self.resultArray);
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}

#pragma mark - UpDownNewCellDelegate
- (void)updownCellDidClickPlusButton:(UpDownNewTableViewCell *)updownCell{
    
    double  totalPrice = self.totalPriceLabel.doubleValue + updownCell.ActFrontModel.costPrice.doubleValue;
    
    self.totalPriceLabel = [NSString stringWithFormat:@"%.2f",totalPrice];

}

- (void)updownCellDidClickMinusButton:(UpDownNewTableViewCell *)updownCell{
    
//    double  totalPrice = self.totalPriceLabel.text.doubleValue - updownCell.ActFrontModel.price.doubleValue;
//
//    self.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",totalPrice];
//
 //   self.buyButton.enabled = (totalPrice > 0);
    
}

@end
