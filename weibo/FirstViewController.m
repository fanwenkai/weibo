//
//  FirstViewController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/2/2.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FirstViewController.h"
#import "FistViewTableCell.h"

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
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[FistViewTableCell class] forCellReuseIdentifier:@"fistViewTableCell"];
    
    calcuCell = [[FistViewTableCell alloc] init];
    
}

- (void)loadRemoteData
{
    //如果没有登录跳过下面语句
    if (![self isValidedExpiresID]) {
        DLog(@"FirstViewController No Login");
        return ;
    }
    
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestPublicTimeLineAndAccessToken:[self getToken]
                                                          andCount:@"50"
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
    /*!
     *  @author Sky
     *
     *  @brief  由于用到了图文混排所以这个里文字需要传入attributedText
     */
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
    
    PublicTimeLineModel* tempData = _dataArr[indexPath.section];
    cell.userNameLabel.text = tempData.user.screen_name;
    cell.timeLabel.text = tempData.created_at;
    /*!
     *  @author Sky
     *
     *  @brief  由于用到了图文混排所以这个里文字需要传入attributedText
     */
    cell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
    
    [cell.headImageView sd_setImageWithURL:STR_URL(tempData.user.profile_image_url)];
    
    [cell setImageswithURLs:[self picUrls:tempData.pic_urls]];
    
    /*!
     *  @author Sky
     *
     *  @brief  一个点击的回调就不多写了具体的逻辑大家可以按需求添加
     */
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
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.25 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
