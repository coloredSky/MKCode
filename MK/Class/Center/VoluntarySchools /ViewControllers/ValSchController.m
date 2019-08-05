//
//  ValSchController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchController.h"
#import "SchoolListViewController.h"

#import "BasicInfoCell.h"
#import "ValSchoolHeaderView.h"

#import "MKUniversityModel.h"
#import "UniversityModel.h"

#import "ValSchoolManager.h"
#import "NSArray+Utilites.h"

@interface ValSchController ()<UITableViewDelegate,UITableViewDataSource,SchoolListViewControllerDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *sectionArr;//区头数组

@property(nonatomic,strong)userInfo * userInfoModel;

@property(nonatomic,strong)NSMutableArray *BcolleageList;//学部的志愿
@property(nonatomic,strong)NSMutableArray *McolleageList;//大学院的志愿

@end

@implementation ValSchController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@[@"学校名称",@"学部/研究科",@"学科/专攻"],@[@"学校名称",@"学部/研究科",@"学科/专攻"],@[@"学校名称",@"学部/研究科",@"学科/专攻"]];
        self.sectionArr =@[@"第一志愿",@"第二志愿",@"第三志愿"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.contentTable reloadData];
}

-(void)setOriginalModel:(PersonModel *)originalModel
{
    _originalModel = originalModel;
    _userInfoModel = [originalModel.userInfo copy];
//    self.BcolleageList = _userInfoModel.BUniversityList;
//    self.McolleageList = _userInfoModel.MUniversityList;
}

#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(K_NaviHeight+190)) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        _contentTable.showsVerticalScrollIndicator = NO;
        _contentTable.showsHorizontalScrollIndicator = NO;
        _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        _contentTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"BasicInfoCell" bundle:nil] forCellReuseIdentifier:@"BasicInfoCell"];
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicInfoCell" forIndexPath:indexPath];
    NSArray * subTitleArr =self.titleArr[indexPath.section];
    cell.ttLabel.text =subTitleArr[indexPath.row];
    cell.textField.userInteractionEnabled = NO;
    UniversityModel *model = self.userInfoModel.university[indexPath.section];
    [cell cellUniversityRefreshDataWithUniversity:model indexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * ary =self.titleArr[section];
    return ary.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(43);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 90;
    if (section == 0) {
        headerHeight = 70;
    }
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==self.sectionArr.count-1) {
        return 130;
    }
    return .1f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ValSchoolHeaderView *headerView = [[ValSchoolHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForHeaderInSection:section])];
    ValSchoolHeaderViewShowType showType = ValSchoolHeaderViewShowTypeDivision;
    __block UniversityModel *universityModel = self.userInfoModel.university[section];
    if ([universityModel.study_category isEqualToString:@"M"]) {
        showType = ValSchoolHeaderViewShowTypeCollege;
    }
    [headerView valSchoolHeaderViewReloadDataWithTitle:self.sectionArr [section] headerViewShowType:showType];
    headerView.schoolHeaderViewBlock = ^(ValSchoolHeaderViewOperationType operationType) {
        if (operationType == ValSchoolHeaderViewOperationTypeDivision) {
//            UniversityModel *firstModel = self.userInfoModel.university[section];
//            UniversityModel *lastModel = self.BcolleageList[section];
//            self.userInfoModel.university[section] = self.BcolleageList[section];
                universityModel.study_category = @"B";
                universityModel.university_name = @"";
                universityModel.university_id = @"";
                universityModel.faculty_name = @"";
                universityModel.faculty_id = @"";
                universityModel.discipline_name = @"";
                universityModel.discipline_id = @"";
        }else{
//            UniversityModel *firstModel = self.userInfoModel.university[section];
//            UniversityModel *lastModel = self.McolleageList[section];
//            self.userInfoModel.university[section] = self.McolleageList[section];
                universityModel.study_category = @"M";
                universityModel.university_name = @"";
                universityModel.university_id = @"";
                universityModel.faculty_name = @"";
                universityModel.faculty_id = @"";
                universityModel.discipline_name = @"";
                universityModel.discipline_id = @"";
        }
        [self.contentTable reloadData];
    };
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==self.sectionArr.count-1) {
        UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 130)];
        bgView.backgroundColor =K_BG_WhiteColor;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setNormalTitle:@"保存" font:MKFont(14) titleColor:K_Text_BlackColor];
        [btn addTarget:self action:@selector(submitHandleTarget:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor =UIColorFromRGB_0x(0xfdf303);
        btn.layer.cornerRadius = 10.0f;
        btn.frame =CGRectMake(K_Padding_Home_LeftPadding, 40, KScreenWidth-K_Padding_Home_LeftPadding*2, (KScreenWidth-K_Padding_Home_LeftPadding*2)/6);
        btn.layer.masksToBounds =YES;
        [bgView addSubview:btn];
        return bgView;
    }
    return nil;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolListViewController *schoolVC = [SchoolListViewController new];
    schoolVC.showType = indexPath.row;
    UniversityModel *universityModel = self.userInfoModel.university[indexPath.section];
    schoolVC.study_category = universityModel.study_category;
    if (indexPath.row == 0) {
        //选择学校
    }else if (indexPath.row == 1){
        if ([NSString isEmptyWithStr:universityModel.university_id]) {
            [MBHUDManager showBriefAlert:@"请先选择学校！"];
            return;
        }
        schoolVC.university_id = universityModel.university_id;
    }else{
        if ([NSString isEmptyWithStr:universityModel.university_id]) {
            [MBHUDManager showBriefAlert:@"请先选择学校！"];
            return;
        }
        if ([NSString isEmptyWithStr:universityModel.faculty_id]) {
            [MBHUDManager showBriefAlert:@"请先选择学部/研究科！"];
            return;
        }
        schoolVC.faculty_id = universityModel.faculty_id;
    }
    [self.navigationController pushViewController:schoolVC animated:YES];
    @weakObject(self);
    schoolVC.schoolValueSelectedBlock = ^(MKSchoolListSelectedModel * _Nonnull schoolModel, SchoolListViewShowType showType) {
        @strongObject(self);
        if (showType == SchoolListViewShowTypeUniversity) {
            //修改了大学
            universityModel.university_id = schoolModel.selectedID;
            universityModel.university_name = schoolModel.selectedname;
            universityModel.faculty_name = @"";
            universityModel.faculty_id = @"";
            universityModel.discipline_name = @"";
            universityModel.discipline_id = @"";
        }else if (showType == SchoolListViewShowTypeFaculty){
            //修改了学部
            universityModel.faculty_name = schoolModel.selectedname;
            universityModel.faculty_id = schoolModel.selectedID;
            universityModel.discipline_name = @"";
            universityModel.discipline_id = @"";
        }else{
            //修改了学科
            universityModel.discipline_name = schoolModel.selectedname;
            universityModel.discipline_id = schoolModel.selectedID;
        }
        [self.contentTable reloadData];
    };
}


