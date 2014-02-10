//
//  SendViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "NearbyViewController.h"
#import "BassNavigationController.h"
#import "WXDataService.h"

@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"发布新微博";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotifica:) name:UIKeyboardWillShowNotification object:nil];
        
        self.isbackButton = NO;
        self.isCancelButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //

    //
    UIButton *button2 = [UIFactory createNavigationBuuton:CGRectMake(0, 0, 45, 30) title:@"发布" target:self action:@selector(sendAction)];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = sendItem;
    
    
 
    
    _textView.delegate = self;
    [self _initButtonViews];

}

- (void)_initButtonViews
{

    
    
    [self.textView becomeFirstResponder];
    _buttons = [NSMutableArray array];

    
    NSArray *imageNames = @[    @"compose_locatebutton_background.png",
                                @"compose_camerabutton_background.png",
                                @"compose_trendbutton_background.png",
                                @"compose_mentionbutton_background.png",
                                @"compose_emoticonbutton_background.png",
                                @"compose_keyboardbutton_background.png" ];
    
    NSArray *imageHiglitNames = @[  @"compose_locatebutton_background_highlighted.png",
                                    @"compose_camerabutton_background_highlighted.png",
                                    @"compose_trendbutton_background_highlighted.png",
                                    @"compose_mentionbutton_background_highlighted.png",
                                    @"compose_emoticonbutton_background_highlighted.png",
                                    @"compose_keyboardbutton_background_highlighted.png" ];
    
    for (int a = 0; a<[imageNames count]; a++) {
        NSString *imageName = imageNames[a];
        NSString *imageHighlitName = imageHiglitNames[a];

        UIButton *button = [UIFactory creatWithImage:imageName highligtImage:imageHighlitName];
        [button setImage:[UIImage imageNamed:imageHighlitName] forState:UIControlStateSelected];
        
        button.tag = 200+a;
        button.frame = CGRectMake(20+64*a,28, 23, 19);
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_buttons  setObject:button atIndexedSubscript:a];

        if (a == 5) {
            button.hidden = YES;
            button.left -= 64;
        }
        [_editorBar addSubview:button];
        

    }
    //XIB上的
    UIImage *image = [self.placeBackgroundView.image  stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    self.placeBackgroundView.width = 250;
    self.placeBackgroundView.image = image;
    
    self.placeLabel.width = 200;
}
#pragma mark---Data
- (void)doSendData
{
    [super showStatustip:YES title:@"发送中...."];
    
    NSString *text = self.textView.text;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:text,@"status", nil];
    if (self.lat.length != 0) {
        [params setObject:self.lat forKey:@"lat"];
    }
    if (self.lon.length != 0) {
        [params setObject:self.lon forKey:@"long"];
    }

    if (self.image != nil) {
        
      NSData *data =  UIImageJPEGRepresentation(self.image, 0.4);
        [params setObject:data forKey:@"pic"];
        
        [self.sinaweibo requestWithURL:@"statuses/upload.json" params:params httpMethod:@"POST" block:^(id result) {
            [self.navigationController dismissModalViewControllerAnimated:YES];
            [super showStatustip:NO title:@"发送成功"];
        }];

        [WXDataService requestWithURl:@"statuses/upload.json" parms:params httpMethod:@"POST" completeBlock:^(id result) {
            [self.navigationController dismissModalViewControllerAnimated:YES];
            [super showStatustip:NO title:@"发送成功"];
        }];
        
    }else{
        
        [self.sinaweibo requestWithURL:@"statuses/update.json" params:params httpMethod:@"POST" block:^(id result) {
            [self.navigationController dismissModalViewControllerAnimated:YES];
            [super showStatustip:NO title:@"发送成功"];
            
        }];
    }

    

}
#pragma mark --UIKeyboardWillShowNotification
- (void)keyboardNotifica:(NSNotification *)notification
{
    
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame = [value CGRectValue];
    
    CGFloat keyboargHigh = frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        _editorBar.bottom = KScreenHeight- keyboargHigh- 20 -44;
        _textView.height = _editorBar.top;

    }];
       
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark---自定义按钮点击事件
- (void)tapAction:(UIButton *)button
{
    if (button.tag == 200) {
        [self locationAction];
        
        
    }else if (button.tag == 201){
        
        [self selectImage];
    }else if (button.tag == 202){
        
    }else if (button.tag == 203){
        
    }else if (button.tag == 204){
        //显示表情
        [self showFaceView];
    }else if (button.tag == 205){
        //x显示键盘
        [self showKeyboard];
        
    }
}
//位置信息
- (void)locationAction
{
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    BassNavigationController *nearbyNav = [[BassNavigationController alloc] initWithRootViewController:nearbyVC];
    
    [self presentModalViewController:nearbyNav animated:YES];
    
    
    nearbyVC.selectBlock = ^(NSDictionary *dic){
      
        self.lat = [dic objectForKey:@"lat"];
        self.lon = [dic objectForKey:@"lon"];
        
        
        NSString *address = [dic objectForKey:@"address"];
        
        if ([address isKindOfClass:[NSNull class]] || address.length == 0) {
            address = [dic objectForKey:@"title"];
        }
        
        self.placeView.hidden = NO;
        self.placeLabel.text = address;

      UIButton *button =  _buttons[0];
        button.selected = YES;
        
    };
    
}
//选取图片
- (void)selectImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
    [actionSheet showInView:self.view];


}
//显示表情面板
- (void)showFaceView
{
    
 

    [_textView resignFirstResponder];
    if (_faceView == nil) {
        
        _faceView = [[WXfaceScrollView alloc] initWithBlock:^(NSString *faceName) {
            
            __block SendViewController *this = self;
           NSString *text =  [this.textView.text stringByAppendingString:faceName];
            self.textView.text = text;
            
        }];
        _faceView.left = 0;
        _faceView.top = KScreenHeight -20- 44 -_faceView.height;
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, _faceView.height);
        
        [self.view addSubview:_faceView];
    }
    
   
    
    UIButton *button1 =_buttons[4];
    button1.alpha = 1;
    UIButton *button2 =_buttons[5];
    button2.alpha = 0;
    button2.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
       
        button1.alpha = 0;
        _faceView.transform = CGAffineTransformIdentity;
        
        //调整——edBor高度
        _editorBar.bottom = KScreenHeight- _faceView.height- 20 -44;
        _textView.height = _editorBar.top;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            button2.alpha = 1;
        }];
        
    }];
    
}
//弹回键盘
- (void)showKeyboard
{
    
    UIButton *button1 =_buttons[4];
    UIButton *button2 =_buttons[5];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, _faceView.height);

                         button2.alpha = 0;

                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             

                             button1.alpha = 1;

                         }];
                         [_textView becomeFirstResponder];

                     }];
}
- (void)sendAction
{
    [self doSendData];
}
#pragma mark --- UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    
    if (buttonIndex == 0) {
        //拍照
       BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        
        }
        sourceType =  UIImagePickerControllerSourceTypeCamera;

        
    }else if (buttonIndex == 1){
        //相册
        sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;

    }else if (buttonIndex == 2){
        //取消
        return;
    }
    [_textView resignFirstResponder];
    UIImagePickerController *imagePiker = [[UIImagePickerController alloc] init];
    imagePiker.sourceType = sourceType;
    
    imagePiker.delegate = self;
    [self presentModalViewController:imagePiker animated:YES];

}
#pragma mark --- UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIButton *button1 = [_buttons objectAtIndex:0];
    UIButton *button2 = [_buttons objectAtIndex:1];
    
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.image = image;
    
    [picker dismissModalViewControllerAnimated:YES];
    
    
    //添加小图天
    if (self.sendImageButton == nil) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.frame = CGRectMake(8, 22, 25, 25);
        [button addTarget:self action:@selector(seeBigImageAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.sendImageButton = button;
    }
    [ self.sendImageButton  setImage:self.image forState:UIControlStateNormal];
    [self.editorBar addSubview:self.sendImageButton];

    //右移
//        UIButton *button1 = [_buttons objectAtIndex:0];
//        UIButton *button2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:1 animations:^{
     
        button1.transform = CGAffineTransformTranslate(button1.transform, 20, 0);
        button2.transform = CGAffineTransformTranslate(button2.transform, 5, 0);
        
    }];
    [picker dismissModalViewControllerAnimated:YES];

    [_textView becomeFirstResponder];
}
//点击全屏图片
- (void)seeBigImageAction
{
    [_textView resignFirstResponder];
    
    if (_fullImageView == nil) {
        
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWedth, KScreenHeight)];
        
               _fullImageView.backgroundColor = [UIColor blackColor];
        _fullImageView.userInteractionEnabled = YES;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImaneAction:)];
        [_fullImageView addGestureRecognizer:tap];
        //删除按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(280, 40, 20, 26)];
        [button addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2014;
        [button setBackgroundColor:[UIColor clearColor]];
        [_fullImageView addSubview:button];
    }
    [_fullImageView viewWithTag:2014].hidden = YES;
    if (![_fullImageView superview]) {
        [_fullImageView setImage:self.image];
        
        
        [self.view.window addSubview:_fullImageView];
    }
  

    
    _fullImageView.frame = CGRectMake(8, KScreenHeight-250, 25, 25);
    [UIView animateWithDuration:0.5 animations:^{
        [UIApplication sharedApplication].statusBarHidden = YES;

        _fullImageView.frame = CGRectMake(0,0,KScreenWedth,KScreenHeight);
        
    } completion:^(BOOL finished) {
        [_fullImageView viewWithTag:2014].hidden = NO;
    }];
    
    
}
//缩小图片
- (void)scaleImaneAction:(UIGestureRecognizer *)tap
{
    [_fullImageView viewWithTag:2014].hidden = YES;

        [UIView animateWithDuration:0.5 animations:^{
            _fullImageView.frame = CGRectMake(8, KScreenHeight-250, 25, 25);
        } completion:^(BOOL finished) {
            [_fullImageView removeFromSuperview];

        }];
    [UIApplication sharedApplication].statusBarHidden = NO;

    [_textView becomeFirstResponder];

}
//删除图片
- (void)deleteAction:(UIButton *)buttonj
{
    [self scaleImaneAction:nil];
    [self.sendImageButton removeFromSuperview];
    self.image = nil;
    
    [UIView animateWithDuration:1 animations:^{
        
        UIButton *button1 = [_buttons objectAtIndex:0];
        UIButton *button2 = [_buttons objectAtIndex:1];
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
    }];

}
#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self showKeyboard];
    
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [self setEditorBar:nil];
    [self setPlaceView:nil];
    [self setPlaceBackgroundView:nil];
    [self setPlaceLabel:nil];
    [super viewDidUnload];
}

@end
