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

/**************************测试数据所需类型*********************/
@property(nonatomic,strong)NSArray*  tableData;

@property(nonatomic,strong)NSArray*  urlArray;

@property(nonatomic,strong)NSArray* urlArray1;

@property(nonatomic,strong)NSArray* urlArray2;
/**************************测试数据所需类型*********************/

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.allowsSelection = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[FistViewTableCell class] forCellReuseIdentifier:@"fistViewTableCell"];
    
    calcuCell = [[FistViewTableCell alloc] init];
    
}

- (void)loadRemoteData
{
//    self.tableData = @[
//                       @{@"username":@"张三",@"icon":@"headImg_1",
//                         @"content":@" 中国网3月26日讯 @范文凯据外媒报道，当地时间3月25日，法国总统奥朗德，德国总理默克尔、西班牙首相拉霍伊共同抵达德国之翼航空公司客机的失事地点。报道称，三位国家领导人抵达当地以后，与参加搜救的工作人员在临时指挥中心进行了会面。此外，法、德、西三国领导人在客机坠毁地点附近对在此次空难中的遇难者表示哀悼，15821223367并对参与搜救的消防队员表示了感谢。"
//                         ,@"pics":@[@"headImg_1"],@"map":@"headImg_1"
//                         }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@"大量的文物流失，频频的文物破坏已成为中国文物保护工作的常年之痛。中国文物保护立法已经30多年，今天，除了相关部门对文物保护的漠视和不作为，我们剩下的只有那些越来越少的沉默的文物。"
//                          ,@"pics":@[@"headImg_1",@"headImg_1"],@"map":@"map1"
//                          }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@"当地时间2015年3月25日，乌克兰基辅，在记者、摄影师及一众高官的注视之下，乌克兰警方冲入一场电视转播的内阁会议现场，逮捕乌克兰紧急服务部部长Serhiy Bochkovsky及其副手Vasyl Stoyetsky，两人均被控“高层次”腐败。据乌克兰内政部长表示，被捕的两人涉嫌多付给包括俄罗斯石油巨头卢克石油公司在内的多家公司采购费用。"
//                          ,@"pics":@[@"headImg_1",@"headImg_1",@"headImg_1"],@"map":@"map1"
//                          }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@"四川峨眉山景区降近7年来最大雪adlfkjasdflksadjflksadjflsakdjfslakdfjsaldkfjsaldkfjsaldkfjsadlfksajdlfkasjflskdjfa"
//                          ,@"pics":@[@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1"],@"map":@"map1"
//                          }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@"萌物：伊犁鼠兔是世界珍稀动物之一。日前，这一天然萌物再次在中国新疆被发现。伊犁鼠兔，生活在天山山脉高寒山区，是中国新疆特有的一个物种。3月23日，实名认证微博“美国国家地理”发布一组有关伊犁鼠兔的照片，因其形象呆萌可爱，长相酷似泰迪，立即引起了众多网友的关注。23日中午，记者电话联系到新疆发现鼠兔第一人，新疆环境保护科学研究院副研究员、新疆生态学会副秘书长李维东，他义务跟踪保护鼠兔三十多年。李维东介绍，美国国家地理微博晒出的这组鼠兔照片，是他去年7月在天山精河县木孜克冰达坂布设红外线触发相机时摄到的。照片中的鼠兔，也是他时隔24年后再次拍摄到的珍贵镜头。"
//                          ,@"pics":@[@"headImg_1",@"headImg_2",@"headImg_3",@"headImg_4",@"headImg_5"],@"map":@"map1"
//                          }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@" 中国网3月26日讯 据外媒报道，当地时间3月25日，法国总统奥朗德，德国总理默克尔、西班牙首相拉霍伊共同抵达德国之翼航空公司客机的失事地点。报道称，三位国家领导人抵达当地以后，与参加搜救的工作人员在临时指挥中心进行了会面。此外，法、德、西三国领导人在客机坠毁地点附近对在此次空难中的遇难者表示哀悼，并对参与搜救的消防队员表示了感谢。"
//                          ,@"pics":@[@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1"],@"map":@"map1"
//                          }
//                       ,@{@"username":@"张三",@"icon":@"headImg_1",
//                          @"content":@"大量的文物流失，频频的文物破坏已成为中国文物保护工作的常年之痛。中国文物保护立法已经30多年，今天，除了相关部门对文物保护的漠视和不作为，我们剩下的只有那些越来越少的沉默的文物。"
//                          ,@"pics":@[@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1",@"headImg_1"],@"map":@"map1"
//                          }
//                       
//                       
//                       ];
//    
//    _urlArray= @[
//                 @"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
//                 @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
//                 @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
//                 @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
//                 @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
//                 @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg"
//                 ];
//    [_tableView reloadData];
    
    //如果没有登录跳过下面语句
    if (![self isValidedExpiresID]) {
        DLog(@"FirstViewController No Login");
        return ;
    }
    
    __weak typeof(self) weakSelf = self;
    [weakSelf showHUD:@"加载中..." isDim:NO];
    [[FKAPIClient getInstance] requestPublicTimeLineAndAccessToken:[self getToken]
                                                          andCount:@"3"
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

#pragma UITableView--DataSource和Delegate方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     PublicTimeLineModel* tempData = _dataArr[indexPath.row];
    calcuCell.userNameLabel.text = tempData.user.screen_name;
    calcuCell.timeLabel.text = tempData.created_at;
    /*!
     *  @author Sky
     *
     *  @brief  由于用到了图文混排所以这个里文字需要传入attributedText
     */
    calcuCell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
    calcuCell.headImageView.image=[UIImage imageNamed:@"headImg_4"];
    
    [calcuCell setImageswithURLs:@[]];
    
    
    
    CGFloat height = [calcuCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 10;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FistViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fistViewTableCell" forIndexPath:indexPath];
    
    PublicTimeLineModel* tempData = _dataArr[indexPath.row];
    cell.userNameLabel.text = tempData.user.screen_name;
    cell.timeLabel.text = tempData.created_at;
    /*!
     *  @author Sky
     *
     *  @brief  由于用到了图文混排所以这个里文字需要传入attributedText
     */
    cell.bodyLabel.attributedText = [NSAttributedString emotionAttributedStringFrom:tempData.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kSmallFontSize]}];
    
    cell.headImageView.image=[UIImage imageNamed:@"headImg_4"];
    
    [cell setImageswithURLs:@[]];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
