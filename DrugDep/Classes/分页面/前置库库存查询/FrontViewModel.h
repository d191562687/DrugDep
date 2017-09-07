//
//  FrontViewModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/8/9.
//  Copyright © 2017年 杜彪. All rights reserved.
//"desc": "操作成功",
//"data": [
//         {
//             "isNewRecord": true,
//             "quantity": 150,
//             "officeCode": "100001",
//             "drugstockCode": "20",
//             "drugstockName": "中成药库",
//             "typeCode": "0",
//             "typeName": "中成药",
//             "drugCode": "c00016",
//             "drugSpec": "0.35g*48粒",
//             "drugName": "清热散结胶囊",
//             "drugUnit": "盒",
//             "invalidateDate": "2019-01-31",
//             "drugBatch": "170204",
//             "costPrice": 25.23,
//             "wholesalePrice": 25.23,
//             "retailPrice": 25.23,
//             "yklower": 20,
//             "ykupper": 193,
//             "yfupper": 20,
//             "yflower": 10,
//             "lcjypBz": "1",
//             "inputCode": "QRSJJN",
//             "ykcgFlag": "0",
//             "manufacturer": "江西普正制药有限公司",
//             "ykFrom": "1",
//             "flag": "0",
//             "daycount": 1
//         },

#import <Foundation/Foundation.h>

@interface FrontViewModel : NSObject
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
