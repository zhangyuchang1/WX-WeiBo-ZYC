//
//  WXDataService.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "WXDataService.h"
#import "JSONKit.h"
#define kAppKey @"3956901542"

#define kBass_URL @"https://open.weibo.cn/2/"

@implementation WXDataService

+(ASIFormDataRequest *)requestWithURl:(NSString *)urlString
                                parms:(NSMutableDictionary *)parms
                           httpMethod:(NSString *)heetMethod
                        completeBlock:(ReuestFinishBlock)block

{
    
    //----------------------token认证----------------------
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
   urlString = [kBass_URL stringByAppendingFormat:@"%@?access_token=%@",urlString,accessToken];
    
    //----------------------Get请求----------------------
    //url:https://open.weibo.cn/2/statuses/home_timeline.json?count=20&access_token=2.008I7LdCcqkm_Ed65ad0231cYKZU_D
    
    NSComparisonResult ascending2 = [ heetMethod caseInsensitiveCompare:@"GET"];
    
    if (ascending2 == NSOrderedSame) {
        
        
        //拼接irl
        NSMutableString *parmsString = [NSMutableString string];
        
        NSArray *keys = [parms allKeys];
        
        for (int i = 0 ; i < parms.count; i++) {
            
            NSString *key = keys[i];
            id obj = parms[key];
            
            
            [parmsString appendFormat:@"%@=%@",key,obj];
            if (i <parms.count-1) {
                [parmsString appendString:@"&"];
            }
            
        }
        
        if (parmsString.length > 0) {
            
            urlString = [urlString stringByAppendingFormat:@"&%@",parmsString];
        }
    }
    

    
    
    //----------------------------创间请、求
   __block ASIFormDataRequest *requst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [requst setTimeOutSeconds:60];
    [requst setRequestMethod:heetMethod];
    


    
    //----------------------Post 请求----------------------
   NSComparisonResult ascending = [ heetMethod caseInsensitiveCompare:@"POST"];
    
    if (ascending == NSOrderedSame) {
        
        NSArray *keys = [parms allKeys];
        
        for (int i = 0 ; i < parms.count; i++) {
        
            NSString *key = keys[i];
            id obj = parms[key];
            
            //判断是否为文件上传
            if ([obj isKindOfClass:[NSData class]]) {
                [requst addData:obj forKey:key];
                
            }else{
                [requst addPostValue:obj forKey:key];
            }
            
        }
        
        
    }
 
    //------------------设置请求完成后调用Block--------------
    [requst setCompletionBlock:^{
        
        NSData *data =  requst.responseData;
        float version = WXHLOSVersion();
        id resuld = nil;
        if (version >= 5.0) {
            
            resuld = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
        }else{
            resuld = [data objectFromJSONData];
            
        }
        if (block != nil) {
            block(resuld);
        }
        

    } ];
    
    [requst startAsynchronous];
     return requst;

}
@end
