//
//  GoodsCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/12/4.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GoodsCellType,
    ShopCarCellType,
    
} CellType;


@interface GoodsCell : UITableViewCell


/** 选中回调 */
@property (nonatomic,copy) dispatch_block_t callBlock;

/** 购买点击回调 */
@property (nonatomic,copy) dispatch_block_t btBlock;

/** 删除回调 */
@property (nonatomic,copy) dispatch_block_t deleteBlock;

/** cell类型 */
@property (nonatomic,assign) CellType  cellType;


@end
