//
//  StockModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/10/23.
//  Copyright © 2017年 杜彪. All rights reserved.
//
//{
//    "isNewRecord": true,
//    "cpbm": "FR20T0000003000000128456",
//    "cpmc": "一清胶囊",
//    "jx": "胶囊剂",
//    "gg": "0.5g",
//    "zhb": "30",
//    "dw": "瓶",
//    "scqy": "成都康弘制药有限公司",
//    "jybj": "国家基药",
//    "pss": "华润",
//    "kcsl": "20.00"
//},
#import <Foundation/Foundation.h>

@interface StockModel : NSObject
//产品编码
@property (strong,nonatomic) NSString * cpbm;
//产品名称
@property (strong,nonatomic) NSString * cpmc;
//产品剂型
@property (strong,nonatomic) NSString * jx;
//产品规格
@property (strong,nonatomic) NSString * gg;
//转换比
@property (strong,nonatomic) NSString * zhb;
//生产企业
@property (strong,nonatomic) NSString * scqy;
//基药标识
@property (strong,nonatomic) NSString * jybj;
//配送商
@property (strong,nonatomic) NSString * pss;
//库存数量
@property (strong,nonatomic) NSString * kcsl;



@end
