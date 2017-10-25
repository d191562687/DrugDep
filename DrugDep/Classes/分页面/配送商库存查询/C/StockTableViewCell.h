//
//  StockTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/10/23.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"
@interface StockTableViewCell : UITableViewCell
/** 创建数据模型 */
@property (strong,nonatomic) StockModel * ActStockModel;

/**类初始化方法*/
+ (instancetype)actcellWithactStockModel:(UITableView *)tableView;

//产品编码
@property (strong,nonatomic) IBOutlet UILabel * cpbm;
//产品名称
@property (strong,nonatomic) IBOutlet UILabel * cpmc;
//产品剂型
@property (strong,nonatomic) IBOutlet UILabel * jx;
//产品规格
@property (strong,nonatomic) IBOutlet UILabel * gg;
//转换比
@property (strong,nonatomic) IBOutlet UILabel * zhb;
//生产企业
@property (strong,nonatomic) IBOutlet UILabel * scqy;
//基药标识
@property (strong,nonatomic) IBOutlet UILabel * jybj;
//配送商
@property (strong,nonatomic) IBOutlet UILabel * pss;
//库存数量
@property (strong,nonatomic) IBOutlet UILabel * kcsl;

@end
