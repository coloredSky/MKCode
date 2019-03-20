//
//  TitleScrollView.h
//  com.yocto.jzy
//
//  Created by zhouyang on 16/10/12.
//  Copyright © 2016年 com.yocto. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TitleScrollViewDelegate ;

/**
 显示标题scroll
 */
@interface TitleScrollView : UIView
@property(nonatomic,assign)id<TitleScrollViewDelegate>delegate;
@property(nonatomic,assign)NSInteger selectedIndex;//选中的下标

-(instancetype)initWithFrame:(CGRect)frame withItemPadding:(CGFloat )padding;
/**
根据数据加载标题
 @param titleArr    标题数组
 */
-(void)reloadDataWithTitleArr:(NSMutableArray *)titleArr;


/**
 滚动index

 @param index index
 */
-(void)titleScrollViewScrollToIndex:(NSInteger )index;
@end


@protocol TitleScrollViewDelegate <NSObject>

@optional
-(void)titleScrollView:(TitleScrollView *)titleView didSelectedIndex:(NSInteger)index;

@end
