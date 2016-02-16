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


@end
