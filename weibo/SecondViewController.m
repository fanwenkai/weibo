//
//  SecondViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "SecondViewController.h"
@interface SecondViewController()
@property(nonatomic, strong) UILabel *statueLabel;
@end

@implementation SecondViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息";
    [self initView];
}

- (void)initView
{
    _statueLabel = [UILabel new];
    [self.view addSubview:_statueLabel];
    _statueLabel.text = @"暂无消息";
    _statueLabel.textColor = kGrayTextColor;
    _statueLabel.font = [UIFont systemFontOfSize:kBigFontSize];
    [_statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
}
@end
