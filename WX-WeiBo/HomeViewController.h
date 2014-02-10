//
//  HomeViewController.h
//  WX-WeiBo
//  首页控制器
//  Created by 张  on 13-12-30.
//  Copyright (c) 2013年 张 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "WeiboTableView.h"

@class ThemeImageView;
@class BassTableView;
@interface HomeViewController : BassViewController<SinaWeiboRequestDelegate,TableViewEnventDelegate>
{
    ThemeImageView *_barView;
}
@property (retain, nonatomic)  WeiboTableView *weiboView;
@property (nonatomic,copy)     NSString *topWeiboID;
@property (nonatomic,copy)     NSString *lastWeiboID;
@property (nonatomic,retain)NSMutableArray *weibos;

//自动刷新微博
- (void)refreshWeibo;

//首次加载数据
- (void)loadSinaData;

@end
