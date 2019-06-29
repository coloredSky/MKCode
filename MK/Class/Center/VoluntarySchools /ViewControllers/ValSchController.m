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
#import "MKUniversityModel.h"
#import "UniversityModel.h"
#import "ValSchoolManager.h"

#import "NSArray+Utilites.h"

@interface ValSchController ()<UITableViewDelegate,UITableViewDataSource,SchoolListViewControllerDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *sectionArr;//区头数组

@property(nonatomic,strong)userInfo * userInfoModel;

@property(nonatomic,strong)UniversityModel * firstUniversityModel;//显示和传值第一志愿
@property(nonatomic,strong)UniversityModel * secondUniversityModel;//显示和传值第二志愿
@property(nonatomic,strong)UniversityModel * thirdUniversityModel;////显示和传值第三志愿

@property (nonatomic, strong) MKUniversityModel *firstSelectedModel;//选中的第一志愿
@property (nonatomic, strong) MKUniversityModel *secondSelectedModel;//选中的第二志愿
@property (nonatomic, strong) MKUniversityModel *thirdSelectedModel;//选中的第三志愿

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
    
    if (originalModel.userInfo.university.count <= 0) {
        self.firstUniversityModel = [UniversityModel new];
        self.secondUniversityModel = [UniversityModel new];
        self.thirdUniversityModel = [UniversityModel new];
    }else if (originalModel.userInfo.university.count == 1){
        self.firstUniversityModel = self.userInfoModel.university[0];
        self.secondUniversityModel = [UniversityModel new];
        self.thirdUniversityModel = [UniversityModel new];
        self.firstSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.firstUniversityModel];
    }else if (originalModel.userInfo.university.count == 2){
        self.firstUniversityModel = self.userInfoModel.university[0];
        self.secondUniversityModel = self.userInfoModel.university[1];
        self.thirdUniversityModel = [UniversityModel new];
        self.firstSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.firstUniversityModel];
        self.secondSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.secondUniversityModel];
    }else if (originalModel.userInfo.university.count == 3){
        self.firstUniversityModel = self.userInfoModel.university[0];
        self.secondUniversityModel = self.userInfoModel.university[1];
        self.thirdUniversityModel = self.userInfoModel.university[2];
        self.firstSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.firstUniversityModel];
        self.secondSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.secondUniversityModel];
        self.thirdSelectedModel = [self getSelectedUniversityModelWithUniversityID:self.thirdUniversityModel];
    }
}

