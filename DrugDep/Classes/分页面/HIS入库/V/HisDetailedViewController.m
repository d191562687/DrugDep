//
//  HisDetailedViewController.m
//  DrugDep
//
//  Created by 金安健 on 2017/11/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "HisDetailedViewController.h"


@interface HisDetailedViewController ()<UITableViewDelegate>

@property (strong,nonatomic) UITableView * tableView;



@end

@implementation HisDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@",self.model];
    NSLog(@"-----8-----%@",self.model);
}

- (void)setupSubViews
{
    
    
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
