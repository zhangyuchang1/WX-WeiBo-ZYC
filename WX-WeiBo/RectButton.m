//
//  RectButton.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "RectButton.h"

@implementation RectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    
    
    }
    
    if (_rectTitleLabel == nil) {
        _rectTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 68, 30)];
        _rectTitleLabel.font = [UIFont systemFontOfSize:15.0];
        _rectTitleLabel.textColor = [UIColor blackColor];
        _rectTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rectTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_rectTitleLabel];
    }
    
    _rectTitleLabel.text = title;
    
    
}
- (void)setSubTitle:(NSString *)subTitle
{
    if (_subTitle != subTitle) {
        _subTitle = subTitle;
        
        
    }
    
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 68, 30)];
        _subTitleLabel.font = [UIFont systemFontOfSize:17.0];
        _subTitleLabel.textColor = [UIColor blueColor];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_subTitleLabel];
    }
    
    _subTitleLabel.text = subTitle;
    
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
