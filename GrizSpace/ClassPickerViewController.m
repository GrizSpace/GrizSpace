//
//  ClassPickerViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassPickerViewController.h"

@interface ClassPickerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf2;

@end

@implementation ClassPickerViewController
@synthesize tf2;
@synthesize coursePicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
  //  UIView *purpleView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f)]; 
    
 //   coursePicker = [UIPickerView initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f)];
//    purpleView.backgroundColor = [UIColor whiteColor]; // Assign the input view 
    
    tf2.inputView = coursePicker;
    
    
}

- (void)viewDidUnload
{
    [self setCoursePicker:nil];
    [self setTf2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
