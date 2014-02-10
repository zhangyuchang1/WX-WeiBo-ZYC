//
//  BassViewController.h
//  WX-WeiBo
//
//  Created by 张  on 13-12-29.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "AppDelegate.h"

@class MBProgressHUD;
@interface BassViewController : UIViewController
//@property (nonatomic,retain) SinaWeibo *sinaweibo;
{
    UIView *_loadView;
    UIWindow *_tipWindow;  //发布提示
}
//导航的返回按钮
@property (nonatomic,assign)BOOL isbackButton;
//模态的取消按钮
@property (nonatomic,assign)BOOL isCancelButton;

@property (nonatomic,retain)MBProgressHUD *hud;

- (SinaWeibo *)sinaweibo;
//加载提示
- (void)showLoading:(BOOL)show;
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
- (void)hiddenHUD;
- (void)showHUDComplete:(NSString *)title;

- (AppDelegate *)appdelegate;

- (void)cancelAction;
//发布提示
- (void)showStatustip:(BOOL)show title:(NSString *)title;
@end
