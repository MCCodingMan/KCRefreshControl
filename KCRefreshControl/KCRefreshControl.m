//
//  KCRefreshControl.m
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCRefreshControl.h"
#import "KCRefreshControlRefreshView.h"

@interface KCRefreshControl()
//代理
@property (nonatomic, weak) id<KCRefreshControlDelegate> refreshDelegate;
//可刷新的滑动视图
@property (nonatomic, strong) UIScrollView *refreshScrollView;
//顶部刷新View
@property (nonatomic, strong) KCRefreshControlTopView *topRefreshView;
//底部刷新View
@property (nonatomic, strong) KCRefreshControlBottomView *bottomRefreshView;
//当前刷新状态
@property (nonatomic, assign) KCRefreshControlType currentRefreshType;
//滑动视图的初始ContentOffset.y->仅设置一次
@property (nonatomic, assign) CGFloat scrollViewOffsetY;

@end

@implementation KCRefreshControl

/**
 初始化-对象方法

 @param registerScrollView 注册滑动视图
 @param delegate 代理
 @return refreshControl
 */
- (instancetype)initWithScrollView:(UIScrollView *)registerScrollView delegate:(id)delegate {
    if (self = [super init]) {
        self.refreshConfig = [[KCRefreshControlConfigure alloc] init];
        self.refreshScrollView = registerScrollView;
        self.refreshDelegate = delegate;
        self.currentRefreshType = KCRefreshControlStatic;
        [self addObserverForScrollView];
        [[UIApplication sharedApplication] statusBarFrame];
    }
    return self;
}

/**
 初始化-类方法

 @param registerScrollView 注册滑动视图
 @param delegate 代理
 @return refreshControl
 */
+ (instancetype)registRefreshControlWithScrollView:(UIScrollView *)registerScrollView delegate:(id)delegate {
    KCRefreshControl *refreshControl = [[KCRefreshControl alloc] initWithScrollView:registerScrollView delegate:delegate];
    return refreshControl;
}

/**
 添加顶部刷新视图
 */
- (void)initTopRefreshViewForScrollView {
    if (!_topRefreshView) {
        self.topRefreshView = [[KCRefreshControlTopView alloc] init];
        self.topRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.refreshScrollView addSubview:_topRefreshView];
        [self.refreshScrollView addConstraints:@[[NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1 constant:0],
                                                 [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:1 constant:0],
                                                 [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeHeight
                                                                             multiplier:1 constant:_refreshConfig.topEstimatedhigh],
                                                 [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1 constant:0]]];
        if (_refreshConfig.topCustomRefreshView) {
            [self.topRefreshView addSubview:_refreshConfig.topCustomRefreshView];
        }else{
            [self.topRefreshView addRefreshSubViewWithDefaultText:_refreshConfig.topWillRefreshText];
        }
    }
}

/**
 添加底部刷新视图
 */
- (void)initbottomRefreshViewForScrollView {
    if (!_bottomRefreshView) {
        self.bottomRefreshView = [[KCRefreshControlBottomView alloc] init];
        self.bottomRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.refreshScrollView addSubview:_bottomRefreshView];
        [self.refreshScrollView addConstraints:@[[NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1 constant:MAX(_refreshScrollView.contentSize.height,_refreshScrollView.bounds.size.height - _refreshConfig.bottomEstimatedhigh + _scrollViewOffsetY)],
                                                 [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:1 constant:0],
                                                 [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeHeight
                                                                             multiplier:1 constant:_refreshConfig.bottomEstimatedhigh],
                                                 [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_refreshScrollView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1 constant:0]]];
        if (_refreshConfig.bottomCustomRefreshView) {
            [self.bottomRefreshView addSubview:_refreshConfig.bottomCustomRefreshView];
        }else{
            [self.bottomRefreshView addRefreshSubViewWithDefaultText:_refreshConfig.bottomWillRefreshText];
        }
    }
}

/**
 注册KVO
 */
