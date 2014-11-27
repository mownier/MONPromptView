//
//  MONPromptView.h
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kMONPromptViewAttribDismissButtonBackgroundColor;
extern NSString *kMONPromptViewAttribDismissButtonTextColor;
extern NSString *kMONPromptViewAttribDismissButtonFont;
extern NSString *kMONPromptViewAttribTitleTextColor;
extern NSString *kMONPromptViewAttribTitleFont;
extern NSString *kMONPromptViewAttribMessageTextColor;
extern NSString *kMONPromptViewAttribMessageFont;

@protocol MONPromptViewDelegate;

@interface MONPromptView : UIView

@property (strong, nonatomic) id<MONPromptViewDelegate> delegate;

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *dismissButtonTitle;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle
                   attributes:(NSDictionary *)attributes;

- (void)showInView:(UIView *)superview;

@end

@protocol MONPromptViewDelegate <NSObject>

@optional
- (void)promptViewWillDismiss:(MONPromptView *)promptView;

@end
