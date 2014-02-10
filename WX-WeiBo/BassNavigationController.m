//
//  BassNavigationController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "BassNavigationController.h"
#import "ThemeManage.h"

@interface BassNavigationController ()

@end

@implementation BassNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangeNotification object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadThemeImage];
    
    UISwipeGestureRecognizer *swipeGusture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];

    swipeGusture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGusture];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (self.viewControllers.count > 1) {
        if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
            [self popViewControllerAnimated:YES];

        }
    }
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidchangeNotification object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---NotificationAction

- (void)themeNotification:(NSNotification *)notification
{
    
    [self loadThemeImage];
    
}

- (void)loadThemeImage
{
    UIImage *image = [[ThemeManage shareInstance] getThemeImage:@"navigationbar_background.png"];

    float version = WXHLOSVersion();
    
    if (version >= 5.0) {
        
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault ];
    }else{
        //调用setNeedsDisplay异步渲染引擎调用drawRect
        [self.navigationBar setNeedsDisplay];
    }

}
@end
