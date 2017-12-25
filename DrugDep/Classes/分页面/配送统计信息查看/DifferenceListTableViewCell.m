//
//  DifferenceListTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/30.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "DifferenceListTableViewCell.h"

@implementation DifferenceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)actcellWithactDifferenceListModel:(UITableView *)tableView
{
    static NSString * identifier = @"DifferenceListTableViewCell";
    DifferenceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DifferenceListTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actDifferenceListModel 赋值操作
 */
- (void)setActDifferenceListModel:(DifferenceListModel *)actDifferenceListModel
{
    //为模型赋值
    _ActDifferenceListModel = actDifferenceListModel;
    //为控件属性赋值
    _ypmc.text = actDifferenceListModel.ypmc;
    _ypgg.text = [NSString stringWithFormat:@"药品规格：%@",actDifferenceListModel.ypgg];
    _cbdj.text = [NSString stringWithFormat:@"购入单价：%@",actDifferenceListModel.cbdj];
    _sl.text = [NSString stringWithFormat:@"出库数量：%@",actDifferenceListModel.sl];
    _sxrq.text = [NSString stringWithFormat:@"有效期：%@",actDifferenceListModel.sxrq];
    _ypdm.text = [NSString stringWithFormat:@"产品编码：%@",actDifferenceListModel.ypdm];
    _qlsl.text = actDifferenceListModel.qlsl;
    

}

@end
