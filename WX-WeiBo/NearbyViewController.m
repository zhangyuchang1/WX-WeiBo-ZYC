//
//  NearbyViewController.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-6.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "NearbyViewController.h"
#import "UIImageView+WebCache.h"
#import "WXDataService.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我在这里";
        
        self.isbackButton = NO;
        self.isCancelButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.hidden = YES;
//    [self showLoading:YES];

    location = [[CLLocationManager alloc] init];
    location.delegate = self;
    [location setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];

    [location startUpdatingLocation];

    
}
#pragma mark -- UI
- (void)refreshUI
{
//    self.tableView.hidden = NO;
//    [self showLoading:NO];
    [self.tableView reloadData];
}

#pragma mark -- CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    
    [manager stopUpdatingLocation];
    //停止有事不靠谱
    if (self.data == nil) {
        CLLocationCoordinate2D newLocationCoor = newLocation.coordinate;
        
       CGFloat latitude = newLocationCoor.latitude;   //纬度
        CGFloat longitude = newLocationCoor.longitude;  //精度
    
        NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
        NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
        
        //请求接口
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:latitudeStr,@"lat",longitudeStr,@"long", nil];
//       [ self.sinaweibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"GET" block:^(NSDictionary *result) {
//           
//           [self loadLocationDataFinish:result];
//       }];
        
        [WXDataService requestWithURl:@"place/nearby/pois.json" parms:params httpMethod:@"GET" completeBlock:^(id result) {
            [self loadLocationDataFinish:result];

        }];
    }
 
    

}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}



- (void)loadLocationDataFinish:(NSDictionary *)data
{
    NSArray *array = [data objectForKey:@"pois"];
    self.data = array;
    
    
    
    [self refreshUI];
}

#pragma mark ---UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
         
    }
    
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *icon = [dic objectForKey:@"icon"];

//    cell.detailTextLabel.text = address; 有的没有address 注意NSNull null用法
    
    cell.textLabel.text = title;

    id address = [dic objectForKey:@"address"];

    if (address != [NSNull null]) {
        cell.detailTextLabel.text = address;
    }
    
       
    [cell.imageView setImageWithURL:[NSURL URLWithString:icon]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock != nil) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        _selectBlock(dic);
        
//
//        Block_release(_selectBlock);
//        _selectBlock =  nil;
    }

    
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
