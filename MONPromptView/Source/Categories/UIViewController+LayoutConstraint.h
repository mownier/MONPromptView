//
//  UIViewController+LayoutConstraint.h
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LayoutConstraint)

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views;

- (void)addLayoutConstraintWithVisualformat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview
                                    metrics:(NSDictionary *)metrics;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                  superview:(UIView *)superview
                                    metrics:(NSDictionary *)metrics
                                    options:(NSLayoutFormatOptions)options;

- (void)addLayoutConstraintCenterVerticalForView:(UIView *)view;

- (void)addLayoutConstraintCenterHorizontalForView:(UIView *)view;

- (void)addLayoutConstraintCenterForView:(UIView *)view;

@end
