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

@interface ViewController ()

@property (strong, nonatomic) UIButton *promptViewButton;

- (void)showPromptView:(UIButton *)button;

@end

@implementation ViewController

#pragma mark -
#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.promptViewButton];
    
    NSDictionary *views = @{ @"promptViewButton": self.promptViewButton };
    [self addLayoutConstraintWithVisualFormat:@"V:[promptViewButton(70)]" views:views];
    [self addLayoutConstraintWithVisualFormat:@"H:[promptViewButton(200)]" views:views];
    [self addLayoutConstraintCenterForView:self.promptViewButton];
}

#pragma mark -
#pragma mark - Actions

- (void)showPromptView:(UIButton *)button {
    MONPromptView *promptView = [[MONPromptView alloc] initWithTitle:@"Error" message:@"Something went wrong." dismissButtonTitle:@"OK"];
    [promptView showInView:self.view];
}

#pragma mark -
#pragma mark - Prompt View Button

- (UIButton *)promptViewButton {
    if (!_promptViewButton) {
        _promptViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _promptViewButton.translatesAutoresizingMaskIntoConstraints = NO;
        _promptViewButton.backgroundColor = [UIColor brownColor];
        [_promptViewButton setTitle:@"Show Prompt View" forState:UIControlStateNormal];
        [_promptViewButton addTarget:self
                              action:@selector(showPromptView:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _promptViewButton;
}

#pragma mark -
#pragma mark - Prompt View

@end
