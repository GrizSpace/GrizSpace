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
               on: (int) days;


- (NSString*)getDays;

@property int crn;
@property int number;
@property NSString* startTime;
@property NSString* endTime;
@property int days;
@end
