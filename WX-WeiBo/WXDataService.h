//
//  WXDataService.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void (^ReuestFinishBlock)(id result);

@interface WXDataService : NSObject

+(ASIFormDataRequest *)requestWithURl:(NSString *)urlString
                                parms:(NSMutableDictionary *)parms
                           httpMethod:(NSString *)heetMethod
                        completeBlock:(ReuestFinishBlock)block;

@end
