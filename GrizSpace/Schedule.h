//
//  Schedule.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseModel.h"
#import "CourseSection.h"

@interface Schedule : NSObject

- (id)initFromCourseList: (NSMutableArray*)aCourseList;
- (NSMutableArray*)toDayArray;

@property NSMutableArray* myCourses;
@end
