//
//  HisSearchModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/26.
//  Copyright © 2017年 杜彪. All rights reserved.
//"rq": 1508860800000,
//"yf": 1509465600000,
//"rkfl": "1",
//"rkdh": "8585",
//"rkph": "2017109206",
//"lydwdm": "G026",
//"lydwmc": "北京市金安健(蒲二里）",
//"jsrdm": "001",
//"jsrxm": "001",
//"czydm": "001",
//"czyxm": "001",
//"shflag": "1",
//"hjje": 936.00,
//"yfje": 936.00,
//"wfje": 936.00,
//"gs": "1",
//"officeCode": "100002         ",
//"isZx": "1",
//"djbh": "XSAQZK00011006",
//"status": "0"

#import <Foundation/Foundation.h>

@interface HisSearchModel : NSObject

//"rq": 1508860800000,  日期
@property (strong,nonatomic) NSString * rq;
//"yf": 1509465600000,  月份
@property (strong,nonatomic) NSString * yf;
//"rkfl": "1",
//"rkdh": "8585",
//"rkph": "2017109206",
//"lydwdm": "G026",
//"lydwmc": "北京市金安健(蒲二里）",名称
@property (strong,nonatomic) NSString * lydwmc;
//"jsrdm": "001",
//"jsrxm": "001",
//"czydm": "001",
//"czyxm": "001",
//"shflag": "1",
//"hjje": 936.00,
@property (assign,nonatomic)float hjje;
//"yfje": 936.00,
//"wfje": 936.00,
//"gs": "1",
//"officeCode": "100002         ",
//"isZx": "1",
//"djbh": "XSAQZK00011006",
//"status": "0"   状态
@property (strong,nonatomic) NSString * status;

@end
