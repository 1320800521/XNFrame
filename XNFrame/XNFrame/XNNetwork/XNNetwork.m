//
//  XNNetwork.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/10.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNNetwork.h"


@interface XNNetwork ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation XNNetwork

static XNNetwork *network = nil;

static AFHTTPSessionManager *XN_Manager;

/**
 公共参数
 */
static NSMutableDictionary *XN_PublicParam = nil;

+ (instancetype)shareInstNetwork{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        network = [[XNNetwork alloc]init];
    });
    
    return network;
}


/**
配置公共参数

 @param dict 公共参数
 @return 公共参数
 */
+ (NSDictionary *)configerPubPram:(NSDictionary *)dict{
    if (!XN_PublicParam && dict) {
        XN_PublicParam = [NSMutableDictionary dictionary];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dict = [defaults objectForKey:@"user"];
        if ([dict[@"ukey"] length] != 0) {
            [XN_PublicParam setObject:dict[@"ukey"] forKey:@"ukey"];
        }
    }
    
    return XN_PublicParam;
}

+ (AFHTTPSessionManager *)XN_manager{
    
    if (!XN_Manager) {
        XN_Manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
        XN_Manager.requestSerializer.timeoutInterval = 60; // 60秒超时
        // 普通格式
        XN_Manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //    _manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
        // 返回json
        XN_Manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return XN_Manager;
}


/**
 get 请求

 @param url 请求url
 @param params 参数
 @param requestBlock 请求回调
 */
+ (void)requestByGetUrl:(NSString *)url Params:(NSDictionary *)params requestBlock:(RequestBlock)requestBlock{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    [dict addEntriesFromDictionary:XN_PublicParam];
    
    [XN_Manager GET:[NSString stringWithFormat:@""] parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSLog(@" get 请求 ---- %@",responseObject);
            
            // 在这里添加处理
            
            if (requestBlock) {
                requestBlock(responseObject,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
    }];
}


/**
 post 请求

 @param url 请求url
 @param params 请求参数
 @param requestBlock 请求回调
 */
+ (void)requestByPostUrl:(NSString *)url Params:(NSDictionary *)params requestBlock:(RequestBlock)requestBlock{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    [dict addEntriesFromDictionary:XN_PublicParam];
    
    [XN_Manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSLog(@" get 请求 ---- %@",responseObject);
            
            // 在这里添加处理
            
            if (requestBlock) {
                requestBlock(responseObject,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
    }];
}


/**
 上传图片

 @param url 上传图片地址
 @param params 参数
 @param image 图片
 @param requestBlock 请求回调
 */
+ (void)onLoadImageByUrl:(NSString *)url Params:(NSDictionary *)params image:(UIImage *)image requestBlock:(RequestBlock)requestBlock{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    [dict addEntriesFromDictionary:XN_PublicParam];
    
    // 图片压缩比
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    [XN_Manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [formData appendPartWithFileData:data name:@"avatar" fileName:@"avatar.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSLog(@" get 请求 ---- %@",responseObject);
            
            // 在这里添加处理
            
            if (requestBlock) {
                requestBlock(responseObject,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
    }];
    
}

/**
 文件上传

 @param url 参数
 @param params 参数
 @param file 需要上传的文件
 @param requestBlock 请求回调
 */
+ (void)onLoadFileByUrl:(NSString *)url Params:(NSDictionary *)params File:(NSString *)file requestBlock:(RequestBlock)requestBlock{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    [dict addEntriesFromDictionary:XN_PublicParam];
    
    [XN_Manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileURL:[NSURL URLWithString:file] name:@"file" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgress) {
            
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSLog(@" get 请求 ---- %@",responseObject);
            
            // 在这里添加处理
            
            if (requestBlock) {
                requestBlock(responseObject,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
    }];
    
}

/**
 文件下载

 @param url 下载地址
 @param params 参数
 @param savePath 下载文件保存路径
 @param requestBlock 请求回调
 */
+ (void)downloadFileByUrl:(NSString *)url Params:(NSDictionary *)params savePath:(NSString *)savePath requestBlock:(RequestBlock)requestBlock{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:url parameters:XN_PublicParam error:nil];
    
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:savePath ];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        return fileURL;

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (requestBlock) {
            if (error) {
                requestBlock(nil,error);
            }else{
                requestBlock(filePath,nil);
            }
        }
    }];
    
    [task resume];
}

/**
 网络监视
 */
+ (void)AFNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G/3G/4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
        
    }] ;
}

@end
