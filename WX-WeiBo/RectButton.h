//
//  RectButton.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-21.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RectButton : UIButton
{
    UILabel *_rectTitleLabel;
    UILabel *_subTitleLabel;
}
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@end
