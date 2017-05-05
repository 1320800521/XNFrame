//
//  XNLunchDown.m
//  XNLaunchAD
//
//  Created by 小鸟 on 2017/3/16.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNLunchDown.h"

@implementation XNLunchDown


+ (void)downLoadADwithDownloadPath:(NSString *)parh downLoadBlock:(DownLoadBlock)downloadBlock{

    NSURL *url = [NSURL URLWithString:parh];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 下载成功
            // 注意 location是下载后的临时保存路径, 需要将它移动到需要保存的位置
            NSError *saveError;
            // 创建一个自定义存储路径
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath = [cachePath stringByAppendingPathComponent:@"fileName"];
            NSURL *saveURL = [NSURL fileURLWithPath:savePath];
            
            // 文件复制到cache路径中
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveURL error:&saveError];
            if (!saveError) {
                NSLog(@"保存成功");
                if (downloadBlock) {
                    
                    downloadBlock(savePath);
                    
                    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                    
                    [def setObject:savePath forKey:@"savepath"];
                    
                    [def setObject:parh forKey:@"url"];
                    
                    [def synchronize];
                }
            
            } else {
                NSLog(@"error is %@", saveError.localizedDescription);
            }
        } else {
            NSLog(@"error is : %@", error.localizedDescription);
        }
    }];
    
    [downloadTask resume];
}




@end
