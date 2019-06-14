//
//  MKDropDownMenu.m
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

static CGFloat const MKDropDownMenuRowHeight = 40;

#import "MKDropDownMenu.h"
#import "DropDownCell.h"

@interface MKDropDownMenu()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) CGRect transViewFrame;
@property (nonatomic, strong) UITableView *menuTable;
@end

@implementation MKDropDownMenu
@synthesize delegate;

-(instancetype)init
{
    if (self = [super init]) {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void)showDropDownMenuWithViewFrame:(CGRect )tapViewFrame arrayOfTitle:(NSArray *)titleArr
{
    self.titleArr = titleArr;
    CGFloat height = 0;
    if (titleArr.count <= 3) {
        height = MKDropDownMenuRowHeight *titleArr.count;
    }else{
        height = MKDropDownMenuRowHeight *3;
    }
    self.transViewFrame = tapViewFrame;
    self.frame = CGRectMake(tapViewFrame.origin.x, tapViewFrame.origin.y+2, tapViewFrame.size.width, height);
//    self.menuTable.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.menuTable.frame = CGRectMake(0, 0, self.width, self.height);
}

-(UITableView *)menuTable
{
    if (!_menuTable) {
        _menuTable =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.transViewFrame.size.width, 0) style:UITableViewStyleGrouped];
        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        [self addSubview:_menuTable];
        _menuTable.layer.cornerRadius = 5;
        _menuTable.separatorColor = [UIColor clearColor];
        _menuTable.backgroundColor = [UIColor whiteColor];
        [_menuTable registerNib:[UINib nibWithNibName:@"DropDownCell" bundle:nil] forCellReuseIdentifier:@"DropDownCell"];
        _menuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.transViewFrame.size.width, 0.001)];//最后无分割线
    }
    return  _menuTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownCell" forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    [self hideDropDownMenu];
}

-(void)hideDropDownMenu{
    self.height = 0;
}

@end
