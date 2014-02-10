//
//  ThemeManage.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-1.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManage : NSObject

@property (nonatomic,copy)NSString *themeName;//当前主题的名称
@property (nonatomic,retain)NSDictionary *themePlist;

@property (nonatomic,retain)NSDictionary *fontColorPlist;

+ (ThemeManage *)shareInstance;
- (UIImage *)getThemeImage:(NSString *)imageName;//返回当前主题包中图片的名称对应的图片

- (UIColor *)getColorWithName:(NSString *)name;//返回当前主题下字体的颜色
@end
