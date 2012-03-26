//
//  MapAnnotation.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "BuildingModel.h"
#import "GPSModel.h"

@interface MapAnnotation : NSObject  <MKAnnotation> 
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; //cordinate of annotation
@property (nonatomic, copy) NSString* title; //title of annotation
@property (nonatomic, copy) NSString* subtitle; //subtitle of annotation
@property (nonatomic, assign) int keyVal; //id of the annotation object type being displayed
@property (nonatomic, assign) NSString* annotationType; //tells the type of annotation building or class
@property (nonatomic, readwrite) int radius; //the radius of the object identified
@property (nonatomic, readwrite) bool arrived; //set to true when arrived at destination.


//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//overloaded constructor.
- (id) initWithAnnotationDataKeyID: (int) newKeyID annotationType: (NSString*) newAnnotationType coordinate: (CLLocationCoordinate2D) newCoordinate title: (NSString*) newTitle subtitle: (NSString*) newSubtitle radius: (int) newRadius;


- (id) initWithBuildingModel: (BuildingModel*) tmpBM; 


@end
