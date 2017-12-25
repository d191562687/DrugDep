//
//  EveryNewTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/8.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryNewModel.h"

@protocol EveryNewTableViewCellDelegate<NSObject>
@optional
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag;
- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath;
@end

static NSString * const EveryNewTableViewCells = @"EveryNewTableViewCell";

@interface EveryNewTableViewCell : UITableViewCell

@property (assign ,nonatomic) id<EveryNewTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UIView *addView;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIButton *delectBtn;

@property (weak, nonatomic) IBOutlet UITextField *conutText;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

//名称
@property (strong, nonatomic) IBOutlet UILabel *LdrugName;
//规格
@property (strong, nonatomic) IBOutlet UILabel *LdrugSpec;
//厂家
@property (strong, nonatomic) IBOutlet UILabel *Lmanufacturer;
//价格
@property (strong, nonatomic) IBOutlet UILabel *LcostPrice;
//药库下限
@property (strong, nonatomic) IBOutlet UILabel *Lyklower;
//药库上线
@property (strong, nonatomic) IBOutlet UILabel *Lykupper;
//数量
@property (strong, nonatomic) IBOutlet UILabel *Lquantity;




/** 创建数据模型 */
@property (strong,nonatomic) EveryNewModel * ActEveryNewModel;

/**类初始化方法*/
+ (instancetype)actcellWithactEveryNewModel:(UITableView *)tableView;


@end
