//
//  FistViewTableCell.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyLinkLabel.h"

/***********功能按钮Tag**********/
#define kRepostBtnTag 1000
#define kCommentBtnTag 1001
#define kAttributeBtnTag 1002

typedef void(^MenuMethod)(UIButton *sender);

@interface FistViewTableCell : UITableViewCell

/**
 *  头像
 */
@property(nonatomic,strong)UIImageView* headImageView;


/**
 *  用户名
 */
@property(nonatomic,strong)UILabel* userNameLabel;


/**
 *  多久发送的微博 e.g 1个小时前
 */
@property(nonatomic,strong)UILabel* timeLabel;


/**
 *  自适应label
 */
@property(nonatomic,strong)SkyLinkLabel* bodyLabel;


/**
 *底部View，评论 、转发、点赞
 */
@property(nonatomic, strong) UIView *menuView;
@property(nonatomic, strong) UIButton *repostsBtn;//转发按钮
@property(nonatomic, strong) UIButton *commentsBtn;//评论按钮
@property(nonatomic, strong) UIButton *attitudesBtn;//点赞按钮


-(void)setImageswithURLs:(NSArray*) urls;

//添加对图片的约束
-(void)layoutImagesInContentView;

- (void)mentMethodCallBack:(MenuMethod)callBack;

@end
