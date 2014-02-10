//
//  UserViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//
//个人中心

#import "BassViewController.h"
#import "WeiboTableView.h"
@class UserModel;
@class UserInfoView;

@interface UserViewController : BassViewController<TableViewEnventDelegate>
{
    
    NSMutableArray *_requests;
}
@property (nonatomic,copy)    NSString *userName;
@property (nonatomic,copy)  NSString  *userID;

@property (nonatomic,assign) BOOL showLginUser; //是否显示为当前登录用户资料

@property (nonatomic,retain)  UserInfoView  *userInfoView;
@property (strong, nonatomic) IBOutlet WeiboTableView *tableView;



@end
