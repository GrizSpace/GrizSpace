//
//  MapViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GrizSpaceDataObjects.h"
#import "AppDelegateProtocol.h"
#import "MapAnnotationList.h"
#import "MapAnnotation.h"
#import "CourseDetailVewController.h"
#import "GrizSpaceTabBarController.h"

@interface MapViewController ()

@end

@implementation MapViewController


//retrieves the GrizeSpaceDataObjects for reference in the application
@synthesize myMapViewTypeSegmentControl;
@synthesize myMapAnnotationSegmentControl;
@synthesize myLocationCoordinate;
@synthesize DirectionCompas;
@synthesize distanceLabel;
@synthesize myLocationManager;


//calculation used to transfer degree measurnments to radians.
#define degreesToRadians(x) (M_PI * ((x) / 180.0))


- (GrizSpaceDataObjects*) theAppDataObject
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
}
 

//init the view conroller
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //reference the data objects in the class

    }
    return self;
}

//this handle gesture is the function call that gets called when double clicking on the map.
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    //id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    //theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint    toCoordinateFromView:mapView];
    
    NSString* messageString = [NSString stringWithFormat:@"Click Location %f : %f", touchMapCoordinate.longitude, touchMapCoordinate.latitude];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:messageString
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Ok", nil];
	[alert show];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    distanceLabel.hidden = true;
    
    //define the action for the double tap process on the map.
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self        action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 2;
    tgr.numberOfTouchesRequired = 1;
    [mapView addGestureRecognizer:tgr];
    
    
    //mapview setup
    [self.view insertSubview:mapView atIndex:0];
    mapView.showsUserLocation = true;
    mapView.delegate = self;
    mapView.zoomEnabled = true;
    mapView.scrollEnabled = true;
    mapView.userInteractionEnabled = true;
    mapView.mapType = MKMapTypeSatellite;
    
    //set the mapview segment selected index.
    myMapViewTypeSegmentControl.selectedSegmentIndex = 1;
    
    //clear map segment set by default
    [myMapAnnotationSegmentControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
    
    
    //location manager setup
    self.myLocationManager = [[CLLocationManager alloc] init];
    myLocationManager.delegate = self;
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    [myLocationManager startUpdatingLocation];
    [myLocationManager startUpdatingHeading];
    
    
    //testing pretend we are in this location and set the view to here.
    myLocationCoordinate.latitude = 46.860900;
    myLocationCoordinate.longitude = -113.985188;
    
    //location updated so center to that location.
    MKCoordinateRegion myRegion;
    //only set the default location one time.
    
    
    //set how zoomed in we are.
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    myRegion.span = mySpan;
    myRegion.center = myLocationCoordinate;
    [mapView setRegion:myRegion animated:true];  
    
    
}

- (void)viewDidUnload
{
    mapView = nil;
    myLocationManager = nil;
    myMapViewTypeSegmentControl = nil;
    myMapAnnotationSegmentControl = nil;
    [self setDirectionCompas:nil];
    [self setDistanceLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//default to Porterate orientation all the time
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//when a Map view is changed this gets called
- (IBAction)SegmentMapViewSelect:(id)sender {
    
    //map view choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 0){
        mapView.mapType = MKMapTypeStandard;
    }
    
    //satalite choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 1){
        mapView.mapType = MKMapTypeSatellite;
        
    }
    
    //hybred choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 2){
        mapView.mapType = MKMapTypeHybrid;
        
    }
}

//when a annotation option is selected, this gets called.
- (IBAction)SegmentAnnotationSelect:(id)sender {
    
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    distanceLabel.hidden = true;
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [mapView removeAnnotations:mapView.annotations];
    
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    
    //all classes
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){

        //get the annotation list 
        NSMutableArray* tmpAnnotationDataArray = theDataObject.myMapAnnotationList.myAnnotationItems;
        
        //not viewing a single class so don't update heading to a specific class
        theDataObject.myMapAnnotationList.currentAnnotationIndexSet = false;
        
        //annotate all the classes on the map.
        for (MapAnnotation* tmpMapAnn in tmpAnnotationDataArray) {

            MKMapPoint annotationPoint = MKMapPointForCoordinate(tmpMapAnn.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            
            //sets up the map annotation
            [mapView addAnnotation: tmpMapAnn];
            [mapView selectAnnotation: tmpMapAnn animated:YES];
            
            NSLog(@"Annotation set %@ Lon:%f Lat%f",tmpMapAnn.title, tmpMapAnn.coordinate.latitude, tmpMapAnn.coordinate.longitude);
            //ensure all annotations are visible in window.
            
            if (MKMapRectIsNull(flyTo)) {
                flyTo = pointRect;
            } else {
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
            
        }//end for
        
        //set the bounding rectangle for the map so all classes are visible.
        mapView.visibleMapRect = flyTo;   
    }
    
    //next class
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 1){

        theDataObject.myMapAnnotationList.currentAnnotationIndexSet = true;
        //gets the next class from the class data table.
        MapAnnotation* tmpNextAnnotation = [theDataObject.myMapAnnotationList GetNextAnnotation];
            
        //define anotation point for map.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(tmpNextAnnotation.coordinate);

        //place the annotation on the map.
        [mapView addAnnotation:tmpNextAnnotation];
        [mapView selectAnnotation:tmpNextAnnotation animated:YES];
      
        //define the bounding rectangle and set visible area.
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        flyTo = pointRect;
        
        annotationPoint = MKMapPointForCoordinate(myLocationCoordinate);
        pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
        
        mapView.visibleMapRect = flyTo;
        
        distanceLabel.hidden = false;
        
    }
    
    //clear map button event
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 2){
        theDataObject.myMapAnnotationList.currentAnnotationIndexSet = false;
    }
    
    
    //ensures that no segment is selected.
    [myMapAnnotationSegmentControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
     
     
}




