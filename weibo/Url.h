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

//微博点赞 POST
static NSString *ATTITUDES_CREATE = @"https://api.weibo.com/2/attitudes/create.json";

//取消微博点赞 POST
static NSString *ATTITUDES_DESTROY = @"https://api.weibo.com/2/attitudes/destroy.json";

#endif /* Url_h */
