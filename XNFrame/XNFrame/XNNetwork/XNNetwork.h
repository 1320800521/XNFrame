//
//  XNNetwork.h
//  XNFrame
//
//  Created by 小鸟 on 2017/3/10.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"


/**
 请求成功回调

 @param requestObj 返回数据
 @param error 错误信息
 */
typedef void(^RequestBlock)(id requestObj,NSError *error);

/**
 文件 上传/下载 进度

 @param progress 进度信息
 */
typedef void(^ProgressBlock)(NSProgress *progress);


/**
 文件上传下崽

 @param response 请求反应
 @param filePath 文件保存路径
 @param error 错误信息
 */
typedef void(^FinishBlock)(NSURLResponse * response, NSURL * filePath, NSError * error);

@interface XNNetwork : NSObject

/**
 初始化 类

 @return self
 */
+ (instancetype)shareInstNetwork;

- (NSDictionary *)configerPubPram:(NSDictionary *)dict;

@end
