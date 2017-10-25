//
//  AddListTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/10/24.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddListModel.h"

@interface AddListTableViewCell : UITableViewCell

/** 创建数据模型 */
@property (strong,nonatomic) AddListModel * ActAddListModel;

/**类初始化方法*/
+ (instancetype)actcellWithactAddListModel:(UITableView *)tableView;

//中心名称
@property (strong,nonatomic) IBOutlet UILabel * officeName;
//编码
@property (strong,nonatomic) IBOutlet UILabel * officeCode;
//状态 1/2
@property (strong,nonatomic) IBOutlet UILabel * status;
//总金额
@property (strong,nonatomic) IBOutlet UILabel * totalAmount;
//日期
@property (strong,nonatomic) IBOutlet UILabel * oppDate;

@property (strong,nonatomic) IBOutlet UILabel * oppMan;

@end
