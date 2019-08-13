//
//  KCRefreshControlRefreshView.m
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "KCRefreshControlRefreshView.h"

@implementation KCRefreshControlTopView

- (void)addRefreshSubViewWithDefaultText:(NSString *)defaultText {
    self.refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull_refresh"]];
    self.refreshImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_refreshImageView];
    self.refreshText = [[UILabel alloc] init];
    self.refreshText.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshText.font = [UIFont systemFontOfSize:13];
    self.refreshText.text = defaultText;
    [self addSubview:_refreshText];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_refreshText
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1 constant:10],
                           [NSLayoutConstraint constraintWithItem:_refreshText
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1 constant:0]]];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1 constant:20],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1 constant:20],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_refreshText
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1 constant:0]]];
}

- (void)startLoading {
    self.refreshImageView.hidden = YES;
    [self.loadingView startAnimating];
}

-(UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingView.color = [UIColor blueColor];
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_loadingView];
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_loadingView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:_loadingView
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_refreshText
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1 constant:-5]]];
    }
    return _loadingView;
}

- (void)endLoading {
    self.refreshImageView.hidden = NO;
    if (_loadingView && _loadingView.isAnimating) {
        [self.loadingView stopAnimating];
    }
}

@end

@implementation KCRefreshControlBottomView

- (void)addRefreshSubViewWithDefaultText:(NSString *)defaultText {
    self.refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull_refresh"]];
    self.refreshImageView.transform = CGAffineTransformMakeRotation(-M_PI);
    self.refreshImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_refreshImageView];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1 constant:20],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1 constant:20],
                           [NSLayoutConstraint constraintWithItem:_refreshImageView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1 constant:2]]];
    
    self.refreshText = [[UILabel alloc] init];
    self.refreshText.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshText.font = [UIFont systemFontOfSize:13];
    self.refreshText.text = defaultText;
    [self addSubview:_refreshText];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_refreshText
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_refreshImageView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:_refreshText
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_refreshImageView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1 constant:5]]];
}

- (void)startLoading {
    self.refreshImageView.hidden = YES;
    [self.loadingView startAnimating];
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        _loadingView.color = [UIColor blueColor];
        [self addSubview:_loadingView];
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:_loadingView
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:_loadingView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1 constant:5]]];
    }
    return _loadingView;
}

- (void)endLoading {
    self.refreshImageView.hidden = NO;
    if (_loadingView && _loadingView.isAnimating) {
        [self.loadingView stopAnimating];
    }
}

@end




