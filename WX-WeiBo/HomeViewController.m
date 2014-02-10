//
//  HomeViewController.m
//  WX-WeiBo
//
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import "HomeViewController.h"
#import "WeiBoModel.h"
#import  "UIFactory.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "DDMenuController.h"
#import "WXDataService.h"

#import "SinaWeiboAuthorizeView.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //绑定账号
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(loginAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

    //注销
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //判断是否认证
    if (self.sinaweibo.isAuthValid) {
        //加载微博数据
        [self loadSinaData];
    }else{
        [self.sinaweibo logIn];
    }

   _weiboView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWedth,KScreenHeight-49-44-20) style:UITableViewStylePlain];
    _weiboView.eventDelegate = self;
    _weiboView.hidden = YES;
    [self.view addSubview:_weiboView];
//    self.weiboView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    

    
}
//弹出跟新微博数目
- (void) showNewWeiboCount:(int)count;
{
    if (_barView == nil) {
        _barView = [UIFactory creatWithImage:@"timeline_new_status_background.png"];
        _barView.frame = CGRectMake(5, -40, KScreenWedth-10, 40);
   
        UIImage *image =  [_barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        _barView.image = image;
    _barView.leftCapWidth = 5;
    _barView.topCapWidth = 5;
        [self.view addSubview:_barView];
        
        

    
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.center = _barView.center;
        label.textColor = [UIColor whiteColor];
    label.tag= 2013;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [_barView addSubview:label];
        
    }

    

    if (count >= 0 ) {
        UILabel *label = (UILabel *)[_barView viewWithTag:2013];
        label.text = [NSString stringWithFormat:@"%d条新微博",count];
        [label sizeToFit];
        label.origin = CGPointMake((_barView.width-label.width)/2.0, (_barView.height-label.height)/2.0);
        
        
        [UIView animateWithDuration:0.8 animations:^{
            _barView.top = 5.0;
        } completion:^(BOOL finished) {
            if (finished) {
                   [UIView beginAnimations:@"weiboCount" context:nil];
            [UIView setAnimationDelay:1];
            [UIView setAnimationDuration:1];
            _barView.top = -40;
            
            [UIView commitAnimations];
                
            }
         
            
        }];
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        SystemSoundID soundUID;
        AudioServicesCreateSystemSoundID(CFBridgingRetain(url), &soundUID);
        
        AudioServicesPlaySystemSound(soundUID);
        
    }

    //隐藏未读——badgeView
    MainViewController *mainViewCtrl = (MainViewController *)self.tabBarController;
    [mainViewCtrl showBadgeView:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //开启左右滑动
    [self.appdelegate.menuCtrl setEnableGesture:YES];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //禁用左右滑动
    [self.appdelegate.menuCtrl setEnableGesture:NO];
}
#pragma mark------TableViewEnventDelegate


//下拉
- (void)pullDown:(BassTableView  *)tableView
{
    [self pullDownData];

}
//上拉
- (void)pullUp:(BassTableView  *)tableViewdoneLoadingTableViewData
{
    [self pullUpData];
}
//选中一个cell
- (void)tableView:(BassTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark-- loadWeiboData
- (void)loadSinaData
{
    //加载提示
    [super showLoading:YES];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    
    
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          delegate:self];
    

}
//----------------------------pull Down--------------------------------

- (void)pullDownData
{
    if (self.topWeiboID == 0) {
        NSLog(@"微博ID为空");
        return;
    }
    
    //    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    //    max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    //    count	false	int	单页返回的记录条数，最大不超过100，默认为20。
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.topWeiboID,@"since_id", nil];
    
    
//    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
//                            params:params
//                        httpMethod:@"GET"
//                          block:^(id result) {
//                              [self pullDownDataFinish:result];
//                          }];
    [WXDataService requestWithURl:@"statuses/home_timeline.json" parms:params httpMethod:@"GET" completeBlock:^(id result) {
        [self pullDownDataFinish:result];;
    }];

}
- (void)pullDownDataFinish:(id)result
{
    NSArray *status = [result objectForKey:@"statuses"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:status.count];
    
    for (NSDictionary *weiboDic in status) {
        
        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weiboDic];
        
        [array addObject:weibo];
        
        
    }
    
  [array addObjectsFromArray:self.weibos];
    self.weibos =array;
    self.weiboView.data = array;
    //更新topID
    if (status.count > 0) {
        WeiBoModel *weibo = [array objectAtIndex:0];
        self.topWeiboID = [weibo.weiboID stringValue];
    }
    
    //刷新UI
    [self.weiboView reloadData];
    
    //弹回
    [self.weiboView doneLoadingTableViewData];
    
    //更新微博数目
    int updownWeiboCount = [status count];
    NSLog(@"下拉跟新条数%d",updownWeiboCount);
    [self showNewWeiboCount:updownWeiboCount];

}

