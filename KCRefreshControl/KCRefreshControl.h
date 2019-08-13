//
//  KCRefreshControl.h
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCRefreshControlConfigure.h"
#import "KCRefreshControlDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KCRefreshControl : NSObject
//refreshControl配置
@property (nonatomic, strong) KCRefreshControlConfigure *refreshConfig;

/**
 初始化-对象方法
 
 @param registerScrollView 注册滑动视图
 @param delegate 代理
 @return refreshControl
 */
- (instancetype)initWithScrollView:(UIScrollView *)registerScrollView delegate:(id)delegate;

/**
 初始化-类方法
 
 @param registerScrollView 注册滑动视图
 @param delegate 代理
 @return refreshControl
 */
+ (instancetype)registRefreshControlWithScrollView:(UIScrollView *)registerScrollView delegate:(id)delegate;

/**
 结束刷新
 注:
 1.当topFinishRefreshImmediately = YES时，下拉刷新不需要手动调用
 2.当bottomFinishRefreshImmediately = YES时，上拉加载不需要手动调用
 */
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
