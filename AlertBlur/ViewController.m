//
//  ViewController.m
//  AlertBlur
//
//  Created by Geraldo Fernandes on 10/18/15.
//  Copyright © 2015 AlertBlur. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+Blur.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *visualEffects;
@property (nonatomic, assign) NSInteger currentVisualEffectsSelected;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.visualEffects = [NSMutableArray new];
	self.currentVisualEffectsSelected = -1;
//	CGFloat oneQuarterHeight = self.view.bounds.size.height / 4;
	
	UIBlurEffect *effectExtraLight = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
	UIVisualEffectView *bluredExtraLightView = [[UIVisualEffectView alloc] initWithEffect:effectExtraLight];
	bluredExtraLightView.frame = self.view.bounds;
//	bluredExtraLightView.frame = CGRectMake(0, 0 * oneQuarterHeight, self.view.bounds.size.width, oneQuarterHeight);
//	[self.view addSubview:bluredExtraLightView];
	[self.visualEffects addObject:bluredExtraLightView];
	
	UIBlurEffect *effectLight = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVisualEffectView *bluredLightView = [[UIVisualEffectView alloc] initWithEffect:effectLight];
	bluredLightView.frame = self.view.bounds;
//	bluredLightView.frame = CGRectMake(0, 1 * oneQuarterHeight, self.view.bounds.size.width, oneQuarterHeight);
//	[self.view addSubview:bluredLightView];
	[self.visualEffects addObject:bluredLightView];
	
	UIBlurEffect *effectDark = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	UIVisualEffectView *bluredDarkView = [[UIVisualEffectView alloc] initWithEffect:effectDark];
	bluredDarkView.frame = self.view.bounds;
//	bluredDarkView.frame = CGRectMake(0, 2 * oneQuarterHeight, self.view.bounds.size.width, oneQuarterHeight);
//	[self.view addSubview:bluredDarkView];
	[self.visualEffects addObject:bluredDarkView];
	
//	[self applyVisualEffect];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)applyVisualEffect
{
	if (self.currentVisualEffectsSelected >= 0) {
		UIVisualEffectView *visualEffect = self.visualEffects[self.currentVisualEffectsSelected];
		[visualEffect removeFromSuperview];
		self.currentVisualEffectsSelected++;
	} else {
		self.currentVisualEffectsSelected = 0;
	}
	
	if (self.currentVisualEffectsSelected < self.visualEffects.count) {
		UIVisualEffectView *visualEffect = self.visualEffects[self.currentVisualEffectsSelected];
		visualEffect = self.visualEffects[self.currentVisualEffectsSelected];
		[self.view addSubview:visualEffect];
	} else {
		self.currentVisualEffectsSelected = -1;
	}
	
}

- (void)showCustomAlert
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Olár"
																   message:@"Tudo bem com você?"
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
	UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleCancel
													 handler:^(UIAlertAction * action) {}];
	UIAlertAction *dontKnowAction = [UIAlertAction actionWithTitle:@"Não sei" style:UIAlertActionStyleDestructive
													 handler:^(UIAlertAction * action) {}];
	
	[alert addAction:yesAction];
	[alert addAction:noAction];
	[alert addAction:dontKnowAction];
	
	[alert showWithBlur];
}

#pragma mark -
- (IBAction)tapView:(id)sender {
//	[self applyVisualEffect];
	[self showCustomAlert];
}
@end
