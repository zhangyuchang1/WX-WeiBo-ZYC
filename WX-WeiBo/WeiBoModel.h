//
//  WeiBoModel.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-4.
//  Copyright (c) 2014年 张 . All rights reserved.
//
//
//
//                返回值字段	字段类型	字段说明
//                created_at	string	微博创建时间
//                id	int64	微博ID
//                text	string	微博信息内容
//                source	string	微博来源
//                favorited	boolean	是否已收藏，true：是，false：否


//                thumbnail_pic	string	缩略图片地址，没有时不返回此字段
//                bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
//                original_pic	string	原始图片地址，没有时不返回此字段
//                geo	object	地理信息字段 详细
//                user	object	微博作者的用户信息字段 详细
//                retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
//                reposts_count	int	转发数
//                comments_count	int	评论数

#import "WXBaseModel.h"
#import "UserModel.h"




@interface WeiBoModel : WXBaseModel

@property (nonatomic,copy)NSString          *createDate;       //微博创建时间
@property (nonatomic,retain)NSNumber        *weiboID;          //微博ID
@property (nonatomic,copy)NSString          *text;             //微博信息内容
@property (nonatomic,copy)NSString          *source;           //微博来源
@property (nonatomic,retain)NSNumber        *favorited;        //是否已收藏，true：是，false：否
@property (nonatomic,copy)NSString          *thumbnailImage;   //缩略图片地址，没有时不返回此字段
@property (nonatomic,copy)NSString          *bmiddleImage;     //中等尺寸图片地址，没有时不返回此字段
@property (nonatomic,copy)NSString          *originalImage;    //原始图片地址，没有时不返回此字段
@property (nonatomic,retain)NSDictionary    *geo;              //地理信息字段
@property (nonatomic,retain)WeiBoModel      *relWeibo;         //被转发的原微博对象
@property (nonatomic,retain)UserModel       *user;             //微博的作者用户
@property (nonatomic,retain)NSNumber        *repostsConut;     //转发数
@property (nonatomic,retain)NSNumber        *commentsCount;    //微博评论数


@end
