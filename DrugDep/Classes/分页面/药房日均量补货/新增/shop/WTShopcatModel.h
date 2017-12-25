//
//  WTShopcatModel.h
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WTShopcatModel : NSObject
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, strong) NSMutableArray *productArray;
@end

@interface WTShopcatProductModel : NSObject
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, assign) CGFloat productPrice;


@end

@interface EveryModel : NSObject
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

@end
