//
//  UpdownHeadView.m
//  DrugDep
//
//  Created by 金安健 on 2017/6/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "UpdownHeadView.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"

#import "FSComboListView.h"
//新增
#import "UpDownSearchViewController.h"

@interface UpdownHeadView ()<FSComboPickerViewDelegate>

@end

@implementation UpdownHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        
      //  [self setupComboListView];
    
    }
    return self;
}

- (void)setupSubViews
{
    //机构选择
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label1.text = @"机构选择:";
    [self addSubview:label1];

    UITextField * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.4, SCREEN_WIDTH * 0.1)];
    textField1.placeholder = @"";
    [self addSubview:textField1];

    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.13, SCREEN_WIDTH, 1)];
    imageView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView1.alpha = 0.7;
    [self addSubview:imageView1];
    //类型选择
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05,SCREEN_WIDTH * 0.15, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label2.text = @"类型选择:";
    [self addSubview:label2];

    UITextField * textField2 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.15, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    textField2.placeholder = @"";
    [self addSubview:textField2];

    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.26, SCREEN_WIDTH, 1)];
    imageView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView2.alpha = 0.7;
    [self addSubview:imageView2];
    //药房选择
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label3.text = @"药房选择:";
    [self addSubview:label3];

    UITextField * textField3 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    textField3.placeholder = @"";
    [self addSubview:textField3];

    UIImageView * imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.39, SCREEN_WIDTH, 1)];
    imageView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView3.alpha = 0.7;
    [self addSubview:imageView3];
    //药房上限补货Button
    UIButton * buttonUp = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.06, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH - (SCREEN_WIDTH * 0.12), SCREEN_WIDTH * 0.12)];
    buttonUp.backgroundColor = NavColor;
    buttonUp.titleLabel.font = [UIFont systemFontOfSize:20];
    [buttonUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonUp setTitle:@"药房上限补货" forState:UIControlStateNormal];
    buttonUp.clipsToBounds = YES;
    buttonUp.layer.cornerRadius = 3;
    [self addSubview:buttonUp];
    
    //药房一键补货Button
    UIButton * buttonOne = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.06, SCREEN_HEIGHT * 0.33, SCREEN_WIDTH - (SCREEN_WIDTH * 0.12), SCREEN_WIDTH * 0.12)];
    buttonOne.backgroundColor = NavColor;
    buttonOne.titleLabel.font = [UIFont systemFontOfSize:20];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonOne setTitle:@"药房一键补货" forState:UIControlStateNormal];
    buttonOne.clipsToBounds = YES;
    buttonOne.layer.cornerRadius = 3;
    [self addSubview:buttonOne];
    
    //采购计划明细
    UIImageView * imagePlan = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.41, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08)];
    imagePlan.backgroundColor = [UIColor lightGrayColor];
    imagePlan.alpha = 0.5;
    
    UILabel * labelPlan = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08)];
    labelPlan.text = @"采购计划明细";
    labelPlan.textAlignment = NSTextAlignmentCenter;
    labelPlan.font = [UIFont systemFontOfSize:23];
    [labelPlan setTextColor:[UIColor blackColor]];
    [imagePlan addSubview:labelPlan];

    [self addSubview:imagePlan];

    
    //保存，取消，提交
    //新增
//    UIView * viewNew = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.08, SCREEN_HEIGHT * 0.48, SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.03)];
//    
//    UIImageView * imageViewNew = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.01, SCREEN_WIDTH * 0.03, SCREEN_WIDTH * 0.03)];
//    imageViewNew.image = [UIImage imageNamed:@"新增icon.png"];
//    
//    UILabel * labelNew = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03 + 10, 0, SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.03)];
//    labelNew.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    labelNew.textColor = TitleColor;
//    labelNew.text = @"新增";
//    [viewNew addSubview:labelNew];
//    [viewNew addSubview:imageViewNew];
//    [self addSubview:viewNew];
    
