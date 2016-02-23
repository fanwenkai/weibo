//
//  PublicTimeLineModel.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

@protocol PICURLSModel <NSObject>

@end

/**
 *头像
 *姓名
 *时间
 *内容
 *图片
 *id
 */
@interface PublicTimeLineModel : BaseModel

@property(nonatomic, strong) NSString *favorited;//收藏
@property(nonatomic, strong) NSString *reposts_count;//转发数
@property(nonatomic, strong) NSString *comments_count;//评论数
@property(nonatomic, strong) NSString *attitudes_count;//表态数
@property(nonatomic, strong) NSString *text;//微博信息内容
@property(nonatomic, strong) NSString *idstr;//字符串型的微博ID
@property(nonatomic, strong) NSString *id;//微博ID
@property(nonatomic, strong) NSString *created_at;//微博创建时间

@property(nonatomic, strong) UserModel *user;//用户信息

@property(nonatomic, strong) NSArray<PICURLSModel> *pic_urls;

@property(nonatomic, strong) NSString<Ignore> *isAttitude;

@end


@interface PICURLSModel : BaseModel

@property(nonatomic, strong) NSString *thumbnail_pic;//图片地址

@end


