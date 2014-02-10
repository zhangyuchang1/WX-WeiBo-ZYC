//
//  MoreViewController.h
//  WX-WeiBo
//  更多控制器
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"


@interface MoreViewController : BassViewController<UITabBarDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