// 计算同一行按钮的坐标
    CGFloat space = 18 * CKproportion;  // 按钮间距
    CGFloat width = (SCREEN_WIDTH - 5 * space)/4;   // 按钮的宽度
    CGFloat height = 42;   // 按钮的高度
    CGFloat Y = CGRectGetMaxY(imagePlan.frame) + 10;  // 按钮的Y
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"新增" forState:UIControlStateNormal];
    addButton.clipsToBounds = YES;
    addButton.layer.cornerRadius = 3;
    [addButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.SelectBlock) {
            _SelectBlock(AddClickType);
        }
    }];
    addButton.frame = CGRectMake(space, Y, width, height);
    addButton.backgroundColor = MainColor;
    [self addSubview:addButton];

    
    //保存
    UIButton * buttonSave = [[UIButton alloc]initWithFrame:CGRectMake(space * 2 + addButton.width, Y, width, height)];
    [buttonSave setTitle: @"保存" forState:UIControlStateNormal];
    [buttonSave setTitleColor:TitleColor forState:UIControlStateNormal];
    buttonSave.clipsToBounds = YES;
    buttonSave.layer.cornerRadius = 3;
    [buttonSave addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.SelectBlock) {
            _SelectBlock(SaveClickType);
        }
    }];
    buttonSave.backgroundColor = MainColor;
    [buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:buttonSave];
    //提交
    UIButton * buttonPut = [[UIButton alloc]initWithFrame:CGRectMake(space * 3 + buttonSave.width + buttonSave.width, Y, width, height)];
    [buttonPut setTitle: @"提交" forState:UIControlStateNormal];
    [buttonPut setTitleColor:TitleColor forState:UIControlStateNormal];
    buttonPut.clipsToBounds = YES;
    buttonPut.layer.cornerRadius = 3;
    [buttonPut addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.SelectBlock) {
            _SelectBlock(TijiaoClickType);
        }
    }];
    buttonPut.backgroundColor = MainColor;
    [buttonPut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:buttonPut];
    //取消
    UIButton * buttonOff = [[UIButton alloc]initWithFrame:CGRectMake(space * 4 + buttonSave.width + buttonSave.width + buttonPut.width, Y, width, height)];
    [buttonOff setTitle: @"取消" forState:UIControlStateNormal];
    [buttonOff setTitleColor:TitleColor forState:UIControlStateNormal];
    buttonOff.clipsToBounds = YES;
    buttonOff.layer.cornerRadius = 3;
    [buttonOff addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.SelectBlock) {
            _SelectBlock(CancleClickType);
        }
    }];
    buttonOff.backgroundColor = MainColor;
    [buttonOff setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:buttonOff];
    //选择框1
    UIButton * buttonStock1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.35, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.1)];
    buttonStock1.backgroundColor = [UIColor clearColor];
    [buttonStock1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.SelectBlock) {
            _SelectBlock(stockFied1);
        }
    }];
    [buttonStock1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:buttonStock1];
    
    //横线
    UIImageView * imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.58, SCREEN_WIDTH, 3)];
    imageView4.backgroundColor = [UIColor lightGrayColor];
    imagePlan.alpha = 0.2;
    [self addSubview:imageView4];
    
}




#pragma mark - FSComboListView

- (void)setupComboListView
{
    FSComboListView *comboListView = [[FSComboListView alloc] initWithValues:@[@"北京市丰台区马家堡社区卫生服务中心",
                                                                               @"北京市丰台区蒲黄榆社区卫生服务中心",
                                                                               @"北京市丰台区石榴园社区卫生服务中心"]
                                                                       frame:CGRectMake(SCREEN_WIDTH * 0.30, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.1)];
    comboListView.delegate = self;
    comboListView.tintColor = [UIColor darkGrayColor];
    comboListView.textColor = [UIColor darkGrayColor];
    
    
    [self addSubview:comboListView];
}



- (void) comboboxChanged:(FSComboListView *)combobox toValue:(NSString *)toValue
{
    NSLog(@"comboboxChanged to value %@",toValue);
    
}

@end
