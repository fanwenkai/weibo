//
//  FistViewTableCell.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/19.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FistViewTableCell.h"
#import <UIImageView+WebCache.h>

//图片浏览类库
#import "SDPhotoBrowser.h"

@interface FistViewTableCell ()<
SDPhotoBrowserDelegate
>
{
    UIImageView* prototypeImage;
}

@property (nonatomic,strong ) NSArray        * urlArray;

@property (nonatomic,strong ) NSMutableArray * imageViewArray;

@property(nonatomic, strong) MenuMethod menuMethod;

@end


#define kHeadImageViewTag 1000

#define UserNameColor     UIColorFromRGB(0xeca55d)

#define LinkColor RGB(30, 144, 255)
#define TextColor RGB(51, 51, 51)
#define MenuBGColor RGB(235, 235, 235)
#define MenuTextColor RGB(181, 181, 181)

#define MenuHeight 30.f

#define HeadImageSize     CGSizeMake(34.f,  34.f)

#define BigImageSize      CGSizeMake(160.f, 80.f)
#define SquareImageSize   CGSizeMake(70.f,  70.f)


#define ImageMargin                         10.f
#define MaxImageCount                       9
#define MinimumImageCount                   0

@implementation FistViewTableCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupCell];
        
    }
    return self;
}

- (void)mentMethodCallBack:(MenuMethod)callBack
{
    _menuMethod = callBack;
}

- (void)setupCell
{
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    
    _headImageView.backgroundColor=[UIColor orangeColor];
    _headImageView.contentMode=UIViewContentModeScaleToFill;
    _headImageView.clipsToBounds=YES;
    _headImageView.tag=kHeadImageViewTag;
    _headImageView.layer.cornerRadius=5.f;
    
    _userNameLabel = [UILabel new];
    [self.contentView addSubview:_userNameLabel];
    
    _userNameLabel.textColor = UserNameColor;
    _userNameLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:kSmallFontSize];
    
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    
    _timeLabel.textColor=[UIColor grayColor];
    _timeLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:kSmallFont8Size];
    
    _bodyLabel = [SkyLinkLabel new];
    [self.contentView addSubview:_bodyLabel];
    
    _bodyLabel.textColor = TextColor;
    _bodyLabel.font=[UIFont fontWithName:@"Avenir-Light" size:kSmallFontSize];
    _bodyLabel.linkColor = LinkColor;
    //以下几个属性必须设置
    _bodyLabel.numberOfLines=0;
    _bodyLabel.textAlignment=NSTextAlignmentLeft;
    [_bodyLabel setPreferredMaxLayoutWidth:(SCREEN_WIDTH - 24)];
    [_bodyLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    
    //添加功能View
    _menuView = [UIView new];
    [self.contentView addSubview:_menuView];
    
    _menuView.backgroundColor = MenuBGColor;
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.size.mas_equalTo(HeadImageSize);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(_headImageView.mas_right).offset(15);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLabel.mas_bottom).offset(10);
        make.left.equalTo(_headImageView.mas_right).offset(15);
    }];
    
    [_bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(15);
        make.left.equalTo(_headImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.bottom.lessThanOrEqualTo(_menuView.mas_top).offset(-10);
    }];
    
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(MenuHeight);
    }];
    
    
    //添加功能按钮
    _repostsBtn = [UIButton new];
    [_menuView addSubview:_repostsBtn];
    
    _repostsBtn.tag = kRepostBtnTag;
    [_repostsBtn setImage:PNG(@"reposts_nor") forState:UIControlStateNormal];
    [_repostsBtn setTitle:@"0" forState:UIControlStateNormal];
    _repostsBtn.titleLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
    [_repostsBtn setTitleColor:MenuTextColor forState:UIControlStateNormal];
    [_repostsBtn addTarget:self action:@selector(menuClickedMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    _commentsBtn = [UIButton new];
    [_menuView addSubview:_commentsBtn];
    
    _commentsBtn.tag = kCommentBtnTag;
    [_commentsBtn setImage:PNG(@"comments_nor") forState:UIControlStateNormal];
    [_commentsBtn setTitle:@"0" forState:UIControlStateNormal];
    _commentsBtn.titleLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
    [_commentsBtn setTitleColor:MenuTextColor forState:UIControlStateNormal];
    [_commentsBtn addTarget:self action:@selector(menuClickedMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    _attitudesBtn = [UIButton new];
    [_menuView addSubview:_attitudesBtn];
    
    _attitudesBtn.tag = kAttributeBtnTag;
    [_attitudesBtn setImage:PNG(@"attitudes_nor") forState:UIControlStateNormal];
    [_attitudesBtn setImage:PNG(@"attitudes_sel") forState:UIControlStateSelected];
    [_attitudesBtn setTitle:@"0" forState:UIControlStateNormal];
    _attitudesBtn.titleLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
    [_attitudesBtn setTitleColor:MenuTextColor forState:UIControlStateNormal];
    [_attitudesBtn addTarget:self action:@selector(menuClickedMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_repostsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_menuView);
        make.left.equalTo(_menuView.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, MenuHeight));
    }];
    
    [_commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_menuView);
        make.left.equalTo(_repostsBtn.mas_right);
        make.size.equalTo(_repostsBtn);
    }];
    
    [_attitudesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_menuView);
        make.left.equalTo(_commentsBtn.mas_right);
        make.size.equalTo(_repostsBtn);
    }];
    
}

