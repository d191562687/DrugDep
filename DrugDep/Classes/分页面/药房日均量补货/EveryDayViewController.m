//
//  EveryDayViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/2.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "EveryDayViewController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
#import "EveryNewViewController.h"

#import "WTShopcatViewController.h"

@interface EveryDayViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 机构 */
@property (nonatomic, strong) BRTextField *companyTF;

@end

@implementation EveryDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"药房日均补货";
    self.tableView.hidden = NO;
    
    [self setupSubViews];
    
}
//设置视图
- (void)setupSubViews
{
    //新增
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:(UIBarButtonItemStyleDone) target:self action:@selector(searchMobanAction)];
    self.navigationItem.rightBarButtonItem = rightitem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(searchMobanAction)];
    //搜索
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 70)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.userInteractionEnabled = YES;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = MainColor;
    [button setTitle:@"搜    索" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button setFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
    }];
    [footView addSubview:button];
    
    self.tableView.tableFooterView = footView;
    
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = RGB_HEX(0x464646, 1.0f);
    NSString *title = [self.titleArr objectAtIndex:indexPath.row];
    if ([title hasPrefix:@"* "]) {
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:title];
        [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
        cell.textLabel.attributedText = textStr;
    } else {
        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupCompanyTF:cell];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 0,SCREEN_WIDTH * 0.74, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14.6f];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 机构 textField
- (void)setupCompanyTF:(UITableViewCell *)cell {
    if (!_companyTF) {
        _companyTF = [self getTextField:cell];
        _companyTF.placeholder = @"请选择机构";
        __weak typeof(self) weakSelf = self;
        _companyTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"请选择组织机构：" dataSource:@[@"北京市丰台区马家堡社区卫生服务中心",@"丰台区马家堡街道角门东里社区卫生服务中心",@"丰台区马家堡街道社区卫生服务中心"] defaultSelValue:@"丰台区马家堡街道角门东里社区卫生服务中心" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.companyTF.text = selectValue;
            }];
        };
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@" 机构选择:",@""];
    }
    return _titleArr;
}

// 新增
- (void)searchMobanAction
{
//    EveryNewViewController *everyNew = [[EveryNewViewController alloc]init];
//    [self.navigationController pushViewController:everyNew animated:YES];
    
    WTShopcatViewController *everyNew = [[WTShopcatViewController alloc]init];
    [self.navigationController pushViewController:everyNew animated:YES];
}

@end
