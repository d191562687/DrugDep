//
//  StockTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/10/23.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "StockTableViewCell.h"
@interface StockTableViewCell()


@end

@implementation StockTableViewCell

+ (instancetype)actcellWithactStockModel:(UITableView *)tableView
{
    static NSString * identifier = @"StockTableViewCell";
    StockTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"StockTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actStockModel 赋值操作
 */
- (void)setActStockModel:(StockModel *)actStockModel
{
    //为模型赋值
    _ActStockModel = actStockModel;
    //为控件属性赋值
    _cpbm.text = actStockModel.cpbm;
    _cpmc.text = actStockModel.cpmc;
    _gg.text = actStockModel.gg;
    _zhb.text = actStockModel.zhb;
    _scqy.text = actStockModel.scqy;
    _jybj.text = actStockModel.jybj;
    _pss.text = actStockModel.pss;
    _kcsl.text = actStockModel.kcsl;

}


@end
