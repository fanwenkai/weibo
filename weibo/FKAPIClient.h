//
//  FKAPIClient.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#import "BaseResponse.h"

typedef void(^SDK_CALLBACK) (BaseResponse *result);

@interface FKAPIClient : NSObject
//获取实例
+(FKAPIClient *)getInstance;
//获取网络管理对象
-(AFHTTPSessionManager *)FKManager;
///取消所有请求.
-(void)cancelAllRequest;

@end

@interface FKAPIClient (Sina)
/**
 *  @Description 返回最新的公共微博
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param count 单页返回的记录条数，默认为50。
 *  @param page 返回结果的页码，默认为1。
 *
 *  @return NSURLSession
 */
- (NSURLSessionTask *)requestPublicTimeLineAndAccessToken:(NSString *)token
                                             andCount:(NSString *)count
                                              andPage:(NSString *)page
                                             callBack:(SDK_CALLBACK)callBack;

@end
