//
//  SubjectPickerViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubjectPickerViewController.h"

@interface SubjectPickerViewController ()
//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SubjectPickerViewController
//@synthesize searchBar = _searchBar;
@synthesize subjects = _subjects;
//@synthesize searchBar;//  = _searchBar;

-(void) setSubjects:(NSArray *)subjects
{
    _subjects = subjects;
    NSLog(@"Number of subjects: %d", [subjects count]);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
  //  NSLog(@"Init with style!!!!!");
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 // self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    
    DBAccess* db = [[DBAccess alloc] init];
    
    self.subjects = db.getAllSubjects;
    
    [db closeDatabase];
    
    //the copy list of items used in the filtering.
    copyListOfItems = [[NSMutableArray alloc] init];
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    searching = NO;
    letUserSelectRow = YES; 
    
 //   self.tableView.tableHeaderView = self.searchBar;

  //  NSArray *myArray = [NSArray arrayWithObjects:@"Anthropology", @"Art", @"Biology", @"Business Administration", @"Chemistry", @"Economics", @"Financial Managment", @"Geology", @"History", @"Journalism", @"Liberal Studies", @"Managment", @"Physics", nil];
 //   [self setSubjects:myArray];
   
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
   // [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searching)
        return [copyListOfItems count];
    else {
        
        //Number of rows it should expect should be based on the section
        return [self.subjects count]; 
    }
}


//sets the cell information for the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSMutableArray *buildings = [self theAppDataObject].buildings;
    
    static NSString *CellIdentifier = @"Subject";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(searching){
        cell.textLabel.text = [[copyListOfItems objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [[copyListOfItems objectAtIndex:indexPath.row] abbr];
        //cell.tag = [[copyListOfItems objectAtIndex:indexPath.row] buildingIndex];
    }
    else {
        
        cell.textLabel.text = [[self.subjects objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [[self.subjects objectAtIndex:indexPath.row] abbr];
        //cell.tag = [[buildings objectAtIndex:indexPath.row] buildingIndex];
    }
    
    NSLog(@"Cell %@ %@", cell.textLabel.text, cell.detailTextLabel.text);
    
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
     SampleViewController *sampleView = [self.storyboard instantiateViewControllerWithIdentifier:@"SampleViewController"];
     [self presentModalViewController:sampleView animated:YES];
     
     */
    
    //ClassPickerViewController *classPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassPickerViewController"];
    SelectCourseTableViewController *classPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCourseTableViewController"];
    
    
    if(searching)
    {
        [classPicker setSelectedSubject:[copyListOfItems objectAtIndex:indexPath.row]];
        NSLog(@"You selected: %@", [[copyListOfItems objectAtIndex:indexPath.row] abbr]);  
    }
    else {
        [classPicker setSelectedSubject:[self.subjects objectAtIndex:indexPath.row]];
        NSLog(@"You selected: %@", [[self.subjects objectAtIndex:indexPath.row] abbr]);
    }
    [self.navigationController pushViewController:classPicker animated:YES];
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SubjectToClass"])
    {
        [segue.destinationViewController setSelectedSubject:self.diagnosis];
    }
}
*/

//put the table in search mode
- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    searching = YES;
    letUserSelectRow = NO;
    self.tableView.scrollEnabled = NO;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    self->searchBar.text = @"";
    [self->searchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    self.navigationItem.rightBarButtonItem = nil;
    self.tableView.scrollEnabled = YES;
    
    [self.tableView reloadData];    
}



//prevent user from selecting a row
- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}

//filter itmes when text enterd
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        
        searching = YES;
        letUserSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
    }
    
    [self.tableView reloadData];
}

//perform search
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    [self->searchBar resignFirstResponder];    
    [self searchTableView];
}

//function to search the table view.
- (void) searchTableView {
    NSString *searchText = searchBar.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    for (SubjectModel *dictionary in self.subjects)
    {
        
        NSRange titleResultsRange = [dictionary.abbr rangeOfString:searchText options:NSCaseInsensitiveSearch];        
        
        NSRange idResultsRange = [dictionary.title rangeOfString:searchText options:NSCaseInsensitiveSearch]; 
        
        if(titleResultsRange.length > 0 || idResultsRange.length > 0)
        {
            [copyListOfItems addObject:dictionary];
        }
    }
    searchArray = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(searching)
        return @"Filtered Sections";
    else 
        return @"Select a Section";
}



@end
