//
//  BcodeTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/12/5.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "BcodeTableViewCell.h"


@interface BcodeTableViewCell ()<UITextFieldDelegate>

@end

@implementation BcodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UIButton * remodel = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
    remodel.backgroundColor = [UIColor redColor];
    [self addSubview:remodel];
    
    
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
//    _qlsl.titleLabel.text =  [NSString stringWithFormat:@"%.f     点击修改",actBcodeModel.qlsl.doubleValue];
    [_qlsl setTitle:[NSString stringWithFormat:@"%.f       点击修改",actBcodeModel.qlsl.doubleValue] forState:UIControlStateNormal];
    
}



@end
