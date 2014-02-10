//
//  UIFactory.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheemeButton.h"
#import "ThemeImageView.h"
#import "Themelabel.h"

@interface UIFactory : NSObject

+ (TheemeButton *)creatWithImage:(NSString *)imageName highligtImage:(NSString *)highligtImageName;

+ (TheemeButton *)creatWithBackgroudImage:(NSString *)backgroudImageName highligtImage:(NSString *)backgroudHighligtImageName;
//创建导航栏的Item
+ (TheemeButton *)createNavigationBuuton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

+ (ThemeImageView *)creatWithImage:(NSString *)imageName;

+ (Themelabel *)creatWithColorName:(NSString *)name;
@end
