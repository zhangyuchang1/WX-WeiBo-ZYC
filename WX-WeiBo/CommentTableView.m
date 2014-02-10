//
//  CommentTableView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-13.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
@implementation CommentTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark--TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"CommentCell";

    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
    }
    
    CommentModel *model = self.data[indexPath.row];

    cell.commentModel = model;
    return cell;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel *model = self.data[indexPath.row];
    
   float h = [CommentCell getCommentHeight:model];
    return h;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *commentCountLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    commentCountLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    commentCountLabel.textColor = [UIColor blueColor];
    commentCountLabel.backgroundColor = [UIColor clearColor];
   NSNumber *count = [self.commentDic objectForKey:@"total_number"];
    
    commentCountLabel.text = [NSString stringWithFormat:@"评论：%@",count];
    [view addSubview:commentCountLabel];
    
    //分割线
    UIImageView *sparetLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, tableView.width, 1)];
    sparetLine.image = [UIImage imageNamed:@"userinfo_header_separator.png"];
    [view addSubview:sparetLine];
    
    
    return view;
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end
