//
//  UIView+Additions.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (UIViewController *)viewController
{
    //下一个响应者
   UIResponder *next = [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            UIViewController *viewController = (UIViewController *)next;
            return viewController;
        }else
        {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}

@end
