//
//  BasicInfoCell.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BasicInfoCell.h"
#import "userInfo.h"
#import "UniversityModel.h"

@interface BasicInfoCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) userInfo *userInfoModel;

@end

@implementation BasicInfoCell

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6.0f;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contentTFValueChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
    [self.ttLabel setFont:MKFont(12) textColor:K_Text_BasicInforDeepGrayColor withBackGroundColor:nil];
}

 -(void)contentTFValueChange:(NSNotification *)noti
 {
     if (self.BasicInfoCellTFContentChangeBlock) {
         self.BasicInfoCellTFContentChangeBlock(self.textField.text, self.textField);
     }
     if (self.indexPath.section == 0) {
         if (self.indexPath.row == 0) {
             self.userInfoModel.lastname = self.textField.text;
         }else if (self.indexPath.row ==1){
             self.userInfoModel.firstname = self.textField.text;
         }
     }
     if (self.indexPath.section == 1) {
         if (self.indexPath.row == 0) {
             self.userInfoModel.lastkana = self.textField.text;
         }else if (self.indexPath.row ==1){
             self.userInfoModel.firstkana = self.textField.text;
         }
     }
     if (self.indexPath.section == 2) {
         if (self.indexPath.row == 0) {
             self.userInfoModel.mobile = self.textField.text;
         }else if (self.indexPath.row ==1){
             self.userInfoModel.mobile_jp = self.textField.text;
         }else if (self.indexPath.row ==2){
             self.userInfoModel.email = self.textField.text;
         }else if (self.indexPath.row ==3){
             self.userInfoModel.weixin = self.textField.text;
         }else if (self.indexPath.row ==4){
             self.userInfoModel.qq = self.textField.text;
         }else if (self.indexPath.row ==5){
             self.userInfoModel.city = self.textField.text;
         }
     }

 }


-(void)cellBasicInfoRefreshDataWithUserInfo:(userInfo *)userInfoModel indexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    self.userInfoModel = userInfoModel;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.textField.text = userInfoModel.lastname;
        }else if (indexPath.row ==1){
            self.textField.text = userInfoModel.firstname;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.textField.text = userInfoModel.lastkana;
        }else if (indexPath.row ==1){
            self.textField.text = userInfoModel.firstkana;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.textField.text = userInfoModel.mobile;
        }else if (indexPath.row ==1){
            self.textField.text = userInfoModel.mobile_jp;
        }else if (indexPath.row ==2){
            self.textField.text = userInfoModel.email;
        }else if (indexPath.row ==3){
            self.textField.text = userInfoModel.weixin;
        }else if (indexPath.row ==4){
            self.textField.text = userInfoModel.qq;
        }else if (indexPath.row ==5){
            self.textField.text = userInfoModel.city;
        }
    }
}

//志愿
-(void)cellUniversityRefreshDataWithUniversity:(UniversityModel *)universityModel indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.textField.text = universityModel.university_name;
    }else if (indexPath.row == 1){
        self.textField.text = universityModel.faculty_name;
    }else if (indexPath.row == 2){
        self.textField.text = universityModel.discipline_name;
    }
}
@end
