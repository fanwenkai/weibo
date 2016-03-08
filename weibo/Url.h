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
static NSString *COMMENT_S_CREATE = @"https://api.weibo.com/2/comments/create.json";

//微博关注 POST
static NSString *ATTITUDES_CREATE = @"https://api.weibo.com/2/friendships/create.json";

//取消微博关注 POST
static NSString *ATTITUDES_DESTROY = @"https://api.weibo.com/2/friendships/destroy.json";

#endif /* Url_h */
