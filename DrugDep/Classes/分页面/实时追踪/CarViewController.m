//
//  CarViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/10/31.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "CarViewController.h"

@interface CarViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *carView;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWithCar];
    
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index1"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [self.carView loadHTMLString:htmlCont baseURL:baseURL];
    


}

#pragma mark - 数据请求
- (void)loadWithCar;
{
    
    NSString *url = @"http://192.168.1.231:9000/transfer-manager-web/app/appCarSingeRealLocation/areaDetal.do";
    NSDictionary *params = @{
                             @"vehicle":@"京HX1890"
                             };
//    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Car ====== %@",responseObject);
                NSDictionary *mapurl = [responseObject objectForKey:@"mapurl"];
        
                NSString * url = [NSString stringWithFormat:@"%@", mapurl];
        
           [self loadString:[NSString stringWithFormat:@"http://api.e6gps.com/public/v3/MapServices/PlayTrack.aspx?appkey=7f89e5d0-fc13-4a03-9034-59ce40b05223&timestamp=2017-10-31 15:13:20&vehicle=%E4%BA%ACHX1890&btime=2017-10-31 06:00:00&etime=2017-10-31 15:13:20&sign=0C84D6A7FD7E4162B1178C0BA055C1D5"]];
        
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

        
     //   http://api.e6gps.com/public/v3/MapServices/PlayTrack.aspx?appkey=7f89e5d0-fc13-4a03-9034-59ce40b05223&timestamp=2017-10-3114:00:04&vehicle=%E4%BA%ACHX1890&btime=2017-10-31 06:00:00&etime=2017-10-31 14:00:04&sign=74BBD5C691C0B2ABA94D7992B7F33134
        
      //  http://api.e6gps.com/public/v3/MapServices/PlayTrack.aspx?appkey=7f89e5d0-fc13-4a03-9034-59ce40b05223&timestamp=2017-10-31%2014:58:13&vehicle=%E4%BA%ACHX1890&btime=2017-10-31%2006:00:00&etime=2017-10-31%2014:58:13&sign=C3725601A672CE362DC226B06F8853AD
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"Car ====Error");
        [self sendAlertAction:error.localizedDescription];
    }];
}

- (void)loadString:(NSString *)str  {
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
    if (![str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"%@", str];
    }

    NSURL *url = [NSURL URLWithString:urlStr];
    
    
//    NSLog(@"01010101---%@",strLocalHtml);
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // 3. 发送请求给服务器
    [self.carView loadRequest:request];

    

}


- (UIWebView *)webView   {
    if (!_carView) {

        _carView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _carView;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[ request URL ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL:requestURL];
    }
    return YES;
}

@end
