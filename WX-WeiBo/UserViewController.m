//
//  UserViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "UserModel.h"
#import "WeiBoModel.h"
#import "UIFactory.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.showLginUser) {
        
        
        
        NSUserDefaults *userDefail = [NSUserDefaults standardUserDefaults];
        NSDictionary *sinaweiboInfo = [userDefail objectForKey:@"SinaWeiboAuthData"];
        NSString *userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        self.userID = userID;
    }
    
    
    self.tableView.eventDelegate = self;

    _userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self loadUserData];
    [self loadWeiboData];
    
    //返回首页按钮
    UIButton *homeButton = [UIFactory creatWithBackgroudImage:@"tabbar_home.png" highligtImage:@"tabbar_home_highlighted.png"];
    [homeButton setFrame:CGRectMake(0, 0, 34, 27)];
    [homeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    self.navigationItem.rightBarButtonItem = homeItem;
    _requests = [[NSMutableArray alloc] init];
}
//离开页面取消请求
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (SinaWeiboRequest *requst  in _requests) {
        //取消请求
        [requst disconnect];
    }
    
}
#pragma mark---Data
//加载用户资料
- (void)loadUserData
{
    if (self.userName.length < 1 && self.userID.length == 0) {
        NSLog(@"errer :用户为空");
        return;
    }
    //请求用户信息

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.userID.length != 0) {
        [params setObject:self.userID forKey:@"uid"];
        
    }else{
        [params setObject:self.userName forKey:@"screen_name"];
    }
    
    
   SinaWeiboRequest *requst = [self.sinaweibo requestWithURL:@"users/show.json" params:params httpMethod:@"GET" block:^(NSDictionary *result) {
    
        [self loadUserDataFinish:result];
    }];
    
    [_requests addObject:requst];
}

- (void)loadUserDataFinish:(NSDictionary *)resilt
{
    UserModel *user = [[UserModel alloc] initWithDataDic:resilt];
    self.userInfoView.user = user;
    
    self.tableView.tableHeaderView = _userInfoView;
    

}
//加载用户发表的微博
- (void)loadWeiboData
{
    if (self.userName.length < 1 && self.userID.length == 0) {
        NSLog(@"errer :用户为空");
        return;
    }
    //请求用户信息
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.userID.length != 0) {
        [params setObject:self.userID forKey:@"uid"];
        
    }else{
        [params setObject:@"o如你所愿o" forKey:@"screen_name"];
    }
    
    //请求用户信息


    //注：这个接口，新浪微博改变为：只有授权的才能读取，所以，在这不能读取所有用户的微博了。
    SinaWeiboRequest *requst = [self.sinaweibo requestWithURL:@"statuses/user_timeline.json" params:params httpMethod:@"GET" block:^(NSDictionary *result) {


        [self loadWeiboDataFinish:result];

    
    }];
    
    [_requests addObject:requst];
}

- (void)loadWeiboDataFinish:(NSDictionary *)resilt
{
    NSArray *statuses = [resilt objectForKey:@"statuses"];
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *dic in statuses) {
        
        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:dic];
        
        [weibos addObject:weibo];
        
        
    }
    
    self.tableView.data = weibos;
    if (weibos.count > 20  ){
        self.tableView.isMore = YES;
    }else{
        self.tableView.isMore = NO;

    }
    [self.tableView reloadData];
    
}
#pragma mark-- TableViewEnventDelegate
//下拉
- (void)pullDown:(BassTableView  *)tableView
{
    [tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2];
}
//上拉
- (void)pullUp:(BassTableView  *)tableView
{
    [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}

#pragma mark --action
- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
@end
