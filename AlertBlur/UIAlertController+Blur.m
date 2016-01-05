//
//  UIAlertController+Blur.m
//  AlertBlur
//
//  Created by Geraldo Fernandes on 10/18/15.
//  Copyright © 2015 AlertBlur. All rights reserved.
//

#import "UIAlertController+Blur.h"

@implementation UIAlertController (Blur)

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
	
	[UIView animateWithDuration:0.3 animations:^{
		bluredDarkView.alpha = 1;
	} completion:^(BOOL finished) {
		[currentViewController presentViewController:self animated:YES completion:nil];
	}];
}

@end
