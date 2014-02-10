//
//  NearbyViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "BassViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SelectDoneBlock)(NSDictionary *);

@interface NearbyViewController : BassViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *location;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)  NSArray *data;
@property (nonatomic,copy)  SelectDoneBlock selectBlock;


@end
