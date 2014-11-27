//
//  MONPromptView.m
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "MONPromptView.h"
#import "UIView+SimplifiedAutolayout.h"

#define kPromptViewWidth 300.0f
#define kPromptViewDismissButtonHeight 44.0f
#define kTopMargin 10.0f
#define kSideMargin 15.0f

#define assert_class(x,y) if (x) { assert([x isKindOfClass:y]); }

NSString *kMONPromptViewAttribDismissButtonBackgroundColor = @"kMONPromptViewAttribDismissButtonBackgroundColor";
NSString *kMONPromptViewAttribDismissButtonTextColor = @"kMONPromptViewAttribDismissButtonTextColor";
NSString *kMONPromptViewAttribDismissButtonFont = @"kMONPromptViewAttribDismissButtonFont";
NSString *kMONPromptViewAttribTitleTextColor = @"kMONPromptViewAttribTitleTextColor";
NSString *kMONPromptViewAttribTitleFont = @"kMONPromptViewAttribTitleFont";
NSString *kMONPromptViewAttribMessageTextColor = @"kMONPromptViewAttribMessageTextColor";
NSString *kMONPromptViewAttribMessageFont = @"kMONPromptViewAttribMessageFont";

@interface MONPromptView ()

/// The dismiss button
@property (strong, nonatomic) UIButton *dismissButton;

/// The title label
@property (strong, nonatomic) UILabel *titleLabel;

/// The message label
@property (strong, nonatomic) UILabel *messageLabel;

/// The wrapper view for the prompt view
@property (strong, nonatomic) UIView *wrapperView;

/**
 * Gets height of the prompt view depending on the text in title and message labels
 * @return The height of the prompt view
 */
- (CGFloat)getHeight;

/**
 * Gets the default height of the prompt view
 * @return The default height of the prompt view
 */
- (CGFloat)getDefaultHeight;

/**
 * The action that will be triggered when the button is tapped
 * @param button The dismiss button
 */
- (void)tapDismiss:(UIButton *)button;

/**
 * Hides the prompt view
 */
- (void)hide;

/**
 * Sets up the attributes for the custom dismiss button, title label, and message label
 */
- (void)setupAttributes:(NSDictionary *)attributes;

/**
 * Sets up the layout constraints for the prompt view
 */
- (void)setupLayoutConstraints;

@end

@implementation MONPromptView

#pragma mark -
#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle {
    self = [self initWithTitle:title message:message dismissButtonTitle:dismissButtonTitle attributes:nil];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           dismissButtonTitle:(NSString *)dismissButtonTitle
                   attributes:(NSDictionary *)attributes {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        
        self.title = title;
        self.message = message;
        self.dismissButtonTitle = dismissButtonTitle;
        
        if (attributes) {
            [self setupAttributes:attributes];
        }
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.dismissButton];
        
        [self setupLayoutConstraints];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Wrapper View

/**
 * Creates the wrapper view
 * @return The wrapper view
 */
- (UIView *)wrapperView {
    if (!_wrapperView) {
        _wrapperView = [[UIView alloc] initWithFrame:CGRectZero];
        _wrapperView.translatesAutoresizingMaskIntoConstraints = NO;
        _wrapperView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    return _wrapperView;
}

#pragma mark -
#pragma mark - Dismiss Button

/**
 * Creates the dismiss button
 * @return The dismiss button
 */
- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
        _dismissButton.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
        _dismissButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_dismissButton addTarget:self action:@selector(tapDismiss:) forControlEvents:UIControlEventTouchUpInside];
        [_dismissButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return _dismissButton;
}

/**
 * Sets the title text of the dismiss button
 * @param dismissButtonTitle The title text of the dismiss button
 */
- (void)setDismissButtonTitle:(NSString *)dismissButtonTitle {
    [self.dismissButton setTitle:dismissButtonTitle forState:UIControlStateNormal];
}

/**
 * Gets the title text of the dismiss button
 * @return The title text of the dismiss button
 */
- (NSString *)dismissButtonTitle {
    return self.dismissButton.titleLabel.text;
}

#pragma mark -
#pragma mark - Title Label

/**
 * Creates the title label
 * @return The title label
 */
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.preferredMaxLayoutWidth = kPromptViewWidth - (2 * kSideMargin);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

/**
 * Sets the title text of the title label
 * @param title The title text of the title label
 */
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self layoutIfNeeded];
}

/**
 * Gets the title text of the title label
 * @return The title text of the title label
 */
- (NSString *)title {
    return self.titleLabel.text;
}

#pragma mark -
#pragma mark - Message Label

/**
 * Creates the message label
 * @return The message label
 */
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _messageLabel.preferredMaxLayoutWidth = kPromptViewWidth - (2 * kSideMargin);
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:14.0f];
        _messageLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    }
    return _messageLabel;
}

/**
 * Sets the message text of the message label
 * @param message The message text of the message label
 */
- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self layoutIfNeeded];
}

/**
 * Gets the message text of the message label
 * @return The message text of the message label
 */
- (NSString *)message {
    return self.messageLabel.text;
}

#pragma mark -
#pragma mark - Show Prompt View