- (void)addObserverForScrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.refreshScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"currentRefreshType" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.scrollViewOffsetY = self.refreshScrollView.contentOffset.y;
    });
}
/**
 KVO响应方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *newOffsetValue = [change valueForKey:NSKeyValueChangeNewKey];
        NSValue *oldOffsetValue = [change valueForKey:NSKeyValueChangeOldKey];
        CGPoint newOffsetPoint = [newOffsetValue CGPointValue];
        CGPoint oldOffsetPoint = [oldOffsetValue CGPointValue];
        if (newOffsetPoint.y != oldOffsetPoint.y) {
            [self dragEventManagerWithPointOffsetY:newOffsetPoint.y];
        }
    }else if ([keyPath isEqualToString:@"currentRefreshType"]) {
        NSNumber *oldNumber = [change valueForKey:NSKeyValueChangeOldKey];
        NSNumber *newNumber = [change valueForKey:NSKeyValueChangeNewKey];
        if ([oldNumber integerValue] != [newNumber integerValue]) {
            [self excuteRefreshDelegateEvent];
        }
    }else if ([keyPath isEqualToString:@"contentSize"]) {
        NSValue *oldContentSizeValue = [change valueForKey:NSKeyValueChangeOldKey];
        NSValue *newContentSizeValue = [change valueForKey:NSKeyValueChangeNewKey];
        if ([oldContentSizeValue CGSizeValue].height != [newContentSizeValue CGSizeValue].height) {
            //下一帧将刷新视图移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.bottomRefreshView) {
                    [self.bottomRefreshView removeFromSuperview];
                    self.bottomRefreshView = nil;
                }
            });
        }
    }
}

/**
 拖动事件管理方法

 @param offsetY contentOffset.y
 */
- (void)dragEventManagerWithPointOffsetY:(CGFloat)offsetY {
    //判断当前状态是否处于等待刷新中
    if (_currentRefreshType == KCRefreshControlStatic || _currentRefreshType == KCRefreshControlEnd || _currentRefreshType == KCRefreshControlTopStartDrap || _currentRefreshType == KCRefreshControlTopWillLose || _currentRefreshType == KCRefreshControlBottomStartDrap || _currentRefreshType == KCRefreshControlBottomWillLose) {
        /**
         * offsetY < _scrollViewOffsetY:当前状态为下拉状态
         * offsetY > _scrollViewOffsetY:当前状态为上拉加载
         * offsetY = _scrollViewOffsetY:静止状态
         */
        if (offsetY < _scrollViewOffsetY) {
            if (_refreshConfig.isCanTopRefresh) {
                /**
                 * _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top : ScrollView的初始边距
                 * 初始状态下_refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top + contentOffset.y = 0
                 */
                if (offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top < 0) {//可省略
                    [self initTopRefreshViewForScrollView];
                    [self topDragEventWithPointOffset:offsetY];
                }
            }
        }else if (offsetY > _scrollViewOffsetY) {
            if (_refreshConfig.isCanBottomRefresh) {
                /**
                 * offsetY + _refreshScrollView.bounds.size.height = 当前ScrollView底部的Y值 Y > _refreshScrollView.contentSize.height说明开始下拉
                 */
                if (offsetY + _refreshScrollView.bounds.size.height > _refreshScrollView.contentSize.height) {//不可省略
                    [self initbottomRefreshViewForScrollView];
                    [self bottomDragEventWithPointOffsetY:offsetY];
                }
            }
        }
    }
}

/**
 顶部下拉事件

 @param offsetY contentOffset.y
 */