//----------------------------pull UP--------------------------------


- (void)pullUpData
{
    if (self.lastWeiboID == 0) {
        NSLog(@"微博ID为空");
        return;
    }
    
    //    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    //    max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    //    count	false	int	单页返回的记录条数，最大不超过100，默认为20。
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"21",@"count",self.lastWeiboID,@"max_id", nil];
    
    
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result) {
                                 [self pullUpDataFinish:result];
                             }];
    
    
}
- (void)pullUpDataFinish:(id)result
{
    NSArray *status = [result objectForKey:@"statuses"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:status.count];
    
    for (NSDictionary *weiboDic in status) {
        
        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weiboDic];
        
        [array addObject:weibo];
        
        
    }
    NSLog(@"----------------%d",array.count);


    
    //更新lastID

    if (array.count > 0) {
        [array removeObjectAtIndex:0];
        WeiBoModel *weibo = [array lastObject];
        self.lastWeiboID = [weibo.weiboID stringValue];
    }
    
    [self.weibos addObjectsFromArray:array];
    self.weiboView.data = self.weibos;
    
    
    //刷新UI
    //---------------新浪返回的数量和请求的数量不一致
    if (status.count >= 20) {
        self.weiboView.isMore = YES;
    }else
    {
        self.weiboView.isMore = NO;
    }
    [self.weiboView reloadData];
    

    

    
}
- (void)refreshWeibo
{
    //显示下拉

    [self.weiboView refreshDta];
    self.weiboView.hidden = NO;
    //取数据
    [self pullDownData];
}

#pragma mark--SinaRequst Delegate
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSLog(@"__________result:%@",result);
    //加载视图消失
    [super showLoading:NO];
    
    _weiboView.hidden = NO;

          NSArray *array = [result objectForKey:@"statuses"];
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *weiboDic in array) {
        
        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weiboDic];
        
        [weibos addObject:weibo];


    }
//---------------新浪返回的数量和请求的数量不一致
    self.weiboView.data = weibos;
    self.weibos = weibos;
    if (weibos.count > 0) {
         WeiBoModel *weibo = [weibos objectAtIndex:0];
        self.topWeiboID = [weibo.weiboID stringValue] ;
        WeiBoModel *lastWeibo = [weibos lastObject];
        self.lastWeiboID = [lastWeibo.weiboID stringValue];

    }
  
    [self.weiboView reloadData];


}//网络加载完成


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--actions
//绑定账号
- (void)loginAction
{
    [[self sinaweibo] logIn];
}
//注销
- (void)logoutAction
{
    [self.sinaweibo logOut];
    
    
    /**
     * @description 初始化构造函数，返回采用默认sso回调地址构造的SinaWeibo对象
     * @param _appKey: 分配给第三方应用的appkey
     * @param _appSecrect: 分配给第三方应用的appsecrect
     * @param _appRedirectURI: 微博开放平台中授权设置的应用回调页
     * @return SinaWeibo对象
     */
//    SinaWeiboAuthorizeView *authorView = [[SinaWeiboAuthorizeView alloc] initWithFrame:CGRectMake(10, 10,KScreenWedth-20
//    ;,KScreenHeight-20-44-20)];
    
    NSDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            kAppKey, @"client_id",
                            @"code", @"response_type",
                            kAppRedirectURI, @"redirect_uri",
                            @"mobile", @"display", nil];
    
    
    SinaWeiboAuthorizeView *authorView = [[SinaWeiboAuthorizeView alloc] initWithAuthParams:params delegate:nil];
    [self.view addSubview:authorView];
    
    [authorView show];
    
}


- (void)viewDidUnload {
    [self setWeiboView:nil];
    [super viewDidUnload];
}
@end
