//
//  UserInfoView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "UserInfoView.h"
#import "UserModel.h"
#import "RectButton.h"
#import "FriendViewController.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        
        view.backgroundColor = color(245, 245, 245, 1);
        [self addSubview:view];
        
        self.frame = view.frame;
    }
    return self;
}

- (void)layoutSubviews
{
    //头像图片
    NSString *imageStr = self.user.avatar_large;
    
    [self.userImage setImageWithURL:[NSURL URLWithString:imageStr]];
    
    //昵称
    NSString *nickStr = self.user.screen_name;
    self.nameLabel.text = nickStr;
    
    //性别  和  地址
    NSString *sexStr = self.user.gender;
    NSString *sexName = @"未知";
    if ([sexStr isEqualToString:@"f"]) {
        sexName = @"女";
    }else if([sexStr isEqualToString:@"m"]){
        sexName = @"男";
    }
    
    NSString *addressStr = (self.user.location == nil)? @"":self.user.location;
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@  %@",sexName,addressStr];
    
    //简介
    NSString *infoStr = self.user.description;
    if (infoStr == nil) {
        infoStr = @"";
    }
    self.infoLabel.text = infoStr;
    
    //微博数
    NSString *countStr = [self.user.statuses_count stringValue];
    self.countLabel.text = [NSString stringWithFormat:@"共%@条微博",countStr];
    
    //粉丝数
   long fansConut = [self.user.followers_count longValue];
    NSString *fanStr = [NSString stringWithFormat:@"%ld",fansConut];
    if (fansConut >= 10000) {
        fanStr = [NSString stringWithFormat:@"%.0f万",(float)fansConut/10000];
    }
    
    
    [self.fansLabel setTitle:@"粉丝"];
    self.fansLabel.subTitle = fanStr;
    
    //关注数
    NSString *attStr = [self.user.friends_count stringValue];
    self.attLabel.title = @"关注";
    self.attLabel.subTitle = attStr;
    
    
}


- (IBAction)toFriendshipVC:(UIButton *)sender {
    
    FriendViewController *frienVC = [[FriendViewController alloc] init];
    
    NSString *uid = self.user.idstr;
    frienVC.userId = uid;
    frienVC.shipType = Attention;
    
    [self.viewController.navigationController pushViewController:frienVC animated:YES];
    
    
}

- (IBAction)fansShipVC:(UIButton *)sender {
    FriendViewController *frienVC = [[FriendViewController alloc] init];
    
    NSString *uid = self.user.idstr;
    frienVC.userId = uid;
    frienVC.shipType = Fans;
    
    [self.viewController.navigationController pushViewController:frienVC animated:YES];
    

}
@end
