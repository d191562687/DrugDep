//
//  TrackViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/6/22.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "TrackViewController.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "HTTPManager.h"

@interface TrackViewController (){
    NSArray *titles;
}
@property (strong, nonatomic) IBOutlet UIWebView *carWebView;


@end

@implementation TrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时追踪";
    
    titles = @[@"京HX1890",@"京HX1890",@"京HX1890",@"京HX1890",@"京HX1890",@"京HX1890",@"京HX1890"];
    

    [self loadWithCar];
    
    [self loadWithCarNumbe];
    
}

- (void)setupSubViews{
      
    
}
- (IBAction)setButton:(id)sender {
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"选择车辆" titles:titles selectIndex:^(NSInteger selectIndex) {
        NSLog(@"选择了第%ld个",selectIndex);
    } selectValue:^(NSString *selectValue) {
        NSLog(@"选择的值为%@",selectValue);
        self.title = selectValue;
    } showCloseButton:NO];
    
    
}

#pragma mark - 数据请求
- (void)loadWithCar;
{

    [[HomeManager sharedManager].netManager trackWithSuccess:^{
        [MBProgressHUD hideHUD];
   
    } Fail:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [self sendAlertAction:errorMsg];
    }];
    

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


- (void)loadWithCarNumbe{
    
//    [[HomeManager sharedManager].netManager carWithSuccess:^{
//          [MBProgressHUD hideHUD];
//    } Fail:^(NSString *errorMsg) {
//        [MBProgressHUD hideHUD];
//        [self sendAlertAction:errorMsg];
//    }];
//    
//    NSURLRequest * reqquest = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    [_carWebView loadRequest:reqquest];
    
    NSString *url = @"http://192.168.1.231:9000/transfer-manager-web/app/appCarSingeRealLocation/areaDetal.do";
    //    NSString *url = @"http://192.168.1.34:9000/a/login"; // 外网
    NSDictionary *params = @{
                             @"vehicle":@"京HX1890"
                             };
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"追踪 = %@",responseObject);
        NSDictionary *mapurl = [responseObject objectForKey:@"mapurl"];
        
        NSString * url = [NSString stringWithFormat:@"%@", mapurl];
        
        NSData *data = [[NSData alloc] initWithBase64EncodedString:url options:0];
        
        NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:url options:0];
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        
         NSData *d6 = [[NSData alloc] initWithBase64EncodedString:url options:0];

        
        NSLog(@"mapurl = %@",mapurl);
        
        NSLog(@"data = %@",data);
        
        NSLog(@"url = %@",url);
        
        NSLog(@"text = %@",text);
        
        NSLog(@"d6 = %@",d6);
        
        NSLog(@"decodedString = %@",decodedString);
        
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        _carWebView.backgroundColor = [UIColor redColor];
        [self.carWebView loadRequest:request];
        
        
        
        }
    fail:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"错误：   %@",error.localizedDescription);
    }];

}



@end

