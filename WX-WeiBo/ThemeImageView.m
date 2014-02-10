//
//  ThemeImageView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManage.h"

@implementation ThemeImageView

//xib创建 初始化 b
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:kThemeDidchangeNotification object:nil];
    
}

- (id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:kThemeDidchangeNotification object:nil];;
    }
    return self;
}
#pragma mark---NotificationAction
- (void)themeChanged:(NSNotification *)notification
{
    [self loadImage];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)loadImage
{
    if (self.imageName == nil) {
        return;
    }
    
   UIImage *image = [[ThemeManage shareInstance] getThemeImage:_imageName];
    
    
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    
    [self setImage:image];
    
    
}
//覆盖set方法
- (void) setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    
    [self loadImage];
}
@end
