//
//  LKBaseTableViewController.m
//  OC_weibo
//
//  Created by lamkhun on 15/10/27.
//  Copyright © 2015年 lamKhun. All rights reserved.
//

#import "LKBaseTableViewController.h"
#import "LKHomeViewController.h"
#import "LKMessageViewController.h"
#import "LKDiscoverViewController.h"
#import "LKProfileViewController.h"

@interface LKBaseTableViewController ()<LKVistorViewDalegate>

@property (nonatomic,assign) BOOL userLogin;

@property (nonatomic,strong)LKVistorView *vistorView;

@end

@implementation LKBaseTableViewController


/**
 *  判断进入 那个界面
 */
-(void)loadView{
    self.userLogin = NO;
    self.userLogin ? [super loadView] :[self setVisitorView];
}

-(void)setVisitorView{
   LKVistorView * vistorView =[[LKVistorView alloc]init];
    self.view = vistorView;
    self.vistorView = vistorView;
    // 设置代理
    vistorView.vistorViewDelegate = self;
    
    // 设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(vistorViewRegistClick)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(vistorViewLoginClick)];

    /**
     *  判断是那个界面  使用的图片个文字
     */
    if ([self isKindOfClass:[LKHomeViewController class]]) {
        [vistorView startRotationAnimation];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [center addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }else if ([self isKindOfClass:[LKMessageViewController class]]){
        [vistorView setupVistorViewWithImageName:@"visitordiscover_image_message" andMessage:@"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"];
    }else if ([self isKindOfClass:[LKDiscoverViewController class]]){
        [vistorView setupVistorViewWithImageName:@"visitordiscover_image_message" andMessage:@"登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"];
    }else if ([self isKindOfClass:[LKProfileViewController class]]){
        [vistorView setupVistorViewWithImageName:@"visitordiscover_image_profile" andMessage:@"登录后，你的微博、相册、个人资料会显示在这里，展示给别人"];
    }
}

#pragma mark -通知方法
// 暂停动画
-(void)didEnterBackground{
    [self.vistorView pauseAnimation];
}
// 继续动画
-(void)didBecomeActive{
    [self.vistorView resumeAnimation];
}

#pragma mark - 代理方法
/**
 *  点击注册按钮
 */
-(void)vistorViewRegistClick{
    NSLog(@"vistorViewRegistClick");
}
/**
 *  点击登录按钮
 */
-(void)vistorViewLoginClick{
    NSLog(@"vistorViewLoginClick");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
