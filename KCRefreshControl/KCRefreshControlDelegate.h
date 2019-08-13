//
//  KCRefreshControlDelegate.h
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KCRefreshControlType) {
    KCRefreshControlStatic = 0,                 ////静止
    KCRefreshControlTopStartDrap,               ////开始下拉
    KCRefreshControlTopWillLose,                ////下拉刷新-超过刷新高度
    KCRefreshControlTopWillLoading,             ////下拉刷新-将要刷新
    KCRefreshControlTopLoading,                 ////下拉刷新-加载中
    KCRefreshControlBottomStartDrap,            ////开始上拉
    KCRefreshControlBottomWillLose,             ////上拉加载-超过刷新高度
    KCRefreshControlBottomWillLoading,          ////上拉加载-将要加载
    KCRefreshControlBottomLoading,              ////上拉加载-加载中
    KCRefreshControlEnd,                        ////刷新结束
};

@class KCRefreshControl;

NS_ASSUME_NONNULL_BEGIN

@protocol KCRefreshControlDelegate <NSObject>

/**
 状态变更代理事件

 @param refreshContrl 刷新对象
 @param refreshType 当前状态
 */
- (void)refreshControlWithControl:(KCRefreshControl *)refreshContrl refreshType:(KCRefreshControlType)refreshType;

@end

NS_ASSUME_NONNULL_END
