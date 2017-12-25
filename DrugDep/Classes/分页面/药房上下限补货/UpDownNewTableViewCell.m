 //
//  UpDownNewTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/9/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "UpDownNewTableViewCell.h"
#import "UITextField+IndexPath.h"

@interface UpDownNewTableViewCell ()<UITextFieldDelegate>
//名称
@property (strong, nonatomic) IBOutlet UILabel *LdrugName;
//规格
@property (strong, nonatomic) IBOutlet UILabel *LdrugSpec;
//厂家
@property (strong, nonatomic) IBOutlet UILabel *Lmanufacturer;
//价格
@property (strong, nonatomic) IBOutlet UILabel *LcostPrice;
//总价
@property (weak, nonatomic) IBOutlet NSString * allPrice;
//总价显示
@property (weak, nonatomic) IBOutlet UILabel * allPriceText;
//购买数量
@property (weak, nonatomic) IBOutlet UITextField *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantity;

@property (weak, nonatomic) IBOutlet UIButton *minusBtu;

@property (nonatomic, copy) NSString *string;

@property (strong,nonatomic) MBProgressHUD * HUD;
@end

@implementation UpDownNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)actcellWithactFrontModel:(UITableView *)tableView
{
    
    static NSString * identifier = @"UpDownNewTableViewCell";
    UpDownNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"UpDownNewTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}


- (IBAction)plusButton {
    
    self.ActFrontModel.count++;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.ActFrontModel.count];
   // self.minusBtu.enabled = YES;
    
    double total = self.ActFrontModel.count * _ActFrontModel.costPrice.doubleValue;
    self.allPriceText.text = [NSString stringWithFormat:@"%.2f",total];
  
    [self.delegate updownCellDidClickPlusButton:self];
    
}

- (IBAction)minusButton {
    
    self.ActFrontModel.count--;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.ActFrontModel.count];
    if (self.ActFrontModel.count == 0) {
        self.minusBtu.enabled = NO;
    }
    
    double total = self.ActFrontModel.count * _ActFrontModel.costPrice.doubleValue;
    self.allPriceText.text = [NSString stringWithFormat:@"%.2f",total];
    
    [self.delegate updownCellDidClickMinusButton:self];
    
}




/**
 重写set方法
 
 @param actFrontModel 赋值操作
 */
- (void)setActFrontModel:(UpDownNewModel *)actFrontModel
            andIndexPath:(NSIndexPath *)indexPath
{
    
    //为模型赋值
    _ActFrontModel = actFrontModel;
    //为控件属性赋值
    self.LdrugName.text = actFrontModel.drugName;
    self.LdrugSpec.text = actFrontModel.drugSpec;
    self.Lmanufacturer.text = actFrontModel.manufacturer;
    self.LcostPrice.text =[NSString stringWithFormat:@"¥%@",actFrontModel.costPrice];
    self.quantity.text = [NSString stringWithFormat:@"最多补货：%@",actFrontModel.quantity];
    self.countLabel.text = actFrontModel.quantity;

    self.countLabel.text = [NSString stringWithFormat:@"%@",actFrontModel.quantity];
    double total = self.countLabel.text.doubleValue * _ActFrontModel.costPrice.doubleValue;
    self.allPriceText.text = [NSString stringWithFormat:@"%.2f",total];
    
    self.countLabel.indexPath = indexPath;
    // 根据count决定countLabel显示文字
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.ActFrontModel.count];
    // 根据count决定减号按钮是否能够被点击（如果不写这一行代码，会出现cell复用)
    //    _minusBtu.enabled = (actFrontModel.count > 0);;
    
}

//- (void)setDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexPath{
//    // 核心代码
//    self.countLabel.indexPath = indexPath;
//    self.countLabel.text = dataString;
//}


@end
