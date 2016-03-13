//
//  FavouritesResponse.h
//  weibo
//
//  Created by wenkai on 16/3/13.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseResponse.h"
#import "FavouritesModel.h"

@interface FavouritesResponse : BaseResponse
@property(strong, nonatomic) NSArray *dataArr;
@end
