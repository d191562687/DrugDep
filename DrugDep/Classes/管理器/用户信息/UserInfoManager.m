//
//  UserInfoManager.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

#pragma mark - 单例初始化
+ (instancetype)sharedManager
{
    static UserInfoManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}
#pragma mark - 保存数据
- (void)saveUserInfo:(UserInfoModel *)userModel Completion:(void (^)())completion
{
    [self removeDataSave];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:userModel.id forKey:@"userID"];
    [dict setValue:userModel.passWord forKey:@"passWord"];
    Account *account = [Account accountWithDict:dict];
    [AccountTool saveAccount:account];
    
    
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    [UD setObject:userModel.id forKey:Uid];
    [UD setObject:userModel.passWord forKey:UpassWord];
    [UD setObject:[NSString stringWithFormat:@"%d",userModel.isNewRecord] forKey:UisNewRecord];
    [UD setObject:userModel.remarks forKey:Uremarks];
    [UD setObject:userModel.createDate forKey:UcreateDate];
    [UD setObject:userModel.updateDate forKey:UupdateDate];
    [UD setObject:userModel.loginName forKey:UloginName];
    [UD setObject:userModel.name forKey:Uname];
    [UD setObject:userModel.email forKey:Uemail];
    [UD setObject:userModel.phone forKey:Uphone];
    [UD setObject:userModel.mobile forKey:Umobile];
    [UD setObject:userModel.loginIp forKey:UloginIp];
    [UD setObject:userModel.loginDate forKey:UloginDate];
    [UD setObject:userModel.loginFlag forKey:UloginFlag];
    [UD setObject:userModel.phone forKey:Uphoto];
    [UD setObject:userModel.oldLoginIp forKey:UoldLoginIp];
    [UD setObject:userModel.oldLoginDate forKey:UoldLoginDate];
    [UD setObject:[NSString stringWithFormat:@"%d",userModel.admin] forKey:Uadmin];
    [UD setObject:userModel.roleNames forKey:UroleNames];
    
    [UD synchronize];
    
    completion();
    
}
#pragma mark - 更新缓存
- (void)updateWithKey:(NSString *)key Value:(NSString *)value
{
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    [UD setObject:value forKey:key];
    [UD synchronize];
}

#pragma mark - 清除缓存
- (void)removeDataSave
{
    
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    // 用户信息
    [UD removeObjectForKey:Uid];
    [UD removeObjectForKey:UpassWord];
    [UD removeObjectForKey:UisNewRecord];
    [UD removeObjectForKey:Uremarks];
    [UD removeObjectForKey:UcreateDate];
    [UD removeObjectForKey:UupdateDate];
    [UD removeObjectForKey:UloginName];
    [UD removeObjectForKey:Uname];
    [UD removeObjectForKey:Uemail];
    [UD removeObjectForKey:Uphone];
    [UD removeObjectForKey:Umobile];
    [UD removeObjectForKey:UloginIp];
    [UD removeObjectForKey:UloginDate];
    [UD removeObjectForKey:UloginFlag];
    [UD removeObjectForKey:Uphoto];
    [UD removeObjectForKey:UoldLoginIp];
    [UD removeObjectForKey:UoldLoginDate];
    [UD removeObjectForKey:Uadmin];
    [UD removeObjectForKey:UroleNames];
    
    // 其他UserDefaults缓存
    
    
}

#pragma mark - 获取用户模型
- (UserInfoModel *)getUserInfo
{
    UserInfoModel *userModel = [[UserInfoModel alloc]init];
    
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    NSString *userID = [UD objectForKey:Uid];
    NSString *passWord = [UD objectForKey:UpassWord];
    BOOL isNewRecord = [[UD objectForKey:UisNewRecord] boolValue];
    NSString *remarks = [UD objectForKey:Uremarks];
    NSString *createDate = [UD objectForKey:UcreateDate];
    NSString *updateDate = [UD objectForKey:UupdateDate];
    NSString *loginName = [UD objectForKey:UloginName];
    NSString *name = [UD objectForKey:Uname];
    NSString *email = [UD objectForKey:Uemail];
    NSString *phone = [UD objectForKey:Uphone];
    NSString *mobile = [UD objectForKey:Umobile];
    NSString *loginIp = [UD objectForKey:UloginIp];
    NSString *loginDate = [UD objectForKey:UloginDate];
    NSString *loginFlag = [UD objectForKey:UloginFlag];
    NSString *photo = [UD objectForKey:Uphoto];
    NSString *oldLoginIp = [UD objectForKey:UoldLoginIp];
    NSString *oldLoginDate = [UD objectForKey:UoldLoginDate];
    BOOL admin = [[UD objectForKey:Uadmin] boolValue];
    NSString *roleNames = [UD objectForKey:UroleNames];
    
    
    userModel.id = userID;
    userModel.passWord = passWord;
    userModel.isNewRecord = isNewRecord;
    userModel.remarks = remarks;
    userModel.createDate = createDate;
    userModel.updateDate = updateDate;
    userModel.loginName = loginName;
    userModel.name = name;
    userModel.email = email;
    userModel.phone = phone;
    userModel.mobile = mobile;
    userModel.loginIp = loginIp;
    userModel.loginDate = loginDate;
    userModel.loginFlag = loginFlag;
    userModel.photo = photo;
    userModel.oldLoginIp = oldLoginIp;
    userModel.oldLoginDate = oldLoginDate;
    userModel.admin = admin;
    userModel.roleNames = roleNames;
    
    return userModel;
}


@end
