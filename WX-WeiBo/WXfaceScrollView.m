//
//  WXfaceScrollView.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-7.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WXfaceScrollView.h"

@implementation WXfaceScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
- (id)initWithBlock:(SelectBlock)block
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _faceView.block = block;
    }
    
    return self;
}
- (void)initViews
{
    _faceView = [[WXFaceView alloc] initWithFrame:CGRectZero];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWedth, _faceView.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(_faceView.width, _faceView.height);
    [_scrollView addSubview:_faceView];
    
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, KScreenWedth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = _faceView.pageCount;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    self.height = _scrollView.height + _pageControl.height;
    self.width = _scrollView.width;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    [[UIImage imageNamed:@"emoticon_keyboard_background.png"] drawInRect:rect];
}

#pragma mark ---UISCrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  int index =  scrollView.contentOffset.x/KScreenWedth;
    _pageControl.currentPage = index;
    
}
@end
