//
//  Themelabel.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-3.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "Themelabel.h"
#import "ThemeManage.h"

@implementation Themelabel

- (id)initWithColorName:(NSString *)name
{
    self = [self init];
    if (self != nil ) {
        
        self.colorName = name;
        
        
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

- (void)setColor
{
    
   UIColor *color = [[ThemeManage shareInstance] getColorWithName:_colorName];
    [self setTextColor:color];
    
    
}
//覆盖set方法
- (void)setColorName:(NSString *)colorName
{
    _colorName = [colorName copy];
    
    [self setColor];
    
}

#pragma mark--NSNotificationAction
- (void) themeChanged:(NSNotification *)notification
{
    [self setColor];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
