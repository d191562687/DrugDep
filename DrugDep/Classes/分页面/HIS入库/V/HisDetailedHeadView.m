//
//  HisDetailedHeadView.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HisDetailedHeadView.h"

@implementation HisDetailedHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    //机构选择
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label1.text = @"药房名称:";
    [self addSubview:label1];
    
    UITextField * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.4, SCREEN_WIDTH * 0.1)];
    textField1.placeholder = @"";
    [self addSubview:textField1];
    
    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.13, SCREEN_WIDTH, 1)];
    imageView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView1.alpha = 0.7;
    [self addSubview:imageView1];
    //类型选择
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05,SCREEN_WIDTH * 0.15, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label2.text = @"药品类型:";
    [self addSubview:label2];
    
    UITextField * textField2 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.15, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    textField2.placeholder = @"";
    [self addSubview:textField2];
    
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.26, SCREEN_WIDTH, 1)];
    imageView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView2.alpha = 0.7;
    [self addSubview:imageView2];
    //药房选择
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    label3.text = @"入库日期:";
    [self addSubview:label3];
    
    UITextField * textField3 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.28, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
    textField3.placeholder = @"";
    [self addSubview:textField3];
    
    UIImageView * imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.39, SCREEN_WIDTH, 1)];
    imageView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView3.alpha = 0.7;
    [self addSubview:imageView3];
    
    
}

@end
