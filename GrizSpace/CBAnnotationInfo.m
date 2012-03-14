//
//  BuildingData.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBAnnotationInfo.h"

@implementation CBAnnotationInfo

@synthesize idBuilding, idGPS, name, latitude, longitude, radius;

//overloaded constructor.
- (id) initWithAnnotationInfo:(NSString *)tmpIDBuilding idGPS:(int)tmpIDGPS Name:(NSString *)tmpName latitude:(double)tmpLat longitude:(double)tmpLon radius:(double)tmpRad
{
    if (self = [super init])
    {
        [self setIdBuilding:tmpIDBuilding];
        [self setIdGPS:tmpIDGPS];
        [self setName:tmpName];

        [self setLongitude:tmpLon];
        [self setLatitude:tmpLat];
        [self setRadius:tmpRad];
    }
    return self;
}

//default constructor
-(id) init {
    //call overloaded contructor to ensure initialization of data
    return [self initWithAnnotationInfo:@"" idGPS:0 Name:@"" latitude:0 longitude:0 radius:0];
}


@end
