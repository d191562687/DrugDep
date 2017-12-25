//
//  BcodeModel.h
//  DrugDep
//
//  Created by 金安健 on 2017/12/5.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BcodeModel : NSObject

//药品名称
@property (strong,nonatomic) NSString * ypmc;
//规格
@property (strong,nonatomic) NSString * ypgg;
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
