//
//  EveryNewTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/8.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "EveryNewTableViewCell.h"


@implementation EveryNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addView.layer.borderWidth = 1;
    self.addView.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    self.addView.layer.cornerRadius = 5;
    self.addView.layer.masksToBounds = YES;
    self.conutText.layer.borderWidth = 0.5;
    self.conutText.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    [self.selectBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [self.selectBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
}

+ (instancetype)actcellWithactEveryNewModel:(UITableView *)tableView
{
    static NSString * identifier = @"EveryNewTableViewCell";
    EveryNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"EveryNewTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actEveryNewModel 赋值操作
 */
- (void)setActEveryNewModel:(EveryNewModel *)actEveryNewModel
{
    //为模型赋值
    _ActEveryNewModel = actEveryNewModel;
    //为控件属性赋值
    _LdrugName.text = actEveryNewModel.drugName;
    _LdrugSpec.text = actEveryNewModel.drugSpec;
    _Lmanufacturer.text = actEveryNewModel.manufacturer;
    _LcostPrice.text = actEveryNewModel.costPrice;
    _Lyklower.text = actEveryNewModel.yklower;
    _Lykupper.text = actEveryNewModel.ykupper;
    _Lquantity.text = actEveryNewModel.quantity;
}

- (IBAction)selectProductAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectProductActionWithIndex:selectFlag:)]) {
        [self.delegate selectProductActionWithIndex:self.indexPath selectFlag:button.selected];
    }
}

- (IBAction)addProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addProductCountActionWithIndex:)]) {
        [self.delegate addProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)subProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(subProductCountActionWithIndex:)]) {
        [self.delegate subProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)deleteProductAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteProductActionWithIndex:)]) {
        [self.delegate deleteProductActionWithIndex:self.indexPath];
    }
}

@end
