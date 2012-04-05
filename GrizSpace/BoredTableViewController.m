//
//  BoredTableViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoredTableViewController.h"

@interface BoredTableViewController ()

@end

@implementation BoredTableViewController
@synthesize events;


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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];

    PFObject* tmpPFObject = [[PFObject alloc] init];
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    
    
    NSArray* PFObjectCourseArray = [query findObjects];
    
    
   for (int i=0; i<[PFObjectCourseArray count]; i++)
   {
       tmpPFObject = [PFObjectCourseArray objectAtIndex:i];
       
    NSString* tmpTitle = [tmpPFObject objectForKey:@"title"];
    
       NSString* tmpDesc = [tmpPFObject objectForKey:@"desc"];
       NSString* tmpLoc = [tmpPFObject objectForKey:@"location"];
       

       BoredEvent* tmpBoredEvent = [[BoredEvent alloc] initWithTitle:tmpTitle andDescription:tmpDesc atLocation:tmpLoc];
       
   // [events addObject:tmpString];
    
    
    
    //NSLog(@"tmpString: %@", tmpString);
    
    [tmpArray addObject:tmpBoredEvent];
   }
    [self setEvents:tmpArray];
     
  //  }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"event";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [[self.events objectAtIndex:indexPath.row] title];
    
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
    EventDetailsViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailsViewController"];
    
    [detailView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    //detailView.courseDelegate = self;
    
    [detailView setSelectedEvent:[self.events objectAtIndex:indexPath.row]];
    
    [self.navigationController presentModalViewController:detailView animated:YES];
}

@end
