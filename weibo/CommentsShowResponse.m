//
//  CommentsShowResponse.m
//  weibo
//
//  Created by wenkai on 16/3/24.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CommentsShowResponse.h"

@implementation CommentsShowResponse

- (BOOL)fromDic:(NSDictionary *)dict
{
    if ([super fromDic:dict])
    {
        NSArray *tempArr = dict[@"comments"];
        
        if (tempArr && [tempArr isKindOfClass:[NSArray class]])
        {
            NSError *error = nil;
            NSMutableArray *tempMutableArr = [NSMutableArray array];
            
            for (NSDictionary *tempData in tempArr)
            {
                CommentsShowModel *commentsShowModel = [[CommentsShowModel alloc] initWithDictionary:tempData error:&error];
                if (commentsShowModel)
                {
                    [tempMutableArr addObject:commentsShowModel];
                }
                if (error)
                {
                    DLog(@"CommentsShowModel failed:%@", [error localizedDescription]);
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
