//
//  SendViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//
// 发送微博

#import "BassViewController.h"
#import "WXfaceScrollView.h"

@interface SendViewController : BassViewController<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>
{
    NSMutableArray *_buttons;  //
    UIImageView    *_fullImageView;   //全屏显示的图片
    WXfaceScrollView *_faceView;      //表情面板
    
}
// send
@property (nonatomic ,copy) NSString *lat;  //纬度
@property (nonatomic ,copy) NSString *lon;   //精度
@property (nonatomic ,retain)UIImage *image;  //微博图片

@property (nonatomic ,retain) UIButton *sendImageButton;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *editorBar;
@property (strong, nonatomic) IBOutlet UIView *placeView;
@property (strong, nonatomic) IBOutlet UIImageView *placeBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;

@end
