//
//  CommentsShowResponse.h
//  weibo
//
//  Created by wenkai on 16/3/24.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseResponse.h"
#import "CommentsShowModel.h"

@interface CommentsShowResponse : BaseResponse
@property(nonatomic, strong) NSArray *dataArr;
@end
