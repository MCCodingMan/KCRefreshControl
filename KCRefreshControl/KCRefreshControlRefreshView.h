//
//  KCRefreshControlRefreshView.h
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KCRefreshControlTopView : UIView

@property (nonatomic, strong) UIImageView *refreshImageView;

@property (nonatomic, strong) UILabel *refreshText;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

- (void)addRefreshSubViewWithDefaultText:(NSString *)defaultText;

- (void)startLoading;

- (void)endLoading;

@end

@interface KCRefreshControlBottomView : UIView

@property (nonatomic, strong) UIImageView *refreshImageView;

@property (nonatomic, strong) UILabel *refreshText;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

- (void)addRefreshSubViewWithDefaultText:(NSString *)defaultText;

- (void)startLoading;

- (void)endLoading;

@end



NS_ASSUME_NONNULL_END
