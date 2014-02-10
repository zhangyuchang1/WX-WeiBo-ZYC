//
//  UIButton+loadNetworkImage.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManagerDelegate.h"

@interface UIButton (loadNetworkImage)<SDWebImageManagerDelegate>


- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end

