//
//  BuildingData.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Note: Class Building Annotation Info = CBAnnotationInfo

#import <Foundation/Foundation.h>

@interface CBAnnotationInfo : NSObject
{
    NSString* idBuilding;
    int idGPS;
    NSString* name;
    
    //testing vars to show class on map without complete structure.
    double longitude;
    double latitude;
    double radius;
}

//overloaded constructor.
- (id) initWithAnnotationInfo: (NSString*) tmpIDBuilding idGPS:(int) tmpIDGPS Name:(NSString*) tmpName latitude:(double) tmpLat longitude:(double) tmpLon radius:(double) tmpRad;


//Getters and setters for private vars.
@property (nonatomic, readwrite) NSString* idBuilding;
@property (nonatomic, readwrite) int idGPS;
@property (nonatomic, readwrite) NSString* name;

@property (nonatomic, readwrite) double longitude;
@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double radius;

@end