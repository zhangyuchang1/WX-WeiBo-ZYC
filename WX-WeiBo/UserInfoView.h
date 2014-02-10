//
//  UserInfoView.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class RectButton;
@interface UserInfoView : UIView

@property (nonatomic,retain) UserModel *user;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet RectButton *attLabel;
@property (strong, nonatomic) IBOutlet RectButton *fansLabel;
- (IBAction)toFriendshipVC:(UIButton *)sender;
- (IBAction)fansShipVC:(UIButton *)sender;


@end
