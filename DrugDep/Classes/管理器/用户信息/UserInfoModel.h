//
//  UserInfoModel.h
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

// 用户名
@property (copy,nonatomic) NSString *id;
// 密码
@property (copy,nonatomic) NSString *passWord;
// isNewRecord
@property (assign,nonatomic) BOOL isNewRecord;
// remarks
@property (copy,nonatomic) NSString *remarks;
// createDate
@property (copy,nonatomic) NSString *createDate;
// updateDate
@property (copy,nonatomic) NSString *updateDate;
// 登录用户名
@property (copy,nonatomic) NSString *loginName;
// name
@property (copy,nonatomic) NSString *name;
// 邮箱
@property (copy,nonatomic) NSString *email;
// phone
@property (copy,nonatomic) NSString *phone;
// mobile
@property (copy,nonatomic) NSString *mobile;
// 登录IP
@property (copy,nonatomic) NSString *loginIp;
// 登录日期
@property (copy,nonatomic) NSString *loginDate;
// loginFlag
@property (copy,nonatomic) NSString *loginFlag;
// photo
@property (copy,nonatomic) NSString *photo;
// oldLoginIp
@property (copy,nonatomic) NSString *oldLoginIp;
// oldLoginDate
@property (copy,nonatomic) NSString *oldLoginDate;
// 是否为管理员
@property (assign,nonatomic) BOOL admin;
// roleNames
@property (copy,nonatomic) NSString *roleNames;
// 是／否
@property (copy,nonatomic) NSString *yesNo;


@end
