//
//  MessageViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "MessageViewController.h"
#import "UIFactory.h"
#import "WXDataService.h"
#import "WeiBoModel.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initWithViews];

}
- (void)initWithViews
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    
    NSArray *imageNames = @[@"navigationbar_mentions.png",@"navigationbar_comments.png",@"navigationbar_messages.png",@"navigationbar_notice.png"];
    for (int i = 0; i<imageNames.count; i ++) {
        
        
      UIButton *button =  [UIFactory creatWithImage:imageNames[i] highligtImage:imageNames[i]];
        button.frame = CGRectMake(15+50*i, 11, 22, 22);
        button.tag = 1000+i;
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
    }
    
    self.navigationItem.titleView = titleView;
    
    _weiboTableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWedth, KScreenHeight - 44 - 49 - 20)];
    _weiboTableView.eventDelegate = self;
    
    _weiboTableView.hidden = YES;
    [self.view addSubview:_weiboTableView];
    

    
}
#pragma mark -- TapAction
- (void)messageAction:(UIButton *)button
{
    if (button.tag == 1000) {
        [self loadAtWeiboData];
    }else if (button.tag == 1001){
        
    }else if (button.tag == 1002){
        
    }else if (button.tag == 1003){
        
    }

}
#pragma mark --loadWeiboData
- (void)loadAtWeiboData
{
    [super showLoading:YES];
    
    [WXDataService requestWithURl:@"statuses/mentions.json" parms:nil httpMethod:@"GET" completeBlock:^(id result) {
        
        [self loadAtWeiboFinish:result];
    }];
    
    
}
- (void)loadAtWeiboFinish:(NSDictionary *)result
{
    NSArray *status = [result objectForKey:@"statuses"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:status.count];
    
    for (NSDictionary *weiboDic in status) {
        
        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weiboDic];
        
        [array addObject:weibo];
        
        
    }
    
    self.weiboTableView.data = array;
    
    //酸辛
    [super showLoading:NO];
    _weiboTableView.hidden = NO;
    [_weiboTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---BassTableView EnventDelegate
- (void)pullDown:(BassTableView  *)tableView
{
    
}
//上拉
- (void)pullUp:(BassTableView  *)tableView
{
    
}
//选中一个cell
@end
