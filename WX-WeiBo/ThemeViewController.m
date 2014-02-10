//
//  ThemeViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManage.h"
#import "UIFactory.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    ThemeManage *themeManage =  [ThemeManage shareInstance];
    
      themes = [themeManage.themePlist allKeys];
        self.title = @"切换主题";

        
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
    return [themes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        UILabel *label = [UIFactory creatWithColorName:kThemeListLabel];
        label.frame = CGRectMake(10, 10, 200, 30);
        label.font = [UIFont boldSystemFontOfSize:18];
        label.tag = 101;
        label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:label];
        
        
    }
  UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    
    NSString *themeName = themes[indexPath.row];
    
    label.text = themeName;
    

    
   NSString *theme = [ThemeManage shareInstance].themeName;
    
    if (theme == nil) {
        theme = @"默认";
    }
    
    if ([theme isEqualToString:themeName]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}         

//发送通知
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    
    NSString *theme = themes[indexPath.row];
  
    if ([theme isEqualToString:@"默认"]) {
        theme = nil;
    }
    
    
    
    [ThemeManage shareInstance].themeName = theme;
    
    //保存成属性列表到本地
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //点击后发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidchangeNotification object:nil];
    
    //更新数据
    [tableView reloadData];
    
}


@end
