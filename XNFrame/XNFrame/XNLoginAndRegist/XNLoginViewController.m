//
//  XNLoginViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNLoginViewController.h"
#import "XNNavViewController.h"
#import "XNFindPwdViewController.h"

@interface XNLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation XNLoginViewController


+ (void)showLogin{
    
    XNLoginViewController *login = [[XNLoginViewController alloc] init];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:login];
    UIViewController *root = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [root presentViewController:loginNavi animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"登录";
    
}

/**
 登录

 @param sender 登录
 */
- (IBAction)login:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:@{@"1":@"1"} forKey:@"userInfo"];
    
    [self dismissViewControllerAnimated:YES completion:^{ }];
    
}


/**
 找回密码

 @param sender 点击事件
 */
- (IBAction)findPW:(id)sender {
    
    XNFindPwdViewController *findpwVC = [[XNFindPwdViewController alloc]init];
    
    [self.navigationController pushViewController:findpwVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
