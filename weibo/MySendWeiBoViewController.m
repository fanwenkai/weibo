//
//  MySendWeiBoViewController.m
//  weibo
//
//  Created by wenkai on 16/3/15.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "MySendWeiBoViewController.h"
#import "MySendWeiBoCell.h"

@interface MySendWeiBoViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArr;//保存最新微博的数据

@end

#define kAttributeNorStatue @"1"
#define kAttributeSelStatue @"2"

static FistViewTableCell *calcuCell = nil;

@implementation MySendWeiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的微博";
    [self initView];
    [self loadRemouteData];
}

#pragma mark - 加载数据
- (void)loadRemouteData
{
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestStatuesUserTimeLineAndAccessToken:[self getToken]
                                                                 andUID:[self getUid]
                                                               andCount:@"200"
                                                               callBack:^(BaseResponse *result)
    {
        if (result.ret == RET_SUCCESSED) {
            StatuesUserTimeLineResponse *tempResponse = (StatuesUserTimeLineResponse *)result;
            weakSelf.dataArr = [NSArray arrayWithArray:tempResponse.dataArr];
            [weakSelf.tableView reloadData];
        }
        else{
            DLog(@"请求数据出错");
        }
        [weakSelf hideHUD];
    }];
    
}
- (void)initView{
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
    [_tableView registerClass:[MySendWeiBoCell class] forCellReuseIdentifier:@"mySendWeiBoCell"];
    
    calcuCell = [[MySendWeiBoCell alloc] init];
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
    StatuesUserTimeLineModel* tempData = _dataArr[indexPath.section];
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
    MySendWeiBoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mySendWeiBoCell" forIndexPath:indexPath];
    
    __block StatuesUserTimeLineModel* tempData = _dataArr[indexPath.section];
    cell.userNameLabel.text = tempData.user.screen_name;
    cell.timeLabel.text = tempData.created_at;
    cell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
    
    [cell.headImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    
    [cell setImageswithURLs:[self picUrls:tempData.pic_urls]];
    
    //    [cell.repostsBtn setTitle:tempData.reposts_count forState:UIControlStateNormal];
    //    [cell.commentsBtn setTitle:tempData.comments_count forState:UIControlStateNormal];
    //    [cell.attitudesBtn setTitle:tempData.attitudes_count forState:UIControlStateNormal];
    
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
        }
        else {
            DLog(@"进入点赞回调");
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
