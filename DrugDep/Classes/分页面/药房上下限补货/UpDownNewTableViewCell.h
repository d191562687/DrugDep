//
//  UpDownNewTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/9/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpDownNewModel.h"

@class UpDownNewModel,UpDownNewTableViewCell;

@protocol UpDownNewCellDelegate <NSObject>

- (void)updownCellDidClickPlusButton:(UpDownNewTableViewCell *)updownCell;

- (void)updownCellDidClickMinusButton:(UpDownNewTableViewCell *)updownCell;

@end

@interface UpDownNewTableViewCell : UITableViewCell

/** 创建数据模型 */
@property (strong,nonatomic) UpDownNewModel * ActFrontModel;
@property (weak,nonatomic) id<UpDownNewCellDelegate> delegate;
/**类初始化方法*/
+ (instancetype)actcellWithactFrontModel:(UITableView *)tableView;



@end
