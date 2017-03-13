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

/**
 配置公共参数

 @param dict 参数
 @return 参数
 */
+ (NSDictionary *)configerPubPram:(NSDictionary *)dict;

/**
 get 请求
 
 @param url 请求url
 @param params 参数
 @param requestBlock 请求回调
 */
+ (void)requestByGetUrl:(NSString *)url Params:(NSDictionary *)params requestBlock:(RequestBlock)requestBlock;

/**
 post 请求
 
 @param url 请求url
 @param params 请求参数
 @param requestBlock 请求回调
 */
+ (void)requestByPostUrl:(NSString *)url Params:(NSDictionary *)params requestBlock:(RequestBlock)requestBlock;

/**
 上传图片
 
 @param url 上传图片地址
 @param params 参数
 @param image 图片
 @param requestBlock 请求回调
 */
+ (void)onLoadImageByUrl:(NSString *)url Params:(NSDictionary *)params image:(UIImage *)image requestBlock:(RequestBlock)requestBlock;

/**
 文件上传
 
 @param url 参数
 @param params 参数
 @param file 需要上传的文件
 @param requestBlock 请求回调
 */
+ (void)onLoadFileByUrl:(NSString *)url Params:(NSDictionary *)params File:(NSString *)file requestBlock:(RequestBlock)requestBlock;

/**
 文件下载
 
 @param url 下载地址
 @param params 参数
 @param savePath 下载文件保存路径
 @param requestBlock 请求回调
 */
+ (void)downloadFileByUrl:(NSString *)url Params:(NSDictionary *)params savePath:(NSString *)savePath requestBlock:(RequestBlock)requestBlock;

/**
 网络监视
 */
+ (void)AFNetworkStatus;

@end
