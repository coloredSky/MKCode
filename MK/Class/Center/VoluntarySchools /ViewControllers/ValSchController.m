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
#import "university.h"

@interface ValSchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *sectionArr;//区头数组

@property(nonatomic,strong)userInfo * userInfoModel;
@property(nonatomic,strong)university * firstUniversityModel;
@property(nonatomic,strong)university * secondUniversityModel;
@property(nonatomic,strong)university * thirdUniversityModel;

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
    self.userInfoModel = [originalModel.userInfo copy];
    if (originalModel.userInfo.university.count <= 0) {
        self.firstUniversityModel = [university new];
        self.secondUniversityModel = [university new];
        self.thirdUniversityModel = [university new];
    }else if (originalModel.userInfo.university.count == 1){
        self.firstUniversityModel = originalModel.userInfo.university[0];
        self.secondUniversityModel = [university new];
        self.thirdUniversityModel = [university new];
    }else if (originalModel.userInfo.university.count == 2){
        self.firstUniversityModel = originalModel.userInfo.university[0];
        self.secondUniversityModel = originalModel.userInfo.university[1];
        self.thirdUniversityModel = [university new];
    }else if (originalModel.userInfo.university.count == 3){
        self.firstUniversityModel = originalModel.userInfo.university[0];
        self.secondUniversityModel = originalModel.userInfo.university[1];
        self.thirdUniversityModel = originalModel.userInfo.university[2];
    }
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
    return 43;
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
        [btn setNormalTitle:@"保存" font:MKFont(13) titleColor:K_Text_DeepGrayColor];
        btn.backgroundColor =UIColorFromRGB_0x(0xfdf303);
        btn.frame =CGRectMake(26, 55, KScreenWidth-52, 60);
        btn.layer.cornerRadius =5.f;
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
    schoolVC.originalModel = self.originalModel;
    schoolVC.showType = indexPath.row;
    @weakObject(self);
    schoolVC.schoolValueSelectedBlock = ^(NSInteger index, SchoolListViewShowType showType) {
      @strongObject(self);
        if (indexPath.section == 0) {//第一志愿
            if (showType == SchoolListViewShowTypeUniversity) {
                VolunteerUniversityList *universityModel = self.originalModel.volunteerUniversityList[index];
                self.firstUniversityModel.university_name = universityModel.name;
                self.firstUniversityModel.university_id = universityModel.universityID;
            }else if (showType == SchoolListViewShowTypeFaculty){
                
            }else{
                
            }
        }else if (indexPath.section == 1){
            
        }else{
            
        }
    };
    [self.navigationController pushViewController:schoolVC animated:YES];
    
//    VolunteerUniversityList *universityModel =  self.universityList[indexPath.row];
//    cell.contentLab.text = universityModel.name;
//}else if (self.showType == SchoolListViewShowTypeFaculty){
//    VolunteerFacultyList *facultyListModel =  self.facultyList[indexPath.row];
//    cell.contentLab.text = facultyListModel.name;
//}else{
//    VolunteerDisciplineList *disciplineModel =  self.disciplineList[indexPath.row];
//    cell.contentLab.text = disciplineModel.name;
}


//#pragma mark - modelDatasource
//-(void)createDataSource
//{
//    if (self.model.userInfo.university.count)
//    {
//        for (university * uni in self.model.userInfo.university) {
//            NSMutableArray * u =[NSMutableArray array];
//            [u  addObject:uni.university_name];
//            [u addObject:uni.faculty_name];
//            [u addObject:uni.discipline_name];
//           [ self.contentArr addObject:u];
//        }
//    }
//    if (self.contentArr.count>3) {
//        [self.contentArr removeObjectsInRange:NSMakeRange(3, self.contentArr.count-3)];
//    }
//    [self.contentTable reloadData];
//}



@end
