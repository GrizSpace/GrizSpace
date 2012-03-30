//
//  BuildingPickerViewController.m
//  GrizSpace
//
//  Created by William Lyon and Kevin Scott on 3/1/12.
//  Copyright (c) 2012 University of Montana, Missoula MT. 
//  All rights reserved.
//
//  Description:  This View controller is used to search for a building to display on
//  the mapviewcontroller as an annotation.  This View controller also allows the user to search for
//  a building to find.


#import "BuildingPickerViewController.h"
#import "MapViewController.h"
#import "GrizSpaceDataObjects.h"
#import "AppDelegateProtocol.h"
@interface BuildingPickerViewController ()

@end

@implementation BuildingPickerViewController

@synthesize delegate;



//used to store global information.
- (GrizSpaceDataObjects*) theAppDataObject
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
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

    //the copy list of items used in the filtering.
    copyListOfItems = [[NSMutableArray alloc] init];
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;

    searching = NO;
    letUserSelectRow = YES; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get reference to the cell that was clicked.
    UITableViewCell* returnCellData = [tableView cellForRowAtIndexPath:indexPath];

    //sets the building index based on the cell tag.
    int indexBuilding = (int)[returnCellData tag];

    //sets the correct tab index
    [self.tabBarController setSelectedIndex:0];
    
    //get handle for nav controller
    UINavigationController *tmpNC = [self.tabBarController.viewControllers objectAtIndex:0];
    
    //get handle for map view controller
    MapViewController *mView = [tmpNC.viewControllers objectAtIndex:0];
    
    //set the appropriate delegate for the action
    self.delegate = mView;
    
    //call delegate action to display the building index
    [delegate showBuildingAnnotation: indexBuilding];    
}


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
    
    for (BuildingModel *dictionary in [self theAppDataObject].buildings)
    {
        
        NSRange titleResultsRange = [dictionary.name rangeOfString:searchText options:NSCaseInsensitiveSearch];        
        
        NSRange idResultsRange = [dictionary.idBuilding rangeOfString:searchText options:NSCaseInsensitiveSearch]; 
        
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searching)
        return [copyListOfItems count];
    else {
        
        //Number of rows it should expect should be based on the section
        return [[self theAppDataObject].buildings count]; 
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(searching)
        return @"Filtered Buildings";
    else 
        return @"";
}


//sets the cell information for the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *buildings = [self theAppDataObject].buildings;
    
    static NSString *CellIdentifier = @"Building";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(searching){
        cell.textLabel.text = [[copyListOfItems objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text = [[copyListOfItems objectAtIndex:indexPath.row] idBuilding];
        cell.tag = [[copyListOfItems objectAtIndex:indexPath.row] buildingIndex];
    }
    else {
        
        cell.textLabel.text = [[buildings objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text = [[buildings objectAtIndex:indexPath.row] idBuilding];
        cell.tag = [[buildings objectAtIndex:indexPath.row] buildingIndex];
    }
    
    return cell;
}




@end
