//
//  HomeManager.h
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoManager.h"
#import "NetWorkDataManager.h"


/************ 工程的总管理者，管理所有的网络数据和用户信息。或其他的 ***********/
@interface HomeManager : NSObject

/** 单利初始化 */
+ (instancetype)sharedManager;

@property (strong,nonatomic) NetWorkDataManager *netManager;

@property (strong,nonatomic) UserInfoManager *userManager;

@end
