//
//  FistViewTableCell.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyLinkLabel.h"


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
 *  底部分割线
 */

@property(nonatomic, strong) UIView *bottomLineView;

-(void)setImageswithURLs:(NSArray*) urls;

//添加对图片的约束
-(void)layoutImagesInContentView;

@end
