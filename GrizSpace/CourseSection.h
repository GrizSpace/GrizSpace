//
//  CourseSection.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseSection : NSObject

- (id)initWithCrn: (int) crn andSection: (int) number 
       thatStarts: (NSString*) start_t andEnds: (NSString*) end_t
               on: (int) days
        inBuilding:(NSString*) building
           inRoom:(NSString*) room
      atLongitude:(double) longitude
      andLatitude:(double) latitude;

- (BOOL)isOnMonday;
- (BOOL)isOnTuesday;
- (BOOL)isOnWednesday;
- (BOOL)isOnThursday;
- (BOOL)isOnFriday;
- (BOOL)isOnSaturday;
- (BOOL)isOnSunday;

- (NSString*)getDays;

@property int crn; 
@property int number;
@property NSString* startTime;
@property NSString* endTime;
@property int days;
@property double longitude;
@property double latitude;
@property NSString* building;
@property NSString* room;

-(NSString*) getNumberString;

@end
