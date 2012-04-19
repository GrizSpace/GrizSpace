//
//  MapAnnotation.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12. 
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

#import "MapAnnotation.h"

@interface MapAnnotation()

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

@end

@implementation MapAnnotation
@synthesize coordinate,subtitle, keyVal, annotationType, radius, arrived;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize title = _title;
@synthesize annObjectArray;
//overloaded constructor.
- (id) initWithAnnotationDataKeyID: (int) newKeyID annotationType: (NSString*) newAnnotationType coordinate: (CLLocationCoordinate2D) newCoordinate title: (NSString*) newTitle subtitle: (NSString*) newSubtitle radius: (int) newRadius;
{
    if (self = [super init])
    {
        [self setKeyVal:newKeyID];
        [self setAnnotationType:newAnnotationType];
        [self setCoordinate:newCoordinate];
        [self setTitle:newTitle];
        [self setSubtitle:newSubtitle];  
        [self setRadius:newRadius];
        [self setArrived:false]; 
        annObjectArray = [[NSMutableArray alloc] init];
        [annObjectArray addObject:self];
    }
    return self;
}



//default constructor
-(id) init {
    //call overloaded contructor to ensure initialization of data
    return [self initWithAnnotationDataKeyID:0 annotationType:@"" coordinate:CLLocationCoordinate2DMake(46.860917, -113.985968) title:@"" subtitle:@"" radius:100];
}


//overload constructor init with building model
- (id) initWithBuildingModel: (BuildingModel*) tmpBM
{
    if (self = [super init])
    {
        [self setKeyVal: tmpBM.buildingIndex];
        [self setAnnotationType: @"Building"];
        
        //should be Latitude then longitude.  Database data needs switched.
        [self setCoordinate:CLLocationCoordinate2DMake(tmpBM.Latitude, tmpBM.Longitude)];
        [self setTitle: tmpBM.name];
        [self setSubtitle: tmpBM.idBuilding];  
        [self setRadius:tmpBM.Radius];
        [self setArrived:false];
        annObjectArray = [[NSMutableArray alloc] init];
        [annObjectArray addObject:self];
    }
    return self;
}

-(id) initWithCourseModel: (CourseModel*) tmpCM
{
    if (self = [super init])
    {
        [self setKeyVal: tmpCM.index];
        [self setAnnotationType: @"myCourse"];
        
        //should be Latitude then longitude.  Database data needs switched.
        [self setCoordinate:CLLocationCoordinate2DMake(tmpCM.section.latitude, tmpCM.section.longitude)];
        [self setTitle: [NSString stringWithFormat: @"(%@) - %@", tmpCM.section.subjectTitle, tmpCM.section.courseTitle]];
        NSLog( @"subject course:%@ %@", tmpCM.section.subjectTitle, tmpCM.section.courseTitle);
        [self setSubtitle: tmpCM.buildingAndRoom];  
        [self setRadius:tmpCM.radius];
        [self setArrived:false];
        annObjectArray = [[NSMutableArray alloc] init];
        [annObjectArray addObject:self];
    }
    return self;  
}

-(id) initWithSearchCourseModel: (CourseModel*) tmpCM
{
    if (self = [super init])
    {
        [self setKeyVal: tmpCM.index];
        [self setAnnotationType: @"mySearchCourse"];
        
        //should be Latitude then longitude.  Database data needs switched.
        [self setCoordinate:CLLocationCoordinate2DMake(tmpCM.section.latitude, tmpCM.section.longitude)];
        [self setTitle: [NSString stringWithFormat: @"(%@) - %@", tmpCM.section.subjectTitle, tmpCM.section.courseTitle]];
        NSLog( @"subject course:%@ %@", tmpCM.section.subjectTitle, tmpCM.section.courseTitle);
        [self setSubtitle: tmpCM.buildingAndRoom];  
        [self setRadius:tmpCM.radius];
        [self setArrived:false];
        annObjectArray = [[NSMutableArray alloc] init];
        [annObjectArray addObject:self];
    }
    return self;  
}

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude {
	if (self = [super init]) {
		self.latitude = latitude;
		self.longitude = longitude;
        annObjectArray = [[NSMutableArray alloc] init];
        [annObjectArray addObject:self];
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinateReturn;
	coordinateReturn.latitude = self.latitude;
	coordinateReturn.longitude = self.longitude;
	return coordinateReturn;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
	self.latitude = newCoordinate.latitude;
	self.longitude = newCoordinate.longitude;
}


@end
