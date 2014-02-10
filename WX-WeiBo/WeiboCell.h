//
//  WeiboCell.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "WeiboView.h"
@class WXImageView;

@interface WeiboCell : UITableViewCell
{
    WXImageView    *_userImage;      //头像
    UILabel        *_nicklabel;      //昵称
    UILabel        *_repostCountLabel;//转发数
    UILabel        *_commentLabel;   //回复数
    UILabel        *_sourceLabel;    //发布来源
    UILabel        *_creatLabel;     //发布时间

    
    
}

@property (nonatomic,retain)WeiBoModel *weiboModal;  //微博数据模型对象
@property (nonatomic,retain)WeiboView  *weiboView;   //微博视图对象

@end
