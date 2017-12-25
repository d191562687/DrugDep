//
//  NetWorkDataManager.h
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessBlock)(); // 不回调参数
typedef void(^FailBlock)(NSString *errorMsg); // 错误信息的回调

typedef void (^SuccessModelBlock)(NSArray *array); // 数组类型的回调

typedef void (^SuccessStringBlock)(NSString *string); // 字符串类型的回调


@interface NetWorkDataManager : NSObject

// 初始化
+ (instancetype)sharedManager;

// 登录
- (void)loginWithUserName:(NSString *)userName PassWord:(NSString *)pass Success:(SuccessBlock)success Fail:(FailBlock)fail;

//实时追踪
- (void)trackWithSuccess:(SuccessBlock)success Fail:(FailBlock)fail;

- (void)carWithSuccess:(SuccessBlock)success Fail:(FailBlock)fail;


// 退出登录，清除当前账号的缓存
- (void)returnCurrentAccountCompletion:(void (^)())completion;

// 药房一键补货
- (void)oneRepairWithUserName:(NSString *)userName PassWord:(NSString *)pass Success:(SuccessBlock)success Fail:(FailBlock)fail;


@end
