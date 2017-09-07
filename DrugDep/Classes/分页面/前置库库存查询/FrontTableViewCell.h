//
//  FrontTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/8/9.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontViewModel.h"

@interface FrontTableViewCell : UITableViewCell
/** 创建数据模型 */
@property (strong,nonatomic) FrontViewModel * ActFrontModel;

/**类初始化方法*/
+ (instancetype)actcellWithactFrontModel:(UITableView *)tableView;

@end
