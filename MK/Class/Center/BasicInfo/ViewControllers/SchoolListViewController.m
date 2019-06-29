//
//  SchoolListViewController.m
//  MK
//
//  Created by 周洋 on 2019/6/23.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "SchoolListViewController.h"
#import "SchoolSelectedCell.h"

@interface SchoolListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;

@end

@implementation SchoolListViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_WhiteColor;
    [self.contentTable reloadData];
}

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [self.view addSubview:_contentTable];
        [_contentTable registerNib:[UINib nibWithNibName:@"SchoolSelectedCell" bundle:nil] forCellReuseIdentifier:@"SchoolSelectedCell"];
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolSelectedCell" forIndexPath:indexPath];
    if (self.showType == SchoolListViewShowTypeUniversity) {
        MKUniversityModel *universityModel = self.universityList[indexPath.row];
        cell.contentLab.text = universityModel.zh_name;
    }else if (self.showType == SchoolListViewShowTypeFaculty){
        MKUniversityFacultyListModel *facultyListModel =  self.facultyList[indexPath.row];
        cell.contentLab.text = facultyListModel.name;
    }else{
        MKUniversityDisciplineListModel *disciplineModel =  self.disciplineList[indexPath.row];
        cell.contentLab.text = disciplineModel.name;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showType == SchoolListViewShowTypeUniversity) {
        return self.universityList.count;
    }else if (self.showType == SchoolListViewShowTypeFaculty){
        return self.facultyList.count;
    }else{
       return self.disciplineList.count;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(45);
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

#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(schoolListViewClickWithIndex:schoolListViewShowType: )]) {
        [delegate schoolListViewClickWithIndex:indexPath.row schoolListViewShowType:self.showType];
    }
    if (self.schoolValueSelectedBlock) {
        self.schoolValueSelectedBlock(indexPath.row, self.showType);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
