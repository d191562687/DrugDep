//
//  PurchaseViewTextController.m
//  DrugDep
//
//  Created by 金安健 on 2017/9/7.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "PurchaseViewTextController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
@interface PurchaseViewTextController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
/** 产品编码 */
@property (nonatomic, strong) BRTextField *numberTF;
/** 药品名称 */
@property (nonatomic, strong) BRTextField *drugNameTF;
/** 商品名称 */
@property (nonatomic, strong) BRTextField *wareNameTF;
/** 药品剂型 */
@property (nonatomic, strong) BRTextField *drugContentTF;
/** 药品规格 */
@property (nonatomic, strong) BRTextField *drugFormatTF;
/** 药品单位 */
@property (nonatomic, strong) BRTextField *drugCompanyTF;
/** 药品包装规格 */
@property (nonatomic, strong) BRTextField *packFormatTF;
/** 生产企业名称 */
@property (nonatomic, strong) BRTextField *companyNameTF;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation PurchaseViewTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"药品采购目录遴选";
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
            [self setupDrugNameTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupWareNameTF:cell];
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupDrugContentTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupDrugFormatTF:cell];
        }
            break;
        case 5:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupDrugCompanyTF:cell];
        }
            break;
        case 6:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupPackFormatTF:cell];
        }
            break;
        case 7:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupCompanyNameTF:cell];
        }
            break;
            
            
        default:
            break;
    }
    
    return cell;
}
- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.27, 0,SCREEN_WIDTH * 0.74, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14.6f];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 产品编码 textField
- (void)setupNumberTF:(UITableViewCell *)cell {
    if (!_numberTF) {
        _numberTF = [self getTextField:cell];
        _numberTF.placeholder = @"";
        _numberTF.returnKeyType = UIReturnKeyDone;
        _numberTF.tag = 0;
    }
}
#pragma mark - 药品名称 textField
- (void)setupDrugNameTF:(UITableViewCell *)cell {
    if (!_drugNameTF) {
        _drugNameTF = [self getTextField:cell];
        _drugNameTF.placeholder = @"";
        _drugNameTF.returnKeyType = UIReturnKeyDone;
        _drugNameTF.tag = 1;
    }
}
#pragma mark - 商品名称 textField
- (void)setupWareNameTF:(UITableViewCell *)cell {
    if (!_wareNameTF) {
        _wareNameTF = [self getTextField:cell];
        _wareNameTF.placeholder = @"";
        _wareNameTF.returnKeyType = UIReturnKeyDone;
        _wareNameTF.tag = 2;
    }
}
#pragma mark - 药品剂型 textField
- (void)setupDrugContentTF:(UITableViewCell *)cell {
    if (_drugContentTF) {
        _drugContentTF = [self getTextField:cell];
        _drugContentTF.placeholder = @"";
        _drugContentTF.returnKeyType = UIReturnKeyDone;
        _drugContentTF.tag = 3;
    }
}
#pragma mark - 药品规格 textField
- (void)setupDrugFormatTF:(UITableViewCell *)cell {
    if (_drugFormatTF) {
        _drugFormatTF = [self getTextField:cell];
        _drugFormatTF.placeholder = @"";
        _drugFormatTF.returnKeyType = UIReturnKeyDone;
        _drugFormatTF.tag = 4;
    }
}
#pragma mark - 药品单位 textField
- (void)setupDrugCompanyTF:(UITableViewCell *)cell {
    if (_drugCompanyTF) {
        _drugCompanyTF = [self getTextField:cell];
        _drugCompanyTF.placeholder = @"";
        _drugCompanyTF.returnKeyType = UIReturnKeyDone;
        _drugCompanyTF.tag = 5;
    }
}
#pragma mark - 药品包装规格 textField
- (void)setupPackFormatTF:(UITableViewCell *)cell {
    if (_packFormatTF) {
        _packFormatTF = [self getTextField:cell];
        _packFormatTF.placeholder = @"";
        _packFormatTF.returnKeyType = UIReturnKeyDone;
        _packFormatTF.tag = 6;
    }
}
#pragma mark - 生产企业名称 textField
- (void)setupCompanyNameTF:(UITableViewCell *)cell {
    if (_companyNameTF) {
        _companyNameTF = [self getTextField:cell];
        _companyNameTF.placeholder = @"";
        _companyNameTF.returnKeyType = UIReturnKeyDone;
        _companyNameTF.tag = 7;
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
        _titleArr = @[@" 产品编码:", @" 药品名称:", @" 商品名称:", @" 药品剂型:",@" 药品规格:",@" 药品单位:",@" 药品包装规格:",@" 生产企业名称:",@""];
    }
    return _titleArr;
}

@end
