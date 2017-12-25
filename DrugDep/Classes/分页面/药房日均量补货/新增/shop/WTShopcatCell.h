//
//  WTShopcatCell.h
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTShopcatModel.h"

@protocol WTShopcatCellDelegate <NSObject>

@optional
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag;
- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath;

@end

static NSString * const WTShopcatCells = @"WTShopcatCell";
@interface WTShopcatCell : UITableViewCell

@property (assign ,nonatomic) id<WTShopcatCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIView *addView;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *rpoductImage;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *delectBtn;

@property (weak, nonatomic) IBOutlet UITextField *conutText;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;


//名称
@property (strong, nonatomic) IBOutlet UILabel *LdrugName;
//规格
@property (strong, nonatomic) UILabel *LdrugSpec;
//厂家
@property (strong, nonatomic) IBOutlet  UILabel *Lmanufacturer;
//价格
@property (strong, nonatomic)  UILabel *LcostPrice;
//药库下限
@property (strong, nonatomic)  UILabel *Lyklower;
//药库上线
@property (strong, nonatomic)  UILabel *Lykupper;
//数量
@property (strong, nonatomic) IBOutlet  UILabel *Lquantity;

/** 创建数据模型 */
@property (strong,nonatomic) EveryModel * ActEveryModel;

/**类初始化方法*/
+ (instancetype)actcellWithactEveryModel:(UITableView *)tableView;


@end
