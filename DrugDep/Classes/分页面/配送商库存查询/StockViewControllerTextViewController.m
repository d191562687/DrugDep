//
//  StockViewControllerTextViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/9/7.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "StockViewControllerTextViewController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
#import "StockSearchViewController.h"

@interface StockViewControllerTextViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
/** 产品编码 */
@property (nonatomic, strong) BRTextField *numberTF;
/** 产品名称 */
@property (nonatomic, strong) BRTextField *nameTF;
/** 生产企业 */
@property (nonatomic, strong) BRTextField *productionTF;
/** 基药标识 */
@property (nonatomic, strong) BRTextField *identificationTF;
/** 配送商 */
@property (nonatomic, strong) BRTextField *dispatchingTF;

@property (nonatomic, strong) NSArray *titleArr;

/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation StockViewControllerTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.navigationItem.title = @"配送商库查询";
    self.tableView.hidden = NO;
    
    [self setupSubViews];

}
//设置视图
- (void)setupSubViews
{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 70)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.userInteractionEnabled = YES;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = MainColor;
    [button setTitle:@"查    询" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button setFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
   
        //存储
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_numberTF.text forKey:@"numberTF"];
        [defaults setObject:_nameTF.text forKey:@"nameTF"];
        [defaults setObject:_productionTF.text forKey:@"productionTF"];
        [defaults setObject:_identificationTF.text forKey:@"identificationTF"];
        [defaults setObject:_dispatchingTF.text forKey:@"dispatchingTF"];

        //查询后跳转
        StockSearchViewController * stockSearchV = [[StockSearchViewController alloc]init];
        [self.navigationController pushViewController:stockSearchV animated:YES];
        
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
            [self setupNumberTF:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupNameTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupProductionTF:cell];
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupIdentificationTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupDispatchingTF:cell];
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

#pragma mark - 产品编码 textField
- (void)setupNumberTF:(UITableViewCell *)cell {
    if (!_numberTF) {
        _numberTF = [self getTextField:cell];
        _numberTF.placeholder = @"请输入产品编码";
        _numberTF.returnKeyType = UIReturnKeyDone;
        _numberTF.tag = 0;
    }
}

#pragma mark - 产品名称 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入产品名称";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 1;
    }
}
#pragma mark - 生产企业 textField
- (void)setupProductionTF:(UITableViewCell *)cell {
    if (!_productionTF) {
        _productionTF = [self getTextField:cell];
        _productionTF.placeholder = @"请输入生产企业";
        _productionTF.returnKeyType = UIReturnKeyDone;
        _productionTF.tag = 2;
    }
}
#pragma mark - 基药标识 textField
- (void)setupIdentificationTF:(UITableViewCell *)cell {
    if (!_identificationTF) {
        _identificationTF = [self getTextField:cell];
        _identificationTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _identificationTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"选择基药标识：" dataSource:@[@"", @""] defaultSelValue:@"" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.identificationTF.text = selectValue;
            }];
        };
    }
}
#pragma mark - 机构 textField
- (void)setupDispatchingTF:(UITableViewCell *)cell {
    if (!_dispatchingTF) {
        _dispatchingTF = [self getTextField:cell];
        _dispatchingTF.placeholder = @"请选择机构";
        __weak typeof(self) weakSelf = self;
        _dispatchingTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"请选择配送商：" dataSource:@[@"",@"",@""] defaultSelValue:@"全部" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.dispatchingTF.text = selectValue;
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
        _titleArr = @[@" 产品编码:", @" 产品名称:", @" 生产企业:", @" 基药标识:",@"     配送商:",@""];
    }
    return _titleArr;
}



@end
