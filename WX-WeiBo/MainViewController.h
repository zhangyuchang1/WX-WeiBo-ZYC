//
//  MainViewController.h
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@class HomeViewController;

@interface MainViewController : UITabBarController<SinaWeiboDelegate,UINavigationControllerDelegate>
{
    UIView *_tabbarView;
    UIImageView *_sliderView;
    UIImageView *_badgeView;
    HomeViewController *_homeViewCtrl;
}
- (void)showBadgeView:(BOOL)show;

//切换隐藏tabbar
- (void) showTabBar:(BOOL)show;
@end