- (void)showInView:(UIView *)superview {
    [superview addSubview:self.wrapperView];
    
    NSDictionary *views = @{ @"wrapperView" : self.wrapperView };
    [superview addLayoutConstraintWithVisualFormat:@"H:|-0-[wrapperView]-0-|" views:views];
    [superview addLayoutConstraintWithVisualFormat:@"V:|-0-[wrapperView]-0-|" views:views];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.wrapperView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.07f, 1.07f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    }];
}

#pragma mark -
#pragma mark - Hide Prompt View

- (void)hide {
    [UIView animateWithDuration:0.2f animations:^{
        self.wrapperView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.wrapperView removeFromSuperview];
        self.wrapperView.alpha = 1.0f;
        self.wrapperView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    }];
}

#pragma mark -
#pragma mark - Dimension

- (CGFloat)getHeight {
    return self.titleLabel.intrinsicContentSize.height + self.messageLabel.intrinsicContentSize.height + kPromptViewDismissButtonHeight + (3 * kTopMargin);
}

- (CGFloat)getDefaultHeight {
    return kPromptViewDismissButtonHeight + (3 * kTopMargin);
}

#pragma mark -
#pragma mark - Actions

- (void)tapDismiss:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(promptViewWillDismiss:)]) {
        [self.delegate promptViewWillDismiss:self];
    }
    [self hide];
}

#pragma mark -
#pragma mark - Set Up Attributes

- (void)setupAttributes:(NSDictionary *)attributes {
    UIColor *dismissButtonBackgroundColor = [attributes objectForKey:kMONPromptViewAttribDismissButtonBackgroundColor];
    UIColor *dismissButtonTextColor = [attributes objectForKey:kMONPromptViewAttribDismissButtonTextColor];
    UIFont *dismissButtonFont = [attributes objectForKey:kMONPromptViewAttribDismissButtonFont];
    UIColor *titleTextColor = [attributes objectForKey:kMONPromptViewAttribTitleTextColor];
    UIFont *titleFont = [attributes objectForKey:kMONPromptViewAttribTitleFont];
    UIColor *messageTextColor = [attributes objectForKey:kMONPromptViewAttribMessageTextColor];
    UIFont *messageFont = [attributes objectForKey:kMONPromptViewAttribMessageFont];
    
    // Assert if the attribute is an instance of class UIColor and UIFont
    assert_class(dismissButtonBackgroundColor, [UIColor class]);
    assert_class(dismissButtonTextColor, [UIColor class]);
    assert_class(dismissButtonFont, [UIFont class]);
    assert_class(titleTextColor, [UIColor class]);
    assert_class(titleFont, [UIFont class]);
    assert_class(messageTextColor, [UIColor class]);
    assert_class(messageFont, [UIFont class]);
    
    if (dismissButtonBackgroundColor) self.dismissButton.backgroundColor = dismissButtonBackgroundColor;
    if (dismissButtonTextColor) [self.dismissButton setTitleColor:dismissButtonTextColor forState:UIControlStateNormal];
    if (dismissButtonFont) self.dismissButton.titleLabel.font = dismissButtonFont;
    if (titleTextColor) self.titleLabel.textColor = titleTextColor;
    if (titleFont) self.titleLabel.font = titleFont;
    if (messageTextColor) self.messageLabel.textColor = messageTextColor;
    if (messageFont) self.messageLabel.font = messageFont;
}

#pragma mark -
#pragma mark - Set Up Layout Constraints

- (void)setupLayoutConstraints {
    NSDictionary *views   = @{ @"dismissButton"         : self.dismissButton,
                               @"messageLabel"          : self.messageLabel,
                               @"titleLabel"            : self.titleLabel,
                               @"promptView"            : self };
    
    NSDictionary *metrics = @{ @"dismissButtonHeight"   : @(kPromptViewDismissButtonHeight),
                               @"promptViewWidth"       : @(kPromptViewWidth),
                               @"promptViewHeight"      : @([self getDefaultHeight]),
                               @"messageLabelHeight"    : @(self.messageLabel.font.lineHeight),
                               @"titleLabelHeight"      : @(self.titleLabel.font.lineHeight),
                               @"topMargin"             : @(kTopMargin),
                               @"sideMargin"            : @(kSideMargin) };
    
    [self addLayoutConstraintWithVisualFormat:@"H:|[dismissButton]|" views:views];
    [self addLayoutConstraintWithVisualFormat:@"H:|-(sideMargin)-[titleLabel]-(sideMargin)-|" views:views metrics:metrics];
    [self addLayoutConstraintWithVisualFormat:@"H:|-(sideMargin)-[messageLabel]-(sideMargin)-|" views:views metrics:metrics];
    [self addLayoutConstraintWithVisualFormat:@"V:|-(topMargin)-[titleLabel(>=titleLabelHeight)]-(topMargin)-[messageLabel(>=messageLabelHeight)]-(topMargin)-[dismissButton(dismissButtonHeight)]|" views:views metrics:metrics];
    
    [self.wrapperView addSubview:self];
    [self.wrapperView addLayoutConstraintWithVisualFormat:@"H:[promptView(promptViewWidth)]" views:views metrics:metrics];
    [self.wrapperView addLayoutConstraintWithVisualFormat:@"V:[promptView(>=promptViewHeight)]" views:views metrics:metrics];
    [self.wrapperView addLayoutConstraintCenterForSubview:self];
}

@end
