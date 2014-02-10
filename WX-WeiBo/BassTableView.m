//
//  BassTableView.m
//  WX-WeiBo
//
//  Created by 张  on 14-1-10.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#import "BassTableView.h"

@implementation BassTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initSubViews];
    }
    return self;
}

- (void) awakeFromNib
{
    [self _initSubViews];
}
- (void)_initSubViews
{

		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
		_refreshHeaderView.delegate = self;
		

    
    
    self.delegate = self;
    self.dataSource = self;
    self.refreshHeader = YES;
    

    //
    _moreBuuton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBuuton setFrame:CGRectMake(0, 0, KScreenWedth, 40)];
    [_moreBuuton setBackgroundColor:[UIColor whiteColor]];
    [_moreBuuton setTitle:@"上拉加载更多" forState:UIControlStateNormal];
    [_moreBuuton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _moreBuuton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _moreBuuton.enabled = YES;
    _moreBuuton.hidden = NO;

    
    //风火林
    UIActivityIndicatorView *activiView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activiView.tag = 1001;
    [activiView stopAnimating];
    activiView.frame = CGRectMake(100, 10, 20, 20);
    [_moreBuuton addSubview:activiView];

    [_moreBuuton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self setTableFooterView:_moreBuuton];
    self.isMore = YES;
    
}
- (void)_startLoadMore
{
   
    [_moreBuuton setTitle:@"正在加载..." forState:UIControlStateNormal];
    //加载时禁用
//    _moreBuuton.enabled = NO;
    UIActivityIndicatorView *activiView = (UIActivityIndicatorView *)[_moreBuuton viewWithTag:1001];
    [activiView startAnimating];
}
- (void)_stopLoadMore
{
    if (self.data.count > 0) {
    
         [_moreBuuton setTitle:@"上拉加载更多" forState:UIControlStateNormal];
    _moreBuuton.enabled = YES;
        _moreBuuton.hidden = NO;
    UIActivityIndicatorView *activiView = (UIActivityIndicatorView *)[_moreBuuton viewWithTag:1001];
    [activiView stopAnimating];
        
        if (!self.isMore) {
            [_moreBuuton setTitle:@"加载完成" forState:UIControlStateNormal];
            _moreBuuton.enabled = NO;
        }
        
    }else{
        _moreBuuton.hidden = YES;

        
    }
    
   
}
//复写reloadData
- (void)reloadData
{
    [super reloadData];
    [self _stopLoadMore];
}
#pragma mark---Action:loadMoreAction
- (void)loadMoreAction
{
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        
        [self _startLoadMore];
    }
}

- (void)setRefreshHeader:(BOOL)refreshHeader
{
    _refreshHeader = refreshHeader;
    if (_refreshHeader) {
        [self addSubview:_refreshHeaderView];
    }else{
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    
    }
    
}
- (void)refreshDta
{
    [_refreshHeaderView refreshLoading:self];
}
#pragma mark ---下拉的动作
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}
//加载完后弹回
- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//滑动实时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

//scrollView 拉动放开手指时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (!self.isMore) {
        return;
    }
    float offset = scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    //当scrollView滑到底部时，差值是scrollView的高度
    float sub = contentHeight  - offset;
    if ((scrollView.height - sub) > 30) {
        
        [self _startLoadMore];
        if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.eventDelegate pullUp:self];

        }
    }
    
    
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }

    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark--TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

@end
