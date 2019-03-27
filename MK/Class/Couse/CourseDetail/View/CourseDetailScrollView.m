//
//  CourseDetailScrollView.m
//  MK
//
//  Created by 周洋 on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseDetailScrollView.h"
#import <WebKit/WebKit.h>
//View c线上课程
#import "CourseOnlineTitleCell.h"
#import "CourseTeacherCell.h"
#import "CourseOnlineListCell.h"
//View 线下课程
#import "CourseOfflineListCell.h"
#import "CourseOfflineTitleCell.h"

@interface CourseDetailScrollView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) WKWebView *contentWeb;
@end
@implementation CourseDetailScrollView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:_contentScroll];
        _contentScroll.backgroundColor = [UIColor whiteColor];
        _contentScroll.pagingEnabled = YES;
        _contentScroll.delegate = self;
        _contentScroll.contentSize = CGSizeMake(self.width*2, self.height);
    }
    return _contentScroll;
}

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.contentScroll.width, self.contentScroll.height) style:UITableViewStyleGrouped];
        [self.contentScroll addSubview:_contentTable];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [_contentTable registerNib:[UINib nibWithNibName:@"CourseOnlineTitleCell" bundle:nil] forCellReuseIdentifier:@"CourseOnlineTitleCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"CourseTeacherCell" bundle:nil] forCellReuseIdentifier:@"CourseTeacherCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"CourseOnlineListCell" bundle:nil] forCellReuseIdentifier:@"CourseOnlineListCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"CourseOfflineListCell" bundle:nil] forCellReuseIdentifier:@"CourseOfflineListCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"CourseOfflineTitleCell" bundle:nil] forCellReuseIdentifier:@"CourseOfflineTitleCell"];
        
    }
    return _contentTable;
}

-(WKWebView *)contentWeb
{
    if (!_contentWeb) {
        _contentWeb = [[WKWebView alloc]initWithFrame:CGRectMake(self.contentScroll.width+K_Padding_Home_LeftPadding, 0, self.width-K_Padding_Home_LeftPadding*2, self.height)];
        _contentWeb.UIDelegate = self;
        _contentWeb.navigationDelegate = self;
        _contentWeb.backgroundColor = [UIColor whiteColor];
        _contentWeb.scrollView.showsVerticalScrollIndicator = NO;
        [self.contentScroll addSubview:_contentWeb];
    }
    return _contentWeb;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.courseType == CourseSituationTypeOnline) {
            CourseOnlineTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOnlineTitleCell" forIndexPath:indexPath];
            [cell cellRefreshData];
            return cell;
        }else{
            CourseOfflineTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOfflineTitleCell" forIndexPath:indexPath];
            [cell cellRefreshData];
            return cell;
        }
    }else if(indexPath.section == 1){
        CourseTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseTeacherCell" forIndexPath:indexPath];
        [cell cellRefreshData];
        return cell;
    }else{
        if (self.courseType == CourseSituationTypeOnline) {
            CourseOnlineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOnlineListCell" forIndexPath:indexPath];
            if (indexPath.row == 0) {
                [cell cellRefreshWithData:YES];
            }else{
                [cell cellRefreshWithData:NO];
            }
            return cell;
        }else{
            CourseOfflineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOfflineListCell" forIndexPath:indexPath];
            [cell cellRefreshData];
            return cell;
        }
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0||section == 1) {
        return 1;
    }
    return 15;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
          return KScaleHeight(85);
    }else if (indexPath.section == 1){
          return KScaleHeight(85);
    }
    if (self.courseType == CourseSituationTypeOnline) {
         return KScaleHeight(70);
    }else{
        return KScaleHeight(80);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark --  webView-delagate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    MKLog(@"页面加载完成");
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'" completionHandler:nil];
}
#pragma mark --  scroll-Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    MKLog(@"-------%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.x == 0) {
        if ([delegate respondsToSelector:@selector(CourseDetailScrollViewScrollOffsetY:)]) {
            [delegate CourseDetailScrollViewScrollOffsetY:scrollView.contentOffset.y];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([delegate respondsToSelector:@selector(CourseDetailScrollViewScrollToIndex:)]) {
        NSInteger index = self.contentScroll.contentOffset.x/self.contentScroll.width;
        [delegate CourseDetailScrollViewScrollToIndex:index];
    }
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollToIndex:(NSInteger )index
{
    [self.contentScroll setContentOffset:CGPointMake(self.contentScroll.width*index, 0) animated:YES];
}

#pragma mark --  数据刷新
-(void)CourseDetailScrollViewReloadData
{
    [self.contentTable reloadData];
    [self.contentWeb loadHTMLString:@"背景：由于语言学校主要以日本老師教学为主，而且教授期间较长，虽然这样可以使学 生在听力和会话能力有所提高，但是在语法的讲解上由于主要以日语讲解和练习为主，导致学生对基础语法现象的理解不足，从而使学生在日语表达能力及听说读解等各方面能力受到限制。而国内的日语培训机构为了保证生源，课程的设计往往偏于“短平快”，加上学生的学习自主性和代课教师水平的参差不齐，很难保证教学质量。 对象：在国内结束基础阶段强化班课程（教材：《新标准日本语-初级》《大家的日本语-初级》；教学期间：3～4个月）的学员。 目的：巩固日语基础阶段学习中必须掌握的语法，为留考，校内考以及N1N2的学习打下良好的基础。 备注：由于国内的强化课程课时和课程过于集中，所以大部分学员对基础阶段语法的理解实际上处于一知半解囫囵吞枣的状态。但是正是因为觉得基础阶段的学习已经结束，才会导致很多学员在选择进学课程时忽视基础课程。可是事实表明没有打好基础想在留考、校内考以及日语能力考试中取得好成绩很困难。所以希望通过这个课程能让大家对在强化课程和语言学校中没有完全掌握的概念和语法有一个更深的理解，能帮助大家走得更远。" baseURL:nil];
}
@end
