//
//  ScheduleTableViewController.m
//  GrizSpace
//
//  Created by Jaylene Naylor on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "CourseList.h"
#import "MapViewController.h"



@interface ScheduleTableViewController ()


@end

@implementation ScheduleTableViewController
@synthesize courses = _courses;
@synthesize dayTimes = _dayTimes;
@synthesize myCourses;

@synthesize coursesByDayArray;

//override setters
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
    //self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    CourseList* myCourseListObject = [[CourseList alloc] init];
    [self setMyCourses:[myCourseListObject getCourseListFromParse]];
    
    //allow the custom background to be seen
    //self.tableView.backgroundColor = [UIColor clearColor];
    
    //still need to figure out how to put in a custom background!
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grizzly1.jpg"]];
    self.tableView.backgroundView = imageView;
    
    
    //The following is VERY hack, but is a first attempt.  Grab the days for the course.  If the days string
    //has an M in it, add the course to the MondayArray.  If it has a Tuesday in it...
    //needs to move to its own method
    //set up an array for all the Monday, etc courses
    NSMutableArray *mondayArray = [NSMutableArray array];
    NSMutableArray *tuesdayArray = [NSMutableArray array];
    NSMutableArray *wednesdayArray = [NSMutableArray array];
    NSMutableArray *thursdayArray = [NSMutableArray array];
    NSMutableArray *fridayArray = [NSMutableArray array];
    
    
    for (int i=0; i<[myCourses count]; i++) 
    {
        
        //get the days for the course section
        CourseModel *tmpCourse = [self.myCourses objectAtIndex:i];
        
        NSString *tmpDays = [tmpCourse.section getDays];
        NSLog(@"MyCourse iteration days %@", tmpDays);
        
        
        //this search will also be moved to its own method where I will just pass in the letter to look for
        
        //Search for M (Monday) in tmpDays
        NSRange rangeM = [tmpDays rangeOfString:@"M" 
                                          options:NSCaseInsensitiveSearch];
        if(rangeM.location != NSNotFound) 
        {
            
            printf("i=%d\n", i);
            NSLog(@"Found an M!");
            
            [mondayArray addObject:tmpCourse];

            //create an index for the Monday array
            int k = mondayArray.count -1;
            printf("Monday k=%d\n", k);
            
            NSLog(@"mondayArray subject:%@", [[mondayArray objectAtIndex:k] subject]);  
           
            NSLog(@"mondayArray subject:%@", [tmpCourse.section getDays]);

        }
        else
        {
            NSLog(@"Didn't find an M");
            
            
        }
        
        NSRange rangeT = [tmpDays rangeOfString:@"T" 
                                       options:NSCaseInsensitiveSearch];
        if(rangeT.location != NSNotFound) 
        {
            
            printf("i=%d\n", i);
            NSLog(@"Found a T!");
            [tuesdayArray addObject:tmpCourse];
            
            //create an index variable for the tuesdayArray
            int j = tuesdayArray.count - 1;
            
            
            
            NSLog(@"TuesdayArray subject:%@", [[tuesdayArray objectAtIndex:j] subject]);  //can't do this because first class has no Tt
            
            NSLog(@"TuesdayArray days:%@", [tmpCourse.section getDays]);
            
            //NSString *tmpRoom = tmpCourse.section.room;
            //NSLog(@"mondayArray subject:%@", [[mondayArray objectAtIndex:i] tmpCourse.section.room]);
            
        }
        else
        {
            NSLog(@"Didn't find an T");
            
        }

        
       
        
        
        //NSLog(@"MyCourse iteration%@", [[myCourses objectAtIndex:i] subject ]);
        
        //NSLog(@"MyCourse iteration%@", [myCourses objectAtIndex:i] );
       
    }  
    
   //Add the day arrays to the coursesByDay array (an array of arrays) **do I need that nil?
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithObjects:mondayArray,tuesdayArray, nil];
    [self setCoursesByDayArray:tmpArray];
    
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections, which is the number of objects in the coursesByDayArray
    
    NSInteger tableSections = [[self coursesByDayArray] count];
    return tableSections;
    
}

//Return the header title for a section
- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
   //if the index of coursesByDayArray =0, then the label should be Monday.  But, if no classes
    //were found on Mondays, then the first item in the cBDArray would be Tuesday classes.
    //what if I added a "nil" element for index 0, if no Monday classes were found?  Then I would
    //always know what order things were in and that all slots in the cBDArray got filled.
    
    NSString *sectionLabel;
    
    if (section == 0)
    {
    
       sectionLabel =  @"Monday";
        
    }

    return sectionLabel;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    //first create a temporary array (sectionContents) by extracting all of the items in the mondayArray, for example.
    //the mondayArray is gotten at by objectAtIndex:section, instead of row.
    NSMutableArray *sectionContents = [[self coursesByDayArray] objectAtIndex:section];
    
    //now just count how many rows are in this new temp array and that will tell you how many rows are in the mondayArray
    NSInteger rows = [sectionContents count];
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create an array with all of the mondayArray (for example) courses
    NSMutableArray *sectionContents = [[self coursesByDayArray] objectAtIndex:[indexPath section]];
    
    //cycle through each element of this new array to display it in a cell.  Basically, have put mondayArray into
    //the coursesByDayArray and just re-extracted it to display it.  The data needed to be prepped properly
    //to make it easy to display without a bunch of case:switch statements
    
    CourseModel *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    cell.textLabel.text = [[contentForThisRow subject] stringByAppendingString:[contentForThisRow number]]; //how to put in a space?
    
    cell.detailTextLabel.text = [contentForThisRow.section getDays]; //works
    
    //cell.detailTextLabel.text = [contentForThisRow.section startTime]; //returns nothing
    
    
    
    //NSLog(@"Days: %@", [tmpCourse.section getDays]);
    
    //NSLog(@"Subject: %@", [[self.myCourses objectAtIndex:indexPath.row] getSubject]);
    
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
}

@end
