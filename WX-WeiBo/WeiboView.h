//
//  WeiboView.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "RTLabel.h"
#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "ThemeImageView.h"

#define kWeibo_width_list  (320-60)     //在微博列表中的宽度
#define kWeibo_width_detail 300         //在详情中的宽度

@interface WeiboView : UIView<RTLabelDelegate>
{
    @private
    RTLabel      *_textLabel;               //微博内容
    UIImageView  *_image;                   //微博图片
    ThemeImageView  *_repostBackgroudView;     //转发的微博视图背景
    WeiboView    *_repostView;              //转发的微博视图
    NSMutableString *_paserText;             //更换的文本
    
}

//数据模型对象
@property (nonatomic,retain)WeiBoModel *weiboMdal;


//是否是转发的微博视图
@property (nonatomic,assign)BOOL isRepost;
//是否是详情视图
@property (nonatomic,assign)BOOL isDetail;

//获取微博视图的高度
+ (CGFloat )getWeiboViewHeigh:(WeiBoModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetai;
//获取微博视图的字体大小
+ (CGFloat)getFontSize: (BOOL)isDetail isRepost:(BOOL)isRepost;

@end
