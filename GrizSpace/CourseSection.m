//
//  CourseSection.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseSection.h"

@implementation CourseSection
@synthesize crn;
@synthesize number;
@synthesize startTime;
@synthesize endTime;
@synthesize days;
@synthesize longitude;
@synthesize latitude;
@synthesize building;
@synthesize room;
@synthesize courseTitle;
@synthesize subjectTitle;

- (id)initWithCrn:(int)aCrn
       andSection:(int)aNumber
       thatStarts:(NSString *)aStartTime 
          andEnds:(NSString *)aEndTime
               on:(int)aDays
       inBuilding:(NSString*) abuilding
           inRoom:(NSString*) aroom
      atLongitude:(double) alongitude
      andLatitude:(double) alatitude 
      andCourseTitle: (NSString*) acourseTitle
      andSubjectTitle: (NSString*) asubjectTitle
{
    self = [super init];
    
    if (!self)
        return nil;
    
    self.crn = aCrn;
    self.number = aNumber;
    self.startTime = aStartTime;
    self.endTime = aEndTime;
    self.days = aDays;
    self.room = aroom;
    self.building = abuilding;
    self.latitude = alatitude;
    self.longitude = alongitude;
    self.courseTitle = acourseTitle;
    self.subjectTitle = asubjectTitle;
    return self;
}

- (NSString*)getNumberString
{
    return [NSString stringWithFormat:@"%d", self.number];

}

// TODO: Clean this up with a hash, e.g., {[COND] => "MONDAY"}
- (NSString*)getDays
{
    NSString* dayStr = @"";

    if ([self isOnMonday])
        dayStr = [dayStr stringByAppendingString: @"M"];
    if ([self isOnTuesday])
        dayStr = [dayStr stringByAppendingString: @"T"];
    if ([self isOnWednesday])
        dayStr = [dayStr stringByAppendingString: @"W"];
    if ([self isOnThursday])
        dayStr = [dayStr stringByAppendingString: @"R"];
    if ([self isOnFriday])
        dayStr = [dayStr stringByAppendingString: @"F"];
    if ([self isOnSaturday])
        dayStr = [dayStr stringByAppendingString: @"S"];
    if ([self isOnSunday])
        dayStr = [dayStr stringByAppendingString: @"U"];
    return dayStr;
}

- (BOOL)isOnMonday    { return (self.days & 1)  > 0; }
- (BOOL)isOnTuesday   { return (self.days & 2)  > 0; }
- (BOOL)isOnWednesday { return (self.days & 4)  > 0; }
- (BOOL)isOnThursday  { return (self.days & 8)  > 0; }
- (BOOL)isOnFriday    { return (self.days & 16) > 0; }
- (BOOL)isOnSaturday  { return (self.days & 32) > 0; }
- (BOOL)isOnSunday    { return (self.days & 64) > 0; }

- (int)getOccurrences
{
    return [[self getDays] length];
}

@end
