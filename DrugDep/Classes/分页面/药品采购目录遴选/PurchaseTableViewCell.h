//
//  PurchaseTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/9/12.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseModel.h"
@interface PurchaseTableViewCell : UITableViewCell

/** 创建数据模型 */
@property (strong,nonatomic) PurchaseModel * ActPurchaseModel;

/**类初始化方法*/
+ (instancetype)actcellWithactPurchaseModel:(UITableView *)tableView;


@end
