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
#import "PasswordView.h"

@interface BStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,TNCustomSegmentDelegate>
{
    PasswordView *passView;
}
/** 表 */
@property (nonatomic, strong) UITableView * tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@property (strong,nonatomic) NSString * pass;
@property (strong,nonatomic) NSString * user;

@property (nonatomic, assign) NSInteger selectIndex;

//建立一个可变字典,记录选择的内容.
@property (nonatomic, retain)NSMutableDictionary *selectedSourceDic;

@end

@implementation BStatisticsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"助计码查询";
    [self setupSubviews];
    
    NSArray *items = @[@"未入库",@"已处理"];

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

    NSString * dicID = [defaults objectForKey:@"dicID"];

    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;
    NSDictionary *params = @{
                             @"data":number,
                             @"officeId":dicID,
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

   //在cell里面添加按钮的点击事件;
    [cell.firstChoose addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.secondChoose addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.qlsl addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag值区分点击的是哪个按钮
    cell.firstChoose.tag=1;
    cell.secondChoose.tag=2;
    cell.qlsl.tag = 3;
    
    return cell;
}

-(void)onBtnClick:(UIButton *)sender{
    BcodeTableViewCell *cell=(BcodeTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];

    //这个就是添加新选中的按钮答案到字典,根据indexPath作为key,并改变选中时的背景图片
    if (sender.tag == 1) {
        NSLog(@"确认收货");
        BcodeModel * model = [[BcodeModel alloc]init];
        model = self.resultArray[indexPath.row];
        NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmDetail.do";
        //读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString * dicID = [defaults objectForKey:@"dicID"];
        UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
        self.pass = userModel.passWord;
        self.user = userModel.loginName;
        NSDictionary * modeldata1 = @{
                                      @"djSn":model.djSn,
                                      @"djbh": model.djbh,
                                      @"shhshl":model.sl,
                                      @"status": @"1",
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
        
        NSLog(@"json= %@",json);
        
        [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            // 成功
            NSArray *data = [responseObject objectForKey:@"data"];
            [self loadWithName:@""];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self sendAlertAction:error.localizedDescription];
        }];
        
        
        
    } if (sender.tag == 2) {
        NSLog(@"退货");
        BcodeModel * model = [[BcodeModel alloc]init];
        model = self.resultArray[indexPath.row];
        NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmDetail.do";
        //读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString * dicID = [defaults objectForKey:@"dicID"];
        UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
        self.pass = userModel.passWord;
        self.user = userModel.loginName;
        NSDictionary * modeldata1 = @{
                                      @"djSn":model.djSn,
                                      @"djbh": model.djbh,
                                      @"shhshl":model.sl,
                                      @"status": @"3",
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
        
        NSLog(@"json= %@",json);
        
        [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            // 成功
            NSArray *data = [responseObject objectForKey:@"data"];
            self.resultArray = [BcodeModel mj_objectArrayWithKeyValuesArray:data];
            
            [self loadWithName:@""];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self sendAlertAction:error.localizedDescription];
        }];
        
    } else if(sender.tag == 3){
        NSLog(@"修改数量");
        passView = [[PasswordView alloc] initWithTitle:@"修改实收数量" cancelBtn:@"取消" sureBtn:@"确认" btnClickBlock:^(NSInteger index,NSString *str) {
            if (index == 0) {
               NSLog(@"0000000");
                
            }else if (index == 1){
                NSLog(@"111111");
                NSLog(@"^^^^^%@^",str);
                BcodeModel * model = [[BcodeModel alloc]init];
                model = self.resultArray[indexPath.row];
                
                NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"1234567890_"];
                s = [s invertedSet];
                NSRange r = [str rangeOfCharacterFromSet:s];
                if (r.location !=NSNotFound || str > model.sl) {
                    NSLog(@"the string contains illegal characters");
                    NSLog(@"输入有误");
                    NSString *title = @"输入数量有误";
                    NSString *message = @"你需要重新输入";
                    NSString *okButtonTitle = @"OK";
                    // 初始化
                    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                    // 创建操作
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        // 操作具体内容
                    }];
                    // 添加操作
                    [alertDialog addAction:okAction];
                    // 呈现警告视图
                    [self presentViewController:alertDialog animated:YES completion:nil];
 
                }else{
                    NSString *url = @"http://192.168.1.34:9000/app/outStorage/confirmDetail.do";
                    //读取
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString * dicID = [defaults objectForKey:@"dicID"];
                    //   NSString * stringValue = [defaults objectForKey:@"stringValue"];
                    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
                    self.pass = userModel.passWord;
                    self.user = userModel.loginName;
                    
                    //    NSLog(@"modeldata1= %@--%@--%@--%@",model.djSn,model.djbh,model.shhshl,model.ckdh);
                    
                    NSDictionary * modeldata1 = @{
                                                  @"djSn":model.djSn,
                                                  @"djbh": model.djbh,
                                                  @"shhshl":str,
                                                  @"status": @"1",
                                                  @"ckdh": model.ckdh,
                                                  };
                    NSArray * dataArr1 = [[NSArray alloc]initWithObjects:modeldata1, nil];
                    
                    NSLog(@"modeldata1= %@",modeldata1);
                    NSLog(@"dataArr= %@",dataArr1);
                    
                    NSDictionary *params1 = @{
                                              @"data":dataArr1,
                                              @"officeId": dicID,
                                              @"passWord": self.pass,
                                              @"userName": self.user,
                                              };
                    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params1 options:0 error:nil] encoding:NSUTF8StringEncoding];
                    NSDictionary *json = @{@"json":p1Str};
                    
                    NSLog(@"json= %@",json);
                    
                    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
                        [self.tableView.mj_header endRefreshing];
                        // 成功
                        NSArray *data = [responseObject objectForKey:@"data"];
                        self.resultArray = [BcodeModel mj_objectArrayWithKeyValuesArray:data];
                        //        NSLog(@"self.responseObject= %@",responseObject);
                        //        NSLog(@"self.data= %@",data);
                        NSLog(@"self.resultArray = %@",self.resultArray);
                        
                        [self loadWithName:@""];
                        
                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                        [self.tableView.mj_header endRefreshing];
                        [self sendAlertAction:error.localizedDescription];
                    }];
                }
     
            }
        }];
        [passView show];

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BcodeModel * model = [[BcodeModel alloc]init];
    model = self.resultArray[indexPath.row];
    
    
    NSLog(@"点击的数据  --   %@",model);

}


#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        _tableView.rowHeight = 180;
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * number = [defaults objectForKey:@"number"];

    NSString * dicID = [defaults objectForKey:@"dicID"];
    
    UserInfoModel *userModel = [[UserInfoManager sharedManager] getUserInfo];
    self.pass = userModel.passWord;
    self.user = userModel.loginName;
    
    NSDictionary *params = @{
                             @"data":number,
                             @"officeId":dicID,
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
