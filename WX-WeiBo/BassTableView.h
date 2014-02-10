//
//  BassTableView.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-10.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BassTableView;
@protocol TableViewEnventDelegate <NSObject>

@optional
//下拉
- (void)pullDown:(BassTableView  *)tableView;
//上拉
- (void)pullUp:(BassTableView  *)tableView;
//选中一个cell
- (void)tableView:(BassTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BassTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    EGORefreshTableHeaderView     *_refreshHeaderView;
    BOOL                           _reloading;   //是否重新加载
    UIButton                      *_moreBuuton;   //下拉加载跟多
}

@property (nonatomic,assign) BOOL refreshHeader;   //是否需要下拉
@property (nonatomic,retain) NSArray *data;
@property (nonatomic,assign) id<TableViewEnventDelegate> eventDelegate;
@property (nonatomic,assign) BOOL  isMore;    //是否还有更多（下一页）
//加载完后弹回
- (void)doneLoadingTableViewData;
- (void)refreshDta;
@end
