//
//  AddListModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/10/24.
//  Copyright © 2017年 杜彪. All rights reserved.
//"isNewRecord": true,
//"hisPurchaseMasterCode": "2017060916233746271467",
//"buyerOrgid": "JSJY10000000000000292309",
//"officeName": "北京市丰台区马家堡社区卫生服务中心",
//"officeCode": "100001",
//"status": "1",
//"totalAmount": 414.00,
//"storeId": "30",
//"xmlStatus": "0",
//"oppDate": 1496996625000,
//"oppMan": "10f4a20dacaf4e0b8de2c578bc75b584",
//"typeCode": "",

#import <Foundation/Foundation.h>

@interface AddListModel : NSObject
//中心名称
@property (strong,nonatomic) NSString * officeName;
//编码
@property (strong,nonatomic) NSString * officeCode;
//状态 1/2
@property (strong,nonatomic) NSString * status;
//总金额
@property (strong,nonatomic) NSString * totalAmount;
//日期
@property (strong,nonatomic) NSString * oppDate;
//时间
@property (strong,nonatomic) NSString * oppMan;

@end