#pragma mark --  保存
-(void)submitHandleTarget:(UIButton *)sender
{
    if ([self.userInfoModel.university isEqualToArray:self.originalModel.userInfo.university]) {
        [MBHUDManager showBriefAlert:@"请修改后保存！"];
        return;
    }
    [MBHUDManager showLoading];
    if (self.userInfoModel.university.count >= 3) {
        UniversityModel *firstUniversityModel = self.userInfoModel.university[0];
        UniversityModel *secondUniversityModel = self.userInfoModel.university[1];
        UniversityModel *thirdUniversityModel = self.userInfoModel.university[2];
        [ValSchoolManager  callBackUpdateValSchoolStudy_category1:firstUniversityModel.study_category University_id_1:firstUniversityModel.university_id faculty_id_1:firstUniversityModel.faculty_id discipline_id_1:firstUniversityModel.discipline_id study_category2:secondUniversityModel.study_category  university_id_2:secondUniversityModel.university_id faculty_id_2:secondUniversityModel.faculty_id discipline_id_2:secondUniversityModel.discipline_id study_category3:thirdUniversityModel.study_category university_id_3:thirdUniversityModel.university_id faculty_id_3:thirdUniversityModel.faculty_id discipline_id_3:thirdUniversityModel.discipline_id mobile:self.originalModel.userInfo.mobile completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
            [MBHUDManager hideAlert];
            if (isSuccess) {
                [MBHUDManager showBriefAlert:@"修改成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                if (![NSString isEmptyWithStr:message]) {
                    [MBHUDManager showBriefAlert:message];
                }
            }
        }];
    }
}

@end
