//
//  LKVistorView.h
//  OC_weibo
//
//  Created by lamkhun on 15/10/27.
//  Copyright © 2015年 lamKhun. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置代理
@protocol LKVistorViewDalegate <NSObject>

@optional

-(void)vistorViewRegistClick;

-(void)vistorViewLoginClick;

@end


@interface LKVistorView : UIView
///设置代理属性
@property (nonatomic,weak) id<LKVistorViewDalegate>vistorViewDelegate;
///设置访客视图内容
-(void)setupVistorViewWithImageName:(NSString*)imageName andMessage:(NSString*)message;
/// 转轮动画
-(void)startRotationAnimation;
/// 暂停旋转
-(void)pauseAnimation;
/// 恢复旋转
-(void)resumeAnimation;

@end
