//
//  DifferenceListModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/30.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DifferenceListModel : NSObject

//"bzph": "170712",
//"cbdj": 28.35,
//"cbje": 2551.50,
//"ckdh": "1716",
//"ckdwdm": "30",
//"ckfl": "4",
//"ckh": "20",
//"djSn": "2",
//"djbh": "XSAQZK00011716",
//"dw": "盒",
//"essentialDrugs": "1",
//"gs": "0",
//"isZx": "0",
//"jajNo": "201700011716002",
//"lcjypBz": "1",
//"lsdj": 28.35,
//"lsje": 2551.50,
//"lydwdm": "G016",
//"lydwmc": "国药集团药业股份有限公司",
//"officeCode": "100001",
//"pfdj": 28.35,
//"pfje": 2551.50,
//"pici": "JHAQZK00008220_3    ",
//"qlsl": "90.000",
//"rkph": "7011716002",
//"rq": 1511712000000,
//"shflag": "0",
//"sl": 90.000,
//"sptm": "6920583602702 ",
//"sqrq": 1511712000000,
//"status": "0",
//"sxrq": 1593446400000,
//"yf": "2017-12-01 00:00:00.0",
//"ypdm": "c00496",
//"ypgg": "0.6g*36片",
//"ypmc": "养心氏片"


//药品名称
@property (strong,nonatomic) NSString * ypmc;
//规格
@property (strong,nonatomic) NSString * ypgg;
//"status": "0",
@property (strong,nonatomic) NSString * status;
//cbdj;        // 购入单价
@property (strong,nonatomic) NSString * cbdj;
//"lydwmc": "国药集团药业股份有限公司",
@property (strong,nonatomic) NSString * lydwmc;
//BigDecimal sl;        // 实发数量
@property (strong,nonatomic) NSString * sl;
//Date sxrq;        // 有效期
@property (strong,nonatomic) NSString * sxrq;
//String ypdm;        // 药品编码
@property (strong,nonatomic) NSString * ypdm;
//String qlsl;        // 申请数量
@property (strong,nonatomic) NSString * qlsl;


@end
