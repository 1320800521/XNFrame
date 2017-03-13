//
//  XNLoginViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNLoginViewController.h"

@interface XNLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;

@property (weak, nonatomic) IBOutlet UITextField *password;



@end

@implementation XNLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 登录

 @param sender 登录
 */
- (IBAction)login:(id)sender {
    
    
}


/**
 找回密码

 @param sender 点击事件
 */
- (IBAction)findPW:(id)sender {
    
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
