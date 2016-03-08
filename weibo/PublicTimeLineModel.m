//
//  PublicTimeLineModel.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "PublicTimeLineModel.h"

@implementation PublicTimeLineModel
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        _isAttitude = @"1";
    }
    return self;
}
@end


@implementation PICURLSModel


@end