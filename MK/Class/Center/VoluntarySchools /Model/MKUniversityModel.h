//
//  MKUniversityModel.h
//  MK
//
//  Created by 周洋 on 2019/6/25.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



/**
 志愿大学的学部下的学科
 */
@interface MKUniversityDisciplineListModel : NSObject

@property (nonatomic, copy) NSString *discipline_id;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *faculty_id;
//@property (nonatomic, assign) BOOL isSelected;

@end

/**
 志愿大学的学部
 */
@interface MKUniversityFacultyListModel : NSObject

@property (nonatomic, copy) NSString *faculty_id;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *university_id;
//@property (nonatomic, assign) BOOL isSelected;
//@property (nonatomic, strong,nullable) MKUniversityDisciplineListModel *selectedDisciplineListModel;//选中的学科
//@property (nonatomic, strong) NSArray <MKUniversityDisciplineListModel *>*disciplineList;


@end


/**志愿大学*/
@interface MKUniversityModel : NSObject

@property (nonatomic, copy) NSString *universityID;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *zh_name;
//@property (nonatomic, copy) NSString *en_name;
//@property (nonatomic, strong , nullable) MKUniversityFacultyListModel *selectedFacultyListModel;//选中的学部
//@property (nonatomic, strong) NSArray <MKUniversityFacultyListModel *>*facultyList;

@end

NS_ASSUME_NONNULL_END
