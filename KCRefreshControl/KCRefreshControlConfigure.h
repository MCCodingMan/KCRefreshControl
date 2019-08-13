//
//  KCRefreshControlConfigure.h
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KCRefreshControlConfigure : NSObject

/**
 * 顶部刷新期望高度
 * 默认:44
 */
@property (nonatomic, assign) float topEstimatedhigh;

/**
 * 底部刷新期望高度
 * 默认:54
 */
@property (nonatomic, assign) float bottomEstimatedhigh;

/**
 * 顶部刷新是否立即返回
 * 默认:否
 */
@property (nonatomic, assign) BOOL topFinishRefreshImmediately;

/**
 * 底部刷新是否立即返回
 * 默认:否
 */
@property (nonatomic, assign) BOOL bottomFinishRefreshImmediately;

/**
 * 下拉刷新是否生效
 * 默认:是
 */
@property (nonatomic, assign) BOOL isCanTopRefresh;

/**
 * 上拉加载是否生效
 * 默认:是
 */
@property (nonatomic, assign) BOOL isCanBottomRefresh;

/**
 * 顶部将要开始刷新文案
 * 默认:下拉加载
 */
@property (nonatomic, copy) NSString *topWillRefreshText;

/**
 * 顶部正在刷新文案
 * 默认:数据加载中...
 */
@property (nonatomic, copy) NSString *topRefreshText;

/**
 * 顶部已经到达刷新点文案
 * 默认:松开刷新
 */
@property (nonatomic, copy) NSString *topDidRefreshText;

/**
 * 底部将要开始刷新文案
 * 默认:上拉加载
 */
@property (nonatomic, copy) NSString *bottomWillRefreshText;

/**
 * 底部正在刷新文案
 * 默认:数据加载中...
 */
@property (nonatomic, copy) NSString *bottomRefreshText;

/**
 * 底部已经到达刷新点文案
 * 默认:松开刷新
 */
@property (nonatomic, copy) NSString *bottomDidRefreshText;

/**
 * 顶部自定义刷新视图
 */
@property (nonatomic, strong, nullable) UIView *topCustomRefreshView;

/**
 * 底部自定义刷新视图
 */
@property (nonatomic, strong, nullable) UIView *bottomCustomRefreshView;

@end

NS_ASSUME_NONNULL_END
