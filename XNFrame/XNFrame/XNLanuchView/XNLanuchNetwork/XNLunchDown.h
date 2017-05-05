//
//  XNLunchDown.h
//  XNLaunchAD
//
//  Created by 小鸟 on 2017/3/16.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownLoadBlock)(NSString *path);

@interface XNLunchDown : NSObject

/**
 下载任务

 @param parh 下载后保存路径
 @param downloadBlock 返回保存路径
 */
+ (void)downLoadADwithDownloadPath:(NSString *)parh downLoadBlock:(DownLoadBlock)downloadBlock;

@end
