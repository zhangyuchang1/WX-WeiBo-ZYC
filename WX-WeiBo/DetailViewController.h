//
//  DetailViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-13.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "BassViewController.h"

@class WeiBoModel;
@class WeiboView;
@class CommentTableView;
#import "BassTableView.h"
@interface DetailViewController : BassViewController<TableViewEnventDelegate>

{
    WeiboView *_weiboView;
    UIView *view;
}
@property (strong, nonatomic) IBOutlet CommentTableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
@property (strong, nonatomic) IBOutlet UIView *userbarView;
@property (nonatomic,retain)WeiBoModel *weiboModel;
@end
