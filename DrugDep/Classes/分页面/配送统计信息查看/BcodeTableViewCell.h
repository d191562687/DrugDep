//
//  BcodeTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/12/5.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BcodeModel.h"


@interface BcodeTableViewCell : UITableViewCell

//"ypmc": "养心氏片"
@property (weak, nonatomic) IBOutlet UILabel * ypmc;
//"ypgg": "0.6g*36片",
@property (weak, nonatomic) IBOutlet UILabel * ypgg;
//"status": "0",
@property (weak, nonatomic) IBOutlet UILabel * status;
//cbdj;        // 购入单价
@property (strong,nonatomic) IBOutlet UILabel * cbdj;
//"lydwmc": "国药集团药业股份有限公司",
@property (strong,nonatomic) IBOutlet UILabel * lydwmc;
//BigDecimal sl;        // 实发数量
@property (strong,nonatomic) IBOutlet UILabel * sl;
//Date sxrq;        // 有效期
@property (strong,nonatomic) IBOutlet UILabel * sxrq;
//String ypdm;        // 药品编码
@property (strong,nonatomic) IBOutlet UILabel * ypdm;
//String qlsl;        // 申请数量
@property (strong,nonatomic) IBOutlet UIButton * qlsl;
//退款
@property (strong, nonatomic) IBOutlet UIButton *refund;

@property (weak, nonatomic) IBOutlet UIButton *firstChoose;
@property (weak, nonatomic) IBOutlet UIButton *secondChoose;

/** 创建数据模型 */
@property (strong,nonatomic) BcodeModel * ActBcodeModel;

/**类初始化方法*/
+ (instancetype)actcellWithactBcodeModel:(UITableView *)tableView;


@end
