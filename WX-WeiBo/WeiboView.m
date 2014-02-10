//
//  WeiboView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "UserViewController.h"
#import "WebViewController.h"


#define LIST_FONT             14.0f      //列表字体
#define LIST_REPOST_FONT      12.0f      //列表中转发的字体
#define DETAIL_FONT           18.0f      //详情字体
#define DETAIL_REPOST_FONT    16.0f      //详情中转发的字体


@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initSubViews];
        _paserText = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)_initSubViews
{
    //w微博内容
    _textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.delegate = self;
    [UIColor redColor];
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"red" forKey:@"color"];
    //三色值 r; g: b; 转成16进制
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    
    [self addSubview:_textLabel];
    
    //微博图片
    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.backgroundColor = [UIColor clearColor];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_image];
    
    //气泡视图 转发的微博视图背景
    _repostBackgroudView = [UIFactory creatWithImage:@"timeline_retweet_background.png"];
  UIImage *image =  [_repostBackgroudView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    
    _repostBackgroudView.leftCapWidth = 25;
    _repostBackgroudView.topCapWidth = 10;
    _repostBackgroudView.image = image;
    
    _repostBackgroudView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroudView atIndex:0];
//    [self addSubview:_repostBackgroudView];
    
}
- (void)setWeiboMdal:(WeiBoModel *)weiboMdal
{

    if (_weiboMdal !=weiboMdal) {
        _weiboMdal = weiboMdal;
    }
    //创建转发的微博视图
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc] initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        _repostView.isDetail = self.isDetail;
        [self addSubview:_repostView];
    }
    
    [self parseLink];
}

//更换字符串
- (void)parseLink
{
    [_paserText setString:@""];
    
    if (_isRepost) {
        //源微博的作者拼接
        NSString *relWeiboUser = _weiboMdal.user.screen_name;
        [_paserText appendFormat:@"<a href='user://%@'>%@</a>:",[relWeiboUser URLEncodedString],relWeiboUser];
    }
    NSString *text = _weiboMdal.text;
    
    
    text = [UIUtils parseLink:text];
    
       [_paserText appendString:text];

}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    //---------------------//w微博内容/--------------------
    [self _renderLabel];
    
    //---------------------/转发的微博视图/--------------------

    [self _renderSourceWeiboView];
    //---------------------/图片视图/--------------------
  
    [self _renderImage];
    //---------------------/转发的微博视图背景/--------------------
    if (self.isRepost ) {
        _repostBackgroudView.frame = self.bounds;
//        _repostBackgroudView.top -= 5;
        _repostBackgroudView.hidden = NO;
    }else{
        _repostBackgroudView.hidden = YES;
    }
    
    
}
//---------------------//w微博内容/--------------------
- (void)_renderLabel
{
    CGFloat fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
    _textLabel.frame = CGRectMake(0, 0, self.width, 20);
    
    //判断视图是否为转发视图
    if (self.isRepost) {
        
        
        _textLabel.frame = CGRectMake(10, 10, self.width-20, 20);
    }
    
    _textLabel.text = _paserText;
    //自适应大小
    CGSize  size =  _textLabel.optimumSize;
    _textLabel.height = size.height;
    

}
 //---------------------/转发的微博视图/--------------------
