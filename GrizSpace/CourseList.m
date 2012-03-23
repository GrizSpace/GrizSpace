//
//  CourseList.m
//  GrizSpace
//
//  Created by William Lyon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseList.h"

@implementation CourseList

-(NSMutableArray*) getCourseList // populate and return an array of CourseModel objects
                                // CURRENTLY JUST DUMMY VALUES, USED FOR TESTING, NOT PULLING FROM DB
{
    NSArray* subjects = [[NSArray alloc] initWithObjects:@"Economics", @"Computer Science", @"Mathematics", nil];
    
    NSArray* subjAbbrs = [[NSArray alloc] initWithObjects:@"ECON", @"CSCI", @"M", nil];
    
    NSArray* numbers = [[NSArray alloc] initWithObjects:@"311", @"576", @"225", nil];
    
    NSArray* titles = [[NSArray alloc] initWithObjects:@"Intermediate Microeconomics", @"Human Computer Interaction", @"Discrete Mathematics", nil];
    
    NSArray* days = [[NSArray alloc] initWithObjects:@"MWF", @"TTh", @"MWF", nil];
    
    NSArray* times = [[NSArray alloc] initWithObjects:@"8:10-9:00", @"12:10-1:30", @"11:10-12:00", nil];
    
    NSArray* buildingAndRooms= [[NSArray alloc] initWithObjects:@"GBB L09", @"LA 311", @"SS 362", nil];
    
    
    NSMutableArray* myCourses = [[NSMutableArray alloc] init ];
    CourseModel* tmpCourse = [[CourseModel alloc] init];
    for (int i=0;i<3;i++)
    {
        [tmpCourse setSubject:[subjects objectAtIndex:i]];
        [tmpCourse setSubjAbbr:[subjAbbrs objectAtIndex:i]];
        [tmpCourse setNumber:[numbers objectAtIndex:i]];
        [tmpCourse setTitle:[titles objectAtIndex:i]];
        [tmpCourse setDays:[days objectAtIndex:i]];
        [tmpCourse setTime:[times objectAtIndex:i]];
        [tmpCourse setBuildingAndRoom:[buildingAndRooms objectAtIndex:i]];
        
        [myCourses addObject:tmpCourse];
        
        
    }
    
    return myCourses;
}
@end


