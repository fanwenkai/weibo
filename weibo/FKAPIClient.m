//
//  FKAPIClient.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FKAPIClient.h"
#import "AppDelegate.h"

#import "Url.h"

@interface FKAPIClient()
{
    AFHTTPSessionManager *_manager;
}
@end

@implementation FKAPIClient

+(FKAPIClient *)getInstance
{
    static FKAPIClient *_instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _instance = [[FKAPIClient alloc] init];
    });
    return _instance;
}

-(AFHTTPSessionManager *)FKManager
{
    return _manager;
}

-(void)cancelAllRequest
{
    [_manager.operationQueue cancelAllOperations];
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        // 设置超时时间
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 30.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [_manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    NSLog(@"3G网络已连接");
                    delegate.isConnect = true;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    NSLog(@"WiFi网络已连接");
                    delegate.isConnect = true;
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    NSLog(@"网络连接失败");
                    delegate.isConnect = false;
                }
                    break;
                default:
                {
                    delegate.isConnect = false;
                }
                    break;
            }
        }];
        [_manager.reachabilityManager startMonitoring];
        
        //发送json数据
        //        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应json数据
        _manager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        _manager.responseSerializer.acceptableContentTypes =  [_manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
        
    }
    return self;
}

- (void) success:(id)responseObject
        response:(BaseResponse *)response
        callback:(SDK_CALLBACK)callback
{
    [response fromDic:responseObject];
    callback(response);
}

- (void) failure:(NSError*)error
        response:(BaseResponse *)response
        callback:(SDK_CALLBACK)callback
{
    response.ret = RET_HTTP_ERROR;
    response.msg = @"网络异常";
    callback(response);
}

- (NSURLSessionTask *)getUrl:(NSString*)url
                 params:(NSMutableDictionary*)params
               response:(BaseResponse *)response
               callback:(SDK_CALLBACK)callback
{
    NSURLSessionDataTask *dataTask = [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self success:responseObject
             response:response
             callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        [self failure:error
          response:response
          callback:callback];
    }];
    return dataTask;
}

-(NSURLSessionTask *)postUrl:(NSString*)url
                 params:(NSMutableDictionary*)params
               response:(BaseResponse *)response
               callback:(SDK_CALLBACK)callback
{
    NSURLSessionDataTask *dataTask = [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self success:responseObject
             response:response
             callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        [self failure:error
             response:response
             callback:callback];
    }];
    return dataTask;
}

@end

@implementation FKAPIClient(Sina)

- (NSURLSessionTask *)requestPublicTimeLineAndAccessToken:(NSString *)token
                                             andCount:(NSString *)count
                                              andPage:(NSString *)page
                                             callBack:(SDK_CALLBACK)callBack
{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    [tempDic setValue:token forKey:@"access_token"];
    [tempDic setValue:count forKey:@"count"];
    [tempDic setValue:page forKey:@"page"];
    
    PublicTimeLineResponse *response   = [[PublicTimeLineResponse alloc] init];
    NSURLSessionTask *dataTask = [self getUrl:PUBLIC_TIMELINE params:tempDic response:response callback:callBack];
    return dataTask;
}

@end
