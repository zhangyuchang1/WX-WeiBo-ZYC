//
//  DiscoverViewController.h
//  WX-WeiBo
//  广场控制器
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"


@interface DiscoverViewController : BassViewController
@property (strong, nonatomic) IBOutlet UIButton *nearUserButton;
@property (strong, nonatomic) IBOutlet UIButton *nearWeiboButton;
- (IBAction)nearWeiboAction:(UIButton *)sender;
- (IBAction)nearUserAction:(UIButton *)sender;

@end
