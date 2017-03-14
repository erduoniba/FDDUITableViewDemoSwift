//
//  BaseViewController.h
//  Fangduoduo
//
//  Created by haifeng on 7/31/15.
//  Copyright (c) 2015 haifeng. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary* modelDict;
@property (nonatomic, assign) BOOL navigationBarHidden;

- (void)showBackBtn;
- (void)hideBackBtn;
- (void)showBackBtnWithSelector:(SEL)selector;
- (void)showRightItemWithTitle:(NSString *)title selector:(SEL) selector;
- (void)showRightItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor selector:(SEL)selector;
- (UIWindow *)getKeyWindow;

- (void)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector;
- (void)showRightBarButtonWithImage:(UIImage *)image hImage:(UIImage *)hImage selector:(SEL)selector;
- (void)showRightItemFixedOffsetWithTitle:(NSString *)itemTitle titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor itemSize:(CGSize)itemSize selector:(SEL)selector;
- (void)backAction:(id)sender;

- (BOOL)shouldAutorotate;
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;

@end
