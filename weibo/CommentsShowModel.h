//
//  CommentsShowModel.h
//  weibo
//
//  Created by wenkai on 16/3/24.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

@interface CommentsShowModel : BaseModel

@property(nonatomic, strong) NSString *text;//微博信息内容
@property(nonatomic, strong) NSString *idstr;//字符串型的微博ID
@property(nonatomic, strong) NSString *id;//微博ID
@property(nonatomic, strong) NSString *created_at;//微博创建时间

@property(nonatomic, strong) UserModel *user;//用户信息

@end
