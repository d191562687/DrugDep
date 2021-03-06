//
//  HisIntoSearchViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/24.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HisIntoSearchViewController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"

#import "HisIntoViewController.h"

@interface HisIntoSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;

/** 药房选择 */
@property (nonatomic, strong) BRTextField *pharmcyTF;
/** 开始时间 */
@property (nonatomic, strong) BRTextField *startTimeTF;
/** 结束时间 */
@property (nonatomic, strong) BRTextField *endTimeTF;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation HisIntoSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"His入库查询";
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
        
        //his跳转
        HisIntoViewController * HisIntoVc = [[HisIntoViewController alloc]init];
        [self.navigationController pushViewController:HisIntoVc animated:YES];
        
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupPharmcyTF:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupStartTimeTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupEndTimeTF:cell];
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


#pragma mark - 药房 textField
- (void)setupPharmcyTF:(UITableViewCell *)cell {
    if (!_pharmcyTF) {
        _pharmcyTF = [self getTextField:cell];
        _pharmcyTF.placeholder = @"请选择药房";
        __weak typeof(self) weakSelf = self;
        _pharmcyTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"请选择药房：" dataSource:@[@"北京市金安健医药经销中心",@"嘉事堂药业股份有限公司",@"华润非基药",@"北京科园海信医药经营有限公司",@"国药控股北京有限公司"] defaultSelValue:@"" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.pharmcyTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 开始日期 textField
- (void)setupStartTimeTF:(UITableViewCell *)cell {
    if (!_startTimeTF) {
        _startTimeTF = [self getTextField:cell];
        _startTimeTF.placeholder = @"请选择开始时间";
        __weak typeof(self) weakSelf = self;
        _startTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.startTimeTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.startTimeTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 结束日期 textField
- (void)setupEndTimeTF:(UITableViewCell *)cell {
    if (!_endTimeTF) {
        _endTimeTF = [self getTextField:cell];
        _endTimeTF.placeholder = @"请选择结束时间";
        __weak typeof(self) weakSelf = self;
        _endTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"结束时间" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.endTimeTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.endTimeTF.text = selectValue;
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
        _titleArr = @[@" 药房选择:", @" 开始时间:", @" 结束时间:",@""];
    }
    return _titleArr;
}
@end
