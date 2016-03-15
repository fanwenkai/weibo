//
//  StatuesUserTimeLineResponse.m
//  weibo
//
//  Created by wenkai on 16/3/15.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "StatuesUserTimeLineResponse.h"

@implementation StatuesUserTimeLineResponse
- (BOOL)fromDic:(NSDictionary *)dict
{
    if ([super fromDic:dict])
    {
        NSArray *tempArr = dict[@"statuses"];
        
        if (tempArr && [tempArr isKindOfClass:[NSArray class]])
        {
            NSError *error = nil;
            NSMutableArray *tempMutableArr = [NSMutableArray array];
            
            for (NSDictionary *tempData in tempArr)
            {
                StatuesUserTimeLineModel *statuesUserTimeLineModel = [[StatuesUserTimeLineModel alloc] initWithDictionary:tempData error:&error];
                if (statuesUserTimeLineModel)
                {
                    [tempMutableArr addObject:statuesUserTimeLineModel];
                }
                if (error)
                {
                    DLog(@"StatuesUserTimeLineModel failed:%@", [error localizedDescription]);
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
