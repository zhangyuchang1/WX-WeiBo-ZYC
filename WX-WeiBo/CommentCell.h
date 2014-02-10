//
//  CommentCell.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-13.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "RTLabel.h"
@class WXImageView;
@interface CommentCell : UITableViewCell<RTLabelDelegate>
{
     WXImageView *_userImage;
     UILabel     *_nickNameLabel;
     UILabel     *_timelabel;
     RTLabel     *_contentLabel;
}
@property (nonatomic,retain) CommentModel *commentModel;
//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel;
@end
