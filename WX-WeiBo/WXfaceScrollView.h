//
//  WXfaceScrollView.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-7.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFaceView.h"

@interface WXfaceScrollView : UIView<UIScrollViewDelegate>

{
    UIScrollView *_scrollView;
    WXFaceView   *_faceView;
    UIPageControl *_pageControl;
}
- (id)initWithBlock:(SelectBlock)block;
@end
