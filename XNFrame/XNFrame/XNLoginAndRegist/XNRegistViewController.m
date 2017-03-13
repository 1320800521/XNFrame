//
//  XNRegistViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNRegistViewController.h"
#import "XNTool.h"

@interface XNRegistViewController ()

/**
 昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *nameTextFlid;

/**
 电话
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFild;

/**
 验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *VerificCodeTextFild;

/**
 密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFild;

/**
 确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *surePwdTextFlid;

@end

@implementation XNRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 获取验证码

 @param sender 点击
 */
- (IBAction)getVerificat:(id)sender {
    
    [XNTool openCountdown:(UIButton *)sender];
}

/**
 同意协议

 @param sender 点击
 */
- (IBAction)agree:(id)sender {
}

/**
 注册

 @param sender 点击
 */
- (IBAction)regist:(id)sender {
    
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
