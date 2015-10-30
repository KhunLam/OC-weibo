//
//  LKTabBarViewController.m
//  OC_weibo
//
//  Created by lamkhun on 15/10/26.
//  Copyright © 2015年 lamKhun. All rights reserved.
//

#import "LKTabBarViewController.h"
#import "LKHomeViewController.h"
#import "LKMessageViewController.h"
#import "LKDiscoverViewController.h"
#import "LKProfileViewController.h"

@interface LKTabBarViewController ()

@property (nonatomic,strong) UIButton  *button;

@end

@implementation LKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 首页
    LKHomeViewController *homeVC = [[LKHomeViewController alloc]init];
    [self addChildViewController:homeVC andTitle:@"首页" andImageName:@"tabbar_home"];
    // 消息
    LKMessageViewController *messageVC = [[LKMessageViewController alloc]init];
    [self addChildViewController:messageVC andTitle:@"消息" andImageName:@"tabbar_message_center"];
    // 添加撰写控制器（占位）
    UIViewController *VC = [[UIViewController alloc]init];
    [self addChildViewController:VC andTitle:@"" andImageName:@""];
    // 发现
    LKDiscoverViewController *discoverVC = [[LKDiscoverViewController alloc]init];
    [self addChildViewController:discoverVC andTitle:@"发现" andImageName:@"tabbar_discover"];
    // 我
    LKProfileViewController *profileVC = [[LKProfileViewController alloc]init];
    [self addChildViewController:profileVC andTitle:@"我" andImageName:@"tabbar_profile"];
    // 给tabBar字体 设颜色
    self.tabBar.tintColor = [UIColor orangeColor];
}

-(void)addChildViewController:(UIViewController *)Controller andTitle:(NSString *)title andImageName:(NSString *)imageName
{
    Controller.title = title;
    Controller.tabBarItem.image = [UIImage imageNamed:imageName];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Controller];
    [self addChildViewController:nav];
    
}

#pragma mark -布局按钮
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float width = self.tabBar.bounds.size.width / 5;
    self.button.frame = CGRectMake(width * 2, 0, width, self.tabBar.bounds.size.height);
    [self.tabBar addSubview:self.button];
    
}

#pragma mark -懒加载
-(UIButton *)button
{
    if (_button == nil) {
        _button = [[UIButton alloc]init];
    }
    // 按钮图片
    [_button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    [_button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    [_button addTarget:self action:@selector(composeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _button;
}

#pragma mark - 点击事件
-(void)composeButtonClick{
    NSLog(@"点击了按钮");
}



@end
