//
//  NetWorkDataManager.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "NetWorkDataManager.h"
#import <MJExtension/MJExtension.h>
#import "HTTPManager.h"
#import <SDWebImage/SDImageCache.h>

@implementation NetWorkDataManager

#pragma mark - 初始化
+ (instancetype)sharedManager
{
    static NetWorkDataManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

// 登录
- (void)loginWithUserName:(NSString *)userName PassWord:(NSString *)pass Success:(SuccessBlock)success Fail:(FailBlock)fail
{
    
//    NSString *url = @"http://124.207.212.87:8098/app/user/loginUser";
//    NSString *url = @"http://192.168.1.34:9000/a/login"; // 外网 124.193.134.76:9000
    NSString *url = @"http://192.168.1.34:9000/app/user/loginUser";
    
    NSDictionary *params = @{
                             @"userName":userName,
                             @"passWord" :pass
                             };
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    

    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"登录返回 = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *message = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
        NSDictionary *user = [responseObject objectForKey:@"user"];
//#warning office的信息没保存，方法跟保存user一样  
        NSDictionary *officeid = [responseObject objectForKey:@"office"];
        NSString * dicId = [officeid objectForKey:@"id"];

            // 保存用户信息
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:user];
            userModel.passWord = pass;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:dicId forKey:@"dicID"];
            [self saveUserInfoWithModel:userModel Competion:^{
                success();
            }];
        }else{
            fail(message);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        fail(error.localizedDescription);
        NSLog(@"错误：   %@",error.localizedDescription);
    }];
}

// 保存用户信息
- (void)saveUserInfoWithModel:(UserInfoModel *)userModel Competion:(void (^)())completion
{
    [[UserInfoManager sharedManager] saveUserInfo:userModel Completion:^{
        completion();
    }];
}
// 退出登录，清除当前账号的缓存
- (void)returnCurrentAccountCompletion:(void (^)())completion
{
    // [[SDImageCache sharedImageCache] cleanDisk];
    [[HomeManager sharedManager].userManager removeDataSave];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件。这里的t_address.sqlite是测试的名，本地数据库，只删数据，不删文件。
            if ([fileName isEqualToString:@"t_address.sqlite"]) {
                // 不删除这些。用户信息、离线订单、归档
                
                completion();
                
            }else{
                NSError *error;
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:&error];
                completion();
            }
        }
    }
}


- (NSString *)switchToJsonStrFrom:(id)object
{
    NSError *error = nil;
    // ⚠️ 参数可能是模型数组，需要转字典数组
    if (object) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        if (jsonData.length < 5 || error) {
            KGLog(@"解析错误");
        }
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

//实时追踪
- (void)trackWithSuccess:(SuccessBlock)success Fail:(FailBlock)fail{
    
    NSString *url = @"http://192.168.1.231:9000/transfer-manager-web/app/appCarSingeRealLocation/areaDetal.do";
    //    NSString *url = @"http://192.168.1.231:9000/transfer-manager-web/app/appCarSingeRealLocation/carList.do"; // 外网
    
    NSDictionary *params = @{
                             @"vehicle":@"京HX1890"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"实时追踪 = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *message = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            NSDictionary *Vehicle = [responseObject objectForKey:@"Vehicle"];
#warning office的信息没保存，方法跟保存user一样
#warning NSDictionary *office = [responseObject objectForKey:@"office"];
            NSLog(@"实时追踪=== %@",Vehicle);
            
            // 保存用户信息
//            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:user];
//            userModel.passWord = pass;
//            [self saveUserInfoWithModel:userModel Competion:^{
//                success();
//            }];
        }else{
            fail(message);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        fail(error.localizedDescription);
        NSLog(@"错误：   %@",error.localizedDescription);
    }];

  
    
}

- (void)carWithSuccess:(SuccessBlock)success Fail:(FailBlock)fail{
    
    NSString *url = @"http://192.168.1.231:9000/transfer-manager-web/app/appCarSingeRealLocation/areaDetal.do";
    NSDictionary *params = @{
                             @"vehicle":@"京HX1890"
                             };
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"追踪 = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *message = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {

#warning office的信息没保存，方法跟保存user一样
#warning NSDictionary *office = [responseObject objectForKey:@"office"];

        }else{
            fail(message);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        fail(error.localizedDescription);
        NSLog(@"错误：   %@",error.localizedDescription);
    }];
    
    
}

// 药房一键补货
- (void)oneRepairWithUserName:(NSString *)userName PassWord:(NSString *)pass Success:(SuccessBlock)success Fail:(FailBlock)fail
{
    NSString *url = @"http://192.168.1.34:9000/app/drugStoresPurchasePlan/storeBuy";

    NSDictionary *params = @{
                             @"officeId":@"95ce99bda3cd4309b0b114d05ffda55c",
                             @"typeCode":@"",
                             @"passWord":@"test1234",
                             @"userName":@"majp01",
                             };
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"补货信息 ===   %@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        fail(error.localizedDescription);
        NSLog(@"错误：   %@",error.localizedDescription);
    }];
    
}


@end
