//
//  CommentModel.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-14.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WXBaseModel.h"
#import "UserModel.h"
#import "WeiBoModel.h"


//https://api.weibo.com/2/comments/show.json
//返回值字段	字段类型	字段说明
//created_at	string	评论创建时间
//id	int64	评论的ID
//text	string	评论的内容
//source	string	评论的来源
//user	object	评论作者的用户信息字段 详细
//mid	string	评论的MID
//idstr	string	字符串型的评论ID
//status	object	评论的微博信息字段 详细
//reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字
@interface CommentModel : WXBaseModel
@property (nonatomic,copy) NSString *created_at; //评论创建时间  "Wed Jun 01 00:50:25 +0800 2011"
@property (nonatomic,assign) int     id;         //评论的ID
@property (nonatomic,copy) NSString *text;       //评论的内容
@property (nonatomic,copy) NSString *source;     //评论的来源
@property (nonatomic,retain) UserModel *user;    //评论作者的用户信息字段 详细
@property (nonatomic,copy) NSString *mid;        //评论的MID
@property (nonatomic,copy) NSString *idstr;      //符串型的评论ID
@property (nonatomic,retain) NSDictionary *status; //评论的微博信息字段 详细
@property (nonatomic,retain) WeiBoModel *weibo; //



@end
