//
//  UserInfoManager.h
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "AccountTool.h"

@interface UserInfoManager : NSObject

/**
 单例初始化
 
 @return UserInfoManager
 */
+ (instancetype)sharedManager;


/**
 保存用户全部信息

 @param userModel 用户模型
 @param completion 完成的回调
 */
- (void)saveUserInfo:(UserInfoModel *)userModel Completion:(void (^)())completion;


/**
 获取用户全部信息
 
 @return UserInfoModel
 */
- (UserInfoModel *)getUserInfo;

/**
 更新某条信息
 
 @param key FYQConstKey里的U开头的Key
 @param value 新值
 */
- (void)updateWithKey:(NSString *)key Value:(NSString *)value;

/**
 删除信息缓存
 */
- (void)removeDataSave;


@end
