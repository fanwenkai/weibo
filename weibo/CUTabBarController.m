//
//  CUTabBarController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/1/28.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CUTabBarController.h"
#import "CUTabBarExtension.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface CUTabBarController ()<CUTabBarExtensionDelegate>

/** 模型数组 */
@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation CUTabBarController

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 添加子控制器 */
    UIViewController *homeVC = [[FirstViewController alloc] init];
    [self tabBarChildViewController:homeVC norImage:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"首页"];
    
    UIViewController *messageVC = [[SecondViewController alloc] init];
    [self tabBarChildViewController:messageVC norImage:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    
    UIViewController *discoverVC = [[ThreeViewController alloc] init];
    [self tabBarChildViewController:discoverVC norImage:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"搜索"];
    
    UIViewController *myVC = [[FourViewController alloc] init];
    [self tabBarChildViewController:myVC norImage:[UIImage imageNamed:@"tabbar_profile"] selImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我的"];
    
    /** 自定义tabbar */
    [self setTatBar];
}

- (void)setTatBar
{
    /** 创建自定义tabbar */
    CUTabBarExtension *tabBar = [[CUTabBarExtension alloc] init];
    tabBar.backgroundColor = tabBarBackColor;
    tabBar.frame = self.tabBar.bounds;
    //一定要在tabBar.items = self.itemArray;前面设置
    [tabBar cu_setTabBarItemTitleColor:tabBarTitleColor andSelTitleColor:tabBarTitleSelColor];
    /** 传递模型数组 */
    tabBar.items = self.itemArray;
    [tabBar cu_setShadeItemBackgroundColor:tabBarItemShadeColor];
    
    /** 设置代理 */
    tabBar.delegate = self;
    
    // 设置中间按钮
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];

    [tabBar.centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:tabBar];
}

- (void)chickCenterButton
{
    NSLog(@"点击了中间按钮");
}

/** View激将显示时 */
- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:animated];
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[CUTabBarExtension class]]) {
            [childView removeFromSuperview];
        }
    }
}

- (void)tabBarChildViewController:(UIViewController *)vc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title
{
    /** 创建导航控制器 */
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    /** 创建模型 */
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.image = norImage;
    tabBarItem.title = title;
    tabBarItem.selectedImage = selImage;
    /** 添加到模型数组 */
    [self.itemArray addObject:tabBarItem];
    [self addChildViewController:nav];
}

/** 代理方法 */
- (void)cu_tabBar:(CUTabBarExtension *)tabBar didSelectItem:(NSInteger)index{
    self.selectedIndex = index;
}

@end
