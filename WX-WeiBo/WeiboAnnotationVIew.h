//
//  WeiboAnnotationVIew.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationVIew : MKAnnotationView
{
    
    UIImageView   *_userImage;   //头像
    UIImageView   *_WeiboImage;  //微博图片
    UILabel       *_textLabel;   //微博内容
    
}




@end
