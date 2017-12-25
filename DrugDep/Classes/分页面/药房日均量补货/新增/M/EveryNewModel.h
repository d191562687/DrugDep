//
//  EveryNewModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/8.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryNewModel : NSObject

//名称
@property (strong,nonatomic) NSString * drugName;
//规格
@property (strong,nonatomic) NSString * drugSpec;
//厂家
@property (strong,nonatomic) NSString * manufacturer;
//价格
@property (strong,nonatomic) NSString * costPrice;
//药库下限
@property (strong,nonatomic) NSString * yklower;
//药库上线
@property (strong,nonatomic) NSString * ykupper;
//数量
@property (strong,nonatomic) NSString * quantity;
//种类
@property (strong,nonatomic) NSString * typeName;


@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, assign) CGFloat productPrice;



@end
