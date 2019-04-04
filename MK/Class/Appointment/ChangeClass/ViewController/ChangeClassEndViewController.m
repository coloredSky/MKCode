//
//  ChangeClassEndViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ChangeClassEndViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "AppointmentTeacherReplyCell.h"

@interface ChangeClassEndViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
//@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSArray *tipStringArr;
@property (nonatomic, strong) NSArray *contentStringArr;
@end

@implementation ChangeClassEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    
    [self creatSubVuew];
}
-(void)creatSubVuew
{
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
}

#pragma mark --  lazy
-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"更改后班级",@"原有班级",@"换班理由"];
    }
    return _tipStringArr;
}
-(NSArray *)contentStringArr
{
    if (!_contentStringArr) {
        _contentStringArr = @[@"中级日语",@"高级日语",@"高级日语的课程感觉有些吃力，想申请换到中级班，望批准。"];
    }
    return _contentStringArr;
}
-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.headerView.bottomY+KScaleHeight(30)+KScaleHeight(70+20)*i, _contentScroll.width-K_Padding_Home_LeftPadding*2, KScaleHeight(20))];
            [_contentScroll addSubview:titleLab];
            [titleLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
            titleLab.text = self.tipStringArr[i];
            
            AppointmentTapView *tapView = [AppointmentTapView new];
            CGFloat tapViewY = tapViewY = titleLab.bottomY+ KScaleHeight(13);
            if (i == self.contentStringArr.count-1) {
                  CGSize size = [self.contentStringArr[i] getStrSizeWithSize:CGSizeMake(_contentScroll.width-K_Padding_Home_LeftPadding*2, 300) font:K_Font_Text_Normal];
                CGFloat height = 33;
                if (size.height+20 > 33) {
                    height = size.height+20;
                }
                tapView.frame = CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, height);
            }else{
                tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            }
            tapView.textString = self.contentStringArr[i];
            [self.contentScroll addSubview:tapView];
            tapView.normalColor = K_Text_YellowColor;
            //底部消息列表
            if (i == self.tipStringArr.count-1) {
                _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, tapView.bottomY+KScaleHeight(35), KScreenWidth, KScreenHeight-tapView.bottomY-KScaleHeight(35)) style:UITableViewStyleGrouped];
                _contentTable.delegate = self;
                _contentTable.dataSource = self;
                [self.contentScroll addSubview:_contentTable];
                _contentTable.backgroundColor = K_BG_WhiteColor;
                _contentTable.sectionHeaderHeight = 0.001;
                [_contentTable registerNib:[UINib nibWithNibName:@"AppointmentTeacherReplyCell" bundle:nil] forCellReuseIdentifier:@"AppointmentTeacherReplyCell"];
            }
        }
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];
        _headerView.titleString = @"换班成功";
        [self.contentScroll addSubview:_headerView];
    }
    return _headerView;
}


#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentTeacherReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentTeacherReplyCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(95);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScaleHeight(48);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(48))];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    [headerView addSubview:titleLab];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    titleLab.text = @"暂无回复";
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end