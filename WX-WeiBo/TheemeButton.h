//
//  TheemeButton.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheemeButton : UIButton

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *highligtImageName;

@property (nonatomic,copy) NSString *backgrougImageName;
@property (nonatomic,copy) NSString *backgrougHighligtImageName;

@property (nonatomic,assign) int leftCapWidth; //图片拉伸左边距离
@property (nonatomic,assign) int topCapWidth;  //图片拉伸上下距离

- (id)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightedImage;

- (id)initWithBackgrougImage:(NSString *)imageName highlighted:(NSString *)highlightedBackgrougImage;

@end
