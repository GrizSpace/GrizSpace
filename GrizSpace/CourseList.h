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
{
    int currentCourseIndex; //the currently selected course index
}

@property (nonatomic, readwrite) NSMutableArray* myCourseItems; //gets the list of annotation items
-(CourseModel*) GetNextCourse; //gets the next course item

@end
