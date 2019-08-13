//
//  KCRefreshControlConfigure.m
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "KCRefreshControlConfigure.h"

@implementation KCRefreshControlConfigure

- (instancetype)init {
    if (self = [super init]) {
        [self defaultSetting];
    }
    return self;
}

/**
 默认设置
 */
- (void)defaultSetting {
    self.topEstimatedhigh = 44.0f;
    self.bottomEstimatedhigh = 54.0f;
    self.topFinishRefreshImmediately = false;
    self.bottomFinishRefreshImmediately = false;
    self.isCanTopRefresh = true;
    self.isCanBottomRefresh = true;
    self.topWillRefreshText = @"下拉加载";
    self.topRefreshText = @"数据加载中...";
    self.topDidRefreshText = @"松开刷新";
    self.bottomWillRefreshText = @"上拉加载";
    self.bottomRefreshText = @"数据加载中...";
    self.bottomDidRefreshText = @"松开刷新";
    self.topCustomRefreshView = nil;
    self.bottomCustomRefreshView = nil;
}

@end
