//
//  CourseListViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// TODO: pull out Parse calls - should not happen in this class [CourseList removeCourse:course]

#import "CourseListViewController.h"
#import "MapViewController.h"

@interface CourseListViewController ()

@end

@implementation CourseListViewController
@synthesize courses = _courses;
@synthesize dayTimes = _dayTimes;
@synthesize delegate;
@synthesize courseDelegate;

@synthesize myCourses;

-(void) setCourses:(NSArray *)courses
{
    _courses = courses;
}

-(void) setDayTimes:(NSArray *)dayTimes
{
    _dayTimes = dayTimes;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
   // NSArray *myCourses = [NSArray arrayWithObjects:@"ECON 513", @"ECON 511", @"CSCI 491", @"CSCI 576", @"ECON 591", @"ECON 221", nil];
    
   // NSArray *myDayTimes = [NSArray arrayWithObjects:@"MWF   10:10-11:00   LA 411", @"MWF   3:10-4:00   SS402", @"MWF   8:10-9:00     SS 362", @"MWF  9:10-10:00   SS 355", @"TTh     12:40-2:00      LA 411", @"TTh  3:10-4:30   SS 341",nil];
    
   CourseList* myCourseListObject = [[CourseList alloc] init];
   [self setMyCourses:[myCourseListObject getCourseListFromParse]];
    
    [self.tableView reloadData];
   // PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
  //  [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
   // NSArray* scoreArray = [query findObjects]; 
     
    //PFQuery *query = [PFQuery queryWithClassName:@"CourseModel"];
    
    
    
    //[self setMyCourses:[query findObjects]];
    
    //NSArray* PFObjArray = [query findObjects];
    
    //PFObject *myPFCourse = [query getObjectWithId:@"Ag4p0stEA3"];
    
    //NSString* myPFCourseNumber = [myPFCourse objectForKey:@"number"];
    
    //NSLog(@"PFCourseNumber: %@", myPFCourseNumber);
    
    
    //int score = [[gameScore objectForKey:@"score"] intValue];
    
    
    
    //NSLog(@"MyCourses number: %d", [self.myCourses count]);
    
    //[self setDayTimes:myDayTimes];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Size of myCourses array: %d", [self.myCourses count]);
    
    return [self.myCourses count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Course";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.myCourses objectAtIndex:indexPath.row] getSubject];
    
    
    cell.detailTextLabel.text = [[self.myCourses objectAtIndex:indexPath.row] getNumber];
    
    NSLog(@"Parse ObjectID: %@", [[self.myCourses objectAtIndex:indexPath.row] getParseObjectID]);
          
    return cell;
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
      //  [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    
        
      /*  PFQuery* query = [PFQuery queryWithClassName:@"CourseModel"];
        NSString* objectID = [[myCourses objectAtIndex:indexPath.row] getParseObjectID];
        PFObject *courseToDelete = [query getObjectWithId:objectID];
        [courseToDelete delete];
    */
        
        [CourseList removeCourse: [myCourses objectAtIndex:indexPath.row]];
         
        [self viewDidLoad];
        [tableView reloadData];
                                    
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//button action for viewing all the classes on the map.
- (IBAction)ViewAllClassesOnMap:(id)sender {

    //sets the correct tab index
    [self.tabBarController setSelectedIndex:0];

    //get handle for nav controller
    UINavigationController *tmpNC = [self.tabBarController.viewControllers objectAtIndex:0];
    
    //get handle for map view controller
    MapViewController *mView = [tmpNC.viewControllers objectAtIndex:0];
    
    //set the appropriate delegate for the action
    self.delegate = mView;
    
    //call delegate action
    [delegate setAnnotationsSegmentIndex:0];
}



#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    CourseDetailVewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
    
    [detailView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    //detailView.courseDelegate = self;
    
    [detailView setSelectedCourse:[self.myCourses objectAtIndex:indexPath.row]];
    
    //[self.navigationController presentModalViewController:detailView animated:YES];
    [self.navigationController pushViewController:detailView animated:YES];
}

@end
