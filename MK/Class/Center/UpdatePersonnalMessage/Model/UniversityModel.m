//
//  UniversityModel.m
//  MK
//
//  Created by 周洋 on 2019/6/27.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "UniversityModel.h"

@interface UniversityModel()<NSCopying>
@end
@implementation UniversityModel

-(instancetype)init
{
    if (self = [super init]) {
        self.university_name = @"";
        self.university_id = @"";
        self.faculty_name = @"";
        self.faculty_id = @"";
        self.discipline_name = @"";
        self.discipline_id = @"";
        self.study_category = @"B";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    
    UniversityModel *universityModel = [[self class]allocWithZone:zone];
    universityModel.study_category = self.study_category;
    universityModel.university_id = self.university_id;
    universityModel.university_name = self.university_name;
    universityModel.faculty_name = self.faculty_name;
    universityModel.faculty_id = self.faculty_id;
    universityModel.discipline_id = self.discipline_id;
    universityModel.discipline_name = self.discipline_name;
    
    return universityModel;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[UniversityModel class]]) {
        return NO;
    }
    return [self isEqualToPerson:(UniversityModel *)object];
}

- (BOOL)isEqualToPerson:(UniversityModel *)person {
    if (!person) {
        return NO;
    }
    BOOL equalUniversity_name = [self.university_name isEqualToString:person.university_name];
    BOOL equalUniversity_id = [self.university_id isEqualToString:person.university_id];
    BOOL equalFaculty_name = [self.faculty_name isEqualToString:person.faculty_name];
    BOOL equalFaculty_id = [self.faculty_id isEqualToString:person.faculty_id];
    BOOL equalDiscipline_name = [self.discipline_name isEqualToString:person.discipline_name];
    BOOL equalDiscipline_id = [self.discipline_id isEqualToString:person.discipline_id];
    
    return equalUniversity_name && equalUniversity_id && equalFaculty_name && equalFaculty_id && equalDiscipline_name&& equalDiscipline_id;
}

@end
