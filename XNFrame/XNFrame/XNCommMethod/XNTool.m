//
//  XNTool.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/13.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNTool.h"

@implementation XNTool


/**
 登录失败的时候抖动textfiled

 @param view 传入textfild
 */
+ (void)animateIncorrectView:(UITextField *)view{
    // Clear the password field
    
    
    // Animate the alert to show that the entered string was wrong
    // "Shakes" similar to OS X login screen
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 20, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -20, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
//    CGAffineTransform transform = CGAffineTransformIdentity;   //申明旋转量
    //transform = CGAffineTransformMakeRotation(-M_PI/2);     //设置旋转量具体值
    
    [UIView animateWithDuration:0.1 animations:^{
        // Translate left
        view.transform = moveLeft;
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            // Translate right
            view.transform = moveRight;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                
                // Translate left
                view.transform = moveLeft;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.1 animations:^{
                    
                    // Translate to origin
                    view.transform = resetTransform;
                }];
            }];
            
        }];
    }];
    
}


/**
 发送验证码按钮计时

 @param btn 发送按钮
 */
+ (void)openCountdown:(UIButton *)btn{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [btn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
