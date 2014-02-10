//
//  NearWeiboMapViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//
#import "WeiBoModel.h"
#import "NearWeiboMapViewController.h"
#import "WXDataService.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationVIew.h"

@interface NearWeiboMapViewController ()

@end

@implementation NearWeiboMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];

    _locationManager.delegate = self;
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    [_locationManager startUpdatingLocation];
    


}
#pragma mark --- CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    //显示区域
    CLLocationCoordinate2D center = newLocation.coordinate;
	MKCoordinateSpan span = {0.1,0.1};
    
    MKCoordinateRegion region = {center,span};
    
    [self.map setRegion:region animated:YES];
    
    
    if (self.data == nil) {
        float lat =   newLocation.coordinate.latitude;
        float lon =   newLocation.coordinate.longitude;
        NSString *latitude = [NSString stringWithFormat:@"%f",lat];
        NSString *longitude = [NSString stringWithFormat:@"%f",lon];
        
        [self loadNearWeiboDataWithLat:latitude lon:longitude];
    }
  
    
    
}
#pragma mark -- MKMapViewDlegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //判断是否是获得当前位置。如果是，则返回nil，让系统自己创建

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
    
        return nil;
    }
    
    static NSString *identifer  = @"WeiboAnnotationVIew";
    
    WeiboAnnotationVIew *weiboAnnotView = (WeiboAnnotationVIew *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifer];
    
    if (weiboAnnotView == nil) {
        
        weiboAnnotView = [[WeiboAnnotationVIew alloc] initWithAnnotation:annotation reuseIdentifier:identifer];
    }
    
    return weiboAnnotView;
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (UIView *annotationView in views) {
        
      CGAffineTransform transform =  annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.5, 0.5);

        annotationView.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            annotationView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView  animateWithDuration:0.5 animations:^{
        
                annotationView.transform = CGAffineTransformIdentity;
                annotationView.alpha = 1;


            }];
        }];
        
        
        
        
        
    }
    
    
    
}

#pragma mark --Load Data
- (void)loadNearWeiboDataWithLat:(NSString *)lat lon:(NSString *)lon
{

    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithObjectsAndKeys:lat,@"lat",lon,@"long", nil];
    
    
    [WXDataService requestWithURl:@"place/nearby_timeline.json" parms:parms httpMethod:@"GET" completeBlock:^(id result) {
        
        
        [self loadDataFinish:result];
    }];
    
}
- (void)loadDataFinish:(NSDictionary *)result
{
    NSArray *status = [result objectForKey:@"statuses"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:status.count];
    
    for (int i = 0;i < status.count;i++) {
        NSDictionary *weiboDic = status[i];

        WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:weiboDic];
        
        [array addObject:weibo];
        
        
        //创建Animaction对象
        
        WeiboAnnotation *weiboAnnotation = [[WeiboAnnotation alloc] initWithWeibo:weibo];
        
        
        [self.map performSelector:@selector(addAnnotation:) withObject:weiboAnnotation afterDelay:i*0.05];
        
        
//        [self.map addAnnotation:weiboAnnotation];
        
        
        
    }
    
  
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMap:nil];
    [super viewDidUnload];
}
@end
