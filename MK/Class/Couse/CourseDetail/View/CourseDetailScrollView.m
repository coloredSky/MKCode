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

#import "MKCourseDetailModel.h"

@interface CourseDetailScrollView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) WKWebView *contentWeb;//课程详情
//model
@property (nonatomic, strong) MKCourseDetailModel *courseDetailModel;
@property (nonatomic, strong) MKLessonModel *selectedLessonModel;
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
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [self.contentScroll addSubview:_contentTable];
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
            [cell cellRefreshDataWithCourseDetailModel:self.courseDetailModel];
            return cell;
        }else{
            CourseOfflineTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOfflineTitleCell" forIndexPath:indexPath];
            [cell cellRefreshData];
            return cell;
        }
    }else if(indexPath.section == 1){
        CourseTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseTeacherCell" forIndexPath:indexPath];
        [cell cellRefreshDataWithCourseDetailModel:self.courseDetailModel];
        return cell;
    }else{
        if (self.courseType == CourseSituationTypeOnline) {
            CourseOnlineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOnlineListCell" forIndexPath:indexPath];
            MKLessonModel *lessonModel =  self.courseDetailModel.lessonList[indexPath.row];
            [cell cellRefreshDataWithLessonModel:lessonModel];
            return cell;
        }else{
            CourseOfflineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOfflineListCell" forIndexPath:indexPath];
            MKLessonModel *lessonModel =  self.courseDetailModel.lessonList[indexPath.row];
            [cell cellRefreshDataWithLessonModel:lessonModel];
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
    return self.courseDetailModel.lessonList.count;
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
    if (indexPath.section == 2) {
        MKLessonModel *lessonModel =  self.courseDetailModel.lessonList[indexPath.row];
        if (self.selectedLessonModel == lessonModel) {
            return;
        }
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        self.selectedLessonModel.isSelected = NO;
        lessonModel.isSelected = YES;
        self.selectedLessonModel = lessonModel;
        if ([delegate respondsToSelector:@selector(courseDidSelectedWithIndexPath: andLessonModel:)]) {
            [delegate courseDidSelectedWithIndexPath:indexPath andLessonModel:lessonModel];
        }
        [tableView reloadData];
    }
}

-(void)scrollToIndex:(NSInteger )index
{
    [self.contentScroll setContentOffset:CGPointMake(self.contentScroll.width*index, 0) animated:YES];
}

#pragma mark --  数据刷新
-(void)courseDetailScrollViewReloadDataWithMKCourseDetailModel:(MKCourseDetailModel *)courseDetailModel;
{
    self.courseDetailModel = courseDetailModel;
    if (![NSString isEmptyWithStr:courseDetailModel.courseInfoDetail.courseDetail]) {
            [self.contentWeb loadHTMLString:courseDetailModel.courseInfoDetail.courseDetail baseURL:nil];
    }
    [self.contentTable reloadData];

}
@end
