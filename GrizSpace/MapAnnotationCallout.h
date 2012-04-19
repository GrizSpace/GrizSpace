//
//  MapAnnotationCallout.h
//  GrizSpace
//
//  Created by Kevin Scott on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@interface MapAnnotationCallout : MapAnnotation

- (id) initWithMapAnnotation: (MapAnnotation*) newMapAnnotation;
-(void) setMapAnnotation: (MapAnnotation*) newMapAnnotation;
@end
