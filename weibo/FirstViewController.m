//
//  FirstViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FirstViewController.h"
#import "FistViewTableCell.h"
#import "CommentViewController.h"

#define kAttributeNorStatue @"1"
#define kAttributeSelStatue @"2"

@interface FirstViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
//    NSInteger _unitCount;//每次请求的条数
//    NSInteger _nextCursor;//记录刷新的位置
}

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArr;//保存最新微博的数据

@end

static FistViewTableCell *calcuCell = nil;

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    [self initView];
    [self loadRemoteData];
}

- (void)initView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = kBGColor;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[FistViewTableCell class] forCellReuseIdentifier:@"fistViewTableCell"];
    
    
//    __unsafe_unretained typeof(self) weakSelf = self;
//    __unsafe_unretained UITableView *tableView = self.tableView;
//    
//    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf loadRemoteData];
//            [tableView.mj_header endRefreshing];
//        });
//    }];
    
    calcuCell = [[FistViewTableCell alloc] init];
    
}

- (void)loadRemoteData
{
    //如果没有登录跳过下面语句
    if (![self isValidedExpiresID]) {
        DLog(@"FirstViewController No Login");
        return ;
    }
    if (_dataArr) {
        _dataArr = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestPublicTimeLineAndAccessToken:[self getToken]
                                                          andCount:@"100"
                                                           andPage:@"1"
                                                          callBack:^(BaseResponse *result)
     {
         if (result.ret == RET_SUCCESSED) {
             PublicTimeLineResponse *tempResponse = (PublicTimeLineResponse *)result;
             weakSelf.dataArr = [NSArray arrayWithArray:tempResponse.dataArr];
             [weakSelf.tableView reloadData];
         }
         else{
             DLog(@"请求数据出错");
         }
         [weakSelf hideHUD];
    }];
}

- (NSArray *)picUrls:(NSArray *)picUrlsArr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (PICURLSModel *data in picUrlsArr) {
        NSString *tempStr = data.thumbnail_pic;
        if (tempStr) {
            [tempArr addObject:tempStr];
        }
    }
    return tempArr;
}

#pragma UITableView--DataSource和Delegate方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     PublicTimeLineModel* tempData = _dataArr[indexPath.section];
    calcuCell.userNameLabel.text = tempData.user.screen_name;
    calcuCell.timeLabel.text = tempData.created_at;
    calcuCell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
   [calcuCell.headImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    
    [calcuCell setImageswithURLs:[self picUrls:tempData.pic_urls]];
    
    
    
    CGFloat height = [calcuCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 10;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FistViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fistViewTableCell" forIndexPath:indexPath];
    
    __block PublicTimeLineModel* tempData = _dataArr[indexPath.section];
    cell.userNameLabel.text = tempData.user.screen_name;
    cell.timeLabel.text = tempData.created_at;
    cell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
    
    [cell.headImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    
    [cell setImageswithURLs:[self picUrls:tempData.pic_urls]];
    
    
    if ([tempData.isAttitude isEqualToString:kAttributeNorStatue]) {
        cell.attitudesBtn.selected = NO;
    }
    else{
        cell.attitudesBtn.selected = YES;
    }
    
    cell.bodyLabel.linkTapHandler=^(SkyLinkType linkType, NSString *string, NSRange range) {
        
        NSString* typeStr=nil;
        switch (linkType)
        {
            case SkyLinkTypeURL:
                typeStr=@"网页链接";
                break;
            case SkyLinkTypeTheme:
                typeStr=@"话题内容";
                break;
            case SkyLinkTypeHashTag:
                typeStr=@"内容标签";
                break;
            case SkyLinkTypePhoneNumber:
                typeStr=@"电话号码";
                break;
            case SkyLinkTypeUserHandle:
                typeStr=@"用户";
                break;
                
            default:
                typeStr=@"点击错误";
                break;
        }
        
        NSString* tapStr=[NSString stringWithFormat:@"点击了%@",string];
        DLog(@"%@",tapStr);
        
    };
    
    [cell mentMethodCallBack:^(UIButton *sender) {
        if (sender.tag == kRepostBtnTag) {
            DLog(@"进入转发回调");
            
            [self showHUD:@"拼命转转发中..." isDim:NO];
            [[FKAPIClient getInstance] requestStatuesRepostAndAccessToken:[self getToken]
                                                                    andID:tempData.idstr
                                                                 callBack:^(BaseResponse *result)
            {
                [self hideHUD];
                [JKAlert showMessage:@"已转发"];
            }];
        }
        else if (sender.tag == kCommentBtnTag){
            DLog(@"进入评论回调");
            CommentViewController *commentVC = [[CommentViewController alloc] init];
            [commentVC fromSuperData:tempData];
            [self.navigationController pushViewController:commentVC animated:YES];
        }
        else {
            DLog(@"进入收藏回调");
            if (!sender.selected) {
                tempData.isAttitude = kAttributeSelStatue;
                sender.selected = !sender.selected;
                [[FKAPIClient getInstance] requestFriendShipsCreateAndAccessToken:[self getToken]
                                                                           andID:tempData.idstr
                                                                         callBack:^(BaseResponse *result)
                {
                    //关注
                }];
                
            }
            else{
                tempData.isAttitude = kAttributeNorStatue;
                sender.selected = !sender.selected;
                [[FKAPIClient getInstance] requestFriendShipsDestroyAndAccessToken:[self getToken]
                                                                            andID:tempData.idstr
                                                                          callBack:^(BaseResponse *result)
                 {
                    //取消关注
                }];
            }
        }
    }];
    
    return cell;
}


@end
