//
//  DiscoverPageViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "DiscoverPageViewController.h"
#import "NewsViewController.h"
#import "CourseDetailViewController.h"
//View
#import "DiscoverNewsCell.h"
#import "DiscoverCourseCategoryView.h"
//manager
#import "DiscoverManager.h"
//Model
#import "DiscoverNewsModel.h"
#import "MKCourseListModel.h"


@interface DiscoverPageViewController ()<UITableViewDelegate,UITableViewDataSource,DiscoverCourseCategoryViewDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray <DiscoverNewsModel *> *dicoverNewsList;
@property (nonatomic, strong) NSArray <MKCourseListModel *> *liveList;
//分页
@property (nonatomic, assign) NSInteger totalPage;//总页数
@property (nonatomic, assign) NSInteger currentPage;//页码
@property (nonatomic, assign) NSInteger pageSize;//取数据的条数
@end

@implementation DiscoverPageViewController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.currentPage = 1;
        self.pageSize = 5;
        self.dicoverNewsList = [NSMutableArray array];
    }
    return self;
}

#pragma mark --- destruct method
-(void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startRequestTheArticleList];
    [self setUpHeaderRefresh];
}


#pragma mark --  refresh
-(void)setUpHeaderRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        self.currentPage = 1;
        [self startRequestTheArticleList];
    }];
}
-(void)setUpFooterRefresh
{
    //上拉加载
    @weakObject(self);
    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
        @strongObject(self);
        self.currentPage ++;
        [self startRequestTheArticleList];
    }];
}


#pragma mark --  request
-(void)startRequestTheArticleList
{
    [DiscoverManager callBackDiscoverNewsListDataWithHUDShow:NO page:self.currentPage page_size:self.pageSize andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, NSArray<DiscoverNewsModel *> * _Nonnull newsList, NSInteger totalpage, NSArray <MKCourseListModel *>* _Nonnull liveList) {
        [self.contentTable.mj_header endRefreshing];
        [self.contentTable.mj_footer endRefreshing];
        if (isSuccess) {
            if (self.currentPage == 1) {
                self.totalPage = totalpage;
                [self.dicoverNewsList removeAllObjects];
                self.dicoverNewsList = newsList.mutableCopy;
                self.liveList = liveList;
                if (self.currentPage < totalpage) {
                    [self setUpFooterRefresh];
                }
            }else{
                [self.dicoverNewsList addObjectsFromArray:newsList];
            }
            if (self.currentPage >= self.totalPage) {
                [self.contentTable.mj_footer endRefreshingWithNoMoreData];
            }
            [self.contentTable reloadData];
        }else{
            self.currentPage--;
        }
    }];
}

#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = [UIColor clearColor];
        [_contentTable registerNib:[UINib nibWithNibName:@"DiscoverNewsCell" bundle:nil] forCellReuseIdentifier:@"DiscoverNewsCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverNewsCell" forIndexPath:indexPath];
    DiscoverNewsModel *newsModel = self.dicoverNewsList[indexPath.section];
    [cell cellRefreshDataWithDiscoverNewsModel:newsModel];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dicoverNewsList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 257*(KScreenWidth-K_Padding_LeftPadding*2)/342+90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 84;
    }else {
        if (section == 1) {
            if (self.liveList.count > 0) {
                return CGFLOAT_MIN;
            }
        }
        return 116;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0){
        if (self.liveList.count > 0) {
            return 140-10;
        }
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 && self.liveList.count > 0) {
        return nil;
    }
//    if (section != 1 || (section == 1 && self.liveList.count == 0)) {
    UIView *headerView = [UIView new];
    if (section == 0) {
        headerView.frame = CGRectMake(0, 0, KScreenWidth, 84);
    }else{
        headerView.frame = CGRectMake(0, 0, KScreenWidth, 116);
    }
    DiscoverNewsModel *newsModel = self.dicoverNewsList[section];
    UILabel *weekDayLab = [UILabel new];
    weekDayLab.frame = CGRectMake(K_Padding_LeftPadding, headerView.height- 40-8, 200, 40);
    [headerView addSubview:weekDayLab];
    [weekDayLab setFont:K_Font_WeekDay_Text textColor:K_Text_BlackColor withBackGroundColor:nil];
    weekDayLab.text = newsModel.newsCreateWeek;
    
    UILabel *timeLab = [UILabel new];
    timeLab.frame = CGRectMake(weekDayLab.leftX, weekDayLab.topY-14, weekDayLab.width, 14);
    [headerView addSubview:timeLab];
    [timeLab setFont:MKFont(12) textColor:K_Text_grayColor withBackGroundColor:nil];
    timeLab.text = newsModel.newsCreateDate;
    
    return  headerView;
//    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.liveList.count > 0) {
            UIView *fotterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 140-10)];
            CGFloat itemWidth = (KScreenWidth-25*2-18*3)/4;
            DiscoverCourseCategoryView *categoryView = [[DiscoverCourseCategoryView alloc]initWithFrame:CGRectMake(0, fotterView.height/2-itemWidth/2, fotterView.width, itemWidth)];
            categoryView.delegate = self;
            [categoryView CourseCategoryViewReloadDataWithList:self.liveList];
            [fotterView addSubview:categoryView];
            return fotterView;
        }
    }
    return nil;
}

-(NSString *)urlEncodeWithUrlString:(NSString *)urlString
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodeValue = [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodeValue;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverNewsModel *newsModel = self.dicoverNewsList[indexPath.section];
    NewsViewController *newsVC = [NewsViewController new];
    newsVC.newsID = newsModel.newsID;
    if (newsModel.isUrl) {
        newsVC.showType = WebViewShowTypeNewsDetailUrlType;
    }else{
        newsVC.showType = WebViewShowTypeNewsDetailHtmlContentType;
    }
    [self.navigationController pushViewController:newsVC animated:YES];
}
#pragma mark -- course category did selected
-(void)itemDidSelectedWithIndex:(NSUInteger )index
{
     MKCourseListModel *courseModel = self.liveList[index];
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    courseDetailVC.course_id = courseModel.courseID;
    courseDetailVC.courseType = CourseSituationTypeOnline;
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}

@end
