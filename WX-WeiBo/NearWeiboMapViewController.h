//
//  NearWeiboMapViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "BassViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface NearWeiboMapViewController : BassViewController<CLLocationManagerDelegate,MKMapViewDelegate>


@property (nonatomic,retain) NSArray *data;     //放
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic,retain)CLLocationManager *locationManager;
@end

