//
//  FirstViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    NSInteger _unitCount;//每次请求的条数
    NSInteger _nextCursor;//记录刷新的位置
}


@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadRemoteData];
}

- (void)loadRemoteData
{
    [[FKAPIClient getInstance] requestPublicTimeLineAndAccessToken:[self getToken]
                                                          andCount:@"1"
                                                           andPage:@"1"
                                                          callBack:^(BaseResponse *result)
     {
        //
    }];
}

@end
