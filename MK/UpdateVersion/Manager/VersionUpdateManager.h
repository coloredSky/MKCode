//
//  VersionUpdateManager.h
//  MK
//
//  Created by 周洋 on 2019/6/22.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateModel : NSObject

@property (nonatomic, copy) NSString *version;//版本号
@property (nonatomic, copy) NSString *is_update;//是否更新
@property (nonatomic, copy) NSString *force;//是否强制更新
@property (nonatomic, strong) NSArray <NSString *>*content;//更新内容
@property (nonatomic, copy) NSString *time;//更新时间
@property (nonatomic, copy) NSString *download_url;//地址

@end

@interface VersionUpdateManager : NSObject

+(void)callBackAppVersionUpdateWithCompletionBlock:(void(^)(BOOL isSuccess,VersionUpdateModel *versionModel,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
