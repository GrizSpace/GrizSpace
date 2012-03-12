//
//  GrizSpaceDataObjects.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDataObject.h"
#import "ClassTable.h"
#import "CourseDetailVewController.h"
#import "GrizSpaceTabBarController.h"
#import "CourseListViewController.h"

@interface GrizSpaceDataObjects : AppDataObject
{
    ClassTable* mapClassTable;
    CourseDetailVewController* myCourseDetailViewController;
    GrizSpaceTabBarController* myGrizSpaceTabBarController;
    CourseListViewController* myCourseListViewController;
}


//procedure to get class data from the data objects.
@property (nonatomic, readwrite) ClassTable* mapClassTable;
@property (nonatomic, readwrite) CourseDetailVewController* myCourseDetailViewController;
@property (nonatomic, readwrite) GrizSpaceTabBarController* myGrizSpaceTabBarController;
@property (nonatomic, readwrite) CourseListViewController* myCourseListViewController;

@end
