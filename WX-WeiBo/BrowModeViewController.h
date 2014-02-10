//
//  BrowModeViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-20.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
@interface BrowModeViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
