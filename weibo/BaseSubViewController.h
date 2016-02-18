//
//  BaseSubViewController.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseSubViewController : BaseViewController

-(AppDelegate *)appDelegate;

//显示进度条
-(void)showHUD:(NSString*)title isDim:(BOOL)isDim;

//隐藏进度条
- (void)hideHUD;

//获取Token
- (NSString *)getToken;

//获取令牌失效时间
- (BOOL)isValidedExpiresID;

@end
