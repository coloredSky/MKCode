//
//  XDSDropDownMenu.m
//  shts_ios_xds
//
//  Created by cdj on 2018/5/8.
//  Copyright © 2018年 itiis. All rights reserved.
//

#import "XDSDropDownMenu.h"
#import "XDSDropDownMenuCell.h"

@interface XDSDropDownMenu()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *menuTableView;
//@property(nonatomic, strong) UIView *btnSender;
@property(nonatomic) CGRect buttonFrame;
@property(nonatomic, retain) NSArray *titleList;
@property(nonatomic, retain) NSArray *imageList;
@end

@implementation XDSDropDownMenu
@synthesize delegate;

+(NSInteger)returnIndexByString:(NSString *)string fromArray:(NSArray *)array{  //返回选项下标
    NSUInteger index = [array indexOfObject:string];
    return index;
}

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

- (void)showDropDownMenu:(UIView *)tapView withTapViewFrame:(CGRect)tapViewFrame arrayOfTitle:(NSArray *)titleArr arrayOfImage:(NSArray *)imageArr animationDirection:(NSString *)direction
{
    
    self.backgroundColor = [UIColor whiteColor];
    self.isShow = YES;
    self.animationDirection = direction;
    self.buttonFrame = tapViewFrame;
    self.titleList = titleArr;
    
    CGRect btnRect = tapViewFrame;//按钮在视图上的位置
    CGFloat height = 0;//菜单高度
    if ( titleArr.count <= 4) {
        height = titleArr.count *40;
    }else{
        height = 160;
    }
    //菜单视图的起始大小和位置
    self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, 0);
//    [UIView animateWithDuration:.5 animations:^{
        self.frame =CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, height);
        self.menuTableView.frame = CGRectMake(0, 0, self.frame.size.width, height);
      [self.menuTableView reloadData];
//    }];
//    [UIView beginAnimations:nil context:nil];//动画
//    [UIView setAnimationDuration:0.5];
//    //菜单视图的最终大小和位置
//    if([direction isEqualToString:@"down"]) {
//        self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, height);
//    }
//    self.menuTableView.frame = CGRectMake(0, 0, self.frame.size.width, height);
//    [UIView commitAnimations];

}

-(UITableView *)menuTableView
{
    if (!_menuTableView) {
        _menuTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.buttonFrame.size.width, 0) style:UITableViewStyleGrouped];
//        _menuTableView.bounces = NO;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        [self addSubview:_menuTableView];
        _menuTableView.layer.cornerRadius = 5;
        _menuTableView.separatorColor = [UIColor clearColor];
        _menuTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = K_BG_blackColor;
        [_menuTableView registerNib:[UINib nibWithNibName:@"XDSDropDownMenuCell" bundle:nil] forCellReuseIdentifier:@"XDSDropDownMenuCell"];
        _menuTableView.sectionHeaderHeight = 0;
        _menuTableView.showsVerticalScrollIndicator = YES;
    }
    return _menuTableView;
}


-(void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame {
    
    self.isShow = NO;
    self.titleList = nil;
    [self.menuTableView reloadData];
//    [UIView animateWithDuration:.5 animations:^{
       self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height+2, 0, 0);
        self.menuTableView.frame = CGRectMake(0, 0, 0, 0);
//    }];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    if ([self.animationDirection isEqualToString:@"down"]) {
//        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height+2, self.buttonFrame.size.width, 0);
//        self.backgroundColor = [UIColor blueColor];
//    }
//    self.menuTableView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
//    self.menuTableView.backgroundColor = [UIColor redColor];
//    [UIView commitAnimations];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDSDropDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XDSDropDownMenuCell" forIndexPath:indexPath];
    cell.titleLab.text = [self.titleList objectAtIndex:indexPath.row];
    if (indexPath.row == self.titleList.count-1) {
        cell.lineIma.hidden = YES;
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDownMenuWithBtnFrame:self.buttonFrame];
    self.isShow = NO;
    if ([delegate respondsToSelector:@selector(dropDownMenu:didSelectedWithIndex:)]) {
        [delegate dropDownMenu:self didSelectedWithIndex:indexPath.row];
    }
}

- (void) myDelegate {
//    [self.delegate setDropDownDelegate:self];
}
-(void)dealloc {
    
}
@end
