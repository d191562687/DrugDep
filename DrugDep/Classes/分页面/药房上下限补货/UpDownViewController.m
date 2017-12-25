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
//下拉
#import "ZJBLStoreShopTypeAlert.h"

#import "UITextField+IndexPath.h"

@interface UpDownViewController ()<UITableViewDataSource,UITableViewDelegate,UpDownNewCellDelegate>
//{
//    NSArray *titlesStock1;
//}
@property (nonatomic,nonatomic) NSArray * titlesStock1;

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
    [self refreshDataAction];
    
    self.titlesStock1 = @[@"北京丰台区马家堡社区卫生服务中心",@"北京丰台区角门东里社区卫生服务中心",@"丰台区马家堡街道马家堡社区卫生服务站"];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

#pragma mark - notification

- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    [self.resultArray replaceObjectAtIndex:indexPath.row withObject:textField.text];
}


- (void)setupSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 160;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBord)];
    [self.tableView addGestureRecognizer:gesture];
    
    [self.view addSubview:self.tableView];
    
    //textStock1
    UILabel * textStock1  = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.75, SCREEN_WIDTH * 0.1)];
    textStock1.textColor = [UIColor blackColor];
    textStock1.text = @"";
    [self.view addSubview:textStock1];
    
//    UIButton * tempButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.04, SCREEN_WIDTH * 0.75, SCREEN_WIDTH * 0.1)];
//    tempButton.backgroundColor = [UIColor redColor];
//    [tempButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:tempButton];
    
    self.headView = [[UpdownHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.645)];
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
            [MBProgressHUD showSuccess:@"ff"];
        }else if (clickType == stockFied1){
            // ff
            [MBProgressHUD showSuccess:@"ff"];
            [ZJBLStoreShopTypeAlert showWithTitle:@"选择机构" titles:weakSelf.titlesStock1 selectIndex:^(NSInteger selectIndex) {
                NSLog(@"选择了第%ld个",selectIndex);
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                textStock1.text = selectValue;
            } showCloseButton:NO];
     
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
    return 2;
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
//    cell.ActFrontModel = self.resultArray[indexPath.row];
//    cell.delegate = self;
    
    [cell setActFrontModel:self.resultArray[indexPath.row] andIndexPath:indexPath];
    cell.delegate = self;

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击结束了");
    
}

- (void)hiddenKeyBord{
    NSLog(@"要隐藏键盘了........1111111111111");
    [self btnClick];
    [self.view endEditing:YES];
}
- (void)btnClick{
    // 打印数据源
    [self.resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
  //      NSString *string = (NSString *)obj;
        

    
        NSLog(@"提交数字%@", obj);
//        if (string.length == 0) {
//            NSLog(@"第%lu个位置元素为空", (unsigned long)idx);
//        }else{
//            NSLog(@"%@", obj);
//        }
    }];
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

- (void)refreshDataAction
{
    //调用接口
    [[HomeManager sharedManager].netManager oneRepairWithUserName:nil PassWord:nil Success:^{
        [MBProgressHUD hideHUD];
        // 登录成功
    } Fail:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [self sendAlertAction:errorMsg];
    }];
}

#pragma mark - 数据请求
- (void)loadWithName
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
        NSLog(@"补货药品列表  ===   %@",responseObject);

        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.resultArray = [UpDownNewModel mj_objectArrayWithKeyValuesArray:data];

        [self.tableView reloadData];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];


}




@end
