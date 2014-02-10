//
//  RightViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "BassNavigationController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        
        SendViewController *sendVC = [[SendViewController alloc] init];
        BassNavigationController *sendNav = [[BassNavigationController alloc] initWithRootViewController:sendVC];
        
        [sendVC.appdelegate.menuCtrl presentModalViewController:sendNav animated:YES];
        
        
    }
    
}
@end
