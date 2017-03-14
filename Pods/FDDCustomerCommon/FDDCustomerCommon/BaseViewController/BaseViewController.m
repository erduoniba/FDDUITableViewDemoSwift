//
//  BaseViewController.m
//  Fangduoduo
//
//  Created by haifeng on 7/31/15.
//  Copyright (c) 2015 haifeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _navigationBarHidden = NO;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _navigationBarHidden = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.view.backgroundColor==nil || [self.view.backgroundColor isEqual:[UIColor clearColor]]) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.view setBackgroundColor:UIColorWithHex(0xf4f4f4)];
    
    if (self.navigationController.viewControllers.count > 1)
    {
        [self showBackBtn];
    }
    else
    {
        [self hideBackBtn];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    if (self.navigationController.isNavigationBarHidden != _navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:_navigationBarHidden animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.isNavigationBarHidden)
    {
        if (!(self.navigationController && self.navigationController.viewControllers && self.navigationController.viewControllers.count > 0 && ([[self.navigationController.viewControllers lastObject] respondsToSelector:@selector(navigationBarHidden)] && [[self.navigationController.viewControllers lastObject] navigationBarHidden])))
        {
            [self.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (self.navigationController.viewControllers.count > 1)
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (UIWindow *)getKeyWindow {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
            break;
        }
    }
    return nil;
}

+ (UIBarButtonItem *)createBarBackButtonItem:(id)target
                                    selector:(SEL)action
{
    UIImage * img = [UIImage imageNamed:@"ic_common_back"];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width+10, img.size.height)];
    
    [button setImage:img forState:UIControlStateNormal];
    
    [button setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [button titleLabel];
    [titleLabel sizeToFit];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

- (void)hideBackBtn
{
    self.navigationItem.leftBarButtonItems = nil;
    static UIView *clearView = nil;
    if(clearView == nil)
    {
        clearView = [UIView new];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearView];
}

- (void)showBackBtn
{
    [self showBackBtnWithSelector:@selector(backAction:)];
}

- (void)showBackBtnWithSelector:(SEL)selector
{
    UIBarButtonItem *backItem = [BaseViewController createBarBackButtonItem:self selector:selector];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
}

-(void) showRightItemWithTitle:(NSString *) title selector:(SEL) selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 44, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showRightItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:titleColor ? : [UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:highlightColor ? : [UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 44, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;

}

- (void)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector
{
    if (image)
    {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showRightBarButtonWithImage:(UIImage *)image hImage:(UIImage *)hImage selector:(SEL)selector
{
    if (self.navigationItem.rightBarButtonItem == nil) {
        UIButton *mRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [mRightBtn setAutoresizesSubviews:YES];
        [mRightBtn setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [mRightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [mRightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barRButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
        [self.navigationItem setRightBarButtonItem:barRButtonItem];
    }
    UIButton *mRightBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [mRightBtn setImage:image forState:UIControlStateNormal];
    if (hImage) {
        [mRightBtn setImage:hImage forState:UIControlStateHighlighted];
    }
}

- (void)showRightItemFixedOffsetWithTitle:(NSString *)itemTitle titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor itemSize:(CGSize)itemSize selector:(SEL)selector
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, itemSize.width, itemSize.height)];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:itemTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    if (highlightColor)
    {
        [rightBtn setTitleColor:highlightColor forState:UIControlStateHighlighted];
    }
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = -20.0f;
    
    self.navigationItem.rightBarButtonItems = @[fixItem,rightItem];
    
}

- (void)backAction:(id) sender
{
    if (self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([self presentingViewController])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end
