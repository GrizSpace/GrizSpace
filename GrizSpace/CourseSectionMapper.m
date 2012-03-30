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

- (CourseSection*)getFirst
{
    [db open];

    NSString* sql = @"SELECT crn, number, start_time, end_time, days"
                    " FROM CourseSection"
                    " LIMIT 1";
    FMResultSet* rs = [db executeQuery:sql];

    while ([rs next]) {
        int crn = [rs intForColumn:@"crn"];
        int number = [rs intForColumn:@"number"];
        NSString* startTime = [rs stringForColumn:@"start_time"];
        NSString* endTime   = [rs stringForColumn:@"end_time"];
        int days = [rs intForColumn:@"days"];

        CourseSection* cs = [[CourseSection alloc] initWithCrn:crn
                                                    andSection:number
                                                    thatStarts:startTime
                                                       andEnds:endTime
                                                            on:days];
        return cs;
    }

    [db close];

    return nil;
}

@end
