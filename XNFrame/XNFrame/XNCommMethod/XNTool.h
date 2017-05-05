//
//  XNTool.h
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XNTool : NSObject

/**
 登录失败的时候抖动textfiled
 
 @param view 传入textfild
 */
+ (void)animateIncorrectView:(UITextField *)view;

/**
 发送验证码按钮计时
 
 @param btn 发送按钮
 */
+ (void)openCountdown:(UIButton *)btn;


/**
 检查登录与否
 */
+ (void)judgeLogin;

@end
