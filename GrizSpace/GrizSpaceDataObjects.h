//
//  GrizSpaceDataObjects.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDataObject.h"
#import "CourseDetailVewController.h"
#import "MapViewController.h"
#import "GPSModel.h"
#import "CourseList.h"

@interface GrizSpaceDataObjects : AppDataObject
{
    //CourseList* myCourses;  
}
//procedure to get class data from the data objects.
@property (nonatomic, strong) NSMutableArray *buildings; //building list to select from
@property (nonatomic, strong) CourseList* myCourses; //the user courses in there list.
@property (nonatomic, strong) NSMutableArray *selectableCourses; //the selectable courses avaliable.
@property (nonatomic, strong) NSMutableArray *selectableSubjects; //the selectable subjects avaliable.

//-(NSMutableArray*) GetMyCourses;


@end
