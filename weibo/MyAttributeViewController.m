//
//  MyAttributeViewController.m
//  weibo
//
//  Created by wenkai on 16/3/17.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "MyAttributeViewController.h"
#import "MyAttributeTableCell.h"

@interface MyAttributeViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArr;

@end

@implementation MyAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    [self initView];
    [self loadData];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestFriendShipsFriendsAndAccessToken:[self getToken]
                                                                andUID:[self getUid]
                                                              andCount:@"200"
                                                              callBack:^(BaseResponse *result)
     {
         if (result.ret == RET_SUCCESSED) {
             FriendShipsFriendsResponse *tempResponse = (FriendShipsFriendsResponse *)result;
             weakSelf.dataArr = [NSArray arrayWithArray:tempResponse.dataArr];
             [weakSelf.tableView reloadData];
         }
         else {
             
         }
         [weakSelf hideHUD];
     }];
}

- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    
    [_tableView registerClass:[MyAttributeTableCell class] forCellReuseIdentifier:@"myAttributeTableCell"];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource and Delegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _dataArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendShipsFriendsModel* tempData = _dataArr[indexPath.row];
    
    MyAttributeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myAttributeTableCell" forIndexPath:indexPath];
    [cell.userImageView sd_setImageWithURL:STR_URL(tempData.profile_image_url)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userNameLabel.text = tempData.name;
    cell.desLabel.text = tempData.des;
    return cell;
}

@end
