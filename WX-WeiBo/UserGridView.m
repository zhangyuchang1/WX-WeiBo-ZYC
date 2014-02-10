//
//  UserGridView.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "UserGridView.h"
#import "UIButton+loadNetworkImage.h"
#import "UserViewController.h"

@implementation UserGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *griView =  [[[NSBundle mainBundle] loadNibNamed:@"UserGridView" owner:self options:nil] lastObject];
        griView.backgroundColor = [UIColor clearColor];
        self.size = griView.size;
        [self addSubview:griView];
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
        [backgroundView setImage:[UIImage imageNamed:@"profile_button3_1.png"]];
        
        [self insertSubview:backgroundView atIndex:0];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //昵称
    _nickLabel.text = self.uer.screen_name;
    
    //粉丝数
    long fansConut = [self.uer.followers_count longValue];
    NSString *fanStr = [NSString stringWithFormat:@"%ld",fansConut];
    if (fansConut >= 10000) {
        fanStr = [NSString stringWithFormat:@"%.0f万",(float)fansConut/10000];
    }
    
    _fansLabel.text = fanStr ;
    
    //用户头像
    NSString *imageStr = self.uer.profile_image_url;
    
    [_imageButton setImageWithURL:[NSURL URLWithString:imageStr]];
    
    
    
    
    
}
- (IBAction)userImageActon:(UIButton *)sender {
    
    UserViewController *userVC = [[UserViewController alloc] init];
    
    userVC.userName = self.uer.screen_name;
    
    [self.viewController.navigationController pushViewController:userVC animated:YES];
    
    
}
@end
