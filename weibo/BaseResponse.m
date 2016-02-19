//
//  BaseResponse.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

- (BOOL)fromDic:(NSDictionary *)dict
{
    if(dict == Nil || ![dict isKindOfClass:[NSDictionary class]])
    {
        _ret = RET_DATA_FORMAT_ERROR;//服务器返回数据格式错误
        _msg = @"请求异常";
        return _ret == 0 ? YES : NO;
    }
    return YES;
//    @try {
//        _ret = [dict[@"returncode"] integerValue];
//        _msg = dict[@"returnmessage"];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"取值:\n%s\n%@", __FUNCTION__, exception);
//        _ret = RET_DATA_FORMAT_ERROR;
//        _msg = @"请求异常";
//    }
//    @finally {
//        NSLog(@"服务器返回提示信息(MSG):%@",_msg);
//    }
//    return self.ret == 0 ? YES : NO;
}

@end
