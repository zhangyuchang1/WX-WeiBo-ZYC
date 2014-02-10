//
//  FrindshipsTableView.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "FrindshipsTableView.h"
#import "FriendshipsCell.h"

@implementation FrindshipsTableView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        self.dataSource =self;
//    }
//    return self;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifer = @"cell";
    
    FriendshipsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {

        cell = [[FriendshipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
      cell.data =  [self.data objectAtIndex:indexPath.row];
   
      return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
@end
