//
//  ScanListTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/12/13.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "ScanListTableViewCell.h"

@interface ScanListTableViewCell ()<UITextFieldDelegate>

@end

@implementation ScanListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)actcellWithactScanListModel:(UITableView *)tableView
{
    static NSString * identifier = @"ScanListTableViewCell";
    ScanListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ScanListTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actScanListModel 赋值操作
 */
- (void)setActScanListModel:(ScanListModel *)actScanListModel
{
    //为模型赋值
    _ActScanListModel = actScanListModel;
    //为控件属性赋值
    _ypmc.text = actScanListModel.ypmc;
    _ypgg.text = [NSString stringWithFormat:@"药品规格：%@",actScanListModel.ypgg];
    _cbdj.text = [NSString stringWithFormat:@"购入单价：%@",actScanListModel.cbdj];
    _sl.text = [NSString stringWithFormat:@"出库数量：%@",actScanListModel.sl];
    _sxrq.text = [NSString stringWithFormat:@"有效期：%@",actScanListModel.sxrq];
    _ypdm.text = [NSString stringWithFormat:@"产品编码：%@",actScanListModel.ypdm];
    _qlsl.text =  [NSString stringWithFormat:@"%.f",actScanListModel.qlsl.doubleValue];
    
}



@end
