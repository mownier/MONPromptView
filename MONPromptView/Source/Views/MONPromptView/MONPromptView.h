//
//  MONPromptView.h
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Attribute keys for customizing the dismiss button, title label, and message label
extern NSString *kMONPromptViewAttribDismissButtonBackgroundColor;
extern NSString *kMONPromptViewAttribDismissButtonTextColor;
extern NSString *kMONPromptViewAttribDismissButtonFont;
extern NSString *kMONPromptViewAttribTitleTextColor;
extern NSString *kMONPromptViewAttribTitleFont;
extern NSString *kMONPromptViewAttribMessageTextColor;
extern NSString *kMONPromptViewAttribMessageFont;

@protocol MONPromptViewDelegate;

@interface MONPromptView : UIView

/// The delegate that implements the methods of the protocl
@property (strong, nonatomic) id<MONPromptViewDelegate> delegate;

/// The title text of the prompt */
@property (nonatomic) NSString *title;

/// The message text of the prompt */
@property (nonatomic) NSString *message;

/// The dismiss button text of the prompt */
@property (nonatomic) NSString *dismissButtonTitle;

/**
 * Constructor
 * @param title Title text of the title of prompt view
 *        message Message text of the message of prompt view
 *        dismissButtonTitle Dismiss button text of prompt view
 * @return Instance of prompt view
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle;

/**
 * Constructor
 * @param title Title text of the title of prompt view
 *        message Message text of the message of prompt view
 *        dismissButtonTitle Dismiss button text of prompt view
 *        attributes This holds the info for the custom color and font of prompt view
 * @return Instance of prompt view
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle
                   attributes:(NSDictionary *)attributes;

/**
 * Shows the prompt view
 * @param superview The view where the prompt view is displayed
 */
- (void)showInView:(UIView *)superview;

@end

@protocol MONPromptViewDelegate <NSObject>

@optional

/**
 * The method that will be called upon tapping the dismiss button
 * @param promptView The prompt view that is about to be dismissed
 */
- (void)promptViewWillDismiss:(MONPromptView *)promptView;

@end
