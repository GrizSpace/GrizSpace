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

-(BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField* aTextField = (UITextField*) view;
            aTextField.delegate = self;
            aTextField.returnKeyType = UIReturnKeyDone;
            aTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            aTextField.borderStyle = UITextBorderStyleRoundedRect;
            aTextField.autocorrectionType = UITextAutocorrectionTypeYes;
            
        }
    }
	// Do any additional setup after loading the view.
}

-(IBAction)selectSubmitButton:(id)sender
{
    NSLog(@"Title: %@", titleText.text);
    BoredEvent* newEvent = [[BoredEvent alloc] initWithTitle:titleText.text andDescription:descText.text atLocation:locationText.text withParseObjID:nil];
    
    [BoredEvent addBoredEvent:newEvent];
    [self.navigationController popViewControllerAnimated:YES];
    
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


@end
