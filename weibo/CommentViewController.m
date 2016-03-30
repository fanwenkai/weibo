//
//  CommentViewController.m
//  weibo
//
//  Created by wenkai on 16/3/22.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentsShowTableCell.h"

@interface CommentViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UITextField *enterTD;
@property(nonatomic, strong) UIButton *sendBtn;

@property(nonatomic, strong) PublicTimeLineModel *publicTimeLineData;

@property(nonatomic, strong) NSArray *dataArr;

@end

static CommentsShowTableCell *staticCell = nil;

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self initView];
    [self loadData];
}

- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestCommentsShowAndAccessToken:[self getToken]
                                                           andID:_publicTimeLineData.idstr
                                                        callBack:^(BaseResponse *result)
    {
        if (result.ret == RET_SUCCESSED)
        {
            CommentsShowResponse *tempResponse = (CommentsShowResponse *)result;
            weakSelf.dataArr = [NSArray arrayWithArray:tempResponse.dataArr];
            [weakSelf.tableView reloadData];
        }
        else
        {
            DLog(@"请求出错");
        }
        [weakSelf hideHUD];
    }];
}

- (void)fromSuperData:(id)data
{
    _publicTimeLineData = data;
}

- (void)initView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    UIView *footView = [UIView new];
    footView.backgroundColor = CLEARCOLOR;
    _tableView.tableFooterView = footView;
    
    [_tableView registerClass:[CommentsShowTableCell class] forCellReuseIdentifier:@"commentsShowTableCell"];
    staticCell = [[CommentsShowTableCell alloc] init];
    
    _bottomView = [UIView new];
    [self.view addSubview:_bottomView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    _enterTD = [UITextField new];
    [_bottomView addSubview:_enterTD];
    _enterTD.placeholder = @"请输入评论内容...";
    _enterTD.font = [UIFont systemFontOfSize:kGeneralFontSize];
    _enterTD.backgroundColor = kWhtieColor;
    
    _sendBtn = [UIButton new];
    [_bottomView addSubview:_sendBtn];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [_sendBtn setBackgroundColor:kGrayTextColor];
    
    [_enterTD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left).offset(5);
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(_sendBtn.mas_left).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(_bottomView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsShowModel *tempData = _dataArr[indexPath.row];
    [staticCell.userImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    staticCell.selectionStyle = UITableViewCellSelectionStyleNone;
    staticCell.userNameLabel.text = tempData.user.name;
    staticCell.desLabel.text = tempData.text;
    CGFloat tempHeight = [staticCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    if (tempHeight <= 60) {
        return 60;
    }
    return tempHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsShowModel *tempData = _dataArr[indexPath.row];
    CommentsShowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentsShowTableCell" forIndexPath:indexPath];
    [cell.userImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userNameLabel.text = tempData.user.name;
    cell.desLabel.text = tempData.text;
    return cell;
}

#pragma mark - Action
- (void)sendBtnMethod{
    DLog(@"发送");
    [[FKAPIClient getInstance] requestCommentsCreateAndAccessToken:[self getToken]
                                                        andComment:_enterTD.text
                                                             andID:_publicTimeLineData.idstr
                                                          callBack:^(BaseResponse *result)
     {
         [JKAlert showMessage:@"发送成功"];
    }];
}

@end
