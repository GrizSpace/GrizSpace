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
        NSString* sql = @"SELECT crn, number, start_time, end_time, days"
                        " FROM CourseSection"
                        " WHERE course_id = ?";
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:courseId]];

        while ([rs next]) {
            int crn = [rs intForColumn:@"crn"];
            int number = [rs intForColumn:@"number"];
            NSString* startTime = [rs stringForColumn:@"start_time"];
            NSString* endTime   = [rs stringForColumn:@"end_time"];
            int days = [rs intForColumn:@"days"];
            NSLog(@"YO DAWG \t\t %@", startTime);
            CourseSection* cs = [[CourseSection alloc] initWithCrn:crn
                                                        andSection:number
                                                        thatStarts:startTime
                                                           andEnds:endTime
                                                                on:days];
            [results addObject:cs];
        }
        return results;
    }];
}
@end
