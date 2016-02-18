//
//  BaseSubViewController.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/16.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "BaseSubViewController.h"

@interface BaseSubViewController ()

@end

@implementation BaseSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(AppDelegate *)appDelegate
{
    return [super appDelegate];
}

-(void)showHUD:(NSString*)title isDim:(BOOL)isDim
{
    [super showHUD:title isDim:isDim];
}

- (void)hideHUD
{
    [super hideHUD];
}

- (NSString *)getToken
{
    return [super getToken];
}

- (BOOL)isValidedExpiresID
{
    return [super isValidedExpiresID];
}

@end
