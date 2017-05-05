//
//  XNLaunchAD.h
//  XNLaunchAD
//
//  Created by 小鸟 on 2017/3/15.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XNLaunchAD : NSObject

+ (instancetype)shareInstLanuchAD;

/**
 添加gif广告
 */
- (void)addGifIMgADD;


- (void)addVideoLanuch:(NSString *)path;

- (void)downloadAD:(NSString *)urlStr;

@end
