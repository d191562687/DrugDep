//
//  DifferenceListTableViewCell.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/30.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "DifferenceListTableViewCell.h"
#import <Masonry.h>

@implementation DifferenceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self createrOneView];
    // Initialization code
}

+ (instancetype)actcellWithactDifferenceListModel:(UITableView *)tableView
{
    static NSString * identifier = @"DifferenceListTableViewCell";
    DifferenceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DifferenceListTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
    
}

/**
 重写set方法
 
 @param actDifferenceListModel 赋值操作
 */
- (void)setActDifferenceListModel:(DifferenceListModel *)actDifferenceListModel
{
    //为模型赋值
    _ActDifferenceListModel = actDifferenceListModel;
    //为控件属性赋值
    _ypmc.text = actDifferenceListModel.ypmc;
    _ypgg.text = [NSString stringWithFormat:@"药品规格：%@",actDifferenceListModel.ypgg];
    _cbdj.text = [NSString stringWithFormat:@"购入单价：%@",actDifferenceListModel.cbdj];
    _sl.text = [NSString stringWithFormat:@"出库数量：%@",actDifferenceListModel.sl];
    _sxrq.text = [NSString stringWithFormat:@"有效期：%@",actDifferenceListModel.sxrq];
    _ypdm.text = [NSString stringWithFormat:@"产品编码：%@",actDifferenceListModel.ypdm];
    _qlsl.text = actDifferenceListModel.qlsl;
    

}

- (void)createrOneView{
    
    self.firstChoose = [[UIButton alloc]init];
    self.firstChoose.backgroundColor = [UIColor whiteColor];
    [self.firstChoose setTitle:@"继续收货" forState:UIControlStateNormal];
    [self.firstChoose setTitleColor:NavColor forState:UIControlStateNormal];
    [self.firstChoose.layer setMasksToBounds:YES];
    [self.firstChoose.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.firstChoose.layer setBorderWidth:1.0]; //边框宽度
    self.firstChoose.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.firstChoose];
    
    
    self.secondChoose = [[UIButton alloc]init];
    self.secondChoose.backgroundColor = [UIColor whiteColor];
    [self.secondChoose setTitle:@"下次处理" forState:UIControlStateNormal];
    [self.secondChoose setTitleColor:NavColor forState:UIControlStateNormal];
    [self.secondChoose.layer setMasksToBounds:YES];
    [self.secondChoose.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.secondChoose.layer setBorderWidth:1.0]; //边框宽度
    self.secondChoose.layer.borderColor=[UIColor grayColor].CGColor;
    [self addSubview:self.secondChoose];
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    // 使用mas_makeConstraints添加约束

    [weakSelf.firstChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.left.equalTo(weakSelf).with.offset(40);
        make.top.mas_equalTo(@150);
    }];
    
    [weakSelf.secondChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.right.equalTo(weakSelf).with.offset(-40);
        make.top.mas_equalTo(@150);
    
    }];
    
}
@end
