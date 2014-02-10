//
//  ThemeManage.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-1.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "ThemeManage.h"

static ThemeManage *sigleton = nil;
@implementation ThemeManage


+ (ThemeManage *)shareInstance 
{
    if (sigleton == nil) {
            @synchronized (self)
        {
            sigleton = [[ThemeManage alloc] init];
        }
    }
    return sigleton;
}

- (id)init
{
   self = [super init];
    if (self) {
      NSString *plistString =  [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        NSDictionary *themePlist = [NSDictionary dictionaryWithContentsOfFile:plistString];
        self.themePlist = themePlist;
        //默认为空
        self.themeName = nil;
    }
    
    return self;
    
    
}

- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        _themeName = [themeName copy];
    }
    
    NSString *themeBeg = [self getThemePath];
    NSString *path = [themeBeg stringByAppendingPathComponent:@"fontColor.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.fontColorPlist = dic;
}

- (UIColor *)getColorWithName:(NSString *)name  //返回当前主题下字体的颜色
{
    if (name.length != 0) {
        NSString *rgb = [self.fontColorPlist objectForKey:name];
        
        NSArray *rgbs = [rgb componentsSeparatedByString:@","];
        
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        
       UIColor *color = color(r, g, b, 1);
        
        return color;
    }else
        return nil;


}
//d当前主题的路径
- (NSString *)getThemePath
{
    //返回默认的主题
    if (self.themeName == nil) {
        NSString *themePath = [[NSBundle mainBundle] resourcePath];
        return themePath;
    }
    //--Skins/pink
    NSString *plistPath = [self.themePlist objectForKey:_themeName];
    //程序包路径
    NSString *resourcePath =[[NSBundle mainBundle] resourcePath];
    //完整主题包路径
    NSString *themePath = [resourcePath stringByAppendingPathComponent:plistPath];
    
    return themePath;
    

}

//返回当前主题包中图片的名称对应的图片
- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
   
        return nil;

    }
    
    NSString *imagePath =[[self getThemePath] stringByAppendingPathComponent:imageName];
    UIImage *themeImage =[UIImage imageWithContentsOfFile:imagePath];
    
    
    return themeImage;
}

-(id)copyWithZone:(NSZone *)zone{
    
    
    
    return sigleton;
}

+(id)allocWithZone:(NSZone *)zone{
    
    
    if (sigleton == nil) {
        sigleton = [super  allocWithZone:zone];
    }
    return sigleton;
    
    
}

@end
