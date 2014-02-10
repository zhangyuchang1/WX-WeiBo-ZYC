//
//  FriendViewController.h
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//
//
//typedef NS_ENUM(NSInteger, FriendshipsType) {
//
//    Attention ,
//    Fans       
//};   //关注和粉丝

typedef enum{
    Attention,
    Fans
}FriendshipsType;

#import "BassViewController.h"
#import "FrindshipsTableView.h"

@interface FriendViewController : BassViewController<TableViewEnventDelegate>

@property (nonatomic,retain) NSMutableArray *data;     //放的是 有三个的二维数组
@property (nonatomic,copy)   NSString       *userId;    //用户ID
@property (strong, nonatomic) IBOutlet FrindshipsTableView *tableView;

@property (nonatomic,copy) NSString *cursor;  //下一页的游标
@property (nonatomic,assign) FriendshipsType shipType;
@end
