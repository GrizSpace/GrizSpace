//
//  EventDetailsViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController
@synthesize descLabel;
@synthesize dateLabel;
@synthesize startLabel;
@synthesize endLabel;
@synthesize locationLabel;
@synthesize titleLabel;
@synthesize whenLabel;
@synthesize selectedEvent;
//@synthesize hollaBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)selectFlag:(id)sender 
{
    [BoredEvent flagEvent:self.selectedEvent];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.selectedEvent.title;
    self.descLabel.text = self.selectedEvent.description;
    self.locationLabel.text = self.selectedEvent.location;
    self.whenLabel.text = self.selectedEvent.when;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDescLabel:nil];
    [self setDateLabel:nil];
    [self setStartLabel:nil];
    [self setEndLabel:nil];
    [self setLocationLabel:nil];
    [self setWhenLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
