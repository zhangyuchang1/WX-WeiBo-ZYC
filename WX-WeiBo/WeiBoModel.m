//
//  WeiBoModel.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-4.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiBoModel.h"

@implementation WeiBoModel

- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *mapAtt = @{
    @"createDate":@"created_at",
    @"weiboID":@"id", 
    @"text":@"text",
    @"source":@"source",
    @"favorited":@"favorited",
    @"thumbnailImage":@"thumbnail_pic",
    @"bmiddleImage":@"bmiddle_pic",
    @"originalImage":@"original_pic",
    @"geo":@"geo",
    @"repostsConut":@"reposts_count",
    @"commentsCount":@"comments_count",
    };
    
    return mapAtt;
    
}

- (void) setAttributes:(NSDictionary *)dataDic
{
    //将字典数据根据映射关系填充到当前对象的属性上
    [super setAttributes:dataDic];
    
  NSDictionary *retWeibo = [dataDic objectForKey:@"retweeted_status"];
    if (retWeibo != nil) {
        
        WeiBoModel *relWeibo = [[WeiBoModel alloc] initWithDataDic:retWeibo];
        self.relWeibo = relWeibo;
    }
    

    
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        
        UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;
    }
    
    
    
}

@end
