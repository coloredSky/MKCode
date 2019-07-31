//
//  BookmarkController.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BookmarkController.h"
#import "CourseDetailViewController.h"
#import "BookmarkCell.h"
#import "BookMarkManager.h"
#import "BookMarkModel.h"

@interface BookmarkController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel * titleLabel;
@property (nonatomic, strong) MKBaseTableView *contentTable;

@property (nonatomic, strong) NSArray <BookMarkModel *> *bookMarkList;

@end

@implementation BookmarkController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUICompents];
    [self setUpRefresh];
    [self startRequest];
    [self addNoti];
}

-(void)addNoti
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bookMarkListRefresh:) name:kMKUserCollectionClassListRefreshNotifcationKey object:nil];
}

#pragma mark-创建ui
-(void)creatUICompents
{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentTable];
    [self reloadPlacehorldViewWithFrame:CGRectMake(0, self.titleLabel.bottomY, self.view.width, self.view.height-self.titleLabel.height) placehorldDisplayType:MKPlaceWorderViewDisplayTypeNoBookMark];
}


#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self startRequest];
    }];
}

#pragma mark --  request
-(void)startRequest
{
    [BookMarkManager callBackUserBookMarkListRequesWithCompletionBlock:^(BOOL isSuccess, NSArray<BookMarkModel *> * _Nonnull bookMarkList, NSString * _Nonnull message) {
        if (isSuccess) {
            [self.contentTable.mj_header endRefreshing];
            self.bookMarkList = bookMarkList;
            if (bookMarkList.count == 0) {
                self.placeholderViewShow = YES;
                self.contentTable.hidden = YES;
            }else{
                self.placeholderViewShow = NO;
                self.contentTable.hidden = NO;
            }
            [self.contentTable reloadData];
        }
    }];
}

#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, K_NaviHeight+77, KScreenWidth, KScreenHeight-77-K_NaviHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = [UIColor clearColor];
        [_contentTable registerNib:[UINib nibWithNibName:@"BookmarkCell" bundle:nil] forCellReuseIdentifier:@"BookmarkCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, K_NaviHeight+7, 200, 50)];
        [_titleLabel setFont:MKBoldFont(28) textColor:[UIColor blackColor] withBackGroundColor:[UIColor clearColor]];
        _titleLabel.text =@"BookMark";
    }
    return  _titleLabel;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookmarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookmarkCell" forIndexPath:indexPath];
    BookMarkModel *model = self.bookMarkList[indexPath.section];
    BookMarkListModel *listModel = model.bookMarkList[indexPath.row];
    [cell cellRefreshDataWithBookMarkListModel:listModel];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bookMarkList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BookMarkModel *model = self.bookMarkList[section];
    if (model.bookMarkList.count <= 8) {
        return model.bookMarkList.count;
    }else{
        if (model.isSpread) {
            return model.bookMarkList.count;
        }
        return 8;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    UILabel  * label =[[UILabel alloc]initWithFrame:CGRectMake(23, 0, KScreenWidth-46, 40)];
    [label setFont:MKBoldFont(16) textColor:K_Text_grayColor withBackGroundColor:nil];
    BookMarkModel *model = self.bookMarkList[section];
    label.text = model.titleString;
    [bgView addSubview:label];
    
    return bgView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BookMarkModel *model = self.bookMarkList[section];
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    UIImageView *spreadIma = [[UIImageView alloc]initWithFrame:CGRectMake(bgView.width/2-8, bgView.height/2-8, 16, 16)];
    [bgView addSubview:spreadIma];
    if (model.isSpread) {
        spreadIma.image = KImageNamed(@"bookmark_show");
    }else{
        spreadIma.image = KImageNamed(@"bookmark_notshow");
    }
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.backgroundColor =[UIColor clearColor];
    moreBtn.frame =CGRectMake(0, 0, KScreenWidth, 30);
    [bgView addSubview:moreBtn];
    moreBtn.tag = section;
    [moreBtn addTarget:self action:@selector(moreShowHandleTarget:) forControlEvents:UIControlEventTouchUpInside];
    return bgView;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookMarkModel *model = self.bookMarkList[indexPath.section];
    BookMarkListModel *listModel = model.bookMarkList[indexPath.row];
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    courseDetailVC.course_id = listModel.course_id;
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}
#pragma mark --  展开
-(void)moreShowHandleTarget:(UIButton *)sender
{
    BookMarkModel *model = self.bookMarkList[sender.tag];
    if (model.bookMarkList.count <= 8) {
        [MBHUDManager showBriefAlert:@"没有更多课程了！"];
        return;
    }
    model.isSpread = !model.isSpread;
    [self.contentTable reloadData];
}
#pragma mark -- course category did selected
-(void)itemDidSelectedWithIndex:(NSUInteger )index
{
    
}
#pragma mark --  placeholderView-delegate
-(void)placeholderViewClickWithDisplayType:(MKPlaceWorderViewDisplayType )placeholderDisplayType
{
    
}

#pragma mark --  通知
-(void)bookMarkListRefresh:(NSNotification *)noti
{
    [self startRequest];
}
@end
