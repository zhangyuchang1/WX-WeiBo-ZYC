//
//  FriendshipsCell.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-8.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "FriendshipsCell.h"
#import "UserGridView.h"


@implementation FriendshipsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initViews];
    }
    return self;
}

- (void) initViews
{
    for (int i = 0; i<3; i ++) {
        
        UserGridView *userView = [[UserGridView alloc] initWithFrame:CGRectZero];
        userView.tag = 200+i;
        
        [self.contentView addSubview:userView];
        
        
    }
}
- (void)setData:(NSArray *)data
{
    if (_data != data) {
        _data = data;
    }
    for (int i = 0; i < 3; i ++) {
        
        UserGridView *view = (UserGridView *)[self.contentView viewWithTag:200+i];
        
        view.hidden = YES;

    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    

    for (int i = 0; i < self.data.count; i ++) {
        
        UserGridView *view = (UserGridView *)[self.contentView viewWithTag:200+i];
        view.frame = CGRectMake(10 + 100*i, 10, 96, 96);
        

        view.hidden = NO;
        view.uer = self.data[i];
        //88888888888888 重复
        
        [view setNeedsLayout];
    }
}
@end
