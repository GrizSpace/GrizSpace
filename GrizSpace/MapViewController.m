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
#import "ClassData.h"
#import "ClassTable.h"
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
@synthesize myLocationManager;


- (GrizSpaceDataObjects*) theAppDataObject;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}
*/

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
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
    //myMapAnnotationSegmentControl.selectedSegmentIndex = 2;
    
    
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
    
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    
    //set how zoomed in we are.
    
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

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
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [mapView removeAnnotations:mapView.annotations];
    
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    //get teh class table
    ClassTable* tmpClassTable = [theDataObject mapClassTable];
    
    NSMutableArray* tmpClassDataArray = [tmpClassTable GetClassItems];
    
    
    //all classes
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){
        
        
        //MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
        
        //annotate all the classes on the map.
        for (ClassData* tmpCD in tmpClassDataArray) {
            
            CLLocationCoordinate2D theCoordinate1;
            theCoordinate1.latitude = [tmpCD latitude];
            theCoordinate1.longitude = [tmpCD longitude];
            
            //MKMapPoint annotationPoint = MKMapPointForCoordinate(theCoordinate1);
            //MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            
            //sets up the map annotation
            MapAnnotation* ann = [[MapAnnotation alloc] init];
            ann.title = [tmpCD className];
            ann.coordinate = theCoordinate1;
            ann.keyVal = [tmpCD classID];
            [mapView addAnnotation:ann];
            [mapView selectAnnotation:ann animated:YES];
            
            NSLog(@"Annotation set %@ Lon:%f Lat%f",tmpCD.className, theCoordinate1.latitude, theCoordinate1.longitude);
            //ensure all annotations are visible in window.
            /*
            if (MKMapRectIsNull(flyTo)) {
                flyTo = pointRect;
            } else {
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
            */
        }
        //mapView.visibleMapRect = flyTo;
        
        
        
    }
    
    //next class
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 1){

        //gets the next class from the class data table.
        ClassData* tmpNextClass = [tmpClassTable GetNextClass];
              
        //sets the cordinate for the annotation.
        CLLocationCoordinate2D theCoordinate1;
        theCoordinate1.latitude = [tmpNextClass latitude];
        theCoordinate1.longitude = [tmpNextClass longitude];
        
        //define rectangle for anotation point
        //MKMapPoint annotationPoint = MKMapPointForCoordinate(theCoordinate1);
        
        //MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        //mapView.visibleMapRect = pointRect;
        
        //sets up the map annotation
        MapAnnotation* ann = [[MapAnnotation alloc] init];
        ann.title = [tmpNextClass className];
        ann.coordinate = theCoordinate1;
        ann.keyVal = [tmpNextClass classID];
        
        [mapView addAnnotation:ann];
        [mapView selectAnnotation:ann animated:YES];
        
        //NSLog(@"Annotation set %@ Lon: %f Lat: %f",tmpNextClass.className, theCoordinate1.latitude, theCoordinate1.longitude);
        
        //clear then selection so next class can be pushed again.
        //myMapAnnotationSegmentControl.selectedSegmentIndex = 2;        
    }
    //ensures that no segment is selected.
    [myMapAnnotationSegmentControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
}


#define degreesToRadians(x) (M_PI * ((x) / 180.0))



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    //float dy = newLocation.coordinate.latitude - oldLocation.coordinate.latitude;
    //float dx = newLocation.coordinate.longitude - oldLocation.coordinate.longitude;
    
    float dy = oldLocation.coordinate.latitude - newLocation.coordinate.latitude;
    
    dy = dy * -1;  
    
    
    float dx = oldLocation.coordinate.longitude - newLocation.coordinate.longitude;
    
    
    float angle = atan2f(dy, dx);
    DirectionCompas.transform = CGAffineTransformMakeRotation(angle);    
    //NSLog(@"Direction: %f", angle);
    //NSLog(@"New Location: %@", newLocation);
    //NSLog(@"New Heading: %@", [myLocationManager heading]);
}



//simulates distance berring and speed based on location.gpx file
- (void) simulateDBS
{
    //CLHeading* tmpHeading = [[CLHeading alloc] init];
    
    //CLHeading* tmpHeading = [myLocationManager heading];
    //[tmpHeading set
    

}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation) return nil;
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"asdf"];
    
    MapAnnotation* tmpAnn = (MapAnnotation*) annotation;
    
    
    if (pin == nil)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: tmpAnn reuseIdentifier: @"asdf"];
    }
    else
    {
        pin.annotation = annotation;
    }
    
    UIButton *annotationButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //[annotationButton : UIButtonTypeDetailDisclosure];
    //UIButton *annotationButton = [[[UIButton buttonWithType:UIButtonTypeDetailDisclosure] alloc] init];
    
    [annotationButton setTag: tmpAnn.keyVal];
    
    [annotationButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    pin.rightCalloutAccessoryView = annotationButton;
    
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
    
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];

}





@end
