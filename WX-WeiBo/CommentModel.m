//
//  CommentModel.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-14.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

//- (NSDictionary *)attributeMapDictionary
//{
//    @property (nonatomic,copy) NSString *created_at; //评论创建时间  "Wed Jun 01 00:50:25 +0800 2011"
//    @property (nonatomic,assign) int     id;         //评论的ID
//    @property (nonatomic,copy) NSString *text;       //评论的内容
//    @property (nonatomic,copy) NSString *source;     //评论的来源
//    @property (nonatomic,retain) UserModel *user;    //评论作者的用户信息字段 详细
//    @property (nonatomic,copy) NSString *mid;        //评论的MID
//    @property (nonatomic,copy) NSString *idstr;      //符串型的评论ID
//    @property (nonatomic,retain) NSDictionary *status; //评论的微博信息字段 详细
//    @property (nonatomic,retain) WeiBoModel *weibo; //
    
    //------------------
//    NSDictionary *mapAtt = @{
//    @"created_at":@"created_at",
//    @"id":@"id",
//    @"text":@"text",
//    @"source":@"source",
//    @"mid":@"mid",
//    @"idstr":@"idstr",
//
//    };
//    
//    return mapAtt;
//    
//}
//
//- (void) setAttributes:(NSDictionary *)dataDic
//{
//    //将字典数据根据映射关系填充到当前对象的属性上
//    [super setAttributes:dataDic];
//    
//    NSDictionary *weibo = [dataDic objectForKey:@"status"];
//    if (weibo != nil) {
//        
//        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weibo];
//        self.weibo = weibo;
//    }
//    
//    
//    
//    
//    NSDictionary *userDic = [dataDic objectForKey:@"user"];
//    if (userDic != nil) {
//        
//        UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
//        self.user = user;
//    }
//    
//    
//    
//}


-(void)setAttributes:(NSDictionary *)dataDic{
    
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    
    UserModel *user = [[UserModel alloc]initWithDataDic:userDic];
    WeiBoModel *weibo = [[WeiBoModel alloc]initWithDataDic:statusDic];
    
    self.user = user ;
    self.weibo =weibo ;
    
}
@end
