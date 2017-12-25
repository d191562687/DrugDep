//
//  HisSearchTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/26.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HisSearchModel.h"

@interface HisSearchTableViewCell : UITableViewCell

//"rq": 1508860800000,  日期
@property (strong,nonatomic)  IBOutlet UILabel * rq;
//"yf": 1509465600000,  月份
@property (strong,nonatomic)  IBOutlet UILabel * yf;
//"lydwmc": "北京市金安健(蒲二里）",名称
@property (strong,nonatomic) IBOutlet  UILabel * lydwmc;
//"hjje": 936.00,
@property (strong,nonatomic)  IBOutlet UILabel * hjje;
//"status": "0"   状态
@property (strong,nonatomic)  IBOutlet UILabel * status;

/** 创建数据模型 */
@property (strong,nonatomic) HisSearchModel * ActHisSearchModel;

/**类初始化方法*/
+ (instancetype)actcellWithactHisSearchModel:(UITableView *)tableView;

@end
