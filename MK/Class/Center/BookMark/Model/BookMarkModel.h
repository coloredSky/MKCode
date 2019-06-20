//
//  BookMarkModel.h
//  MK
//
//  Created by 周洋 on 2019/6/20.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookMarkListModel : NSObject
@property (nonatomic, copy) NSString *course_id;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *course_Image;

@end

@interface BookMarkModel : NSObject

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) BOOL isOnline;
@property (nonatomic, assign) BOOL isSpread;//是否h展开
@property (nonatomic, strong) NSArray< BookMarkListModel *> *bookMarkList;

@end

NS_ASSUME_NONNULL_END
