//
//  UIViewController+LayoutConstraint.m
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "UIViewController+LayoutConstraint.h"

@implementation UIViewController (LayoutConstraint)

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views {
    [self addLayoutConstraintWithVisualformat:visualFormat views:views superview:self.view];
}

- (void)addLayoutConstraintWithVisualformat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview {
    [self addLayoutConstraintWithVisualFormat:visualFormat views:views superview:superview metrics:nil];
}

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview
                                    metrics:(NSDictionary *)metrics {
    [self addLayoutConstraintWithVisualFormat:visualFormat views:views superview:superview metrics:metrics options:0];
}

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview
                                    metrics:(NSDictionary *)metrics
                                    options:(NSLayoutFormatOptions)options {
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                      options:options
                                                                      metrics:metrics
                                                                        views:views]];
}

- (void)addLayoutConstraintCenterHorizontalForView:(UIView *)view {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
}

- (void)addLayoutConstraintCenterVerticalForView:(UIView *)view {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
}

- (void)addLayoutConstraintCenterForView:(UIView *)view {
    [self addLayoutConstraintCenterHorizontalForView:view];
    [self addLayoutConstraintCenterVerticalForView:view];
}

@end
