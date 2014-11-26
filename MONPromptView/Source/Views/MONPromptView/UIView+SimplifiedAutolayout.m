//
//  UIView+SimplifiedAutolayout.m
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "UIView+SimplifiedAutolayout.h"

@implementation UIView (SimplifiedAutolayout)

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views {
    [self addLayoutConstraintWithVisualFormat:visualFormat views:views metrics:nil];
}

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                    metrics:(NSDictionary *)metrics {
    [self addLayoutConstraintWithVisualFormat:visualFormat views:views metrics:metrics options:0];
}

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat
                                      views:(NSDictionary *)views
                                    metrics:(NSDictionary *)metrics
                                    options:(NSLayoutFormatOptions)options {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views]];
}

- (void)addLayoutConstraintVCenterForSubview:(UIView *)subview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

- (void)addLayoutConstraintHCenterForSubview:(UIView *)subview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)addLayoutConstraintCenterForSubview:(UIView *)subview {
    [self addLayoutConstraintHCenterForSubview:subview];
    [self addLayoutConstraintVCenterForSubview:subview];
}


@end
