//
//  FrontTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/8/9.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "FrontTableViewCell.h"

@interface FrontTableViewCell ()
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

@end
@implementation FrontTableViewCell

+ (instancetype)actcellWithactFrontModel:(UITableView *)tableView
{
    static NSString * identifier = @"FrontTableViewCell";
    FrontTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FrontTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;

}

/**
 重写set方法
 
 @param actFrontModel 赋值操作
 */
- (void)setActFrontModel:(FrontViewModel *)actFrontModel
{
    //为模型赋值
    _ActFrontModel = actFrontModel;
    //为控件属性赋值
    _LdrugName.text = actFrontModel.drugName;
    _LdrugSpec.text = actFrontModel.drugSpec;
    _Lmanufacturer.text = actFrontModel.manufacturer;
    _LcostPrice.text = actFrontModel.costPrice;
    _Lyklower.text = actFrontModel.yklower;
    _Lykupper.text = actFrontModel.ykupper;
    _Lquantity.text = actFrontModel.quantity;
}

@end
