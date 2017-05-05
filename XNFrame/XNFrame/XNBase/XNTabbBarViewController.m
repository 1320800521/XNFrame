//
//  XNTabbleViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/14.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNTabbBarViewController.h"
#import "XNTool.h"

@interface XNTabbBarViewController ()

@end

@implementation XNTabbBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [XNTool judgeLogin];
}

- (void)viewDidLoad:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
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
