//
//  SelectSectionTableViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectSectionTableViewController.h"

@interface SelectSectionTableViewController ()

@end

@implementation SelectSectionTableViewController

@synthesize sectiondelegate;
@synthesize sections;
@synthesize selectedCourse;
@synthesize selectedSubject;

- (IBAction)cancelButtonSelected:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
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
    
    CourseSectionMapper *mapper = [[CourseSectionMapper alloc] init];
    //self.selectedCourse.idCourse = 105;
    
    self.sections = [mapper findByCourseId:[self.selectedCourse getIdCourse]];
                     
    
    NSLog(@"idCourse: %d", [self.selectedCourse idCourse]);
    
    
    NSLog(@"Number of sections: %d", [self.sections count]);
    

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"section";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
 //   NSString* sectionText = [[sections objectAtIndex:indexPath.row] number];
    
  //  NSString* sectionText = [NSString stringWithFormat:@"%d", (CourseSection*)[[sections objectAtIndex:indexPath.row].number]];
                             
    NSString* sectionText = [[sections objectAtIndex:indexPath.row] getNumberString];                        
    
    
    
    //@"%d", [[[self.sections objectAtIndex:indexPath.row] number];
    
    cell.textLabel.text = sectionText;
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
    ClassPickerViewController *classPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassPickerViewController"];
    
    [classPicker setSelectedSubject:self.selectedSubject];
    [classPicker setSelectedCourse:self.selectedCourse];
    [classPicker setReceivedSection:[self.sections objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:classPicker animated:YES];
//[sectiondelegate didReceiveSection:[self.sections objectAtIndex:indexPath.row]];
//[self dismissModalViewControllerAnimated:YES];
}

@end
