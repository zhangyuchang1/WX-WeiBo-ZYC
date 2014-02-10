//
//  WeiboTableView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-10.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "DetailViewController.h"

@implementation WeiboTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kReloadWeiboTableViewNotification object:nil];
    
    }
    return self;
}

#pragma mark---TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"WeiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    WeiBoModel *weibo = [self.data objectAtIndex:indexPath.row];
    cell.weiboModal= weibo;
    
    return cell;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiBoModel *weibo = [self.data objectAtIndex:indexPath.row];
    float height = [WeiboView getWeiboViewHeigh:weibo isRepost:NO isDetail:NO];
    
    height += 60;
    
    return height;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoModel *weiboMadel = [self.data objectAtIndex:indexPath.row];
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    
    detailViewCtrl.weiboModel = weiboMadel;
    
    [self.viewController.navigationController pushViewController:detailViewCtrl animated:YES];
}
//为什么不能加
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadWeiboTableViewNotification object:nil];
}
@end
