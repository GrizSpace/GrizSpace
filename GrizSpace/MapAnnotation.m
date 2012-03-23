//
//  MapAnnotation.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12. 
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

#import "MapAnnotation.h"


@implementation MapAnnotation
@synthesize coordinate,title,subtitle, keyVal, annotationType, radius;



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
        //[self setCoordinate:CLLocationCoordinate2DMake(tmpBM.Longitude, tmpBM.Latitude)];
        [self setTitle: tmpBM.name];
        [self setSubtitle: tmpBM.idBuilding];  
        [self setRadius:tmpBM.Radius];
    }
    return self;
}



@end
