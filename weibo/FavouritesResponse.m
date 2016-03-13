//
//  FavouritesResponse.m
//  weibo
//
//  Created by wenkai on 16/3/13.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FavouritesResponse.h"

@implementation FavouritesResponse

- (BOOL)fromDic:(NSDictionary *)dict
{
    if ([super fromDic:dict])
    {
        NSArray *tempArr = dict[@"favorites"];
        
        if (tempArr && [tempArr isKindOfClass:[NSArray class]])
        {
            NSError *error = nil;
            NSMutableArray *tempMutableArr = [NSMutableArray array];
            
            for (NSDictionary *tempData in tempArr)
            {
                
                FavouritesModel *favouritesModel = [[FavouritesModel alloc] initWithDictionary:tempData[@"status"] error:&error];
                if (favouritesModel)
                {
                    [tempMutableArr addObject:favouritesModel];
                }
                if (error)
                {
                    DLog(@"FavouritesModel failed:%@", [error localizedDescription]);
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
