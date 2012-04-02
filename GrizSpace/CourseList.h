//
//  CourseList.h
//  GrizSpace
//
//  Created by William Lyon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "CourseModel.h"
#import "SubjectModel.h"


@interface CourseList : NSObject
{
    int currentCourseIndex; //the currently selected course index
}


@property (nonatomic, readwrite) NSMutableArray* myCourseItems; //gets the list of annotation items
-(CourseModel*) GetNextCourse; //gets the next course item
-(NSMutableArray*) getCourseList;


-(NSMutableArray*) getCourseListFromParse;  //used for TESTING ONLY
+(void) addCourse:(CourseModel*) courseToBeAdded inSubject:(SubjectModel*) subjToBeAdded;

+(void) removeCourse:(CourseModel*) courseToBeRemoved;


+(NSMutableArray*) getMyCourseList;


@end
