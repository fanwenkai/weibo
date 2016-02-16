//
//  BaseResponse.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RET_SUCCESSED 0 //请求成功
#define RET_HTTP_ERROR 2 // http请求错误
#define RET_DATA_FORMAT_ERROR 3 // 服务器返回数据格式错误
#define RET_PARSE_JSON_ERROR 4 //数据解析错误

@interface BaseResponse : NSObject

@property(assign, nonatomic) NSInteger ret;
@property(strong, nonatomic) NSString *msg;

- (BOOL)fromDic:(NSDictionary *)dict;

@end