//gets the distance from the current class location to the next annotation spot if a single annotation is selected.
-(double) CalculateDistance:(double) lon1 Lat1:(double) lat1
{
   
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    float d = 0;
    
     
      
    if(theDataObject.myMapAnnotationList.currentAnnotationIndexSet == true){
        
        MapAnnotation* tmpMapAnn = theDataObject.myMapAnnotationList.GetCurrentAnnotation;
        
        //((miles * feet * great circle) great arc distance formula.
        d = 3963.0 * 5280 * acos(sin(lat1/57.2958) * sin(tmpMapAnn.coordinate.latitude/57.2958) + cos(lat1/57.2958) * cos(tmpMapAnn.coordinate.latitude/57.2958) *  cos(tmpMapAnn.coordinate.longitude/57.2958 -lon1/57.2958));
        //ensure positive distance is returned
        if(d < 0)
        {
            d = d * -1;
        }        
    }
    
    distanceLabel.text = [NSString stringWithFormat:@"Distance %.1lf ft", d];
    
    
    
    return d;
     
}



//fires every time the locatioin manager is updated.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    MapAnnotation* tmpMapAnn = theDataObject.myMapAnnotationList.GetCurrentAnnotation;
    
    myLocationCoordinate.latitude = newLocation.coordinate.latitude;
    myLocationCoordinate.longitude = newLocation.coordinate.longitude;
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    
    float dy = oldLocation.coordinate.latitude - newLocation.coordinate.latitude;
    
    //if navigating to class set heading to the class
    if(theDataObject.myMapAnnotationList.currentAnnotationIndexSet == true){
        dy = newLocation.coordinate.latitude - tmpMapAnn.coordinate.latitude;
    }
    
    dy = dy * -1;  
    
    
    float dx = oldLocation.coordinate.longitude - newLocation.coordinate.longitude;
    
    //if navigating to class set heading to the class
    if(theDataObject.myMapAnnotationList.currentAnnotationIndexSet == true){
        dx = newLocation.coordinate.longitude - tmpMapAnn.coordinate.longitude;
    }
    
    float angle = atan2f(dy, dx);
    DirectionCompas.transform = CGAffineTransformMakeRotation(angle);    
    
    //if navigating to a class make sure both person and class are in map window.
    if(theDataObject.myMapAnnotationList.currentAnnotationIndexSet == true){
        [self CalculateDistance:newLocation.coordinate.longitude Lat1:newLocation.coordinate.latitude];
        
        //define the bounding rectangle and set visible area.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(newLocation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        flyTo = mapView.visibleMapRect;
        
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
        
        mapView.visibleMapRect = flyTo;
    }   
     
}

//creates the annotation display for the annoation that is being added to the map.
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    //if the annotation is the users location than return nil
    if (annotation == mapView.userLocation) return nil;

    //cast the annotation object to get more atributes about it.
    MapAnnotation* tmpAnn = (MapAnnotation*) annotation;
    
    
    //define the annotation pin
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"asdf"];
    
    //ensure the annotation pin is correctly defined.
    if (pin == nil)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: tmpAnn reuseIdentifier: @"asdf"];
    }
    else
    {
        pin.annotation = annotation;
    }
    
    //define the annotation button type to add to the annotation.
    UIButton *annotationButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    //set the identifying atribute to the annotation
    [annotationButton setTag: tmpAnn.keyVal];
    
    //add an event to the button
    [annotationButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //define the button on the pin annotation
    pin.rightCalloutAccessoryView = annotationButton;
    
    //set pin atributes.
    pin.pinColor = MKPinAnnotationColorRed;
    pin.animatesDrop = YES;
    [pin setEnabled:YES];
    [pin setCanShowCallout:YES];
    return pin;
}

//action for annotation object click event.
-(void) buttonClicked:(UIButton*) button
{

    NSLog(@"Button %ld clicked.", (long int)[button tag]);
    
    //get the app data from teh griz space data objects ref.
    //GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    //erform action for annotation.
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];
}






@end
