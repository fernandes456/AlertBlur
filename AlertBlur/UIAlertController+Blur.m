//
//  UIAlertController+Blur.m
//  AlertBlur
//
//  Created by Geraldo Fernandes on 10/18/15.
//  Copyright © 2015 AlertBlur. All rights reserved.
//

#import "UIAlertController+Blur.h"
#import <objc/runtime.h>

@interface UIAlertController ()

@property (nonatomic, unsafe_unretained) UIVisualEffectView *bluredDarkView;

@end

NSString * const kBluredDarkViewKey = @"kBluredDarkViewKey";

@implementation UIAlertController (Blur)

#pragma mark - Category method
- (void)showWithBlur
{
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	UIView *topView;
	UIViewController *currentViewController;
	
	if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navigationController = (UINavigationController *)window.rootViewController;
		topView = navigationController.topViewController.view;
		currentViewController = [navigationController visibleViewController];
	} else {
		topView = window.rootViewController.view;
		currentViewController = window.rootViewController;
	}
	
	UIBlurEffect *effectDark = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	UIVisualEffectView *bluredDarkView = [[UIVisualEffectView alloc] initWithEffect:effectDark];
	bluredDarkView.frame = topView.bounds;
	bluredDarkView.alpha = 0;
	[topView addSubview:bluredDarkView];

    self.bluredDarkView = bluredDarkView;
	
	[UIView animateWithDuration:0.3 animations:^{
		bluredDarkView.alpha = 1;
	} completion:^(BOOL finished) {
		[currentViewController presentViewController:self animated:YES completion:nil];
	}];
}

#pragma mark - getters/setters
- (void)setBluredDarkView:(UIVisualEffectView *)bluredDarkView
{
    objc_setAssociatedObject(self, (__bridge const void *)(kBluredDarkViewKey), bluredDarkView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIVisualEffectView *)bluredDarkView
{
    return objc_getAssociatedObject(self, (__bridge const void *)(kBluredDarkViewKey));
}

#pragma mark - Lifecycle
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.bluredDarkView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bluredDarkView removeFromSuperview];
        self.bluredDarkView = nil;
    }];
}

@end
