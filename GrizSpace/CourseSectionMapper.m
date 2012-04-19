//
//  CourseSectionMapper.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseSectionMapper.h"

@implementation CourseSectionMapper

- (id)init
{
    self = [super init];
    if (!self)
        return nil;

    return self;
}

- (NSMutableArray*)findByCourseId: (int)courseId
{
    return [self query:^{
        NSMutableArray* results = [[NSMutableArray alloc] init];
       // NSString* sql = @"SELECT crn, number, start_time, end_time, days"
       //                 " FROM CourseSection"
       //                 " WHERE course_id = ?"
       //                 " ORDER BY number";
        
        NSString* sql = @"SELECT crn, CourseSection.number, start_time, end_time, days, Building.abbr AS building," 
                        " Classroom.room AS room, GPS.Latitude AS latitude, GPS.Longitude AS longitude,"
                        " Course.title as 'courseTitle', Subject.title as 'subjectTitle'" 
                        " FROM CourseSection"
                        " INNER JOIN Course ON Course.id = CourseSection.course_id"
                        " INNER JOIN Subject ON Course.subject_id = Subject.id"
                        " INNER JOIN Classroom ON CourseSection.classroom_id = Classroom.id"
                        " INNER JOIN Building ON Classroom.building_ID = Building.id"
                        " INNER JOIN GPS ON Building.gps_id = GPS.idGPS"
                        " WHERE course_id = ?"
                        " ORDER BY CourseSection.number";
        
        /*
         ****  ORIGINAL *****
        NSString* sql = @"SELECT crn, number, start_time, end_time, days, Building.abbr AS building, Classroom.room AS room, GPS.Latitude AS latitude, GPS.Longitude AS longitude"
        " FROM CourseSection"
        " INNER JOIN Classroom ON CourseSection.classroom_id = Classroom.id"
        " INNER JOIN Building ON Classroom.building_ID = Building.id"
        " INNER JOIN GPS ON Building.gps_id = GPS.idGPS"
        " WHERE course_id = ?"
        " ORDER BY number";
        */
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:courseId]];

        while ([rs next]) {
            int crn = [rs intForColumn:@"crn"];
            int number = [rs intForColumn:@"number"];
            NSString* startTime = [rs stringForColumn:@"start_time"];
            NSString* endTime   = [rs stringForColumn:@"end_time"];
            int days = [rs intForColumn:@"days"];
            double longitude = [rs doubleForColumn:@"longitude"];
            double latitude = [rs doubleForColumn:@"latitude"];
            NSString* building = [rs stringForColumn:@"building"];
            NSString* room = [rs stringForColumn:@"room"];
            NSString* coursetitle = [rs stringForColumn:@"courseTitle"];
            NSString* subjecttitle = [rs stringForColumn:@"subjectTitle"];
            
            NSLog(@"YO DAWG \t\t %@", startTime);
            CourseSection* cs = [[CourseSection alloc] initWithCrn:crn
                                                        andSection:number
                                                        thatStarts:startTime
                                                           andEnds:endTime
                                                                on:days
                                                        inBuilding:building
                                                            inRoom:room
                                                       atLongitude:longitude
                                                       andLatitude:latitude
                                                    andCourseTitle: coursetitle
                                                   andSubjectTitle: subjecttitle];
            [results addObject:cs];
        }
        return results;
    }];
}
@end
