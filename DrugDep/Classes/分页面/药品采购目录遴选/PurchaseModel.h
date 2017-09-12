//
//  PurchaseModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/9/12.
//  Copyright © 2017年 杜彪. All rights reserved.
//json={
//"currentPage": "1",
//"officeId": "95ce99bda3cd4309b0b114d05ffda55c",
//"pageSize": "2",
//"passWord": "test1234",
//"userName": "majp01",
//"code": "",
//"medicalname": "",
//"productname": "",
//"factoryname": "",
//"medicalmode": "",
//"packageSpec": "",
//"medicalspec": "",
//"metricname": ""
//}

#import <Foundation/Foundation.h>

@interface PurchaseModel : NSObject
//产品编码
@property (strong,nonatomic) NSString * code;
//药品名称
@property (strong,nonatomic) NSString * medicalname;
//产品名称
@property (strong,nonatomic) NSString * productname;
//生产企业
@property (strong,nonatomic) NSString * factoryname;
//药品剂型
@property (strong,nonatomic) NSString * medicalmode;
//药品规格
@property (strong,nonatomic) NSString * packageSpec;
//药品单位
@property (strong,nonatomic) NSString * medicalspec;
//药品包装规格
@property (strong,nonatomic) NSString * metricname;
//客观评分
@property (strong,nonatomic) NSString * fraction;
//全国最低价
@property (strong,nonatomic) NSString * minimun;
//企业报价
@property (strong,nonatomic) NSString * offer;
//目录范围
@property (strong,nonatomic) NSString * catalog;

@end
