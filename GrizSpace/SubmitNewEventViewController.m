//
//  SubmitNewEventViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubmitNewEventViewController.h"

@interface SubmitNewEventViewController ()

@end

@implementation SubmitNewEventViewController
@synthesize titleText;
@synthesize descText;
@synthesize locationText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTitleText:nil];
    [self setDescText:nil];
    [self setLocationText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectSubmitButton:(id)sender {
}
@end
