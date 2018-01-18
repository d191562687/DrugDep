//
//  BcodeTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/12/5.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "BcodeTableViewCell.h"
#import <Masonry.h>


@interface BcodeTableViewCell ()<UITextFieldDelegate>

@end

@implementation BcodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    
    
}

+ (instancetype)actcellWithactBcodeModel:(UITableView *)tableView
{
    static NSString * identifier = @"BcodeTableViewCell";
    BcodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BcodeTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");

    }
    return cell;
    
}

/**
 重写set方法
 
 @param actBcodeModel 赋值操作
 */
- (void)setActBcodeModel:(BcodeModel *)actBcodeModel
{
    //为模型赋值
    _ActBcodeModel = actBcodeModel;
    //为控件属性赋值
    _ypmc.text = actBcodeModel.ypmc;
    _ypgg.text = [NSString stringWithFormat:@"药品规格：%@",actBcodeModel.ypgg];
    _cbdj.text = [NSString stringWithFormat:@"购入单价：%@",actBcodeModel.cbdj];
    _sl.text = [NSString stringWithFormat:@"出库数量：%@",actBcodeModel.sl];
    _sxrq.text = [NSString stringWithFormat:@"有效期：%@",actBcodeModel.sxrq];
    _ypdm.text = [NSString stringWithFormat:@"产品编码：%@",actBcodeModel.ypdm];
//    [_qlsl setTitle:[NSString stringWithFormat:@"%.f       点击修改",actBcodeModel.qlsl.doubleValue] forState:UIControlStateNormal];
    _status.text = [NSString stringWithFormat:@"%@",actBcodeModel.status];
    _qlsl.text = [NSString stringWithFormat:@"实收数量：%.f",actBcodeModel.qlsl.doubleValue];
    
    
    NSLog(@"-状态   %@ ",actBcodeModel.status);
    if ([actBcodeModel.status isEqualToString:@"1"]) {
        _qlsl.text = [NSString stringWithFormat:@"实收数量：%.f",actBcodeModel.qlsl.doubleValue];
        [self createrRepeatView];
    }else if ([actBcodeModel.status isEqualToString:@"3"])
    {
        _qlsl.text = [NSString stringWithFormat:@"退货数量：%.f",actBcodeModel.qlsl.doubleValue];
        [self createrRepeatView];
    }else if ([actBcodeModel.status isEqualToString:@"0"])
    {
        [self createrOneView];
    }
    else if ([actBcodeModel.status isEqualToString:@"2"])
    {
        [self createrOneView];
    }

}
- (void)createrOneView{
    
    self.firstChoose = [[UIButton alloc]init];
    self.firstChoose.backgroundColor = [UIColor whiteColor];
    [self.firstChoose setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.firstChoose setTitleColor:NavColor forState:UIControlStateNormal];
    [self.firstChoose.layer setMasksToBounds:YES];
    [self.firstChoose.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.firstChoose.layer setBorderWidth:1.0]; //边框宽度
    self.firstChoose.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.firstChoose];
    
    
    self.secondChoose = [[UIButton alloc]init];
    self.secondChoose.backgroundColor = [UIColor whiteColor];
    [self.secondChoose setTitle:@"退货" forState:UIControlStateNormal];
    [self.secondChoose setTitleColor:NavColor forState:UIControlStateNormal];
    [self.secondChoose.layer setMasksToBounds:YES];
    [self.secondChoose.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.secondChoose.layer setBorderWidth:1.0]; //边框宽度
    self.secondChoose.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.secondChoose];
    
    self.alterButton = [[UIButton alloc]init];
    self.alterButton.backgroundColor = [UIColor whiteColor];
    self.alterButton.alpha = 0.8;
    self.alterButton.titleLabel.font = [UIFont systemFontOfSize:15];;
    [self.alterButton setTitle:@"修改数量" forState:UIControlStateNormal];
    [self.alterButton setTitleColor:NavColor forState:UIControlStateNormal];
//    [self.alterButton.layer setMasksToBounds:YES];
//    [self.alterButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//    [self.alterButton.layer setBorderWidth:1.0]; //边框宽度
//    self.alterButton.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.alterButton];
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    // 使用mas_makeConstraints添加约束
    [weakSelf.alterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@20);
        make.width.width.offset(80);
        make.centerX.equalTo(weakSelf);
        make.top.width.offset(122);
    }];
    
    [weakSelf.firstChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.left.equalTo(weakSelf).with.offset(40);
        make.top.equalTo(self.alterButton.mas_bottom).with.offset(6);
    }];
    
    [weakSelf.secondChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.right.equalTo(weakSelf).with.offset(-40);
        make.top.equalTo(self.alterButton.mas_bottom).with.offset(6);
    }];
}

- (void)createrRepeatView{

    
    self.remodelButton = [[UIButton alloc]init];
    self.remodelButton.backgroundColor = [UIColor whiteColor];
    [self.remodelButton setTitle:@"重制药品" forState:UIControlStateNormal];
    [self.remodelButton setTitleColor:NavColor forState:UIControlStateNormal];
    [self.remodelButton.layer setMasksToBounds:YES];
    [self.remodelButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.remodelButton.layer setBorderWidth:1.0]; //边框宽度
    self.remodelButton.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.remodelButton];
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    // 使用mas_makeConstraints添加约束
    [self.remodelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.left.equalTo(weakSelf).with.offset(30);
        make.right.equalTo(weakSelf).with.offset(-30);
        make.top.with.offset(150);
    }];

}


@end
