//
//  OAuthWebViewController.h
//  weibo
//
//  Created by 你懂得的神 on 16/2/17.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OAuthCompletedBlock)();

@interface OAuthWebViewController : UIViewController

- (void)oauthFinishSetBlock:(OAuthCompletedBlock)block;

@end
