//
//  WebViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-5.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        
        _url = url;
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:_url];
   NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:requset];
    
    
    
    self.title = @"正在加载";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;



}
#pragma mark--Actions
- (IBAction)goBack:(UIButton *)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)goForward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)reload:(UIButton *)sender {
    
    [_webView reload];
}
#pragma mark---UIVebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  NSString *title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

@end

