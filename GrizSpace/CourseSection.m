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

- (id)initWithCrn:(int)aCrn andSection:(int)aNumber 
       thatStarts:(NSString *)aStartTime 
          andEnds:(NSString *)aEndTime
               on:(int)aDays
{
    self = [super init];
    
    if (!self)
        return nil;
    
    self.crn = aCrn;
    self.number = aNumber;
    self.startTime = aStartTime;
    self.endTime = aEndTime;
    self.days = aDays;

    return self;
}

- (NSString *)getNumberString
{
    return [NSString stringWithFormat:@"%d", self.number];

}

// TODO: Clean this up with a hash, e.g., {[COND] => "MONDAY"}
- (NSString*)getDays
{
    NSString* dayStr = @"";
    int m = self.days & 1;
    int t = self.days & 2;
    int w = self.days & 4;
    int r = self.days & 8;
    int f = self.days & 16;
    int s = self.days & 32;
    int u = self.days & 64;

    if (m > 0)
        dayStr = [dayStr stringByAppendingString: @"M"];
    if (t > 0)
        dayStr = [dayStr stringByAppendingString: @"T"];
    if (w > 0)
        dayStr = [dayStr stringByAppendingString: @"W"];
    if (r > 0)
        dayStr = [dayStr stringByAppendingString: @"R"];
    if (f > 0)
        dayStr = [dayStr stringByAppendingString: @"F"];
    if (s > 0)
        dayStr = [dayStr stringByAppendingString: @"S"];
    if (u > 0)
        dayStr = [dayStr stringByAppendingString: @"U"];
    return dayStr;
}

@end
