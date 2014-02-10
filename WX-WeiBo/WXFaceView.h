//
//  WXFaceView.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-7.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(NSString *faceName);

@interface WXFaceView : UIView
{
    NSMutableArray *_items;   //全部表情对象
    UIImageView    *_magnifierView;  //放大镜
}
@property (nonatomic,copy) NSString *selectFaceName;
@property (nonatomic,assign) NSInteger  pageCount;

@property (nonatomic,copy) SelectBlock block;
@end
