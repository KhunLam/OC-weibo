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
/// 遮盖视图
@property (nonatomic,strong)UIImageView *coverView;

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

#pragma mark - 按钮点击事件
//点击了  通过代理实现该 事件
-(void)registClick{
    if ([self.vistorViewDelegate respondsToSelector:@selector(vistorViewRegistClick)]) {
        [self.vistorViewDelegate vistorViewRegistClick];
    }
}

-(void)loginClick{
    if ([self.vistorViewDelegate respondsToSelector:@selector(vistorViewLoginClick)]) {
        [self.vistorViewDelegate vistorViewLoginClick];
    }
    
}

#pragma mark - 设置访客视图内容
/**
 设置访客视图内容,出了首页 就隐藏房子
 - parameter imageName: 图片名称
 - parameter message:   消息
 */
-(void)setupVistorViewWithImageName:(NSString*)imageName andMessage:(NSString*)message{
    
    self.homeView.hidden = YES;
    self.iconView.image = [UIImage imageNamed:imageName];
    self.messageLabel.text = message;
    // 把遮盖View 带到最底部
    [self sendSubviewToBack:self.coverView];
}
/// 转轮动画
-(void)startRotationAnimation{
    // 创建动画
 CABasicAnimation* animation =[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    // 设置参数
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = MAXFLOAT ;
    animation.duration = 20 ;
    // 完成的时候不移除
    animation.removedOnCompletion = NO;
    // 开始动画
    [self.iconView.layer addAnimation:animation forKey:@"homeRotation"];
}
/// 暂停旋转
-(void)pauseAnimation{
    // 记录暂停时间
  double pauseTime =  [self.iconView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 设置动画速度为0
    self.iconView.layer.speed = 0 ;
    
    // 设置动画偏移时间
    self.iconView.layer.timeOffset = pauseTime ;
}

/// 恢复旋转
-(void)resumeAnimation{
    // 获取暂停时间
    double pauseTime = self.iconView.layer.timeOffset;
    // 设置动画速度为1
    self.iconView.layer.speed = 1;
    
    self.iconView.layer.timeOffset = 0;
    
    self.iconView.layer.beginTime = 0;
    
    double timeSincePause = [self.iconView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.iconView.layer.beginTime = timeSincePause;
}


#pragma mark - 添加控件约束
-(void)prepareUI
{
    //设View的背景色
    self.backgroundColor = [UIColor colorWithWhite:237.0 / 255 alpha:1];
    
    // 添加子控件
    [self addSubview:self.iconView];
    [self addSubview:self.coverView];
    [self addSubview:self.homeView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    
    
     // 设置约束
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.coverView.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    // 遮盖视图  上下左右
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coverView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coverView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coverView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coverView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_loginButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    

    
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
        [_registerButton addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
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
        [_loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton sizeToFit];
    }
    return _loginButton;
}

-(UIImageView *)coverView{
     if (!_coverView) {
    _coverView = [[UIImageView alloc]init];
    _coverView.image = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
     }
    return _coverView;
}

@end
