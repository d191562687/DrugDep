//
//  AddListTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/10/24.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "AddListTableViewCell.h"

@implementation AddListTableViewCell

+ (instancetype)actcellWithactAddListModel:(UITableView *)tableView
{
    static NSString * identifier = @"AddListTableViewCell";
    AddListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddListTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actAddListModel 赋值操作
 */
- (void)setActAddListModel:(AddListModel *)actAddListModel
{
    //为模型赋值
    _ActAddListModel = actAddListModel;
    //为控件属性赋值
    _officeName.text = actAddListModel.officeName;
    _officeCode.text = actAddListModel.officeCode;
    //判断状态
    if ([actAddListModel.status  isEqual: @"1"]) {
        _status.text = @"暂存";
    }else if ([actAddListModel.status  isEqual: @"2"]){
        _status.text = @"提交";
    }
    //总金额
    _totalAmount.text = [NSString stringWithFormat:@"%.2f",actAddListModel.totalAmount.doubleValue];
    //时间转换
    NSString * timeStampString = [NSString stringWithFormat:@"%@",actAddListModel.oppDate];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _oppDate.text = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
 
}

@end
