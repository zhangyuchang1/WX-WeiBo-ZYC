//
//  WeiboAnnotation.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation


- (void)setWeibo:(WeiBoModel *)weibo
{
    if (_weibo != weibo) {
        _weibo = weibo;
    }
    NSDictionary *geo = weibo.geo;
    if ([geo isKindOfClass:[NSDictionary class]]) {
        
        NSArray *coordinates = [geo objectForKey:@"coordinates"];
        if (coordinates.count == 2) {
          
            
            float lat = [coordinates[0] floatValue];
            float lon = [coordinates[1] floatValue];
            
            _coordinate = CLLocationCoordinate2DMake(lat, lon);
        }
  
    }
    
 
}

- (id)initWithWeibo:(WeiBoModel *)weibo
{
    self = [super init];
    
    if (self != nil) {
        self.weibo = weibo;
    }
    
    return self;
    
}
@end
