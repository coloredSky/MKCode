//
//  BookmarkController.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BookmarkController.h"
#import "BookmarkCell.h"
@interface BookmarkController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel * titleLabel;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation BookmarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUICompents];
    [self setUpRefresh];
    self.dataArr = @[@"",@"",@"",@"",@""].mutableCopy;
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
        [self.contentTable.mj_header endRefreshing];
        self.dataArr = @[@""].mutableCopy;
        [self.contentTable reloadData];
        self.placeholderViewShow = YES;
        self.contentTable.hidden = YES;
    }];
    //上拉加载
        self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
//            @strongObject(self);
//            [self.contentTable.mj_footer endRefreshing];
//            self.dataArr = @[@"",@"",@"",@"",@"",@""].mutableCopy;
//            [self.contentTable reloadData];
//            self.placeholderViewShow = NO;
//            self.contentTable.hidden = NO;
        }];
}

#pragma mark --  request
-(void)startRequest
{
}



#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, K_NaviHeight+77, KScreenWidth, KScreenHeight-77-K_NaviHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
//        [_contentTable setNoDataTitleString:@"先去看看感兴趣的课程吧！" noDataImage:@"bookmark_nodata"];
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
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(69);
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
    label.text =section ==0?@"线上课程":@"线下课程";
    [bgView addSubview:label];
    
    return bgView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.backgroundColor =[UIColor clearColor];
    moreBtn.frame =CGRectMake(0, 0, KScreenWidth, 30);
    [bgView addSubview:moreBtn];
    
    UIView * lineView =[UIView new];
    lineView.bounds =CGRectMake(0, 0, 24, 4);
    lineView.center =CGPointMake(KScreenWidth/2, 15);
    lineView.backgroundColor =UIColorFromRGB_0x(0X727272);
    [bgView addSubview:lineView];
    return bgView;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
#pragma mark -- course category did selected
-(void)itemDidSelectedWithIndex:(NSUInteger )index
{
    
}
#pragma mark --  placeholderView-delegate
-(void)placeholderViewClickWithDisplayType:(MKPlaceWorderViewDisplayType )placeholderDisplayType
{
    self.dataArr = @[@"",@"",@"",@"",@"",@""].mutableCopy;
    [self.contentTable reloadData];
    self.placeholderViewShow = NO;
    self.contentTable.hidden = NO;
}

@end
