//
//  WXFaceView.m
//  WX-WeiBo
//
//  Created by 张  on 14-2-7.
//  Copyright (c) 2014年 张 . All rights reserved.
//

#define item_wedth  42
#define item_high  45

#import "WXFaceView.h"


@implementation WXFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        self.pageCount = _items.count;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/*    行 row    :4
 *    列 colum  :7
 *
 *    表情尺寸   ; 30*30
 */
/*
 *    item = [
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *           ]
 */
- (void)initData
{
    _items = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    
    NSArray *itemDics = [NSArray arrayWithContentsOfFile:filePath];
    //------------------整理成二维数组----------------------
    NSMutableArray *items2D = nil;
    for (int i = 0; i< itemDics.count; i ++) {
        NSDictionary *item = [itemDics objectAtIndex:i];
        
        if (i % 28 == 0) {
            
            
            items2D = [NSMutableArray arrayWithCapacity:28];
            [_items addObject:items2D];
            
            
        }
        [items2D addObject:item];
    }
    
    //-------------尺寸---------
    self.width = _items.count * KScreenWedth;
    self.height = item_high * 4;
    
    
    _magnifierView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 64, 92)];
    [_magnifierView setImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier.png"]];
    _magnifierView.backgroundColor = [UIColor clearColor];
    _magnifierView.hidden = YES;
    [self addSubview:_magnifierView];
    
    UIImageView *faceItem = [[UIImageView alloc] initWithFrame:CGRectMake((64-30)/2, 15, 30, 30)];
    faceItem.backgroundColor = [UIColor clearColor];
    faceItem.tag = 2012;
    [_magnifierView addSubview:faceItem];
    
    
}
/*
 *    _item = [
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *                 [@"表情1",@"表情2",@"表情3",....,@"表情28"];
 *           ]
 */
- (void)drawRect:(CGRect)rect
{
    //定义列行
    int row = 0, colum = 0;
    
    for (int i = 0; i<_items.count; i++) {
        
        NSArray *items2D = [_items objectAtIndex:i];
        for (int j = 0; j< items2D.count; j ++) {
            
           NSDictionary *dic = [items2D objectAtIndex:j];
            
            NSString *imageStr = [dic objectForKey:@"png"];
            
            UIImage *image =[UIImage imageNamed:imageStr];
            
            CGRect frame = CGRectMake(15+ colum*item_wedth, 15+ row*item_wedth, 30, 30);
            
            //考虑页数,
            CGFloat x = KScreenWedth * i +frame.origin.x;
            frame.origin.x = x;
            
            [image drawInRect:frame];

            
            //跟新列行
            colum ++;
            if (colum % 7 == 0) {
                row ++;
                colum = 0;

            }
            if (row == 4) {
                row = 0;
            }
        
            
            
            
        }
        
        
    }

}
//计算行和列
- (void)touchFace:(CGPoint)point
{
    int page = point.x/KScreenWedth;
    
    //在当前中的坐标
    int x = point.x- KScreenWedth*page-10;
    int y = point.y - 0;
    
    //在当前中的行列
    int colum = x/item_wedth;
    int row   = y/item_high;
    
    //防止越界
    if (colum > 6) {
        colum = 6;
    }
    if (colum < 0) {
        colum = 0;
    }
    if (row > 3) {
        row = 3;
    }
    if (row < 0) {
        row = 0;
    }
    
    //索引
    int index  =  row * 7 + colum;
    
 
   //取到
    NSArray *items2D = _items [page];
    NSDictionary *dic = items2D[index];
    NSString *imageName = dic[@"chs"];
  
    //放大镜内的item
    if ( ![self.selectFaceName isEqualToString:imageName] || self.selectFaceName == nil) {
        UIImageView *faceItem = (UIImageView *)[_magnifierView viewWithTag:2012];
          NSString *image = dic[@"png"];
        [faceItem setImage:[UIImage imageNamed:image]];
       
        _magnifierView.left = page * KScreenWedth + colum * item_wedth-2;
        _magnifierView.bottom = row *item_high+28;
        
        self.selectFaceName = imageName;

    }
   
}

//touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
    

}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = NO;
    
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = NO;
    }
//    self.subviews;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
    
    if (self.block != nil) {
        _block(self.selectFaceName);
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }

    
}
@end
