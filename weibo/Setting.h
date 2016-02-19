//
//  Setting.h
//  ZuJinBao
//
//  Created by wenkai on 15/12/22.
//  Copyright © 2015年 xueban. All rights reserved.
//

#ifndef Setting_h
#define Setting_h


/*-----------------------------全局配置----------------------------------------*/
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//UIImage的创建 此加载方式会加载到缓存中  占用内存
#define PNG(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]]
#define JPG(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageName]]
//UIImage的创建 此加载方式会加载到缓存中  不占用内存
#define PNG_N(imageName) [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@.png",imageName]]
#define JPG_N(imageName) [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",imageName]]

//格式化字符串
#define STR_FORMAT(format ,str) [NSString stringWithFormat:format ,str]

////自定义打印信息打印出行号
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#define DLog(...) NSLog(@"%d行:%@", __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#define DLog(...) {}
#endif

//自定义颜色
/*
 *  从RGB获得颜色 0xffffff
 */
#define UIColorFromRGB(rgbValue)                            \
[UIColor                                                    \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0   \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0             \
blue:((float)(rgbValue & 0xFF))/255.0                       \
alpha:1.0]

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//获取系统版本
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)
/*-----------------------------全局配置----------------------------------------*/

#endif /* Setting_h */
