//
//  ThemeViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
@interface ThemeViewController : BassViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *themes;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
