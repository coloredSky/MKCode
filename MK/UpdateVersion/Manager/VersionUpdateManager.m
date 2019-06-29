//
//  VersionUpdateManager.m
//  MK
//
//  Created by 周洋 on 2019/6/22.
//  Copyright © 2019 周洋. All rights reserved.
//

static  NSString * const MKUpdateVersionDateKey =  @"MKUpdateVersionDateKey";


#import "VersionUpdateManager.h"
#import "MKAlterView.h"
#import "BMPopView.h"

@implementation VersionUpdateModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (_content && _content.count > 0) {
        _messageContent  = [_content componentsJoinedByString:@"\n"];
    }else{
        _messageContent = @"更新到最新版本";
    }
    return YES;
}
@end

@interface VersionUpdateManager()<MKAlterViewDelegate>

@property (nonatomic, strong) NSDate *updateDate;

@end

@implementation VersionUpdateManager

-(void)checkUpXHBorrowAppVersionUpdateWhenFoundNewsVersion
{
    static BOOL isChecking = NO;
    static BOOL isCheckSuccess = NO;
    
    @synchronized (self) {
        if (isChecking || isCheckSuccess) {
            return;
        }
        isChecking = YES;
    }
    
    [[self class] callBackAppVersionUpdateWithCompletionBlock:^(BOOL isSuccess, VersionUpdateModel * _Nonnull versionModel, NSString * _Nonnull message) {
        if (isSuccess) {
            versionModel.force = @"0";
            isChecking = NO;
            isCheckSuccess = YES;
            [self goToCheckUpAppVersionComparamCurrentCheckTimeWithVersionModel:versionModel completionBlock:^{
                isCheckSuccess = NO;
            }];
        }else{
            isChecking = NO;
            isCheckSuccess = NO;
        }
    }];
}

-(void)goToCheckUpAppVersionComparamCurrentCheckTimeWithVersionModel:(VersionUpdateModel *)versionModel completionBlock:(dispatch_block_t)completionBlock
{
    if ([NSString isEmptyWithStr:versionModel.version] || [NSString isEmptyWithStr:versionModel.force] || [NSString isEmptyWithStr:versionModel.download_url]) {
        return;
    }
    if ([NSString compareVersion:versionModel.version] == 1) {//需要更新
        if ([versionModel.force integerValue] == 1) {
            //强制更新
            [self updateAlterViewShowWithUpdateModel:versionModel force:YES];
            if (completionBlock) {
                completionBlock();
            }
        }else{//不是强制更新
            //先比较时间、间隔一天再次提示
            NSDate *currentDate = [NSDate date];
            NSTimeInterval alertTimeOut = [currentDate timeIntervalSinceDate:self.updateDate];
            
//            if (alertTimeOut >= 60*60*24 || isnan(alertTimeOut)) {
                [self updateAlterViewShowWithUpdateModel:versionModel force:NO];
                if (completionBlock) {
                    completionBlock();
                }
//            }
        }
    }
}

-(void)updateAlterViewShowWithUpdateModel:(VersionUpdateModel *)updateModel  force:(BOOL )force
{
    self.updateDate = [NSDate date];
    MKAlterView *alterView = [MKAlterView alterViewWithTitle:@"提示" message:updateModel.messageContent delegate:self cancelButtonTitle:force ? nil : @"取消" otherButtonTitles:@"确定"];
    alterView.delegate = self;
    alterView.downloadUrl = updateModel.download_url;
    alterView.isForce = force;
    BMPopView *popView = [BMPopView shareInstance];
    [popView showWithContentView:alterView];
    popView.canDisMiss = !force;
}

-(void)MKAlterViewButtonClickWithAlterView:(MKAlterView *)alterView index:(NSInteger )index
{
    if (!alterView.isForce) {
        if (index == 0) {
            [[BMPopView shareInstance]dismiss];
            return;
        }
    }
    NSString * downloadUrl = alterView.downloadUrl;
    if (![NSString isEmptyWithStr:downloadUrl]) {
        //版本更新
        if (@available(iOS 10.0,*)){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:downloadUrl]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadUrl] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(false)} completionHandler:nil];
            }
        }else{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:downloadUrl]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadUrl]];
            }
        }
    }
}


-(NSDate *)updateDate
{
    NSDate *updateDate =  [[NSUserDefaults standardUserDefaults]objectForKey:MKUpdateVersionDateKey];
    return updateDate;
}

-(void)setUpdateDate:(NSDate *)updateDate
{
    @synchronized (self) {
        NSDate *date = [NSDate date];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:MKUpdateVersionDateKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


+(void)callBackAppVersionUpdateWithCompletionBlock:(void(^)(BOOL isSuccess,VersionUpdateModel *versionModel,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_APPVersionUpdate_url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                VersionUpdateModel *versionModel = [VersionUpdateModel yy_modelWithJSON:MKResult.dataResponseObject];
                completionBlock(YES, versionModel, MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

@end
