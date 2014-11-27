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

@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) UIView *wrapperView;

- (CGFloat)getHeight;
- (void)tapDismiss:(UIButton *)button;
- (void)hide;

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
            UIColor *dismissButtonBackgroundColor = [attributes objectForKey:kMONPromptViewAttribDismissButtonBackgroundColor];
            UIColor *dismissButtonTextColor = [attributes objectForKey:kMONPromptViewAttribDismissButtonTextColor];
            UIFont *dismissButtonFont = [attributes objectForKey:kMONPromptViewAttribDismissButtonFont];
            
            UIColor *titleTextColor = [attributes objectForKey:kMONPromptViewAttribTitleTextColor];
            UIFont *titleFont = [attributes objectForKey:kMONPromptViewAttribTitleFont];
            
            UIColor *messageTextColor = [attributes objectForKey:kMONPromptViewAttribMessageTextColor];
            UIFont *messageFont = [attributes objectForKey:kMONPromptViewAttribMessageFont];
            
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
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.dismissButton];
        
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
    
    return self;
}

#pragma mark -
#pragma mark - Wrapper View

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

- (void)setDismissButtonTitle:(NSString *)dismissButtonTitle {
    [self.dismissButton setTitle:dismissButtonTitle forState:UIControlStateNormal];
}

- (NSString *)dismissButtonTitle {
    return self.dismissButton.titleLabel.text;
}

#pragma mark -
#pragma mark - Title Label

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

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self layoutIfNeeded];
}

- (NSString *)title {
    return self.titleLabel.text;
}

#pragma mark -
#pragma mark - Message Label

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

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self layoutIfNeeded];
}

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

@end
