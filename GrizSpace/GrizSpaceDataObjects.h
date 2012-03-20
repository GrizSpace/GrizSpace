//
//  GrizSpaceDataObjects.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDataObject.h"
#import "MapAnnotationList.h"
#import "CourseDetailVewController.h"

@interface GrizSpaceDataObjects : AppDataObject

//procedure to get class data from the data objects.
@property (nonatomic, readwrite) MapAnnotationList* myMapAnnotationList;
@property (nonatomic, readwrite) CourseDetailVewController* myCourseDetailViewController;



@end
