//
//  GrizSpaceDataObjects.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrizSpaceDataObjects.h"
#import "DBAccess.h"
#import "CourseList.h"

@implementation GrizSpaceDataObjects 

@synthesize buildings;
@synthesize myCourses; 
@synthesize selectableCourses, selectableSubjects;

//default constructor
-(id) init {
    self = [super init];
    //myMapAnnotationList = [[MapAnnotationList alloc] init];
    buildings = [[NSMutableArray alloc] init];
 
    
     //sets up the buildings for reference.
     DBAccess *dbAccess = [[DBAccess alloc] init];
     self.buildings = [dbAccess.getAllBuildings mutableCopy];
     [dbAccess closeDatabase];
     
    //sets up the courses for reference.
    self.myCourses = [[CourseList alloc] init];
    //self.myCourses.myCourseItems = [myCourses getCourseListFromParse];
    
    //[self setMyCourses:[myCourses getCourseListFromParse]];
    //sets up the courses for reference.
    [dbAccess initializeDatabase];
    self.selectableCourses = [dbAccess.getAllCourses mutableCopy];
    [dbAccess closeDatabase];
    
    //sets up the subjects for reference.
    [dbAccess initializeDatabase];
    self.selectableSubjects = [dbAccess.getAllSubjects mutableCopy];
    [dbAccess closeDatabase];
    
    
    
    
    
    return self;
}

/*
-(NSMutableArray*) MyCourses
{
    CourseList* tmpCL = [[CourseList alloc] init];
    return [tmpCL getCourseListFromParse];
}
*/

@end
