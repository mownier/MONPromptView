//
//  ViewController.m
//  MONPromptView
//
//  Created by mownier on 11/25/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "ViewController.h"
#import "MONPromptView.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *promptViewButton;
@property (strong, nonatomic) MONPromptView *promptView;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views;
- (void)addLayoutConstraintWithVisualformat:(NSString *)visualFormat views:(NSDictionary *)views superview:(UIView *)superview;

@end

@implementation ViewController

#pragma mark -
#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark - Prompt View Button

- (UIButton *)promptViewButton {
    if (!_promptViewButton) {
        _promptViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _promptViewButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_promptViewButton setTitle:@"Show Prompt View" forState:UIControlStateNormal];
    }
    return _promptViewButton;
}

#pragma mark -
#pragma mark - Prompt View

@end
