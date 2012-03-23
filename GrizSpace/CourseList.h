//
//  CourseList.h
//  GrizSpace
//
//  Created by William Lyon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseModel.h"

@interface CourseList : NSObject

-(NSMutableArray*) getCourseList; // return array of CourseModel objects => current Course List

@end
