//
//  WeiboAnnotationVIew.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiboAnnotationVIew.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initViews];
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self != nil) {
        
        
        [self initViews];
    }
    
    return self;
    
}

- (void) initViews
{
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.contentMode = UIViewContentModeScaleAspectFit;
    _userImage.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userImage.layer.borderWidth = 1;
    
    
    _WeiboImage = [[UIImageView alloc] initWithFrame:CGRectZero];
  
    _WeiboImage.backgroundColor = [UIColor blackColor] ;
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:12.0f];
    _textLabel.numberOfLines = 3;
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textColor = [UIColor whiteColor];
    
    
   
    [self addSubview:_WeiboImage];
    [self addSubview:_textLabel];
     [self addSubview:_userImage];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self setImage:[UIImage imageNamed:@"nearby_map_content.png"]];

    
   WeiboAnnotation *weiboAnnotation = self.annotation;
    WeiBoModel *weibo = nil;
    if ([weiboAnnotation isKindOfClass:[weiboAnnotation class]]) {
        
        weibo = weiboAnnotation.weibo;
        
                
    }
    
    
    NSString *thumbnailImage = weibo.thumbnailImage;
    if (thumbnailImage.length != 0) {
        //图片视图
        [self setImage:[UIImage imageNamed:@"nearby_map_photo_bg.png"]];
        
        _userImage.frame = CGRectMake(70, 70, 30, 30);
        NSString *urlStr = weibo.user.avatar_large;
        [_userImage setImageWithURL:[NSURL URLWithString:urlStr]];
        
        
        _WeiboImage.frame = CGRectMake(15, 15, 90,85);
        [_WeiboImage setImageWithURL:[NSURL URLWithString:thumbnailImage]];
        
        _textLabel.hidden = YES;
        _WeiboImage.hidden = NO;
        
        
    }else if (thumbnailImage.length == 0){
        //weibo内容
        [self setImage:[UIImage imageNamed:@"nearby_map_content.png"]];
        _userImage.frame = CGRectMake(20, 20, 50, 50);
        NSString *urlStr = weibo.user.avatar_large;
        [_userImage setImageWithURL:[NSURL URLWithString:urlStr]];
        
        _textLabel.frame = CGRectMake(_userImage.right+5,20, 100, 45);
        _textLabel.text = weibo.text;
        
        
        _textLabel.hidden = NO;
        _WeiboImage.hidden = YES;
        
        
    }
    
    
    
    
    
    

    
}



@end
