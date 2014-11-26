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
#define kPromptViewDismissButtonHeight 70.0f

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
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.titleLabel.text = title;
        self.messageLabel.text = message;
        [self.dismissButton setTitle:dismissButtonTitle forState:UIControlStateNormal];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.dismissButton];

        NSDictionary *views   = @{ @"dismissButton"         : self.dismissButton,
                                   @"messageLabel"          : self.messageLabel,
                                   @"titleLabel"            : self.titleLabel,
                                   @"promptView"            : self };
        
        NSDictionary *metrics = @{ @"dismissButtonHeight"   : @(kPromptViewDismissButtonHeight),
                                   @"promptViewWidth"       : @(kPromptViewWidth),
                                   @"promptViewHeight"      : @([self getHeight])};
        
        [self addLayoutConstraintWithVisualFormat:@"H:|[dismissButton]|" views:views];
        [self addLayoutConstraintWithVisualFormat:@"V:[dismissButton(dismissButtonHeight)]|" views:views metrics:metrics];
        
        [self addLayoutConstraintWithVisualFormat:@"H:|[titleLabel]|" views:views];
        [self addLayoutConstraintWithVisualFormat:@"H:|[messageLabel]|" views:views];
        [self addLayoutConstraintWithVisualFormat:@"V:|[titleLabel(21)][messageLabel(21)]" views:views];
       
        [self.wrapperView addSubview:self];
        [self.wrapperView addLayoutConstraintWithVisualFormat:@"H:[promptView(promptViewWidth)]" views:views metrics:metrics];
        [self.wrapperView addLayoutConstraintWithVisualFormat:@"V:[promptView(promptViewHeight)]" views:views metrics:metrics];
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
        _wrapperView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _wrapperView;
}

#pragma mark -
#pragma mark - Dismiss Button

- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_dismissButton addTarget:self action:@selector(tapDismiss:) forControlEvents:UIControlEventTouchUpInside];
        _dismissButton.backgroundColor = [UIColor brownColor];
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
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
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
    }
    return _messageLabel;
}

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
}

- (NSString *)message {
    return self.messageLabel.text;
}

#pragma mark -
#pragma mark - Show Prompt View

- (void)showInView:(UIView *)superview {
    CGSize s = [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    NSLog(@"size : %@", NSStringFromCGSize(s));
    [superview addSubview:self.wrapperView];
    
    NSDictionary *views = @{ @"wrapperView" : self.wrapperView };
    [superview addLayoutConstraintWithVisualFormat:@"H:|-0-[wrapperView]-0-|" views:views];
    [superview addLayoutConstraintWithVisualFormat:@"V:|-0-[wrapperView]-0-|" views:views];
}

#pragma mark -
#pragma mark - Hide Prompt View

- (void)hide {
    [self.wrapperView removeFromSuperview];
    self.wrapperView = nil;
}

#pragma mark -
#pragma mark - Dimension

- (CGFloat)getHeight {
    return 500;
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
