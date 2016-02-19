//
//  PublicTimeLineResponse.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "PublicTimeLineResponse.h"

@implementation PublicTimeLineResponse

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
                PublicTimeLineModel *publicTimeLineModel = [[PublicTimeLineModel alloc] initWithDictionary:tempData error:&error];
                if (publicTimeLineModel)
                {
                    [tempMutableArr addObject:publicTimeLineModel];
                }
                if (error)
                {
                    DLog(@"PublicTimeLineModel failed:%@", [error localizedDescription]);
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

