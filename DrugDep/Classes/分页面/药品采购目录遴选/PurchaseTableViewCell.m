//
//  PurchaseTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/9/12.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "PurchaseTableViewCell.h"

@interface PurchaseTableViewCell()
//产品编码
@property (strong,nonatomic) IBOutlet UILabel * code;
//药品名称
@property (strong,nonatomic) IBOutlet UILabel * medicalname;
//产品名称
@property (strong,nonatomic) IBOutlet UILabel * productname;
//生产企业
@property (strong,nonatomic) IBOutlet UILabel * factoryname;
//药品剂型
@property (strong,nonatomic) IBOutlet UILabel * medicalmode;
//药品规格
@property (strong,nonatomic) IBOutlet UILabel * medicalspec;
//客观评分
@property (strong,nonatomic) IBOutlet UILabel * fraction;
//全国最低价
@property (strong,nonatomic) IBOutlet UILabel * minimun;
//企业报价
@property (strong,nonatomic) IBOutlet UILabel * offer;
//目录范围
@property (strong,nonatomic) IBOutlet UILabel * catalog;

@end

@implementation PurchaseTableViewCell

+ (instancetype)actcellWithactPurchaseModel:(UITableView *)tableView
{
    static NSString * identifier = @"PurchaseTableViewCell";
    PurchaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PurchaseTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actPurchaseModel 赋值操作
 */
- (void)setActPurchaseModel:(PurchaseModel *)actPurchaseModel
{
    //为模型赋值
    _ActPurchaseModel = actPurchaseModel;
    //为控件属性赋值
    _code.text = actPurchaseModel.code;
    _productname.text = actPurchaseModel.productname;
    _factoryname.text = actPurchaseModel.factoryname;
    _medicalmode.text = actPurchaseModel.medicalmode;
    _medicalspec.text = actPurchaseModel.medicalspec;
    _fraction.text = actPurchaseModel.fraction;
    _minimun.text = actPurchaseModel.minimun;
    _offer.text = actPurchaseModel.offer;
    _catalog.text = actPurchaseModel.catalog;

}


@end
