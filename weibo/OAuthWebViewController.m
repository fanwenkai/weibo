//
//  OAuthWebViewController.m
//  weibo
//
//  Created by 你懂得的神 on 16/2/17.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "OAuthWebViewController.h"

@interface OAuthWebViewController()<
UIWebViewDelegate
>

@property(nonatomic, strong) UIWebView *webView;


@end

@implementation OAuthWebViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [UIWebView new];
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=https://api.weibo.com/oauth2/default.html&response_type=code&display=mobile",appID];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView setDelegate:self];
    [_webView loadRequest:request];
    
}


#pragma mark - UIWebView Delegate Methods

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = webView.request.URL.absoluteString;
    DLog(@"absoluteString:%@",url);
    
    if ([url hasPrefix:@"https://api.weibo.com/oauth2/default.html?"]) {
        
        //找到”code=“的range
        NSRange rangeOne;
        rangeOne=[url rangeOfString:@"code="];
        
        //根据他“code=”的range确定code参数的值的range
        NSRange range = NSMakeRange(rangeOne.length+rangeOne.location, url.length-(rangeOne.length+rangeOne.location));
        //获取code值
        NSString *codeString = [url substringWithRange:range];
        DLog(@"code = :%@",codeString);
        
        //access token调用URL的string
        NSMutableString *muString = [NSMutableString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=https://api.weibo.com/oauth2/default.html&code=",appID,appSecret];

        [muString appendString:codeString];
        DLog(@"access token url :%@",muString);
        
        //第一步，创建URL
        NSURL *urlstring = [NSURL URLWithString:muString];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = @"type=focus-c";//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        __weak typeof(self) weakSelf = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            if (error) {
                DLog(@"出错");
                return ;
            }
            NSString *str1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            DLog(@"Back String :%@",str1);
            
            NSError *errorDic;
            //如何从str1中获取到access_token
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorDic];
            
            //保存用户Token信息
            [weakSelf saveUserMsg:dictionary];
            
            //退出控制器
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                DLog(@"登录成功");
            }];
            
        }];
        
        [task resume];
    }
}

- (void)saveUserMsg:(NSDictionary *)userInfo
{
    NSString *token = userInfo[@"access_token"];
    NSString *expires = [NSString stringWithFormat:@"%@",userInfo[@"expires_in"]];
    DLog(@"expires = %@",expires);
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[expires doubleValue]];
    NSString *expiresTimeStr = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    
    @try {
        [SSKeychain setPassword:token forService:serverName account:tokenName];
        [SSKeychain setPassword:expiresTimeStr forService:serverName account:expiresInName];
    }
    @catch (NSException *exception) {
        DLog(@"保存Token,Expires异常");
    }
}

@end
