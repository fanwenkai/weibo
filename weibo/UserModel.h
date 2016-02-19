//
//  UserModel.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property(nonatomic, strong) NSString *created_at;//用户创建（注册）时间
@property(nonatomic, strong) NSString *des;//用户个人描述
@property(nonatomic, strong) NSString *name;//友好显示名称
@property(nonatomic, strong) NSString *screen_name;//用户昵称
@property(nonatomic, strong) NSString *gender;//性别，m：男、f：女、n：未知
@property(nonatomic, strong) NSString *id;//用户UID
@property(nonatomic, strong) NSString *idstr;//字符串型的用户UID
@property(nonatomic, strong) NSString *favourites_count;//收藏数
@property(nonatomic, strong) NSString *follow_me;//粉丝数
@property(nonatomic, strong) NSString *friends_count;//关注数
@property(nonatomic, strong) NSString *profile_image_url;//用户头像地址（中图），50×50像素

@end
