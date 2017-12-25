//
//  EveryNewViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/2.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "EveryNewViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "EveryNewModel.h"
#import "EveryNewTableViewCell.h"
#import "EveryShopHeaderFooterView.h"
#import <Masonry.h>

@interface EveryNewViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,EveryShopHeadViewDelegate,EveryNewTableViewCellDelegate>
{
    UILabel *_allMoneyLabel;
    UIButton *_payButton;
    
}
/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;

@end

@implementation EveryNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self setFootView];

    
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
    EveryNewTableViewCell * cell = [EveryNewTableViewCell actcellWithactEveryNewModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    EveryNewModel * model = self.dataSource[indexPath.row];
    cell.ActEveryNewModel = model;
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
/** cell点击 */
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 1;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    EveryShopHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:EveryShopHeaderFooterViews];
//    head.delegate = self;
//    head.section = section;
//    EveryNewModel *model = self.dataSource[section];
//    if (model.selectStatus) {
//        head.selectBtn.selected = YES;
//    }else{
//        head.selectBtn.selected = NO;
//    }
//    return head;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 110;
//}
//
//- (void)WTShopcatHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus {
//    EveryNewModel *model = self.dataSource[section];
//    model.selectStatus = selectStatus;
//
//    [self updateAllpriceAction];
//}

#pragma mark - 数据请求
- (void)loadWithName:(NSString *)name;
{
    //内网ip：192.168.1.70
    //外网ip：124.207.212.87
    
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/stockListQz";
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
        self.dataSource = [EveryNewModel mj_objectArrayWithKeyValuesArray:data];
        
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


//#pragma mark - 懒加载
//- (UITableView *)searchTableView{
//    if (!_searchTableView) {
//        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50) style:UITableViewStylePlain];
//
//        _searchTableView.rowHeight = 160;
//        _searchTableView.dataSource = self;
//        _searchTableView.delegate = self;
//        _searchTableView.backgroundColor = self.view.backgroundColor;
//        [self.view addSubview:_searchTableView];
////        [_searchTableView registerNib:[UINib nibWithNibName:EveryNewTableViewCells bundle:nil] forCellReuseIdentifier:EveryNewTableViewCells];
//        [_searchTableView registerClass:[EveryShopHeaderFooterViews class] forHeaderFooterViewReuseIdentifier:EveryShopHeaderFooterViews];
//
//    }
//    return _searchTableView;
//}

#pragma mark setTableView
- (void)setTableView {
    self.searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50 - tabbar_height) style:UITableViewStylePlain];
    
    self.searchTableView.rowHeight = 160;
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    self.searchTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.searchTableView];
    //        [_searchTableView registerNib:[UINib nibWithNibName:EveryNewTableViewCells bundle:nil] forCellReuseIdentifier:EveryNewTableViewCells];
    [self.searchTableView registerClass:[EveryShopHeaderFooterView class] forHeaderFooterViewReuseIdentifier:EveryShopHeaderFooterViews];
}

#pragma mark - setFootView
- (void)setFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 64  - tabbar_height ,SCREEN_WIDTH,tabbar_height)];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGB_COLOR(200, 200, 200);
    [footView addSubview:line];
    
    UIButton *selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:selectAllBtn];
    [selectAllBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [selectAllBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
    selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [selectAllBtn addTarget:self action:@selector(selectAllProductAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(footView);
    }];
    
    UILabel *allselectLabel = [[UILabel alloc] init];
    [footView addSubview:allselectLabel];
    allselectLabel.text = @"全选";
    [allselectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(50);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(footView);
    }];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:_payButton];
    _payButton.backgroundColor = WT_COLOR_TABBAR;
    [_payButton setTitle:@"付款(0)" forState:0];
    [_payButton setTitleColor:[UIColor whiteColor] forState:0];
    [_payButton addTarget:self action:@selector(gotoOderPage) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footView).offset(-0);
        make.height.mas_equalTo(48);
        make.top.equalTo(footView).offset(0);
        make.width.mas_equalTo(80);
    }];
    
    _allMoneyLabel = [[UILabel alloc] init];
    [footView addSubview:_allMoneyLabel];
    _allMoneyLabel.text = @"合计：¥0.00";
    _allMoneyLabel.font = [UIFont systemFontOfSize:14];
    _allMoneyLabel.textColor  = [UIColor blackColor];
    [_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footView).offset(-90);
        make.centerY.equalTo(footView);
        make.height.mas_equalTo(25);
    }];
}

//- (void)updateAllpriceAction {
//    CGFloat allmoney = 0;
//    NSInteger counts = 0;;
//    for (EveryNewModel * shopModel in self.resultArray) {
//            if (shopModel.selectStatus) {
//                allmoney += shopModel.productPrice * shopModel.productCount;
//                counts ++;
//        }
//    }
//    NSString *moneys = [NSString stringWithFormat:@"¥%.2f",allmoney];
//    NSString *tempString = [@"合计：" stringByAppendingString:moneys];
//    _allMoneyLabel.attributedText = [self changeLabelColorOriginalString:tempString changeString:moneys];
//    [_payButton setTitle:[NSString stringWithFormat:@"付款(%ld)",counts] forState:0];
//}
//- (NSMutableAttributedString *)changeLabelColorOriginalString:(NSString *)originalString changeString:(NSString *)changeString {
//    NSRange changeStringRange = [originalString rangeOfString:changeString];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:changeStringRange];
//    return attributedString;
//}
- (void)gotoOderPage {
    // 结算所选择的按钮
    
    
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
