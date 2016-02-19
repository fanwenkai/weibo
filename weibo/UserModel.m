//
//  UserModel.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"des",
                                                       }];
}
@end
