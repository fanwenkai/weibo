//
//  StatuesUserTimeLineResponse.h
//  weibo
//
//  Created by wenkai on 16/3/15.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseResponse.h"
#import "StatuesUserTimeLineModel.h"

@interface StatuesUserTimeLineResponse : BaseResponse
@property(nonatomic, strong) NSArray *dataArr;
@end