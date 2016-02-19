//
//  PublicTimeLineResponse.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseResponse.h"
#import "PublicTimeLineModel.h"

@interface PublicTimeLineResponse : BaseResponse

@property(nonatomic, strong) NSArray *dataArr;

@end
