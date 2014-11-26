//
//  MONPromptView.h
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MONPromptViewDelegate;

@interface MONPromptView : UIView

@property (strong, nonatomic) id<MONPromptViewDelegate> delegate;
@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *message;
@property (weak, nonatomic) NSString *dismissButtonTitle;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle;

- (void)showInView:(UIView *)superview;

@end

@protocol MONPromptViewDelegate <NSObject>

@optional
- (void)promptViewWillDismiss:(MONPromptView *)promptView;

@end
