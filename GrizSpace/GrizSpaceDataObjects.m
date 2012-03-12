//
//  GrizSpaceDataObjects.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrizSpaceDataObjects.h"
#import "ClassTable.h"
#import "CourseDetailVewController.h"
#import "GrizSpaceTabBarController.h"
#import "CourseListViewController.h"

@implementation GrizSpaceDataObjects

@synthesize mapClassTable, myCourseDetailViewController, myGrizSpaceTabBarController, myCourseListViewController;
//default constructor
-(id) init {
    
    if (self = [super init])
    {
        //create instance of the class table.
        mapClassTable = [[ClassTable alloc ] init];
        myCourseDetailViewController = [[CourseDetailVewController alloc] init];
        myGrizSpaceTabBarController = [[GrizSpaceTabBarController alloc] init];
        myCourseListViewController = [[CourseListViewController alloc] init];
    }
    return self;
    
}



@end
