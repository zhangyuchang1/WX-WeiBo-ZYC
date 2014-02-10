//
//  AppDelegate.h
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//
//App Key：3956901542
//App Secret：32f986bde276829e8a6737eb664950ab
#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "MainViewController.h"

#import "DDMenuController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (nonatomic,retain) MainViewController *mainViewController;
@property (nonatomic,retain)  DDMenuController *menuCtrl;

@end
