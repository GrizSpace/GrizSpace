//
//  MapAnnotation.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MKAnnotation.h>
@interface MapAnnotation : NSObject  <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    int keyVal;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) int keyVal;
@end
