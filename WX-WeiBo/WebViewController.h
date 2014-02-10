//
//  WebViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//
//  点链接弹出的网页

#import <UIKit/UIKit.h>
#import "BassViewController.h"

@interface WebViewController : BassViewController<UIWebViewDelegate>
{
    NSString *_url;
}


@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)goBack:(UIButton *)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)reload:(UIButton *)sender;


- (id)initWithURL:(NSString *)url;
@end
