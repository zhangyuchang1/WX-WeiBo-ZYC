//
//  MessageViewController.h
//  WX-WeiBo
//  消息控制器
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "WeiboTableView.h"


@interface MessageViewController : BassViewController<TableViewEnventDelegate>

@property (nonatomic,retain) WeiboTableView *weiboTableView;;

@end
