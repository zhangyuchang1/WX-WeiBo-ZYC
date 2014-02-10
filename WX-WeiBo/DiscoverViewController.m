//
//  DiscoverViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearWeiboMapViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"广场";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    for (int i = 100; i <102; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
//        button.layer.shadowColor = ([UIColor grayColor]);
        button.layer.shadowColor = [[UIColor grayColor] CGColor];
        button.layer.shadowOffset = CGSizeMake(3, 3);
        button.layer.shadowOpacity = 1;
        
        
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNearWeiboButton:nil];
    [self setNearUserButton:nil];
    [super viewDidUnload];
}
- (IBAction)nearWeiboAction:(UIButton *)sender {
    NearWeiboMapViewController *nearWeiboVC = [[NearWeiboMapViewController alloc] init];
    
    [self.navigationController pushViewController:nearWeiboVC animated:YES];
    
    
}

- (IBAction)nearUserAction:(UIButton *)sender {
}
@end
