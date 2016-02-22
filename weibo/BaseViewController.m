//
//  BaseViewController.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseViewController.h"
#import "OAuthWebViewController.h"
#import "SSKeychain.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>

@interface BaseViewController ()

@property(nonatomic, strong) MBProgressHUD *hud;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isValided = [self isValidedExpiresID];
    
    AppDelegate *delegate = [self appDelegate];
    //如果没网切同时没登录的情况下  就跳过登录界面
    if (!delegate.isConnect) {
        DLog(@"没有联网");
        return ;
    }
    
    //判断是否登录成功--如果没登录弹出登录界面
    if (!isValided) {
        //如果已经是登录界面提过下面语句
        if ([self isKindOfClass:[OAuthWebViewController class]]) {
            return ;
        }
        DLog(@"弹出登录页面");
        OAuthWebViewController *oauthWebVC = [[OAuthWebViewController alloc] init];
        [self presentViewController:oauthWebVC animated:YES completion:^{
            //
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *delegate = [self appDelegate];
    if (!delegate.isConnect) {
        JKAlert *alert = [[JKAlert alloc] initWithTitle:@"网络出错" andMessage:@"" style:STYLE_ALERT];
        [alert addButton:ITEM_OK withTitle:@"确定" handler:^(JKAlertItem *item) {
            //
        }];
        [alert addButton:ITEM_CANCEL withTitle:@"取消" handler:^(JKAlertItem *item) {
            //
        }];
        [alert show];
    }
}

-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

-(void)showHUD:(NSString*)title isDim:(BOOL)isDim
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.dimBackground = isDim;
    _hud.animationType = MBProgressHUDAnimationZoom;
    
    _hud.labelText = title;
    _hud.labelColor = [UIColor grayColor];
}

- (void)hideHUD
{
    [_hud hide:YES afterDelay:0.5];
    _hud = nil;
}

- (NSString *)getToken
{
    NSError *error = nil;
    NSString *token = [SSKeychain passwordForService:serverName account:tokenName error:&error];
    
    if ([error code] == SSKeychainErrorNotFound) {
        DLog(@"Token not found");
        return nil;
    }
    
    return token;
}

- (BOOL)isValidedExpiresID
{
    if (![self getToken]) {
        DLog(@"还没登录");
        return false;
    }
    
    NSError *error = nil;
    NSString *expiresIn = [SSKeychain passwordForService:serverName account:expiresInName error:&error];
    
    if ([error code] == SSKeychainErrorNotFound) {
        DLog(@"expiresIn not found");
        return false;
    }
    
    NSDate *nowDate = [NSDate date];
    
    NSDate *expiresDate = [NSDate dateWithTimeIntervalSince1970:[expiresIn doubleValue]];
    
    if ([expiresDate compare:nowDate] == NSOrderedDescending) {
        DLog(@"令牌有效");
        return true;
    }
    else {
        DLog(@"令牌失效");
    }
    return false;
}

@end
