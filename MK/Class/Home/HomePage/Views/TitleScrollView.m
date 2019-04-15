//
//  TitleScrollView.m
//  com.yocto.jzy
//
//  Created by zhouyang on 16/10/12.
//  Copyright © 2016年 com.yocto. All rights reserved.
//

#define TitleLabPanding  50
#define ScrollViewLeftPanding  38

#import "TitleScrollView.h"
#import "SelectedCustomLab.h"


@interface TitleScrollView()
@property(nonatomic,assign)CGFloat itemPadding;//title间距
@property(nonatomic,strong)UIScrollView *titleScroll;//title的scroll
@property(nonnull,strong)SelectedCustomLab *haveSelectedLab;
@property (nonatomic, strong) UIImageView *tipIma;//移动ima
/**装lab的数组*/
@property(nonatomic,strong)NSMutableArray *titleLabArr;
/**装title数组*/
@property(nonatomic,strong)NSMutableArray *allTitleArr;
@end

@implementation TitleScrollView
@synthesize delegate;
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        return  [self initWithFrame:frame withItemPadding:TitleLabPanding];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withItemPadding:(CGFloat )padding
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.itemPadding = padding;
        self.titleScroll.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}

-(void)reloadDataWithTitleArr:(NSMutableArray *)titleArr
{
    if (self.allTitleArr == titleArr) {
        return;
    }
    self.allTitleArr = titleArr;
    [self.titleLabArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    @weakObject(self);
    //label 的X轴值
    __block float widthX = ScrollViewLeftPanding;
    //scrollerView的contentSize
    __block float contentWidth = ScrollViewLeftPanding*2;
    [self.allTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongObject(self);
        NSString *title = obj;
        //每个字符的长度
        float titleWidth = [title getStrWidthWithfont:TitleLabFont];
        contentWidth += (titleWidth + self.itemPadding);
        //X
        float currentWidthX = widthX;
        if (idx > 0)
        {
            NSString *beforeString = self.allTitleArr[idx - 1];
            float beforeTitleWidth = [beforeString getStrWidthWithfont:TitleLabFont];
            widthX += (beforeTitleWidth +self.itemPadding);
            currentWidthX = widthX;
        }
        SelectedCustomLab *titleLab = [[SelectedCustomLab alloc]initWithFrame:CGRectMake(currentWidthX, self.height/2-10, titleWidth, 20)];
        [self.titleScroll addSubview:titleLab];
        if (idx == 0) {
            titleLab.selected = YES;
            self.selectedIndex = 0;
            self.haveSelectedLab = titleLab;
            self.tipIma.frame = CGRectMake(self.haveSelectedLab.centerX-(self.haveSelectedLab.width+32)/2, self.haveSelectedLab.centerY-self.height/2, self.haveSelectedLab.width+32, self.height);
        }
        titleLab.text = title;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.userInteractionEnabled = YES;
        titleLab.tag = idx;
        [titleLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        [self.titleLabArr addObject:titleLab];
    }];
    _titleScroll.contentSize = CGSizeMake(contentWidth, self.height);
}
//lazy
-(UIScrollView *)titleScroll
{
    if (!_titleScroll) {
        _titleScroll = [[UIScrollView alloc]init];
        [self addSubview:_titleScroll];
        _titleScroll.showsHorizontalScrollIndicator = NO;
        _titleScroll.showsVerticalScrollIndicator = NO;
    }
    return _titleScroll;
}
-(UIImageView *)tipIma
{
    if (!_tipIma) {
        _tipIma = [UIImageView new];
//        _tipIma.frame = CGRectMake(self.haveSelectedLab.centerX-(self.haveSelectedLab.width+36)/2, self.haveSelectedLab.centerY-self.height/2, self.haveSelectedLab.width+36, self.height);
        [_titleScroll insertSubview:_tipIma atIndex:0];
        _tipIma.backgroundColor = K_BG_YellowColor;
        _tipIma.layer.masksToBounds = YES;
        _tipIma.layer.cornerRadius = self.height/2;
    }
    return _tipIma;
}
-(NSMutableArray *)titleLabArr
{
    if (!_titleLabArr) {
        _titleLabArr = [NSMutableArray array];
    }
    return _titleLabArr;
}
-(NSMutableArray *)allTitleArr
{
    if (!_allTitleArr) {
        _allTitleArr = [NSMutableArray array];
    }
    return _allTitleArr;
}

//lab 点击
-(void)labelClick:(UITapGestureRecognizer *)tap
{
    SelectedCustomLab *sender = (SelectedCustomLab *)tap.view;
    if (self.haveSelectedLab==sender)
    {
        return;
    }
    sender.selected = YES;
    self.haveSelectedLab.selected = NO;
    self.haveSelectedLab = sender;
    self.selectedIndex = sender.tag;
    [self tipImaAnimatied];
    
    if ([delegate respondsToSelector:@selector(titleScrollView:didSelectedIndex:)])
    {
        [delegate titleScrollView:self didSelectedIndex:sender.tag];
    }
    [self titleScrollContentOffsetChange:sender.tag];
}

//o动画
-(void)tipImaAnimatied
{
    [UIView animateWithDuration:.5 animations:^{
        self.tipIma.frame = CGRectMake(self.haveSelectedLab.centerX-(self.haveSelectedLab.width+32)/2, self.haveSelectedLab.centerY-self.height/2, self.haveSelectedLab.width+32, self.height);
    }];
}

//selectedIndex 的set方法
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (self.titleLabArr.count <= 0) {
        return;
    }
    SelectedCustomLab *sender = [self.titleLabArr objectAtIndex:selectedIndex];
    if (self.haveSelectedLab==sender)
    {
        return;
    }
     [self titleScrollContentOffsetChange:sender.tag];
    sender.selected = YES;
    self.haveSelectedLab.selected = NO;
    self.haveSelectedLab = sender;
    [self tipImaAnimatied];
}

//选中后改变contentoffset
-(void)titleScrollContentOffsetChange:(NSInteger )index
{
    SelectedCustomLab *sender = self.titleLabArr[index];
    float contentOffsetx =0;
    if (_titleScroll.contentSize.width>_titleScroll.width)
    {
        if (sender.centerX<=_titleScroll.width/2)
        {
            contentOffsetx = 0;
        }
        else
        {
            if (_titleScroll.contentSize.width-sender.centerX<=_titleScroll.width/2)
            {
                contentOffsetx = _titleScroll.contentSize.width-_titleScroll.width;
            }
            else
            {
                contentOffsetx = sender.centerX-_titleScroll.width/2;
            }
        }
    }
    [_titleScroll setContentOffset:CGPointMake(contentOffsetx, 0) animated:YES];
}

-(void)titleScrollViewScrollToIndex:(NSInteger )index
{
    self.selectedIndex = index;
}
@end
