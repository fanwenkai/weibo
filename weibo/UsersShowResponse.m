//
//  UsersShowResponse.m
//  weibo
//
//  Created by wenkai on 16/3/13.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "UsersShowResponse.h"

@implementation UsersShowResponse

- (BOOL)fromDic:(NSDictionary *)dict
{
    if ([super fromDic:dict])
    {
        NSError *error = nil;
        _userShowData = [[UsersShowModel alloc] initWithDictionary:dict error:&error];
        if (error)
        {
            DLog(@"UsersShowModel failed:%@", [error localizedDescription]);
            _userShowData = nil;
            self.ret = RET_PARSE_JSON_ERROR;
            self.msg = @"请求异常";
            return false;
        }
        return true;
    }
    return false;
}

@end
