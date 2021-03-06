//
//  Url.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#ifndef Url_h
#define Url_h

//返回最新的公共微博  GET
static NSString *PUBLIC_TIMELINE = @"https://api.weibo.com/2/statuses/public_timeline.json";

//对一条微博进行评论
static NSString *COMMENTS_CREATE = @"https://api.weibo.com/2/comments/create.json";

//根据微博ID返回某条微博的评论列表
static NSString *COMMENTS_SHOW = @"https://api.weibo.com/2/comments/show.json";

//转发一条微博
static NSString *STATUES_REPOST = @"https://api.weibo.com/2/statuses/repost.json";

//微博收藏 POST
static NSString *ATTITUDES_CREATE = @"https://api.weibo.com/2/favorites/create.json";

//取消微博收藏 POST
static NSString *ATTITUDES_DESTROY = @"https://api.weibo.com/2/favorites/destroy.json";

//根据用户ID获取用户信息
static NSString *USERS_SHOW = @"https://api.weibo.com/2/users/show.json";

//获取当前登录用户的收藏列表
static NSString *FAVOURITES = @"https://api.weibo.com/2/favorites.json";

//获取用户的关注列表
static NSString *FRIENDSHIPS_FRIENDS = @"https://api.weibo.com/2/friendships/friends.json";

//获取某个用户最新发表的微博列表
static NSString *STATUES_USER_TIMELINE = @"https://api.weibo.com/2/statuses/user_timeline.json";

//发布一条新微博
static NSString *STATUES_UPDATE = @"https://api.weibo.com/2/statuses/update.json";
#endif /* Url_h */

//搜索某一话题下的微博

