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

+ (AFHTTPSessionManager *)manager{
    
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

+ (void)onLoadImageByUrl:(NSString *)url Params:(NSDictionary *)params image:(UIImage *)image requestBlock:(RequestBlock)requestBlock{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    [dict addEntriesFromDictionary:XN_PublicParam];
    
    NSData *date = UIImageJPEGRepresentation(image, 1);
    
}

@end