-(void)setImageswithURLs:(NSArray*) urls
{
    
    if (_imageViewArray) {
        
        for (UIView *removeView in _imageViewArray) {
            [removeView removeFromSuperview];
        }
        
        [_imageViewArray removeAllObjects];
        _imageViewArray = nil;
    }
    _imageViewArray = [NSMutableArray array];
    
    if (urls.count>MaxImageCount)  NSAssert(nil,@"set images must less than 9",MaxImageCount);
    
    _urlArray=[[NSArray alloc] initWithArray:urls];
    
    
    
    [_urlArray enumerateObjectsUsingBlock:^(NSString* url, NSUInteger idx, BOOL *stop) {
       
        UIImageView* imgV = [UIImageView new];
        imgV.backgroundColor=[UIColor orangeColor];
        imgV.contentMode=UIViewContentModeScaleToFill;
        imgV.userInteractionEnabled=YES;
        imgV.tag=idx;
        [imgV addGestureRecognizer:[self addTapGestureRecognizer]];
        [imgV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload];
        
        [self.imageViewArray addObject:imgV];
    }];
    
    [self layoutImagesInContentView];
}

#pragma mark - 更新对图片的约束
-(void)layoutImagesInContentView
{
    
    NSInteger imageCount=_imageViewArray.count;
    DLog(@"count:%ld",(long)imageCount);
    //如果没有图片数组则不对此进行布局
    if (imageCount==0) return;

    for (UIImageView* imgV in _imageViewArray)
    {
        [self.contentView addSubview:imgV];
    }
    
    prototypeImage=[_imageViewArray firstObject];
    
    if (imageCount == 1) {
        
        UIImageView* imgView=[_imageViewArray firstObject];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bodyLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.size.mas_equalTo(BigImageSize);
//            make.bottom.lessThanOrEqualTo(_menuView.mas_top).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        }];
        
    }
    //三张图为一行 为小图显示 九图为3列
    else if (imageCount>1&&imageCount<=9)
    {
        [prototypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bodyLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.size.mas_equalTo(SquareImageSize);
        }];
        
        NSInteger count=0;
        
        UIView *previousView = nil;
        for (UIView *view in _imageViewArray)
        {
            if (previousView)
            {
                if (count%3!=0)
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(previousView.mas_right).offset(10);
                        make.top.equalTo(previousView.mas_top);
                        make.size.equalTo(previousView);
                        
                    }];
                }
                else
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(prototypeImage.mas_left);
                        make.top.equalTo(previousView.mas_bottom).offset(10);
                        make.size.equalTo(previousView);
                    }];
                }
            }
            previousView = view;
            
            count++;
        }
        [_menuView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(previousView.mas_bottom).offset(10);
        }];
    }
}

-(UITapGestureRecognizer*)addTapGestureRecognizer
{
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTapped:)];
    
    return tapGesture;
}

-(void)imgViewTapped:(UITapGestureRecognizer*) tapGestureRecognizer
{
    // NSLog(@"tap frame:%@",NSStringFromCGRect(tapGestureRecognizer.view.frame));
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.contentView; // 原图的父控件
    browser.imageCount = self.imageViewArray.count; // 图片总数
    browser.currentImageIndex = (int)tapGestureRecognizer.view.tag;
    browser.imageArray=self.imageViewArray;
    browser.tapedImageView=tapGestureRecognizer.view;
    browser.delegate = self;
    [browser show];
    
}
#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return ((UIImageView*)_imageViewArray[index]).image;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr =[self.urlArray[index] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}

#pragma mark - 功能按钮点击方法
- (void)menuClickedMethod:(UIButton *)sender
{
    switch (sender.tag) {
        case kAttributeBtnTag:
        {
            DLog(@"点赞");
            if (_menuMethod) {
                _menuMethod(sender);
            }
        }
            break;
        case kCommentBtnTag:
        {
            DLog(@"评论");
            if (_menuMethod) {
                _menuMethod(sender);
            }
        }
            break;
        case kRepostBtnTag:
        {
            DLog(@"转发");
            if (_menuMethod) {
                _menuMethod(sender);
            }
        }
            break;
        default:
            break;
    }
}

@end
