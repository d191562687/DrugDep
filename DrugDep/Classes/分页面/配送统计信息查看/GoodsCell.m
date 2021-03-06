//
//  GoodsCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/12/4.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "GoodsCell.h"
#import "ShopCarModel.h"

@interface GoodsCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ypmc;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic) ShopCarModel *carModel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addBt;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UIButton *reduceBt;
@property (weak, nonatomic) IBOutlet UIButton *buyBt;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation GoodsCell

- (void)awakeFromNib {
    
    
}

//重写set方法
- (void)setCarModel:(ShopCarModel *)carModel
{
    //在每次设置观察者之前先提前移除，防止之前的没移除
    [_carModel removeObserver:self forKeyPath:@"goodsSelectCount"];
    _carModel = carModel;
    [_carModel addObserver:self forKeyPath:@"goodsSelectCount" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)dealloc
{
    [self.carModel removeObserver:self forKeyPath:@"goodsSelectCount"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    int  newCount =   [change[@"new"] intValue];
    
    _textField.text = [NSString stringWithFormat:@"%d",newCount];
    
    [self setTing:newCount andIsAddOrReduce:YES];
    
    if (self.callBlock) {
        self.callBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setTing:(NSInteger)count andIsAddOrReduce:(BOOL)isAddOrReduce
{
    //在商品列表中,如果没有商品数量是0那么取消减少与添加到购物车的交互。
    if (self.carModel.goodsSelectCount <=0) {
        self.reduceBt.enabled = NO;
        self.buyBt.enabled = NO;
        
    }else{
        self.reduceBt.enabled = YES;
        self.buyBt.enabled = YES;
        
        if (isAddOrReduce) {
            //判断一下如果是在购物车中，需要更新数据库信息
            if (self.cellType == ShopCarCellType) {
                
            }
        }
        
    }
    
    //判断一下如果是在购物车中
    if (self.cellType == ShopCarCellType) {
        //小于等于1 静止减少
        if (self.carModel.goodsSelectCount <=1) {
            self.reduceBt.enabled = NO;
        }else{
            self.reduceBt.enabled = YES;
        }
        
    }
    
    double allPrice = count * self.carModel.price;
    self.allPrice.text = [NSString stringWithFormat:@"总价：%.2f",allPrice];
    
}

/**
 *  选中
 *
 *  @param sender button
 */
- (IBAction)selectButton:(id)sender {
    
    self.carModel.select = !self.carModel.select;
    
    
}

/**
 *  购买
 *
 *  @param sender button
 */
- (IBAction)buyGood:(id)sender {
    if (self.btBlock) {
        self.btBlock();
    }
}

/**
 *  增加
 *
 *  @param sender button
 */
- (IBAction)add:(UIButton *)sender {
    
    self.carModel.goodsSelectCount ++;
}

/**
 *  减少
 *
 *  @param sender button
 */
- (IBAction)reduce:(UIButton *)sender {
    
    if (self.carModel.goodsSelectCount>0) {
        self.carModel.goodsSelectCount --;
    }
    
}

/**
 *  删除
 *
 *  @param sender button
 */
- (IBAction)deleteBt:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    
    self.textField.text = [NSString stringWithFormat:@"%@",textField.text];
    self.carModel.goodsSelectCount = [textField.text intValue];
    NSLog(@"%@",textField.text);
}


@end
