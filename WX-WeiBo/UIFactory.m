//
//  UIFactory.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (TheemeButton *)creatWithImage:(NSString *)imageName highligtImage:(NSString *)highligtImageName
{
    TheemeButton *themeButton = [[TheemeButton alloc] initWithImage:imageName highlighted:highligtImageName];
    
    return themeButton;
}

+ (TheemeButton *)creatWithBackgroudImage:(NSString *)backgroudImageName highligtImage:(NSString *)backgroudHighligtImageName
{
    TheemeButton *themeButton = [[TheemeButton alloc] initWithBackgrougImage:backgroudImageName highlighted:backgroudHighligtImageName];
    
    return themeButton;
}
+ (ThemeImageView *)creatWithImage:(NSString *)imageName
{
    ThemeImageView *themeImageView = [[ThemeImageView alloc] initWithImageName:imageName];
    
    return themeImageView;
}

+ (Themelabel *)creatWithColorName:(NSString *)name
{
    Themelabel *themeLabel = [[Themelabel alloc] initWithColorName:name];
    return themeLabel;
    
    
}

//创建导航栏的Item
+ (UIButton *)createNavigationBuuton:(CGRect)frame
                                   title:(NSString *)title
                                  target:(id)target
                                  action:(SEL)action
{
   TheemeButton *button = [self creatWithBackgroudImage:@"navigationbar_button_background.png" highligtImage:@"navigationbar_button_delete_background.png"];
    
    button.frame = frame;

    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor yellowColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.leftCapWidth = 3;
    
    
    return button;
    
    
}


@end
