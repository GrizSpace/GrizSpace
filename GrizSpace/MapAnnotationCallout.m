//
//  MapAnnotationCallout.m
//  GrizSpace
//
//  Created by Kevin Scott on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotationCallout.h"

@implementation MapAnnotationCallout
- (id) initWithMapAnnotation: (MapAnnotation*) newMapAnnotation
{
    if(self = [super init])
    {
        [self setMapAnnotation:newMapAnnotation];
        
    }
    return self;
}

- (void) setMapAnnotation: (MapAnnotation*) newMapAnnotation
{
    self.coordinate = newMapAnnotation.coordinate;
    self.title = newMapAnnotation.title;
    self.subtitle = newMapAnnotation.subtitle;
    self.keyVal = newMapAnnotation.keyVal;
    self.arrived = false;
    self.annotationType = newMapAnnotation.annotationType;
    self.annObjectArray = newMapAnnotation.annObjectArray;
}

@end
