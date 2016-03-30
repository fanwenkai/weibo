//
//  FKAPIClient.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#import "BaseResponse.h"

#import "PublicTimeLineResponse.h"
#import "UsersShowResponse.h"
#import "FavouritesResponse.h"
#import "StatuesUserTimeLineResponse.h"
#import "FriendShipsFriendsResponse.h"
#import "CommentsShowResponse.h"

typedef void(^SDK_CALLBACK) (BaseResponse *result);

@interface FKAPIClient : NSObject
//获取实例
+(FKAPIClient *)getInstance;
//获取网络管理对象
-(AFHTTPSessionManager *)FKManager;
///取消所有请求.
-(void)cancelAllRequest;

@end

@interface FKAPIClient (Sina)
/**
 *  @Description 返回最新的公共微博
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param count 单页返回的记录条数，默认为50。
 *  @param page 返回结果的页码，默认为1。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestPublicTimeLineAndAccessToken:(NSString *)token
                                             andCount:(NSString *)count
                                              andPage:(NSString *)page
                                             callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 收藏
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param ID 填写微博 id ，一串数字。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestFriendShipsCreateAndAccessToken:(NSString *)token
                                                         andID:(NSString *)ID
                                                      callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 取消收藏
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param ID 填写微博 id ，一串数字。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestFriendShipsDestroyAndAccessToken:(NSString *)token
                                                          andID:(NSString *)ID
                                                       callBack:(SDK_CALLBACK)callBack;

/**
 *  @Description 根据用户ID获取用户信息
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param UID 填写微博 id ，一串数字。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestUsersShowAndAccessToken:(NSString *)token
                                                  andUID:(NSString *)UID
                                                callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 获取当前登录用户的收藏列表
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param count 单页返回的记录条数，默认为50。
 *  @param page 返回结果的页码，默认为1。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestFavouritesAndAccessToken:(NSString *)token
                                                 andCount:(NSString *)count
                                                  andPage:(NSString *)page
                                                 callBack:(SDK_CALLBACK)callBack;


/**
 *  @Description 获取用户的关注列表
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param UID 需要查询的用户UID。
 *  @param count 单页返回的记录条数，默认为50，最大不超过200。
 *
 *  @return NSURLSessionTask
 */

- (NSURLSessionTask *)requestFriendShipsFriendsAndAccessToken:(NSString *)token
                                                       andUID:(NSString *)UID
                                                     andCount:(NSString *)count
                                                     callBack:(SDK_CALLBACK)callBack;

/**
 *  @Description 获取某个用户最新发表的微博列表
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param UID 需要查询的用户UID。
 *  @param count 单页返回的记录条数，默认为50，最大不超过200。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestStatuesUserTimeLineAndAccessToken:(NSString *)token
                                                        andUID:(NSString *)UID
                                                      andCount:(NSString *)count
                                                      callBack:(SDK_CALLBACK)callBack;

/**
 *  @Description 转发一条微博
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param UID 要转发的微博ID。
 *
 *  @return NSOperation
 */
- (NSURLSessionTask *)requestStatuesRepostAndAccessToken:(NSString *)token
                                              andID:(NSString *)UID
                                           callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 根据微博ID返回某条微博的评论列表
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param ID 需要查询的微博ID。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestCommentsShowAndAccessToken:(NSString *)token
                                                  andID:(NSString *)ID
                                               callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 对一条微博进行评论
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param commnet 评论内容
 *  @param ID 需要评论的微博ID。
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestCommentsCreateAndAccessToken:(NSString *)token
                                               andComment:(NSString *)commnet
                                                    andID:(NSString *)ID
                                                 callBack:(SDK_CALLBACK)callBack;
/**
 *  @Description 搜索某一话题下的微博
 *
 *  @param token 采用OAuth授权方式为必填参数，OAuth授权后获得。
 *  @param statue 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask *)requestStatuesUpdateAndToken:(NSString *)token
                                             andStatue:(NSString *)statue
                                         callBack:(SDK_CALLBACK)callBack;
@end
