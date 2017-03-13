//
//  XNFindPwdViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNFindPwdViewController.h"

@interface XNFindPwdViewController ()

/**
 手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFlid;

/**
 验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *verificTextFlid;


/**
 输入密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFlid;

@end

@implementation XNFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/**
 获取验证码

 @param sender dianji
 */
- (IBAction)getVerfic:(id)sender {
}


/** 
 
 提交

 @param sender 点击
 */
- (IBAction)submit:(id)sender {
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