- (void)topDragEventWithPointOffset:(CGFloat)offsetY {
    /**
     * _refreshScrollView.decelerating && !_refreshScrollView.dragging 结束拖拽
     */
    if (_refreshScrollView.decelerating && !_refreshScrollView.dragging) {
        /**
         * offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top <= -_refreshConfig.topEstimatedhigh
         * 超出下拉刷新的高度z，则开始刷新，否则自然回弹
         */
        if (offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top <= -_refreshConfig.topEstimatedhigh) {
            self.currentRefreshType = KCRefreshControlTopWillLoading;
            if (!_refreshConfig.topFinishRefreshImmediately) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.refreshScrollView.contentInset = UIEdgeInsetsMake(self.refreshConfig.topEstimatedhigh, 0, 0, 0);
                }];
                self.topRefreshView.refreshText.text = _refreshConfig.topRefreshText;
                self.currentRefreshType = KCRefreshControlTopLoading;
                [self.topRefreshView startLoading];
                //测试
                [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1];
            }else{
                [self endRefresh];
            }
        }else{
            [self endRefresh];
        }
    }else{
        if (offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.top > -_refreshConfig.topEstimatedhigh) {
            self.currentRefreshType = KCRefreshControlTopStartDrap;
            self.topRefreshView.refreshText.text = _refreshConfig.topWillRefreshText;
            [UIView animateWithDuration:0.3 animations:^{
                self.topRefreshView.refreshImageView.transform = CGAffineTransformMakeRotation(0);
            }];
        }else{
            self.currentRefreshType = KCRefreshControlTopWillLose;
            self.topRefreshView.refreshText.text = _refreshConfig.topDidRefreshText;
            [UIView animateWithDuration:0.3 animations:^{
                self.topRefreshView.refreshImageView.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
        }
    }
}

/**
 底部上拉加载事件

 @param offsetY contentOffset.y
 */
- (void)bottomDragEventWithPointOffsetY:(CGFloat)offsetY {
    if (_refreshScrollView.decelerating && !_refreshScrollView.dragging) {
        /**
         * 场景分两种
         * 1.contentSize.height >= bounds.size.height 即数据不能显示完整
         * (offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.bottom + _refreshScrollView.adjustedContentInset.bottom >= _refreshScrollView.contentSize.height - _refreshScrollView.bounds.size.height + _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height >= _refreshScrollView.bounds.size.height)
         * 2.contentSize.height < bounds.size.height 即数据能显示完整
         * (offsetY + _refreshScrollView.adjustedContentInset.top >= _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height < _refreshScrollView.bounds.size.height)
         */
        if ((offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.bottom + _refreshScrollView.adjustedContentInset.bottom >= _refreshScrollView.contentSize.height - _refreshScrollView.bounds.size.height + _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height >= _refreshScrollView.bounds.size.height) || (offsetY + _refreshScrollView.adjustedContentInset.top >= _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height < _refreshScrollView.bounds.size.height)) {
            self.currentRefreshType = KCRefreshControlBottomWillLoading;
            if (!_refreshConfig.bottomFinishRefreshImmediately) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.refreshScrollView.contentInset = UIEdgeInsetsMake(0, 0, self.refreshConfig.bottomEstimatedhigh, 0);
                }];
                self.bottomRefreshView.refreshText.text = _refreshConfig.bottomRefreshText;
                self.currentRefreshType = KCRefreshControlBottomLoading;
                [self.bottomRefreshView startLoading];
                [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1];
            }else{
                [self endRefresh];
            }
        }else{
            [self endRefresh];
        }
    }else{
        if ((offsetY + _refreshScrollView.adjustedContentInset.top - _refreshScrollView.contentInset.bottom < _refreshScrollView.contentSize.height - _refreshScrollView.bounds.size.height + _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height >= _refreshScrollView.bounds.size.height) || ((offsetY + _refreshScrollView.adjustedContentInset.top < _refreshConfig.bottomEstimatedhigh && _refreshScrollView.contentSize.height < _refreshScrollView.bounds.size.height))) {
            self.currentRefreshType = KCRefreshControlBottomStartDrap;
            self.bottomRefreshView.refreshText.text = _refreshConfig.bottomWillRefreshText;
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomRefreshView.refreshImageView.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
        }else{
            self.currentRefreshType = KCRefreshControlBottomWillLose;
            self.bottomRefreshView.refreshText.text = _refreshConfig.bottomDidRefreshText;
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomRefreshView.refreshImageView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
    }
}

/**
 执行代理方法
 */
- (void)excuteRefreshDelegateEvent {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshControlWithControl:refreshType:)]) {
        [self.refreshDelegate refreshControlWithControl:self refreshType:_currentRefreshType];
    }
}

/**
 结束刷新
 注:
 1.当topFinishRefreshImmediately = YES时，下拉刷新不需要手动调用
 2.当bottomFinishRefreshImmediately = YES时，上拉加载不需要手动调用
 */
- (void)endRefresh {
    [UIView animateWithDuration:0.5 animations:^{
        self.refreshScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }completion:^(BOOL finished) {
        if (self.currentRefreshType == KCRefreshControlTopLoading) {
            [self.topRefreshView endLoading];
            [self.topRefreshView removeFromSuperview];
            self.topRefreshView = nil;
        }else if (self.currentRefreshType == KCRefreshControlBottomLoading) {
            [self.bottomRefreshView endLoading];
            [self.bottomRefreshView removeFromSuperview];
            self.bottomRefreshView = nil;
        }else{
            [self.topRefreshView endLoading];
            [self.topRefreshView removeFromSuperview];
            self.topRefreshView = nil;
            [self.bottomRefreshView endLoading];
            [self.bottomRefreshView removeFromSuperview];
            self.bottomRefreshView = nil;
        }
        self.currentRefreshType = KCRefreshControlEnd;
    }];
}

/**
 销毁
 */
- (void)dealloc {
    [self.refreshScrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.refreshScrollView removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"currentRefreshType"];
}

@end
