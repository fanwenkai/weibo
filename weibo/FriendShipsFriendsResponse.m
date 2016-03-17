//
//  FriendShipsFriendsResponse.m
//  weibo
//
//  Created by wenkai on 16/3/17.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FriendShipsFriendsResponse.h"

@implementation FriendShipsFriendsResponse
- (BOOL)fromDic:(NSDictionary *)dict
{
    if ([super fromDic:dict])
    {
        NSArray *tempArr = dict[@"users"];
        
        if (tempArr && [tempArr isKindOfClass:[NSArray class]])
        {
            NSError *error = nil;
            NSMutableArray *tempMutableArr = [NSMutableArray array];
            
            for (NSDictionary *tempData in tempArr)
            {
                FriendShipsFriendsModel *friendShipsFriendsModel = [[FriendShipsFriendsModel alloc] initWithDictionary:tempData error:&error];
                if (friendShipsFriendsModel)
                {
                    [tempMutableArr addObject:friendShipsFriendsModel];
                }
                if (error)
                {
                    DLog(@"FriendShipsFriendsModel failed:%@", [error localizedDescription]);
                    tempMutableArr = nil;
                    self.ret = RET_PARSE_JSON_ERROR;
                    self.msg = @"请求异常";
                    return false;
                }
            }
            
            _dataArr = [NSArray arrayWithArray:tempMutableArr];
            return true;
        }
    }
    return false;
}
@end
