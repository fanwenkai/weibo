//
//  FourViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FourViewController.h"
#import "FourViewTableCell.h"
#import "FavouriteViewController.h"
#import "MySendWeiBoViewController.h"
#import "MyAttributeViewController.h"

@interface FourViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@property(nonatomic, strong) UsersShowModel *userData;

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIImageView *pickerImageView;
@property(nonatomic, strong) UILabel *pickerNameLabel;
@property(nonatomic, strong) UILabel *pickerDesLabel;
@property(nonatomic, strong) UITableView *tableView;

@end

#define kPickerImageWidthAndHeight 50

@implementation FourViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    [self initView];
    [self loadRemoveeData];
}

#pragma mark - 请求数据
- (void)loadRemoveeData
{
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestUsersShowAndAccessToken:[self getToken]
                                                       andUID:[self getUid]
                                                     callBack:^(BaseResponse *result)
    {
        if (result.ret == RET_SUCCESSED)
        {
            UsersShowResponse *tempResponse = (UsersShowResponse *)result;
            weakSelf.userData = tempResponse.userShowData;
            [weakSelf updateUserInfoView];
            [weakSelf.tableView reloadData];
        }
        else
        {
            DLog(@"请求出错");
        }
        [weakSelf hideHUD];
    }];
}
#pragma mark - 刷新用户信息
- (void)updateUserInfoView
{
    [_pickerImageView sd_setImageWithURL:[NSURL URLWithString:_userData.profile_image_url]
                        placeholderImage:nil
                                 options:SDWebImageRetryFailed | SDWebImageProgressiveDownload | SDWebImageRefreshCached];
    _pickerNameLabel.text = _userData.name;
    _pickerDesLabel.text = _userData.des;
}
#pragma mark - 初始化View
- (void)initView
{
    _topView = [UIView new];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _pickerImageView = [UIImageView new];
    [_topView addSubview:_pickerImageView];
    _pickerImageView.layer.cornerRadius = kPickerImageWidthAndHeight/2;
    _pickerImageView.layer.masksToBounds = YES;
    
    _pickerNameLabel = [UILabel new];
    [_topView addSubview:_pickerNameLabel];
    _pickerNameLabel.textColor = kTextColor;
    _pickerNameLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
    _pickerNameLabel.textAlignment = NSTextAlignmentCenter;
    
    _pickerDesLabel = [UILabel new];
    [_topView addSubview:_pickerDesLabel];
    _pickerDesLabel.textColor = kGrayTextColor;
    _pickerDesLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
    _pickerDesLabel.numberOfLines = 2;
    _pickerDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _pickerDesLabel.textAlignment = NSTextAlignmentCenter;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = kBGColor;
    [_tableView registerClass:[FourViewTableCell class]
       forCellReuseIdentifier:@"fourViewTableCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 44;
    
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.lessThanOrEqualTo(@150);
    }];
    
    [_pickerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView);
        make.top.equalTo(_topView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(kPickerImageWidthAndHeight, kPickerImageWidthAndHeight));
    }];
    
    [_pickerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pickerImageView.mas_bottom).offset(10);
        make.left.equalTo(_topView.mas_left).offset(10);
        make.right.equalTo(_topView.mas_right).offset(-10);
    }];
    
    [_pickerDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pickerNameLabel.mas_bottom).offset(10);
        make.left.equalTo(_topView.mas_left).offset(10);
        make.right.equalTo(_topView.mas_right).offset(-10);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - UITableView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FourViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourViewTableCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的收藏";
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = @"我的微博";
    }
    else if (indexPath.section == 2){
        cell.textLabel.text = @"我的关注";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //我的收藏
        FavouriteViewController *favouriteVC = [[FavouriteViewController alloc] init];
        [self.navigationController pushViewController:favouriteVC animated:YES];
    }
    else if (indexPath.section == 1){
        //我的微博
        MySendWeiBoViewController *mySendWeiBoVC = [[MySendWeiBoViewController alloc] init];
        [self.navigationController pushViewController:mySendWeiBoVC animated:YES];
        
    }
    else if (indexPath.section == 2){
        //我的关注
        MyAttributeViewController *myAttributeVC = [[MyAttributeViewController alloc] init];
        [self.navigationController pushViewController:myAttributeVC animated:YES];
    }
}

@end
