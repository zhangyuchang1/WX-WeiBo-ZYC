//
//  MainViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "MainViewController.h"
#import "BassNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "TheemeButton.h"
#import "UIFactory.h"
#import "AppDelegate.h"
#import "UserViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewControllers];
    [self _initTabbarView];
    
    //每隔60s请求未读数的接口
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----UI
//加载子视图控制器
- (void)_initViewControllers
{
    _homeViewCtrl = [[HomeViewController alloc] init];
    MessageViewController *messageViewController = [[MessageViewController alloc] init];
    UserViewController *profileViewController = [[UserViewController alloc] init];
    profileViewController.showLginUser  = YES;
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] init];
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    
    
    NSArray *viewControllers = @[_homeViewCtrl,messageViewController,profileViewController,discoverViewController,moreViewController];
    
    NSMutableArray *viewcontrls = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in viewControllers) {
        BassNavigationController *navgationCtrl = [[BassNavigationController alloc] initWithRootViewController:viewController];
        navgationCtrl.delegate = self;
        [viewcontrls addObject:navgationCtrl];
        
    }
    
    self.viewControllers = viewcontrls;
    
    

}
//自定义Tabbar视图
- (void)_initTabbarView
{
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight-49-20, KScreenWedth, 49)];
    
//    [_tabbarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]]];
    [self.view addSubview:_tabbarView];
    
  UIImageView *imageView =  [UIFactory creatWithImage:@"tabbar_background.png"];
    imageView.frame = _tabbarView.bounds;
    [_tabbarView addSubview:imageView];
    
    _sliderView =[UIFactory creatWithImage:@"tabbar_slider.png"];
    _sliderView.frame = CGRectMake((64-15)/2, 2.5, 15, 44);
    
    [_tabbarView addSubview:_sliderView];
    
    
    
    
    NSArray *itemNames = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *highligtht_itemNames = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for (int index = 0; index <[itemNames count]; index ++) {
        
        NSString *itemName = itemNames[index];
        NSString *hightName = highligtht_itemNames[index];
        
        
//        TheemeButton *item = [[TheemeButton alloc] initWithImage:itemName highlighted:hightName];
      UIButton *item = [UIFactory creatWithImage:itemName highligtImage:hightName];
        
        item.showsTouchWhenHighlighted = YES;
        [item setFrame:CGRectMake((64-30)/2+index*64, (49-30)/2, 30, 30)];
//        [item setBackgroundImage:[UIImage imageNamed:itemName] forState:UIControlStateNormal];
//        [item setBackgroundImage: [UIImage imageNamed:hightName] forState:UIControlStateHighlighted];
        item.tag = index;
        [item addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside ];
        
        [_tabbarView addSubview:item];
    }
    
    
}
- (void)selectTab:(UIButton *)button
{
    button.highlighted = YES;
  
    [UIView animateWithDuration:0.5 animations:^{
        _sliderView.left=button.left + (button.width - _sliderView.width)/2;

    }];
    //判断是否为重复点击 若是则下拉刷新
    if (button.tag == self.selectedIndex && button.tag == 0) {
        
        
        [_homeViewCtrl refreshWeibo];
        
    }
    self.selectedIndex = button.tag;
    

    
    
    

}

- (void)refreshUnreadView:(NSDictionary *)result
{
    int unreadCount =[[result objectForKey:@"status"] intValue];
    
    if (_badgeView == nil) {
         _badgeView = [UIFactory creatWithImage:@"main_badge.png"];
        _badgeView.frame = CGRectMake(64-20-5, 5, 20, 20);
        [_tabbarView addSubview:_badgeView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:_badgeView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.tag = 101;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        [_badgeView addSubview:label];
        
    }
    if (unreadCount > 0) {
        UILabel *label = (UILabel *)[_badgeView viewWithTag:101];
        if (unreadCount > 99) {
            unreadCount = 99;
        }
        label.text = [NSString stringWithFormat:@"%d",unreadCount];
        _badgeView.hidden = NO;
        
    }else{
        _badgeView.hidden = YES;
    }
   
    
    
}

- (void)showBadgeView:(BOOL)show
{
    _badgeView.hidden = !show;
}
//隐藏tabbar
- (void) showTabBar:(BOOL)show
{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.left = 0;
        }else{
            _tabbarView.left = -KScreenWedth;
        }
    

    }];
      [self resiziView:show];
    
}
- (void) resiziView:(BOOL)showTabBar
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showTabBar) {
                subView.height = KScreenHeight-20-49;
                
            }else{
                subView.height = KScreenHeight-20;
            }
        }
    
    }
    
    
}
#pragma mark---data
- (void)timerAction:(NSTimer *)timer
{
    [self loadUnreadData];
    
}
- (void)loadUnreadData
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaweibo =  appdelegate.sinaweibo;
    
    
    [sinaweibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" block:^(NSDictionary *result) {
        
        [self refreshUnreadView:result];
    }];
}
#pragma mark--SinaDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    //保存认证的信息到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [_homeViewCtrl loadSinaData];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    //移除认证数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

#pragma mark --UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int n = navigationController.viewControllers.count;
    if (n == 2) {
        [self showTabBar:NO];
    }else if (n == 1){
        [self showTabBar:YES];
    }
        
    
}
@end
