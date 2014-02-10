//
//  ThemeImageView.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-2.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,assign) int leftCapWidth;
@property (nonatomic,assign) int topCapWidth;

- (id)initWithImageName:(NSString *)imageName;

@end
