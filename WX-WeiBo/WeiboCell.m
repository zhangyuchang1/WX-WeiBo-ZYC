//
//  WeiboCell.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "WXImageView.h"
#import "UserViewController.h"
@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self _initView];
    }
    return self;
}
- (void)_initView
{
    //头像
    _userImage = [[WXImageView alloc] initWithFrame:CGRectZero];
      //设置圆角
    _userImage.layer.cornerRadius = 5;
    _userImage.layer.borderWidth = 0.5;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor ;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nicklabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nicklabel.backgroundColor = [UIColor clearColor];
    _nicklabel.font = [UIFont systemFontOfSize:14];
    _nicklabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nicklabel];
    
    //转发数
    _repostCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.font = [UIFont systemFontOfSize:12];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    //回复数
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.font = [UIFont systemFontOfSize:12];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    
    //发布来源
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.font = [UIFont systemFontOfSize:12];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    

    
    //发布时间
    _creatLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _creatLabel.backgroundColor = [UIColor clearColor];
    _creatLabel.font = [UIFont systemFontOfSize:14];
    _creatLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_creatLabel];
    
    //微博视图
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    
    //cell选中的背景图片
    UIView *cellBackgroungView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    cellBackgroungView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    self.selectedBackgroundView = cellBackgroungView;
}
//
- (void)setWeiboModal:(WeiBoModel *)weiboModal
{
    if (_weiboModal != weiboModal) {
        
        _weiboModal = weiboModal;
    }
    
    
 
    
    __block WeiboCell *this = self;
    _userImage.touchBlock= ^{
        
        UserViewController *userVC = [[UserViewController alloc] init];
        NSString *nickName = weiboModal.user.screen_name;
        userVC.userName = nickName;
        
        [this.viewController.navigationController pushViewController:userVC animated:YES];
    
    };
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //头像
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *imageStr = _weiboModal.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:imageStr]];
    
    //昵称
    _nicklabel.frame = CGRectMake(50, 5, 200, 20);
    _nicklabel.text = _weiboModal.user.screen_name;
    
    //微博视图
    _weiboView.weiboMdal = _weiboModal;

     CGFloat  heigh =  [WeiboView getWeiboViewHeigh:_weiboModal isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nicklabel.bottom+10, kWeibo_width_list, heigh);
    
    //发布时间;注意新浪的时间格式
    NSString *dateString = _weiboModal.createDate;
    if (dateString != nil) {
        _creatLabel.hidden = NO;
        NSString *date = [UIUtils fomateString:dateString];
        _creatLabel.text = date;
        [_creatLabel sizeToFit];
        _creatLabel.frame = CGRectMake(50, self.height-20, 100, 20);
    }else{
        _creatLabel.hidden = YES;
    }
    
    //发布来源        "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
    NSString *source = _weiboModal.source;
    NSString *sourceText =  [self paserSource:source];

    if (sourceText  != nil ) {
        _sourceLabel.hidden = NO;
        _sourceLabel.text = [NSString stringWithFormat:@"来自%@",sourceText];
        _sourceLabel.frame = CGRectMake(_creatLabel.right+5, _creatLabel.top, 180, 20);
        [_creatLabel sizeToFit];

        
    }else{
        _sourceLabel.hidden = YES;
    }
    //转发数
//    NSString *repostCount = _weiboModal.repostsConut;

    NSString *str = [NSString stringWithFormat:@"转发数:%@",_weiboModal.repostsConut];
    _repostCountLabel.text = str;
    _repostCountLabel.frame = CGRectMake(180, 10, 60, 20);
    [_repostCountLabel sizeToFit];
    
    //评论数

    
    NSString *comment = [NSString stringWithFormat:@"评论数:%@",_weiboModal.commentsCount];
    _commentLabel.text = comment;
    _commentLabel.frame = CGRectMake( _repostCountLabel.right+10,10,60, 20);
    [_commentLabel sizeToFit];
    
//---------------------调用WeiBoView重新布局方法---------------
    [_weiboView setNeedsLayout];
    
}
//"source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",取出
- (NSString *)paserSource:(NSString *)source
{
    NSString *regexStr = @">\\w+<";
   NSArray *array = [source componentsMatchedByRegex:regexStr];
    
    if (array.count > 0) {
        NSString *sourceStr = [array objectAtIndex:0];
//        >新浪微博<
        NSRange range;
        range.location = 1;
        range.length = sourceStr.length-2;
       NSString *str = [sourceStr substringWithRange:range];
        return str;
    }
    return nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];


    
    // Configure the view for the selected state
    
    
}

@end
