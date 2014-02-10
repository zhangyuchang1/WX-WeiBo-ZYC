//
//  WXImageView.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WXImageView.h"

@implementation WXImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    
    }
    return self;
}

- (void)awakeFromNib{
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.touchBlock) {
        _touchBlock();
    }



}

- (void)dealloc
{
    
//    Block_release(_touchBlock);
    
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
