//
//  HomeContentScrollView.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeContentScrollView.h"


@interface HomeContentScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) NSMutableArray *childViewControllers;
@end

@implementation HomeContentScrollView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark --  lazy
-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _contentScroll.showsVerticalScrollIndicator= NO;
        _contentScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentScroll];
        _contentScroll.backgroundColor = [UIColor yellowColor];
        _contentScroll.delegate = self;
        _contentScroll.pagingEnabled = YES;
    }
    return _contentScroll;
}

-(void)AddChildViewWithTitleArr:(NSMutableArray *)childViewControllers andRootViewController:(UIViewController *)rootVC
{
    self.childViewControllers = childViewControllers;
    if (childViewControllers.count > 1) {
        self.contentScroll.contentSize  =CGSizeMake(self.contentScroll.width*childViewControllers.count, self.contentScroll.height);
        for (int index = 0; index < childViewControllers.count; index++) {
            UIViewController *childVC = childViewControllers[index];
            [rootVC addChildViewController:childVC];
            childVC.view.frame = CGRectMake(self.contentScroll.width*index, 0, self.contentScroll.width, self.contentScroll.height);
            [self.contentScroll addSubview:childVC.view];
            [childVC didMoveToParentViewController:rootVC];
        }
    }
}

-(void)scrollToIndex:(NSInteger )index
{
    [self.contentScroll setContentOffset:CGPointMake(self.contentScroll.width*index, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    if ([delegate respondsToSelector:@selector(homeContentScrollViewScrollToIndex:)]) {
        [delegate homeContentScrollViewScrollToIndex:index];
    }
}
@end
