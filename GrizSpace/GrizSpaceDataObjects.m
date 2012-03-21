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

@synthesize myMapAnnotationList, buildings, gpsPoints;

//default constructor
-(id) init {
    self = [super init];
    myMapAnnotationList = [[MapAnnotationList alloc] init];
    buildings = [[NSMutableArray alloc] init];
    gpsPoints = [[NSMutableArray alloc] init];
    return self;
}


//gets a gps cordinate from the list of points
-(GPSModel*) GetGPSModelFromGPSPointsID: (NSInteger) tmpPointID
{
    return [GPSModel FindGPSModelFromList:gpsPoints idGPS:tmpPointID];
    
}

@end
