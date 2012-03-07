//
//  MapViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> 
{
    __weak IBOutlet MKMapView *mapView;

    CLLocationManager *myLocationManager; //used for updating the movment of my ocation
    CLLocationCoordinate2D myLocationCoordinate; //used for storing 2d location cordinates.
    
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *myMapViewTypeSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myMapAnnotationSegmentControl;

@property (nonatomic, retain) CLLocationManager *myLocationManager; 
@property (nonatomic, readonly) CLLocationCoordinate2D myLocationCoordinate; 
@property (weak, nonatomic) IBOutlet UIImageView *DirectionCompas;

@end
