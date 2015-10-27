//
//  LKVistorView.m
//  OC_weibo
//
//  Created by lamkhun on 15/10/27.
//  Copyright © 2015年 lamKhun. All rights reserved.
//

#import "LKVistorView.h"

@interface LKVistorView ()
/// 转轮
@property (nonatomic,strong)UIImageView *iconView;
/// 小房子.只有首页
@property (nonatomic,strong)UIImageView *homeView;
///消息文字
@property (nonatomic,strong)UILabel *messageLabel;
///注册按钮
@property (nonatomic,strong)UIButton *registerButton;
/// 登录按钮
@property (nonatomic,strong)UIButton *loginButton;

@end

@implementation LKVistorView

#pragma mark - 初始化方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self prepareUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - 添加控件约束
-(void)prepareUI
{   // 添加子控件
    [self addSubview:self.iconView];
    [self addSubview:self.homeView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    
    
     // 设置约束
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.homeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 转轮  XY中
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-60.0]];
    
    // 小房子  XY中
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_homeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_homeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
    
    // 消息label  X中  顶  宽
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1 constant:16]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:240]];

    // 注册按钮  左  顶  宽  高
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_messageLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_messageLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:16]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:35]];

    // 登录按钮  右 顶 宽 高
   
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_messageLabel attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_messageLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:16]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:35]];
}

#pragma mark - 添加控件 懒加载

-(UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"visitordiscover_feed_image_smallicon"]];
        [_iconView sizeToFit];
    }
    return _iconView;
}

-(UIImageView *)homeView
{
    if (!_homeView) {
        _homeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"visitordiscover_feed_image_house"]];
        [_homeView sizeToFit];
    }
    return _homeView;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"关注一些人,看看有什么惊喜";
        _messageLabel.textColor = [UIColor lightGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        [_messageLabel sizeToFit];
    }
    return _messageLabel;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [[UIButton alloc]init];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
        [_registerButton sizeToFit];
    }
    return _registerButton;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
        [_loginButton sizeToFit];
    }
    return _loginButton;
}


@end
