//
//  FriendViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "FriendViewController.h"
#import "WXDataService.h"
#import "UserModel.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.data = [NSMutableArray array];
    }
    return self;
}

#pragma mark-- Data
- (void)loadData :(NSString *)url
{
    //接口新浪改为必须用自己的uid  self.userID
    //返回结果的游标，下一页用返回值里的next_cursor
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithObject:@"2411264843"forKey:@"uid"];
    
    if (self.cursor.length > 0) {
        
        [parms setObject:self.cursor forKey:@"cursor"];

    }
    
    [WXDataService requestWithURl:url parms:parms httpMethod:@"GET" completeBlock:^(id result) {
        [self loadDataFinish:result];
    }];
    
}
- (void)loadDataFinish:(NSDictionary *)result
{
    NSArray *users = result[@"users"];
    
 
    [super showLoading:NO];
   
    
    if (users != nil) {
        
        /*    [
         *        [@"",@"",@""]
         *        [@"",@"",@""]
         *        [@"",@"",@""]       ]
         *
         */
        NSMutableArray *users2d = nil;
        
        for (int i = 0; i < users.count; i ++) {
            
            NSDictionary *userDic = users[i];
            
            UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
            users2d = [self.data lastObject];
            
            if (users2d.count == 3 || users2d == nil) {
                users2d = [[NSMutableArray alloc] initWithCapacity:3];
                
                [self.data addObject:users2d];
            }
            
            [users2d addObject:user];
            
        }
        
        if (users.count < 45) {
            self.tableView.isMore = NO;
        }else{
            self.tableView.isMore = YES;
        }
        
        self.tableView.data = self.data;
        
        [self.tableView reloadData];

    }
    
    if (self.cursor == nil) {
        [self.tableView doneLoadingTableViewData];
    }
    //游标 
    NSString *cursor = [result[@"next_cursor"] stringValue];
    
    self.cursor = cursor;
    
    
    [self.tableView doneLoadingTableViewData];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [super showLoading:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.eventDelegate = self;
    
    if (self.shipType == Attention) {
        self.title = @"关注数";
        [self loadData:@"friendships/friends.json"];
        
    }else if (self.shipType == Fans){
        self.title = @"粉丝数";
        [self loadData:@"friendships/followers.json"];
    }

}
#pragma mark ---EventDelegate
//下拉
- (void)pullDown:(BassTableView  *)tableView
{
    //此时下拉的功能是：重新显示第一页，且只显示第一页。

    self.cursor = nil;
    [self.data removeAllObjects];
    if (self.shipType == Attention) {
        [self loadData:@"friendships/friends.json"];
        
    }else if (self.shipType == Fans){
        [self loadData:@"friendships/followers.json"];
    }

}
//上拉
- (void)pullUp:(BassTableView  *)tableView
{
    if (self.shipType == Attention) {
        [self loadData:@"friendships/friends.json"];
        
    }else if (self.shipType == Fans){
        [self loadData:@"friendships/followers.json"];
    }

}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
