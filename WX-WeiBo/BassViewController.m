//
//  BassViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "BassViewController.h"
#import "AppDelegate.h"
#import "UIFactory.h"
#import "MBProgressHUD.h"

@interface BassViewController ()

@end

@implementation BassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.isbackButton = YES;
        self.isCancelButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.navigationController.viewControllers count]>1 && self.isbackButton == YES ) {
 
    
   UIButton *button = [UIFactory creatWithImage:@"navigationbar_back.png" highligtImage:@"navigationbar_back_highlighted.png"];
    
    [button setFrame:CGRectMake(0, 0, 24, 24)];
        button.showsTouchWhenHighlighted = YES;
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = backItem;
    }
    
    if (self.isCancelButton) {
        UIButton *button = [UIFactory createNavigationBuuton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancelAction)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = cancelItem;
    }
    

}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancelAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SinaWeibo *)sinaweibo
{
   AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
  SinaWeibo *sinaweibo =  appdelegate.sinaweibo;
    
    return sinaweibo;
}
- (AppDelegate *)appdelegate
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return appdelegate;
}
- (void)setTitle:(NSString *)title
{
    UILabel *label = [UIFactory creatWithColorName:kNavigationBarTitleLabel];
    

    
    label.font = [UIFont boldSystemFontOfSize:18];
   label.text = title;

    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;

}
#pragma mark---Loading
- (void)showLoading:(BOOL)show
{
    if (_loadView == nil) {
        _loadView = [[UIView alloc] initWithFrame:CGRectMake( 0, KScreenHeight/2-80, KScreenWedth, 20)];

        //loadinig视图
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        
    //loadingLabel
        UILabel *label = [[UILabel alloc ] initWithFrame:CGRectZero];
        label.text = @"正在加载。。。";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        
        
        label.left = (320-label.width)/2;
        activityView.right = label.left-5;
        [_loadView addSubview:label];
        [_loadView addSubview:activityView];
  
    }
    
    
    
    if (show) {
        if (![_loadView superview]) {
            [self.view addSubview:_loadView];
        }
        
    }else{
        [_loadView removeFromSuperview];
    }
    
    
}

- (void)showHUD:(NSString *)title isDim:(BOOL)isDim{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}
- (void)hiddenHUD
{
    [self.hud hide:YES];
}
- (void)showHUDComplete:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];

    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    [self.hud hide:YES afterDelay:2];
}
#pragma mark --发布提示
//发布提示
- (void)showStatustip:(BOOL)show title:(NSString *)title
{
    if (_tipWindow == nil) {
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.tag = 2013;
        [_tipWindow addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20-6 , 100, 6)] ;
        imageView.image = [UIImage imageNamed:@"queue_statusbar_progress.png"];
        imageView.tag = 2012;
        [_tipWindow addSubview:imageView];
        
               
        
    }
  
    UILabel *label = (UILabel *)[_tipWindow viewWithTag:2013];
    UIImageView *imageView = (UIImageView *)[_tipWindow viewWithTag:2012];
    
    if (show) {
        //另一种显示方法不行
        _tipWindow.hidden = NO;
        label.text = title;
        //发送闪动画
        imageView.left = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationRepeatCount:1000];

        imageView.left = KScreenWedth;
        
        [UIView commitAnimations];

        

    }else{
        label.text = title;
        [imageView setHidden:YES];

        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:2];
    }
    
    
}
- (void)removeTipWindow
{
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}
@end
