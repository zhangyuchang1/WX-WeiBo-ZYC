//
//  WXImageView.h
//  WX-WeiBo
//

//  公共类
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(void);

@interface WXImageView : UIImageView

@property(nonatomic,copy)ImageBlock touchBlock;

@end
