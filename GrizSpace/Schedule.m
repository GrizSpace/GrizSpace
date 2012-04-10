//
//  Schedule.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize myCourses;

- (id)initFromCourseList:(NSMutableArray *)aCourseList
{
    self = [super init];
    if (!self)
        return nil;

    myCourses = aCourseList;

    return self;
}

- (NSMutableArray*)toDayArray
{
    NSMutableArray *mondayArray = [NSMutableArray array];
    NSMutableArray *tuesdayArray = [NSMutableArray array];
    NSMutableArray *wednesdayArray = [NSMutableArray array];
    NSMutableArray *thursdayArray = [NSMutableArray array];
    NSMutableArray *fridayArray = [NSMutableArray array];

    for (int i = 0; i < [myCourses count]; i++) {
        CourseModel* tmpCourse = [myCourses objectAtIndex:i];
        CourseSection* sect    = tmpCourse.section;
        if ([sect isOnMonday])
            [mondayArray addObject:tmpCourse];
        if ([sect isOnTuesday])
            [tuesdayArray addObject:tmpCourse];
        if ([sect isOnWednesday])
            [wednesdayArray addObject:tmpCourse];
        if ([sect isOnThursday])
            [thursdayArray addObject:tmpCourse];
        if ([sect isOnFriday])
            [fridayArray addObject:tmpCourse];
    }

    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    [tmpArray addObject:mondayArray];
    [tmpArray addObject:tuesdayArray];
    [tmpArray addObject:wednesdayArray];
    [tmpArray addObject:thursdayArray];
    [tmpArray addObject:fridayArray];

    return tmpArray;
}

@end
