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
@property(nonatomic, strong) UIView *btnSender;
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

- (void)showDropDownMenu:(UIView *)tapView withTapViewFrame:(CGRect)tapViewFrame arrayOfTitle:(NSArray *)titleArr arrayOfImage:(NSArray *)imageArr animationDirection:(NSString *)direction
{
    
    self.backgroundColor = [UIColor whiteColor];
    self.isShow = YES;
    self.animationDirection = direction;
    self.btnSender = tapView;
    self.menuTableView = (UITableView *)[super init];
    
    self.buttonFrame = tapViewFrame;
    if (self) {
        CGRect btnRect = tapViewFrame;//按钮在视图上的位置
        CGFloat height = 0;//菜单高度
        if ( titleArr.count <= 4) {
            height = titleArr.count *40;
        }else{
            height = 160;
        }
        
        self.titleList = [NSArray arrayWithArray:titleArr];
        self.imageList = [NSArray arrayWithArray:imageArr];
        
        //菜单视图的起始大小和位置
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y-2, btnRect.size.width, 0);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, 0);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0)];
        self.menuTableView.delegate = self;
        self.menuTableView.dataSource = self;
        self.menuTableView.layer.cornerRadius = 5;
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.menuTableView.separatorColor = [UIColor grayColor];
        self.menuTableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        self.menuTableView.backgroundColor = [UIColor whiteColor];
        [self.menuTableView registerNib:[UINib nibWithNibName:@"XDSDropDownMenuCell" bundle:nil] forCellReuseIdentifier:@"XDSDropDownMenuCell"];
        self.menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0.001)];//最后无分割线
        [self.menuTableView flashScrollIndicators];//显示滚动条
        
        [UIView beginAnimations:nil context:nil];//动画
        [UIView setAnimationDuration:0.5];
        //菜单视图的最终大小和位置
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y-height-2, btnRect.size.width, height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, height);
        }
        self.menuTableView.frame = CGRectMake(0, 0, btnRect.size.width, height);
        [UIView commitAnimations];
        [self addSubview:self.menuTableView];
    }

}


-(void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame {
    
//    CGRect btn = button.frame;
    self.isShow = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if ([self.animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y-2, btnFrame.size.width, 0);
    }else if ([self.animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height+2, btnFrame.size.width, 0);
    }
    self.menuTableView.frame = CGRectMake(0, 0, btnFrame.size.width, 0);
    [UIView commitAnimations];
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
    [cell cellRefreshDataWithContentString:[self.titleList objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDownMenuWithBtnFrame:self.buttonFrame];
    self.isShow = NO;
    [delegate XDSDropDownMenu:self didSelectedWithIndex:indexPath.row];
}
- (void) myDelegate {
//    [self.delegate setDropDownDelegate:self];
}
-(void)dealloc {
    
}
@end
