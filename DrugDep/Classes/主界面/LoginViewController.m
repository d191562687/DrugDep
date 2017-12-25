//
//  LoginViewController.m
//  DrugDep
//
//  Created by Chan_Sir on 2017/6/20.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry.h>
#import "RootNavgationController.h"
#import "HomeViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton *clickButton;
}
/** 账号 */
@property (strong,nonatomic) UITextField *phoneField;
/** 密码 */
@property (strong,nonatomic) UITextField *passField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setupSubViews];
}

- (void)setupSubViews
{
    // 登录的背景图片
    UIImageView *backImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    backImgView.userInteractionEnabled = YES;
    backImgView.frame = self.view.bounds;
    [self.view addSubview:backImgView];
    
    // 文字icon
    UIImageView *titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title_login"]];
    titleIconView.frame = CGRectMake(50, 90*CKproportion, self.view.width - 100, 100);
    [backImgView addSubview:titleIconView];
    
    // 账户输入框
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.delegate = self;
    self.phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneField.borderStyle = UITextBorderStyleNone;
    self.phoneField.background = [UIImage imageNamed:@"userImage"];
    self.phoneField.textAlignment = NSTextAlignmentCenter;
    self.phoneField.placeholder = @"用户名";
    self.phoneField.tag = 43;
    self.phoneField.tintColor = [UIColor whiteColor];
    self.phoneField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.phoneField.keyboardType = UIKeyboardTypeEmailAddress;
    self.phoneField.textColor = [UIColor whiteColor];
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.phoneField.placeholder attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.phoneField.attributedText = [[NSAttributedString alloc]initWithString:self.phoneField.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [backImgView addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleIconView.mas_bottom).offset(50*CKproportion);
        make.left.equalTo(backImgView.mas_left).offset(40);
        make.right.equalTo(backImgView.mas_right).offset(-40);
        make.height.equalTo(@40);
    }];
    
    // 密码输入框
    self.passField = [[UITextField alloc]init];
    self.passField.delegate = self;
    self.passField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passField.borderStyle = UITextBorderStyleNone;
    self.passField.background = [UIImage imageNamed:@"passworkImage"];
    self.passField.textAlignment = NSTextAlignmentCenter;
    self.passField.placeholder = @"密码";
    self.passField.secureTextEntry = YES;
    self.passField.tag = 44;
    self.passField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.passField.tintColor = [UIColor whiteColor];
    self.passField.textColor = [UIColor whiteColor];
    self.passField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.passField.placeholder attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.passField.attributedText = [[NSAttributedString alloc]initWithString:self.passField.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [backImgView addSubview:self.passField];
    [self.passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).offset(10);
        make.left.equalTo(backImgView.mas_left).offset(40);
        make.right.equalTo(backImgView.mas_right).offset(-40);
        make.height.equalTo(@40);
    }];
    
    clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setTitle:@"登  录" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [clickButton addTarget:self action:@selector(loginClickAction) forControlEvents:UIControlEventTouchUpInside];
    clickButton.layer.masksToBounds = YES;
    clickButton.layer.cornerRadius =  5;
    clickButton.backgroundColor = RGBACOLOR(15, 104, 186, 1);
    [backImgView addSubview:clickButton];
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImgView.mas_left).offset(40);
        make.right.equalTo(backImgView.mas_right).offset(-40);
        make.height.equalTo(@44);
        make.top.equalTo(self.passField.mas_bottom).offset(50*CKproportion);
    }];
    
    
#ifdef DEBUG // 处于开发阶段
    self.phoneField.text = @"phy001";
    self.passField.text = @"test1234";
#else // 处于发布阶段
    self.phoneField.text = nil;
    self.passField.text = nil;
#endif
}

- (void)loginClickAction
{
    [self.view endEditing:YES];
    if (self.phoneField.text.length == 0) {
        [self showPopTipsWithMessage:@"用户名有误" AtView:self.phoneField inView:self.view];
        return;
    }
    if (self.passField.text.length == 0) {
        [self showPopTipsWithMessage:@"密码有误" AtView:self.passField inView:self.view];
        return;
    }
    // 调用登录接口
    [MBProgressHUD showMessage:nil];
    [[HomeManager sharedManager].netManager loginWithUserName:self.phoneField.text PassWord:self.passField.text Success:^{
        [MBProgressHUD hideHUD];
        // 登录成功
        [self loginSuccessAction];
    } Fail:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
        [self sendAlertAction:errorMsg];
    }];
    
}

- (void)loginSuccessAction
{
    
    //     去主界面
    HomeViewController *home = [[HomeViewController alloc]init];
    RootNavgationController *nav = [[RootNavgationController alloc]initWithRootViewController:home];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.6;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text containsString:@" "]) {
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text containsString:@" "]) {
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return YES;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

// 隐藏电池栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
