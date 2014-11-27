//
//  ViewController.m
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "ViewController.h"
#import "MONPromptView.h"
#import "UIViewController+LayoutConstraint.h"

@interface ViewController () <MONPromptViewDelegate> {
    int _counter;
}

@property (strong, nonatomic) UIButton *promptViewButton;
@property (strong, nonatomic) MONPromptView *promptView;

- (void)showPromptView:(UIButton *)button;
- (void)printAllFonts;

@end

@implementation ViewController

#pragma mark -
#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self printAllFonts];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.promptViewButton];
    
    NSDictionary *views = @{ @"promptViewButton": self.promptViewButton };
    [self addLayoutConstraintWithVisualFormat:@"V:[promptViewButton(44)]" views:views];
    [self addLayoutConstraintWithVisualFormat:@"H:[promptViewButton(200)]" views:views];
    [self addLayoutConstraintCenterForView:self.promptViewButton];
}

#pragma mark -
#pragma mark - Prompt View

- (MONPromptView *)promptView {
    if (!_promptView) {
        _promptView =
        [[MONPromptView alloc] initWithTitle:@"Hello, John Doe!"
                                     message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                          dismissButtonTitle:@"TRY AGAIN"
                                  attributes:@{ kMONPromptViewAttribDismissButtonBackgroundColor: [UIColor colorWithRed:40/255.0f green:122/255.0f blue:1.0f alpha:1.0f],
                                                kMONPromptViewAttribDismissButtonTextColor: [UIColor whiteColor],
                                                kMONPromptViewAttribDismissButtonFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f],
                                                kMONPromptViewAttribMessageFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f],
                                                kMONPromptViewAttribTitleFont: [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f] }];
        _promptView.delegate = self;
    }
    return _promptView;
}

#pragma mark -
#pragma mark - Actions

- (void)showPromptView:(UIButton *)button {
    _counter++;
    if (_counter % 3 == 0) {
        self.promptView.title = @"Hello, John Doe!";
        self.promptView.message = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
    } else if (_counter % 3 == 1) {
        self.promptView.title = @"Hello, John Doe!";
        self.promptView.message = @"Lorem Ipsum is simply dummy text.";
    } else if (_counter % 3 == 2) {
        self.promptView.title = @"Hello, John Doe! Hello, John Doe! Hello, John Doe! Hello, John Doe! Hello, John Doe!";
        self.promptView.message = @"Lorem Ipsum is simply dummy text.";
    }
    [self.promptView showInView:self.view];
}

#pragma mark -
#pragma mark - Prompt View Button

- (UIButton *)promptViewButton {
    if (!_promptViewButton) {
        _promptViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _promptViewButton.translatesAutoresizingMaskIntoConstraints = NO;
        _promptViewButton.backgroundColor = [UIColor brownColor];
        _promptViewButton.layer.cornerRadius = 3.0f;
        [_promptViewButton setTitle:@"Show Prompt View" forState:UIControlStateNormal];
        [_promptViewButton addTarget:self
                              action:@selector(showPromptView:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _promptViewButton;
}

#pragma mark -
#pragma mark - Prompt View Delegate

- (void)promptViewWillDismiss:(MONPromptView *)promptView {
    
}

#pragma mark -
#pragma mark - Print All Fonts

- (void)printAllFonts {
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++) {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}

@end
