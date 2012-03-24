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

//used to store global information.
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

    }
    return self;
}

/*
***************
 Jester Regognition could be future functionality aka double tap map
 **************
//this handle gesture is the function call that gets called when double clicking on the map.
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
*/

- (void)viewDidLoad 
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    distanceLabel.hidden = true;
    
    
    //define the action for the double tap process on the map.
    /*
     ***************
     Jester Regognition could be future functionality aka double tap map
     **************
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self        action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 2;
    tgr.numberOfTouchesRequired = 1;
    [mapView addGestureRecognizer:tgr];
    */
    
    
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

    
    //set how zoomed in we are.
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    myRegion.span = mySpan;
    myRegion.center = myLocationCoordinate;
    [mapView setRegion:myRegion animated:true];  
    
    //segment annotation select action
    [self SegmentAnnotationSelect: nil];
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
    
    //add the current location to the map fly to area.
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    MKMapPoint annotationPoint = MKMapPointForCoordinate(myLocationCoordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
 
    //all classes
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){

        //get the annotation list 
        NSMutableArray* tmpAnnotationDataArray = theDataObject.myMapAnnotationList.myAnnotationItems;


        
        //annotate all the classes on the map.
        for (MapAnnotation* tmpMapAnn in tmpAnnotationDataArray) {

            annotationPoint = MKMapPointForCoordinate(tmpMapAnn.coordinate);
            pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            
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

        //gets the next class from the class data table.
        MapAnnotation* tmpNextAnnotation = [theDataObject.myMapAnnotationList GetNextAnnotation];
            
        //define anotation point for map.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(tmpNextAnnotation.coordinate);

        //place the annotation on the map.
        [mapView addAnnotation:tmpNextAnnotation];
        [mapView selectAnnotation:tmpNextAnnotation animated:YES];
      
        //define the bounding rectangle and set visible area to include annotation point.
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
        
        //show the distance label
        distanceLabel.hidden = false;
    }
    
    //clear map button event
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 2){
        //theDataObject.myMapAnnotationList.currentAnnotationIndexSet = false;
    }
    else {
        //focus map to fly to area only if an annotation point is set.
        mapView.visibleMapRect = flyTo;
    }
    
    //ensures that no segment is selected.
    [myMapAnnotationSegmentControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
}




//gets the distance from the current class location to the next annotation spot if a single annotation is selected.
-(double) CalculateDistance:(double) lon1 Lat1:(double) lat1 Lon2:(double) lon2 Lat2: (double) lat2
{

    float d = 0;

    //((miles * feet * great circle) great arc distance formula.
    d = 3963.0 * 5280 * acos(sin(lat1/57.2958) * sin(lat2/57.2958) + cos(lat1/57.2958) * cos(lat2/57.2958) *  cos(lon2/57.2958 -lon1/57.2958));
    
    //ensure positive distance is returned
    if(d < 0)
    {
        d = d * -1;
    }        

    return d;
}



//fires every time the locatioin manager is updated.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    myLocationCoordinate.latitude = newLocation.coordinate.latitude;
    myLocationCoordinate.longitude = newLocation.coordinate.longitude;
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    
    
    //identify the destinate annotation.
    CLLocation* destCord = newLocation;
    CLLocation* startCord = oldLocation;
    if(mapView.annotations.count == 2){    
        for(id<MKAnnotation> annotation in mapView.annotations)
        {
            if(annotation != mapView.userLocation)
            {
                startCord = newLocation;
                destCord = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
                
                //sets the distance label text.
                double distance = [self CalculateDistance:startCord.coordinate.longitude Lat1:startCord.coordinate.latitude Lon2: destCord.coordinate.longitude Lat2:destCord.coordinate.latitude];
                distanceLabel.text = [NSString stringWithFormat:@"Distance %.1lf ft", distance];
        
                //check if the user has arrived
                if([(MapAnnotation*)annotation arrived] == false)
                {
                    if ([annotation isKindOfClass:[MapAnnotation class]])
                    {
                        if(distance <= [(MapAnnotation*)annotation radius])
                        {
                            [(MapAnnotation*)annotation setArrived:true];
                            NSString* messageString = [[NSString alloc] initWithString:@"You have arrived at your at your location!  Now get to class :-)."];
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Destination Reached" message:messageString
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        }
                    }
                }
                
            }
            
        }
    }
    

    float dy = startCord.coordinate.latitude - destCord.coordinate.latitude;    
    float dx = startCord.coordinate.longitude - destCord.coordinate.longitude;
    dy = dy * -1;
    float angle = atan2f(dy, dx);
    DirectionCompas.transform = CGAffineTransformMakeRotation(angle);    
    
    
    //if navigating to a class make sure both person and class are in map window.
    if(mapView.annotations.count == 2){
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
    
    //only one annotation, center map here as this is usually the users location
    if(mapView.annotations.count == 1)
    {
        //location updated so center to that location.
        MKCoordinateRegion myRegion;
        
        
        //set how zoomed in we are.
        MKCoordinateSpan mySpan;
        mySpan.latitudeDelta = 0.006;
        mySpan.longitudeDelta = 0.006;
        myRegion.span = mySpan;
        myRegion.center = myLocationCoordinate;
        [mapView setRegion:myRegion animated:true];  
    } 
}

