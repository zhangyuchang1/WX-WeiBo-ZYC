//
//  WeiboAnnotation.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-9.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiBoModel.h"

@interface WeiboAnnotation : NSObject<MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//// Title and subtitle for use by selection UI.
//@property (nonatomic, readonly, copy) NSString *title;
//@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic,retain) WeiBoModel *weibo;

- (id)initWithWeibo:(WeiBoModel *)weibo;

@end
