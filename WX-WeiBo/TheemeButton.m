//
//  TheemeButton.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "TheemeButton.h"
#import "ThemeManage.h"
@implementation TheemeButton



- (id)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightedImage
{
    self = [self init];
    if (self){
        
        self.imageName = imageName;
        self.highligtImageName = highlightedImage;
                
    }
    return self;
}

- (id)initWithBackgrougImage:(NSString *)imageName highlighted:(NSString *)highlightedBackgrougImage
{
    self = [self init];
    if (self) {
        
        self.backgrougImageName = imageName;
        self.backgrougHighligtImageName = highlightedBackgrougImage;
        
        
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
//切换主题的通知
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
    ThemeManage *themeManager = [ThemeManage shareInstance];
    
    UIImage *image1 = [themeManager getThemeImage:_imageName];
    
    [self setImage:image1 forState:UIControlStateNormal];
//    [themeManager getThemeImage:_imageName];
    [self setImage:[themeManager getThemeImage:_highligtImageName] forState:UIControlStateHighlighted];
    
    UIImage *ima =[themeManager getThemeImage:_backgrougImageName];
    ima = [ima stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    
    [self setBackgroundImage:ima forState:UIControlStateNormal];
    //    [themeManager getThemeImage:_imageName];
    
    UIImage *ima2 = [themeManager getThemeImage:_backgrougHighligtImageName];
    ima2 = [ima2 stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    [self setBackgroundImage:ima2 forState:UIControlStateHighlighted];
    
}


//覆盖
- (void)setLeftCapWidth:(int)leftCapWidth
{
    _leftCapWidth = leftCapWidth;
    [self loadImage];
    
}
- (void)setTopCapWidth:(int)topCapWidth
{
    _topCapWidth = topCapWidth;
    [self loadImage];
}
//覆盖set方法
- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        
    
    _imageName = [imageName copy];
    }
    [self loadImage];
}


- (void)setHighligtImageName:(NSString *)highligtImageName
{
    _highligtImageName = [highligtImageName copy];
    [self loadImage];
}
- (void)setBackgrougImageName:(NSString *)backgrougImageName
{
    _backgrougImageName = backgrougImageName;
    [self loadImage];
}
- (void)setBackgrougHighligtImageName:(NSString *)backgrougHighligtImageName
{
    _backgrougHighligtImageName = backgrougHighligtImageName;
    
    [self loadImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