//creates the annotation display for the annoation that is being added to the map.
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    //if the annotation is the users location than return nil
    if (annotation == mapView.userLocation) return nil;

    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        
        //define the annotation pin
        MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"mapPin"];
    
        //ensure the annotation pin is correctly defined.
        if (pin == nil)
        {
            pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"mapPin"];
        }
        else
        {
            pin.annotation = annotation;
        }
    
        //Only show button for Classes
        if(([(MapAnnotation*)annotation annotationType] == @"Class"))
        {
            //define the annotation button type to add to the annotation.
            UIButton *annotationButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

            //set the identifying atribute to the annotation
            [annotationButton setTag: [(MapAnnotation*)annotation keyVal]];
            
            //add an event to the button
            [annotationButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
            //define the button on the pin annotation
            pin.rightCalloutAccessoryView = annotationButton;
            
        }
        else {
            pin.rightCalloutAccessoryView = nil;
        }
        //set pin atributes.
        pin.pinColor = MKPinAnnotationColorRed;
        pin.animatesDrop = YES;
        [pin setEnabled:YES];
        [pin setCanShowCallout:YES];
        return pin;
        
    }
    return nil;
}

//action for annotation object click event.
-(void) buttonClicked:(UIButton*) button
{

    NSLog(@"Button %ld clicked.", (long int)[button tag]);
    annotationButtonActionTag = (long int)[button tag];
    
    //get the app data from teh griz space data objects ref.
    //GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    //erform action for annotation.
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];
    
    //override prepare for segway function.  Use segway identifier.
    //-(void)prepareForSegue:(UStoryboardSeque)
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    /*
    if ([[segue identifier] isEqualToString:@"MapToCourseDetail"])
    {
        // Get reference to the destination view controller
        //CourseDetailVewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
     */
}

//function used to show all annotations on the map.
-(void)setAnnotationsSegmentIndex: (int) newSegmentIndex
{
    myMapAnnotationSegmentControl.selectedSegmentIndex = newSegmentIndex;
    [self SegmentAnnotationSelect: nil];
}

//function used to show all annotations on the map.
-(void)showBuildingAnnotation: (int) newBuildingIndex
{

    BuildingModel* newBuilding = [[self theAppDataObject].buildings objectAtIndex:newBuildingIndex];
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [mapView removeAnnotations:mapView.annotations];
    
    tmpAnn = [[MapAnnotation alloc] initWithBuildingModel:newBuilding];
    
    //add the current location to the map fly to area.
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    MKMapPoint annotationPoint = MKMapPointForCoordinate(myLocationCoordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
    
    //define anotation point for map.
    annotationPoint = MKMapPointForCoordinate(tmpAnn.coordinate);
    
    //place the annotation on the map.
    [mapView addAnnotation:tmpAnn];
    [mapView selectAnnotation:tmpAnn animated:YES];

    //define the bounding rectangle and set visible area to include annotation point.
    pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
    
    
    //set visible rectngle
    mapView.visibleMapRect = flyTo;
    
    //show the distance label
    distanceLabel.hidden = false;
}




@end