-(MKUniversityModel *)getSelectedUniversityModelWithUniversityID:(UniversityModel *)university
{
    MKUniversityModel *resultUniversityModel;
    //找到大学
    for (MKUniversityModel *universityModel in self.originalModel.volunteerUniversityList) {
        if ([universityModel.universityID integerValue] == [university.university_id integerValue]) {
            resultUniversityModel = universityModel;
            break;
        }
    }
    //找到学部
    MKUniversityFacultyListModel *resultFacultyListModel;
    if (resultUniversityModel) {
        for (MKUniversityFacultyListModel *facultyListModel in resultUniversityModel.facultyList) {
            if ([facultyListModel.faculty_id integerValue] == [university.faculty_id integerValue]) {
                resultFacultyListModel = facultyListModel;
//                resultFacultyListModel.isSelected = YES;
                resultUniversityModel.selectedFacultyListModel = facultyListModel;
                break;
            }
        }
    }
    //找到学科
    if (resultFacultyListModel) {
        for (MKUniversityDisciplineListModel *disciplineListModel in resultFacultyListModel.disciplineList) {
            if ([disciplineListModel.faculty_id integerValue] == [university.discipline_id integerValue]) {
//                disciplineListModel.isSelected = YES;
                resultFacultyListModel.selectedDisciplineListModel = disciplineListModel;
                break;
            }
        }
    }
    return resultUniversityModel;
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
    if (indexPath.section == 0) {
        [cell cellUniversityRefreshDataWithUniversity:self.firstUniversityModel indexPath:indexPath];
    }else if (indexPath.section == 1){
        [cell cellUniversityRefreshDataWithUniversity:self.secondUniversityModel indexPath:indexPath];
    }else{
        [cell cellUniversityRefreshDataWithUniversity:self.thirdUniversityModel indexPath:indexPath];
    }
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
    return 40;
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
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    bgView.backgroundColor =K_BG_WhiteColor;
    
    UILabel  * label  =[[UILabel alloc]initWithFrame:CGRectMake(26, 15, KScreenWidth-52, 25)];
    [label setFont:MKFont(13) textColor:UIColorFromRGB_0x(0x707070) withBackGroundColor:[UIColor clearColor]];
    label.text =self.sectionArr [section];
    [bgView addSubview:label];
    return bgView;
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

-(void)UniversityClickWithIndexPath:(NSIndexPath *)indexPath schoolListVC:(SchoolListViewController *)schoolVC universityModel:(MKUniversityModel *)universityModel
{
    schoolVC.showType = indexPath.row;
    if (indexPath.row == 0) {
        schoolVC.universityList = self.originalModel.volunteerUniversityList;
    }else if (indexPath.row == 1){
        if (!universityModel) {
            [MBHUDManager showBriefAlert:@"请先选择学校！"];
            return;
        }
        schoolVC.facultyList = universityModel.facultyList;
    }else{
        if (!universityModel) {
            [MBHUDManager showBriefAlert:@"请先选择学校！"];
            return;
        }
        if (!universityModel.selectedFacultyListModel) {
            [MBHUDManager showBriefAlert:@"请先选择学部！"];
            return;
        }
        if (universityModel.selectedFacultyListModel.disciplineList.count == 0) {
            [MBHUDManager showBriefAlert:@"该学部暂无学科可供选择！"];
            return;
        }
        schoolVC.disciplineList = universityModel.selectedFacultyListModel.disciplineList;
    }
    [self.navigationController pushViewController:schoolVC animated:YES];
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolListViewController *schoolVC = [SchoolListViewController new];
    schoolVC.delegate = self;
    schoolVC.showType = indexPath.row;
    if (indexPath.section == 0) {
        [self UniversityClickWithIndexPath:indexPath schoolListVC:schoolVC universityModel:self.firstSelectedModel];
    }else if (indexPath.section == 1){
       [self UniversityClickWithIndexPath:indexPath schoolListVC:schoolVC universityModel:self.secondSelectedModel];
    }else if (indexPath.section == 2){
        [self UniversityClickWithIndexPath:indexPath schoolListVC:schoolVC universityModel:self.thirdSelectedModel];
    }
    @weakObject(self);
    schoolVC.schoolValueSelectedBlock = ^(NSInteger index, SchoolListViewShowType showType) {
      @strongObject(self);
        if (indexPath.section == 0) {//第一志愿
            [self universitySelectedHandleCallbackWithSchoolViewShowType:showType clickIndex:index cellSection:indexPath.section selectedUniversityModel:self.firstSelectedModel showUniversity:self.firstUniversityModel];
        }else if (indexPath.section == 1){
            [self universitySelectedHandleCallbackWithSchoolViewShowType:showType clickIndex:index cellSection:indexPath.section selectedUniversityModel:self.secondSelectedModel showUniversity:self.secondUniversityModel];
        }else{
            [self universitySelectedHandleCallbackWithSchoolViewShowType:showType clickIndex:index cellSection:indexPath.section selectedUniversityModel:self.thirdSelectedModel showUniversity:self.thirdUniversityModel];
        }
        [self.contentTable reloadData];
    };
}

-(void)universitySelectedHandleCallbackWithSchoolViewShowType:(SchoolListViewShowType )showType clickIndex:(NSInteger )index cellSection:(NSInteger )section selectedUniversityModel:(MKUniversityModel *)selectedUniversityModel  showUniversity:(UniversityModel *)showUniversityModel;

{
    if (showType == SchoolListViewShowTypeUniversity) {
        //重新选择学校后置为充实状态
    selectedUniversityModel.selectedFacultyListModel.selectedDisciplineListModel = nil;
        selectedUniversityModel.selectedFacultyListModel = nil;
        showUniversityModel.faculty_name = @"";
        showUniversityModel.faculty_id = @"";
        showUniversityModel.discipline_name = @"";
        showUniversityModel.discipline_id = @"";
        
        selectedUniversityModel = self.originalModel.volunteerUniversityList[index];
        //赋值
        if (section == 0) {
            self.firstSelectedModel = selectedUniversityModel;
        }else if (section == 1){
            self.secondSelectedModel = selectedUniversityModel;
        }else{
            self.thirdSelectedModel = selectedUniversityModel;
        }
        showUniversityModel.university_id = selectedUniversityModel.universityID;
        showUniversityModel.university_name = selectedUniversityModel.name;
    }else if (showType == SchoolListViewShowTypeFaculty){
        //重新选择学校后置为充实状态
        selectedUniversityModel.selectedFacultyListModel.selectedDisciplineListModel = nil;
        showUniversityModel.discipline_name = @"";
        showUniversityModel.discipline_id = @"";
        //赋值
        selectedUniversityModel.selectedFacultyListModel = selectedUniversityModel.facultyList[index];
        showUniversityModel.faculty_id = selectedUniversityModel.selectedFacultyListModel.faculty_id;
        showUniversityModel.faculty_name = selectedUniversityModel.selectedFacultyListModel.name;
    }else{
        selectedUniversityModel.selectedFacultyListModel.selectedDisciplineListModel = selectedUniversityModel.selectedFacultyListModel.disciplineList[index];;
        showUniversityModel.discipline_id = selectedUniversityModel.selectedFacultyListModel.selectedDisciplineListModel.discipline_id;
        showUniversityModel.discipline_name = selectedUniversityModel.selectedFacultyListModel.selectedDisciplineListModel.name;
    }
}

-(void)schoolListViewClickWithIndex:(NSInteger )index schoolListViewShowType:(SchoolListViewShowType )showType
{
    //nil
}

#pragma mark --  保存
-(void)submitHandleTarget:(UIButton *)sender
{
    if ([self.userInfoModel.university isEqualToArray:self.originalModel.userInfo.university]) {
        [MBHUDManager showBriefAlert:@"请修改后保存！"];
        return;
    }
    [MBHUDManager showLoading];
    [ValSchoolManager callBackUpdateValSchoolUniversity_id_1:self.firstUniversityModel.university_id faculty_id_1:self.firstUniversityModel.faculty_id discipline_id_1:self.firstUniversityModel.discipline_id university_id_2:self.secondUniversityModel.university_id faculty_id_2:self.secondUniversityModel.faculty_id discipline_id_2:self.secondUniversityModel.discipline_id university_id_3:self.thirdUniversityModel.university_id faculty_id_3:self.thirdUniversityModel.faculty_id discipline_id_3:self.thirdUniversityModel.discipline_id mobile:self.originalModel.userInfo.mobile completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
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

@end
