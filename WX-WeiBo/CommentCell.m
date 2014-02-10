//
//  CommentCell.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-13.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "UserViewController.h"
#import "NSString+URLEncoding.h"
#import "WXImageView.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    
    _userImage = (WXImageView *)[self viewWithTag:100];
    _nickNameLabel = (UILabel *)[self viewWithTag:101];
    _timelabel = (UILabel *)[self viewWithTag:102];
    
    _contentLabel = [[RTLabel alloc] initWithFrame:CGRectMake(_userImage.right+10, _nickNameLabel.bottom+5, 240, 20)];
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate = self;
    
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    //三色值 r; g: b; 转成16进制
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    
    [self addSubview:_contentLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //头像
  NSString *userimageStr =  self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userimageStr]];
    _userImage.layer.cornerRadius = 8;
    _userImage.layer.masksToBounds = YES;
    //昵称
   _nickNameLabel.text = self.commentModel.user.screen_name;
//
    
    //评论时间
   NSString *time= [UIUtils fomateString:self.commentModel.created_at];
    _timelabel.text = time;
    NSLog(@"%@",self.commentModel.user);
    
    //评论内容
    NSString *text = self.commentModel.text;
    _contentLabel.text  = [UIUtils parseLink:text];
    
    _contentLabel.frame = CGRectMake(_userImage.right+10, _nickNameLabel.bottom+5, 240,  _contentLabel.optimumSize.height);
    
}
//手势到用户业
- (void)setCommentModel:(CommentModel *)commentModel
{
    if (_commentModel != commentModel) {
        _commentModel = commentModel;
    }
    
    __block CommentCell *this = self;
    _userImage.touchBlock = ^{
        NSString *nickName =commentModel.user.screen_name;
        
        UserViewController *userVC = [[UserViewController alloc] init];
        userVC.userName = nickName;
        
        [this.viewController.navigationController pushViewController:userVC animated:YES];
        
    };
    
}
//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel
{
    RTLabel *rt = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.text = commentModel.text;
    rt.font = [UIFont systemFontOfSize:14.0f];
    float h = rt.optimumSize.height;
    
    return h+60;
    
    
}
#pragma mark----Rtlabel delegate
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
        NSLog(@"网址:%@",hostStr);
    }
    
    
    
}
@end
