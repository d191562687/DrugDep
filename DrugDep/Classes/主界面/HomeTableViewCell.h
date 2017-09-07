//
//  HomeTableViewCell.h
//  DrugDep
//
//  Created by 金安健 on 2017/6/22.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *imageV;
@property (strong,nonatomic) UILabel *label;
+ (instancetype)sharedHomeTableViewCell:(UITableView *)tableView;

@end
