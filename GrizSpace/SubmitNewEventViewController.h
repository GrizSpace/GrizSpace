//
//  SubmitNewEventViewController.h
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoredEvent.h"

@interface SubmitNewEventViewController : UIViewController
- (IBAction)selectSubmitButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *titleText;
@property (strong, nonatomic) IBOutlet UITextField *descText;
@property (strong, nonatomic) IBOutlet UITextField *locationText;

@end
