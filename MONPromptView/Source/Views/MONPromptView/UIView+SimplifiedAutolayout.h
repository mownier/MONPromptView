//
//  UIView+SimplifiedAutolayout.h
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimplifiedAutolayout)

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                    metrics:(NSDictionary *)metrics;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                    metrics:(NSDictionary *)metrics
                                    options:(NSLayoutFormatOptions)options;

- (void)addLayoutConstraintVCenterForSubview:(UIView *)subview;

- (void)addLayoutConstraintHCenterForSubview:(UIView *)subview;

- (void)addLayoutConstraintCenterForSubview:(UIView *)subview;

@end