- (void)_renderSourceWeiboView
{
    WeiBoModel  *repostModel = _weiboMdal.relWeibo;
    
    if (repostModel != nil){
        
        _repostView.weiboMdal = repostModel;
        
        CGFloat height = [WeiboView getWeiboViewHeigh:repostModel isRepost:YES isDetail:self.isDetail];
        
        
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width, height);
        _repostView.hidden = NO;
        
    }else{
        _repostView.hidden = YES;
    }
}
//---------------------/图片视图/--------------------
- (void)_renderImage
{
    if (self.isDetail) {
        //中等图
        NSString *imageString =  _weiboMdal.bmiddleImage;
        
        if (imageString != nil && ![@"" isEqualToString:imageString]) {
            
            _image .frame = CGRectMake(10, _textLabel.bottom+10, 280, 200);
            [_image setImageWithURL:[NSURL URLWithString:imageString]];
            _image.hidden = NO;
        }else{
            _image.hidden = YES;
        }
    }else{
        
      int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kBrowMode];
        
        if (mode == 0) {
            //缩略图
            NSString *imageString =  _weiboMdal.thumbnailImage;
            
            if (imageString != nil && ![@"" isEqualToString:imageString]) {
                
                _image .frame = CGRectMake(10, _textLabel.bottom+10, 70, 80);
                [_image setImageWithURL:[NSURL URLWithString:imageString]];
                _image.hidden = NO;
            }else{
                _image.hidden = YES;
            }
        }else if (mode == 1){
            //中等图
            NSString *imageString =  _weiboMdal.bmiddleImage;
            
            if (imageString != nil && ![@"" isEqualToString:imageString]) {
                
                _image .frame = CGRectMake(10, _textLabel.bottom+10, self.width-20,180);
                [_image setImageWithURL:[NSURL URLWithString:imageString]];
                _image.hidden = NO;
            }else{
                _image.hidden = YES;
            }
        }
       
        
    }
    
}
+ (CGFloat )getWeiboViewHeigh:(WeiBoModel *)weiboModel
                     isRepost:(BOOL)isRepost
                     isDetail:(BOOL)isDetai;
{
    //计算各个子视图的高度然后相加
    float heigth = 0;
    //-------------------------计算微博内容text的高度--------------------------
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    CGFloat fontSize = [WeiboView getFontSize:isDetai isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontSize];
    
    //判断是否显示在详情页面
    if (isDetai) {
        textLabel.width = kWeibo_width_detail;
    }else {
        textLabel.width = kWeibo_width_list;
    }
    
    NSString *weiboText = nil;
    if (isRepost) {
        
        
        textLabel.width -= 20;
        weiboText = [NSString stringWithFormat:@"%@:%@",weiboModel.user.screen_name,weiboModel.text];
        
    }else
    {
        weiboText = weiboModel.text;
    }
    
    
    textLabel.text = weiboText;
    heigth += textLabel.optimumSize.height;
    
    
    
    
    //-------------------------计算微博图片的高度--------------------------
    if (isDetai) {
        NSString *imageString =  weiboModel.bmiddleImage;
        
        if (imageString != nil && ![@"" isEqualToString:imageString]) {
            
            heigth += (200+10);
            
        }
        

    }else{
        
            int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kBrowMode];
                if (mode == 0) {
                    NSString *imageString =  weiboModel.thumbnailImage;
                    
                    if (imageString != nil && ![@"" isEqualToString:imageString]) {
                        
                        heigth += (80+10);
                    }
                }else if (mode == 1){
                    NSString *imageString =  weiboModel.bmiddleImage;
                    
                    if (imageString != nil && ![@"" isEqualToString:imageString]) {
                        
                        heigth += (180+10);
                    }
          
            
        
                }
     
            
    }
    //-------------------------计算转发微博的高度--------------------------
    WeiBoModel *relModel = weiboModel.relWeibo;
    if (relModel != nil) {
         CGFloat repostViewHeigt = [WeiboView getWeiboViewHeigh:relModel isRepost:YES isDetail:isDetai];
    
         heigth += repostViewHeigt;
    }
    if (isRepost == YES) {
        heigth += 20;
    }
    
    
    
    return heigth;
}
//获取微博视图的字体大小
+ (CGFloat)getFontSize: (BOOL)isDetail isRepost:(BOOL)isRepost
{
    CGFloat fontSiuze = 14.0f;
   
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }else if (!isDetail && isRepost){
        return LIST_REPOST_FONT;
    }else if (isDetail && !isRepost){
        return DETAIL_FONT;
    }else if (isDetail && isRepost){
        return DETAIL_REPOST_FONT;
    }
    
    return fontSiuze;
    
}


#pragma mark--RTlabel delagate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString *absolute = [url absoluteString];
    if ([absolute hasPrefix:@"user"]) {
        NSString *hostStr = [url host];
        NSString *userStr = [hostStr URLDecodedString];
        
        if ([userStr hasPrefix:@"@"]) {
          userStr = [userStr substringFromIndex:1];
        }
        
        NSLog(@"用户:%@",userStr);
        UserViewController *viewVC = [[UserViewController alloc] init];
        viewVC.userName = userStr;
        [self.viewController.navigationController pushViewController:viewVC animated:YES];
        
    }else if ([absolute hasPrefix:@"topic"]){
        NSString *hostStr = [url host];
        NSLog(@"话题:%@",[hostStr URLDecodedString]);
    }else if ([absolute hasPrefix:@"http"]){
        NSString *hostStr = [url absoluteString];
        
        WebViewController *webViewCtrl =[[WebViewController alloc] initWithURL:hostStr];
        
        [self.viewController.navigationController pushViewController:webViewCtrl animated:YES];
        
        NSLog(@"网址:%@",hostStr);
    }



    
}

@end
