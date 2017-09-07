//
//  HomeManager.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HomeManager.h"

@implementation HomeManager

+ (instancetype)sharedManager
{
    static HomeManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.netManager = [NetWorkDataManager sharedManager];
        self.userManager = [UserInfoManager sharedManager];
    }
    return self;
}



@end
