# MONPromptView

A custom simple prompt view. It consists only title and message labels, and a single dismiss button where the text color and font of the two labels and the button can be customized.

![MONPromptView] (https://raw.github.com/mownier/MONPromptView/master/screenshot.gif)

## Initialization
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"Hello, John Doe!";
    NSString *message = @"Welcome, Home.";
    NSString *dismissTitle = @"OK";
    MONPromptView *promptView = [[MONPromptView alloc] initWithTitle:title 
                                                             message:message 
                                                  dismissButtonTitle:dismissTitle];
}
```

## Customization
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"Hello, John Doe!";
    NSString *message = @"Welcome, Home.";
    NSString *dismissTitle = @"OK";
    NSDictionary *attributes = @{ kMONPromptViewAttribDismissButtonBackgroundColor: [UIColor colorWithRed:40/255.0f green:122/255.0f blue:1.0f alpha:1.0f],
                                  kMONPromptViewAttribDismissButtonTextColor: [UIColor whiteColor],
                                  kMONPromptViewAttribDismissButtonFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f],
                                  kMONPromptViewAttribMessageFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f],
                                  kMONPromptViewAttribTitleFont: [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f] };
    MONPromptView *promptView = [[MONPromptView alloc] initWithTitle:title
                                                             message:message
                                                  dismissButtonTitle:dismissTitle 
                                                          attributes:attributes];
}
```

## Attribute Keys
```objective-c
// Dismiss Button Background Color
kMONPromptViewAttribDismissButtonBackgroundColor

// Dismiss Button Text Color
kMONPromptViewAttribDismissButtonTextColor

// Dismiss Button Font
kMONPromptViewAttribDismissButtonFont

// Title Text Color
kMONPromptViewAttribTitleTextColor

// Title Font
kMONPromptViewAttribTitleFont

// Messsage Text Color
kMONPromptViewAttribMessageTextColor

// Message Font
kMONPromptViewAttribMessageFont
```

## Delegate
```objective-c
@interface ViewController : UIViewController<MONPromptViewDelegate>

@end

@implementation ViewController

#pragma mark -
#pragma mark - MONPromptView Delegate

- (void)promptViewWillDismiss:(MONPromptView *)promptView {
    // TODO Handle on dismiss
}

@end
```
## Displaying Prompt View
```objective-c
// If there is no navigation controller
[promptView showInView:self.view];

// If there is a navigation controller
[promptView showInView:self.navigationController.view];
```





