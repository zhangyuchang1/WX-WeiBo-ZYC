//
//  DetailViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-13.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "DetailViewController.h"
#import "WeiBoModel.h"
#import "WeiboView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "CommentTableView.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initSubView];
    [self loadData];
}

- (void)_initSubView
{
    //----------------大的头视图-----------
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWedth, 0)];
    headerView.backgroundColor = [UIColor clearColor];
    //---用户栏视图------
    //头像
    self.userImageView.layer.cornerRadius = 5;
    self.userImageView.layer.masksToBounds = YES;
    NSString *imageURL= self.weiboModel.user.profile_image_url;
    [self.userImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    //昵称
    self.nickLabel.text = self.weiboModel.user.screen_name;

    
    
    [headerView addSubview:self.userbarView];
    headerView.height += 60;
    
    
    //---------------------WeiboView--------------
    float h = [WeiboView getWeiboViewHeigh:_weiboModel isRepost:NO isDetail:YES];
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(15, _userbarView.bottom+10, KScreenWedth-20, h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboMdal = _weiboModel;
    [headerView addSubview:_weiboView];
    headerView.height += h+10;
    
    
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.eventDelegate = self;
    
}
#pragma mark---eventDelegate Dlegate
//-------------------模拟---------------------------
//下拉
- (void)pullDown:(BassTableView  *)tableView
{
    [self.tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2];
}
//上拉
- (void)pullUp:(BassTableView  *)tableView
{
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}
//选中一个cell
- (void)tableView:(BassTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma maek---Requst Comment
- (void) loadData
{
  NSString  *weiboID = [_weiboModel.weiboID stringValue];
    if (weiboID.length == 0) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:weiboID forKey:@"id"];
    [self.sinaweibo requestWithURL:@"comments/show.json" params:params httpMethod:@"GET" block:^(NSDictionary *result) {
        [self loadDataFinished:result];
    
    }];
    
}

- (void)loadDataFinished:(NSDictionary *)result
{
   NSArray *comments = [result objectForKey:@"comments"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:comments.count];
    for (NSDictionary *comment in comments) {
        
        CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:comment];
        
        [array addObject:commentModel];
    }
    
    //判断
    if (comments.count >= 50) {
        self.tableView.isMore = YES;
    }else{
        self.tableView.isMore = NO;
    }
    //
    self.tableView.commentDic = result;
    self.tableView.data = array;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setUserImageView:nil];
    [self setNickLabel:nil];
    [self setUserbarView:nil];
    [super viewDidUnload];
}
@end
