//
//  ThreeViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
@property(nonatomic, strong) UILabel *sendTipLabel;
@property(nonatomic, strong) UITextView *sendTextView;
@property(nonatomic, strong) UIButton *sendBtn;
@end

@implementation ThreeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发微博";
    [self initView];
}

- (void)initView
{
    _sendTipLabel = [UILabel new];
    [self.view addSubview:_sendTipLabel];
    _sendTipLabel.font = [UIFont systemFontOfSize:kBigFontSize];
    _sendTipLabel.text = @"请在下方输入框里输入发布内容：";
    
    _sendTextView = [UITextView new];
    [self.view addSubview:_sendTextView];
    
    _sendBtn = [UIButton new];
    [self.view addSubview:_sendBtn];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn setBackgroundColor:kGrayTextColor];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:kBigFontSize];
    [_sendBtn addTarget:self action:@selector(sendBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [_sendTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendTextView.mas_left);
        make.bottom.equalTo(_sendTextView.mas_top).offset(-10);
    }];
    
    [_sendTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*.9, 200));
    }];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendTextView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*.9, 35));
    }];
}

#pragma mark - Action
- (void)sendBtnMethod{
    [[FKAPIClient getInstance] requestStatuesUpdateAndToken:[self getToken]
                                                  andStatue:_sendTextView.text
                                                   callBack:^(BaseResponse *result)
    {
        [JKAlert showMessage:@"发送成功"];
        _sendTextView.text = @"";
    }];
}
@end
