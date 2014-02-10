//
//  UserGridView.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserGridView : UIView

@property (nonatomic,retain)UserModel *uer;

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansLabel;
- (IBAction)userImageActon:(UIButton *)sender;

@end
