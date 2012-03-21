//
//  GrizSpaceDataObjects.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrizSpaceDataObjects.h"
//#import "MapAnnotationList.h"
//#import "CourseDetailVewController.h"

@implementation GrizSpaceDataObjects

@synthesize myMapAnnotationList; 
//@synthesize myCourseDetailViewController;
//@synthesize myMapViewController;

//default constructor
-(id) init {
    self = [super init];
    myMapAnnotationList = [[MapAnnotationList alloc] init];
    //myCourseDetailViewController = [[CourseDetailVewController alloc] init];
    //myMapViewController = [[MapViewController alloc] init];
    return self;
}

@end
