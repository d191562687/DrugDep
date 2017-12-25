//
//  HisSearchTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/26.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HisSearchTableViewCell.h"


@implementation HisSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)actcellWithactHisSearchModel:(UITableView *)tableView
{
    static NSString * identifier = @"HisSearchTableViewCell";
    HisSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HisSearchTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actHisSearchModel 赋值操作
 */
- (void)setActHisSearchModel:(HisSearchModel *)actHisSearchModel
{
    
        //为模型赋值
    _ActHisSearchModel = actHisSearchModel;
    //为控件属性赋值
    _lydwmc.text = [NSString stringWithFormat:@"药房名称：         %@",actHisSearchModel.lydwmc];
    _hjje.text = [NSString stringWithFormat:@"总价：                       %.2f",actHisSearchModel.hjje];
    _status.text = actHisSearchModel.status;

    //时间转换
    NSString * timeStampString = [NSString stringWithFormat:@"%@",actHisSearchModel.yf];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    
    NSString * timeStampString1 = [NSString stringWithFormat:@"%@",actHisSearchModel.rq];
    NSTimeInterval _interval1=[timeStampString1 doubleValue] / 1000.0;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:_interval1];
    NSDateFormatter *objDateformat1 = [[NSDateFormatter alloc] init];
    [objDateformat1 setDateFormat:@"HH:mm:ss"];
    _rq.text = [NSString stringWithFormat:@"入库时间：         %@   %@",[objDateformat stringFromDate: date],[objDateformat1 stringFromDate: date1]];
}

@end
