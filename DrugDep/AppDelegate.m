//
//  AppDelegate.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavgationController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "AccountTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = NavColor;
    [self setupSDKWithOptions:launchOptions];
    [self chooseRootViewControllerWithVersion];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 切换主控制器
- (void)chooseRootViewControllerWithVersion
{
    Account *account = [AccountTool account];
//    if (account) {
//        // 已登录，去主界面 
//        HomeViewController *homeVC = [[HomeViewController alloc]init];
//        RootNavgationController *nav = [[RootNavgationController alloc]initWithRootViewController:homeVC];
//        self.window.rootViewController = nav;
//    }else{
        // 没有登录，去登录界面
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        RootNavgationController *nav = [[RootNavgationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
//    }
}

#pragma mark - 初始化各个第三方库
- (void)setupSDKWithOptions:(NSDictionary *)launchOptions
{
    
}

@end
