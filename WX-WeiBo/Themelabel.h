//
//  Themelabel.h
//  WX-WeiBo
//
//  Created by 张  on 14-1-3.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Themelabel : UILabel
@property (nonatomic ,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)name;
@end
