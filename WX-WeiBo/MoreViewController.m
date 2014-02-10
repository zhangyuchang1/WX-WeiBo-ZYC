//
//  MoreViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeViewController.h"
#import "BrowModeViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}


#pragma mark--UItableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row == 0) {
            cell.textLabel.text = @"主题";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"图片浏览模式";

    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        //到ThemeViewController
        ThemeViewController *themeViewCtrl = [[ThemeViewController alloc] init];
        
        [self.navigationController pushViewController:themeViewCtrl animated:YES];
        
        
    }else if (indexPath.row == 1){
        BrowModeViewController *browViewCtrl = [[BrowModeViewController alloc] init];
        
        [self.navigationController pushViewController:browViewCtrl animated:YES];
    }

}
@end
